package com.bawei.hgshop.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.dubbo.common.utils.StringUtils;
import org.apache.dubbo.config.annotation.Service;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.common.text.Text;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.Aggregations;
import org.elasticsearch.search.aggregations.bucket.terms.LongTerms;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.SearchResultMapper;
import org.springframework.data.elasticsearch.core.aggregation.AggregatedPage;
import org.springframework.data.elasticsearch.core.aggregation.impl.AggregatedPageImpl;
import org.springframework.data.elasticsearch.core.query.FetchSourceFilter;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.util.CollectionUtils;

import com.bawei.hgshop.dao.BrandMapper;
import com.bawei.hgshop.dao.CategoryMapper;
import com.bawei.hgshop.dao.SkuMapper;
import com.bawei.hgshop.dao.SpecMapper;
import com.bawei.hgshop.dao.SpuMapper;
import com.bawei.hgshop.pojo.Brand;
import com.bawei.hgshop.pojo.Category;
import com.bawei.hgshop.pojo.ESSpu;
import com.bawei.hgshop.pojo.Sku;
import com.bawei.hgshop.pojo.Spec;
import com.bawei.hgshop.pojo.Spu;
import com.bawei.hgshop.service.SpuService;
import com.bawei.hgshop.util.ESUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;

@Service
public class SpuServiceImpl implements SpuService {

	@Autowired
	private SpuMapper spuMapper;
	
	@Override
	public PageInfo<Spu> list(Spu spu, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Spu> list = spuMapper.selectSpuList(spu);
		PageInfo<Spu> pageInfo = new PageInfo<Spu>(list);
		return pageInfo;
	}

	@Override
	public Integer saveOrUpdateSpu(Spu spu) {
		Integer count = null;
		if (spu.getId() == null) {
			//新增
			count = spuMapper.insertSpu(spu);
		} else {
			//修改
			count = spuMapper.updateSpu(spu);
		}
		return count;
	}

	@Override
	public Spu getSpuById(Integer id) {
		return spuMapper.selectSpuById(id);
	}

	@Override
	public Integer deleteSpuByIds(Integer[] ids) {
		return spuMapper.deleteSpuByIds(ids);
	}
	
	
	
	@Override
	public List<Spu> spus() {
		return spuMapper.selectSpus();
	}

	
	
	@Autowired
	private CategoryMapper categoryMapper;
	
	@Autowired
	private BrandMapper brandMapper;
	
	@Autowired
	private SpecMapper specMapper;
	
	@Autowired
	private SkuMapper skuMapper;
	
	@Autowired
	private ElasticsearchTemplate template;
	
	
	/********************************前台搜索列表页**********************************/
	@Override
	public Map<String, Object> getSpuList(Spu spu, Integer pageNum, Integer pageSize) {
		Map<String, Object> map = new HashMap<>();
		
		//①查询spuId列表
		List<Integer> spuIds = spuMapper.selectSpuIdsBySearch(spu);
		
		if (spuIds.size() == 0) return map;
		
		//②分页查询sku列表
		PageHelper.startPage(pageNum, pageSize);
		List<Spu> list = spuMapper.selectSpuByIds(spuIds);
		list.forEach(s -> s.setSkuList(skuMapper.selectSkusBySpuId(s.getId())));
		PageInfo<Spu> pageInfo = new PageInfo<>(list);
		map.put("pageInfo", pageInfo);
		//③查询分类列表
		List<Category> categoryList = spuMapper.selectCategoryBySpuIds(spuIds);
		//④查询品牌列表
		List<Brand> brandList = spuMapper.selectBrandBySpuIds(spuIds);
		//⑤查询规格参数列表
		List<Spec> specList = specMapper.selectSpecBySpuIds(spuIds);
	
		map.put("categoryList", categoryList);
		map.put("brandList", brandList);
		map.put("specList", specList);
		
		return map;
	}
	
	
	@Override
	public void saveOrUpdateESSpu(Integer spuId) throws IOException {
		//1.通过spu_id查询spu(spu自己的字段)
		Spu spu = spuMapper.selectSpuById(spuId);
		//2.查询商品分类名
        String categoryNames = categoryMapper.selectCategoryNamesByThreeCategoryId(spu.getCategoryId());
        //3.查询商品品牌
        Brand brand = brandMapper.selectBrandById(spu.getBrandId());
        //4.所有的搜索字段拼接到all中，all存入索引库，并进行分词处理，搜索时与all中的字段进行匹配查询
        String all = spu.getGoodsName() + " " + categoryNames + " " + brand.getName();

        //5.查询sku列表
        List<Sku> skus = skuMapper.selectSkusBySpuId(spuId);
        StringBuilder sb = new StringBuilder();
        for (Sku sku : skus) {
			String title = sku.getTitle();
			sb.append(title).append("^A");
        }
        String title = sb.substring(0, sb.length()-2).toString();
        //6.查询spec列表
        Map<String, Object> specs = new HashMap<>();
        List<Integer> spuIds = new ArrayList<>();
        spuIds.add(spuId);
        List<Spec> specList = specMapper.selectSpecBySpuIds(spuIds);
        for (Spec spec : specList) {
			String specName = spec.getSpecName();
			List<String> optionList = spec.getOptions().stream().map(option -> option.getOptionName()).collect(Collectors.toList());
			specs.put(specName, optionList);
        }
        
        ESSpu esSpu = new ESSpu();
        esSpu.setId(spuId);
        esSpu.setBrandId(spu.getBrandId());
        esSpu.setCategoryId(spu.getCategoryId());
        esSpu.setKeyword(all);
        esSpu.setTitle(title);
        esSpu.setSpecs(specs);
        esSpu.setSkus(skus);
        
        ESUtils.saveObject(template, esSpu.getId() + "", esSpu);
    }
	
