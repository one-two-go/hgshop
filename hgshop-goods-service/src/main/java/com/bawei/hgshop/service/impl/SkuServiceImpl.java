package com.bawei.hgshop.service.impl;

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
}
