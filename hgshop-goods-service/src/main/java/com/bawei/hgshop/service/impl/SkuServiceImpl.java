package com.bawei.hgshop.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.dubbo.config.annotation.Service;

import com.bawei.hgshop.dao.SkuMapper;
import com.bawei.hgshop.dao.SpecMapper;
import com.bawei.hgshop.pojo.Sku;
import com.bawei.hgshop.pojo.SkuSpec;
import com.bawei.hgshop.pojo.Spec;
import com.bawei.hgshop.service.SkuService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class SkuServiceImpl implements SkuService {

	@Resource
	private SkuMapper skuMapper;
	
	@Resource
	private SpecMapper specMapper;
	
	/**
	 * 查询sku列表(分页)
	 */
	@Override
	public PageInfo<Sku> list(Sku sku, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Sku> list = skuMapper.selectSkuList(sku);
		PageInfo<Sku> pageInfo = new PageInfo<Sku>(list);
		return pageInfo;
	}
	/**
	 * 添加或修改sku
	 */
	@Override
	public Integer saveOrUpdateSku(Sku sku) {
		Integer count = 0;
		//①新增
		if (sku.getId() == null) {
			sku.setStatus("0");
			sku.setCreateTime(new Date());
			sku.setUpdateTime(new Date());
			count = skuMapper.insertSku(sku);
		} else {
			//Ⅱ修改
			sku.setUpdateTime(new Date());
			count = skuMapper.updateSku(sku);
			skuMapper.deleteSkuSpecBySkuIds(new Integer[]{sku.getId()});
		}
		if (count > 0) {
			List<SkuSpec> skuSpecs = sku.getSkuSpec();
			if (skuSpecs != null) {
				for (SkuSpec skuSpec : skuSpecs) {
					skuSpec.setSkuId(sku.getId());
					skuMapper.insertSkuSpec(skuSpec);
				}
			}
		}
		return count;
	}

	/**
	 * 修改回显或查看详情
	 */
	@Override
	public Map<String, Object> getSkuById(Integer id) {
		Map<String, Object> map = new HashMap<>();
		//1.获取sku详情
		Sku sku = skuMapper.selectSkuById(id);
		//2.将中间表对象列表映射成规格参数id列表
		List<Integer> specIds = sku.getSkuSpec().stream().map(ks -> ks.getSpecId()).collect(Collectors.toList());
		//3.根据规格参数id列表获取规格参数及规格参数选项信息
		List<Spec> specList = specMapper.selectSpecByIds(specIds);
		map.put("sku", sku);
		map.put("specs", specList);
		return map;
	}

	@Override
	public Integer deleteSkuByIds(Integer[] ids) {
		//1.删除sku表
		Integer count = skuMapper.deleteSkuByIds(ids);
		if (count > 0) {
			//2.删除sku_spec表
			skuMapper.deleteSkuSpecBySkuIds(ids);
		}
		return count;
	}
	
	
	
	@Override
	public List<Sku> selectNews(int num) {
		return skuMapper.selectNews(num);
	}
	
	@Override
	public Map<String, Object> getSkuById1(Integer id) {
		Map<String, Object> map = new HashMap<>();
		
		//1.根据skuId查询sku信息
		Sku sku = skuMapper.selectSkuById1(id);
		//2.根据spuId查询规格参数列表
		List<Integer> spuIds = new ArrayList<>();
		spuIds.add(sku.getSpuId());
		List<Spec> specs = specMapper.selectSpecBySpuIds(spuIds);
		
		//3.放到map
		map.put("sku", sku);
		map.put("specs", specs);
		return map;
	}
	@Override
	public Map<String, Object> getSkuBySpecOptionIds(Integer[] optionIds) {
		Map<String, Object> map = new HashMap<>();
		//1.获取sku详情
		Sku sku = skuMapper.selectSkuBySpecOptionIds(optionIds);
		//一般正常情况下sku不为空,即使没有该规格参数的组合,后台录入时,也会添加一份库存和价格为0的记录
		//这样处理是为了详情页展示图片及其他相关信息
		//库存为空，需在页面将规格选项置为禁用状态
		if (sku == null || sku.getStockCount() == 0) {
		}
		List<SkuSpec> skuSpecList = new ArrayList<>();
		for (int i = 0; i < optionIds.length; i++) {
			SkuSpec skuSpec = new SkuSpec();
			skuSpec.setSpecOptionId(optionIds[i]);
			skuSpecList.add(skuSpec);
		}
		sku.setSkuSpec(skuSpecList);
		//2.根据spu id获取规格参数及规格参数选项信息(查询该商品中有哪些规格参数)
		List<Integer> spuIds = new ArrayList<>();
		spuIds.add(sku.getSpuId());	
		List<Spec> specList = specMapper.selectSpecBySpuIds(spuIds);
		map.put("sku", sku);
		map.put("specs", specList);
		return map;
	}
	@Override
	public Sku getSkuById2(Integer skuId) {
		return skuMapper.selectSkuById2(skuId);
	}
}