	/**
	 * 查询ES
	 */
	@Override
	public Map<String, Object> search(String keyword, Integer pageNum, Integer pageSize, Map<String, String> filter) {
		Map<String, Object> map = new HashMap<>();
		AggregatedPage<ESSpu> result = null;
		
        NativeSearchQueryBuilder queryBuilder = new NativeSearchQueryBuilder();

        //通过sourceFilter字段过滤只要我们需要的数据
        queryBuilder.withSourceFilter(new FetchSourceFilter(new String[]{"id", "title", "skus"}, null));

        //分页
        queryBuilder.withPageable(PageRequest.of(pageNum-1, pageSize));

        //基本搜索条件
        //构建布尔查询
        BoolQueryBuilder basicQuery = QueryBuilders.boolQuery();
        //过滤条件
        if (!CollectionUtils.isEmpty(filter)) {
            for (Map.Entry<String, String> entry : filter.entrySet()) {
                String key = entry.getKey();
                //判断key是否是分类或者品牌过滤条件
                if (!"categoryId".equals(key) && !"brandId".equals(key)) {
                    key = "specs." + key + ".keyword";
                }
                //过滤条件
                String value = entry.getValue();
                basicQuery.filter(QueryBuilders.termQuery(key, value));
            }
        }
        //搜索条件
        // 没有查询条件的的时候，获取es中的全部数据 分页获取
        if (StringUtils.isNotEmpty(keyword)) {
        	// 高亮拼接的前缀与后缀
			String preTags = "<font color=\"red\">";
			String postTags = "</font>";

			String[] fieldNames = new String[]{"keyword", "title"};
			// 定义创建高亮的构建集合对象
			HighlightBuilder.Field highlightFields[] = new HighlightBuilder.Field[fieldNames.length];

			for (int i = 0; i < fieldNames.length; i++) {
				highlightFields[i] = new HighlightBuilder.Field(fieldNames[i]).preTags(preTags).postTags(postTags);
			}

			basicQuery.must(QueryBuilders.multiMatchQuery(keyword, fieldNames));
			queryBuilder.withHighlightFields(highlightFields);
        }
        queryBuilder.withQuery(basicQuery);
        //对分类和品牌聚合
        String categoryAggName = "categoryAgg";
        queryBuilder.addAggregation(AggregationBuilders.terms(categoryAggName).field("categoryId"));

        String brandAggName = "brandAgg";
        queryBuilder.addAggregation(AggregationBuilders.terms(brandAggName).field("brandId"));

        List<Spec> specs = specMapper.selectSpecs();
        for (Spec spec : specs) {
            //聚合
            String name = spec.getSpecName();
            queryBuilder.addAggregation(AggregationBuilders.terms(name).field("specs." + name + ".keyword"));
        }
        
        //查询，获取结果
        if (StringUtils.isNotEmpty(keyword)) {
        	result = template.queryForPage(queryBuilder.build(), ESSpu.class, new SearchResultMapper() {

    			@SuppressWarnings("unchecked")
    			@Override
    			public <T> AggregatedPage<T> mapResults(SearchResponse response, Class<T> clazz, Pageable pageable) {
    				long total = 0l;
    				List<T> content = new ArrayList<>();
    				
    				SearchHits searchHits = response.getHits();
    				if (searchHits != null) {
    					//获取总记录数
    					total = searchHits.getTotalHits();
    					// 获取结果数组
    					SearchHit[] hits = searchHits.getHits();
    					// 判断结果
    					if (hits != null && hits.length > 0) {
    						// 遍历结果
    						for (SearchHit hit : hits) {
    							Gson gson = new Gson();
    							ESSpu spu = gson.fromJson(hit.getSourceAsString(), ESSpu.class);
    							
    							Map<String, HighlightField> highlightFields = hit.getHighlightFields();
    							HighlightField title = highlightFields.get("title");
    							if (title != null) {
    								Text[] fragments = title.fragments();
    								spu.setTitle(fragments[0].toString());
    							}
    							content.add((T)spu);
    						}
    					}
    				}
    				return new AggregatedPageImpl<T>(content, pageable, total, response.getAggregations());
    			}
    		});
        } else {
        	result = template.queryForPage(queryBuilder.build(), ESSpu.class);
        }
        
     	
        
        
        //解析聚合结果
        Aggregations aggs = result.getAggregations();
        
        //解析分类聚合
        
        //根据ID查询分类
        List<Category> categories = new ArrayList<>();
        if (((LongTerms)aggs.get(categoryAggName)).getBuckets().size() > 0) {
        	List<Long> categoryIds = ((LongTerms)aggs.get(categoryAggName)).getBuckets()
                    .stream()
                    .map(b -> b.getKeyAsNumber().longValue())
                    .collect(Collectors.toList());
        	categories = categoryMapper.selectCategoryByIds(categoryIds);
        }
        
        //解析品牌聚合
        List<Brand> brands = new ArrayList<>();
        if (((LongTerms)aggs.get(brandAggName)).getBuckets().size() > 0) {
        	List<Long> brandIds = ((LongTerms)aggs.get(brandAggName)).getBuckets()
        			.stream()
        			.map(b -> b.getKeyAsNumber().longValue())
        			.collect(Collectors.toList());
        	brands = brandMapper.selectBrandByIds(brandIds);
        }
        
      //对规格参数聚合
        List<Map<String, Object>> specList = new ArrayList<>();
        for (Spec spec : specs) {
            String name = spec.getSpecName();
            Terms terms = aggs.get(name);
            //创建聚合结果
            HashMap<String, Object> specMap = new HashMap<>();
            specMap.put("k", name);
            List<Object> options = terms.getBuckets()
                    .stream()
                    .map(b -> b.getKey())
                    .collect(Collectors.toList());
            if (options.size() > 0) {
            	specMap.put("options", options);
            	specList.add(specMap);
            }
        }
        
        
        //解析分页结果
        long total = result.getTotalElements();
        int totalPage = result.getTotalPages();
        List<ESSpu> items = result.getContent();
        items.forEach(item -> {
        	String title = item.getTitle();
        	if (title.indexOf("</font>")>0 && title.indexOf("<font")>0) {
        		int start = title.substring(0, title.indexOf("<font")).lastIndexOf("^A");
        		if (start == -1) {
        			start = 0;
        		} else {
        			start += 2;
        		}
        		int end = title.substring(title.indexOf("</font>")).indexOf("^A");
        		if (end == -1) {
        			end = title.length();
        		} else {
        			end += title.indexOf("</font>");
        		}
    			title = title.substring(start, end);
    			item.setTitle(title);
        	}
        });
        
        map.put("total", total);
        map.put("totalPage", totalPage);
        map.put("items", items);
        map.put("categories", categories);
        map.put("brands", brands);
        map.put("specs", specList);
        return map;
    }

}
