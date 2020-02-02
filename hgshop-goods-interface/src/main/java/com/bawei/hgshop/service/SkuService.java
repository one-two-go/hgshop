package com.bawei.hgshop.service;

import java.util.List;
import java.util.Map;

import com.bawei.hgshop.pojo.Sku;
import com.github.pagehelper.PageInfo;

public interface SkuService {

	PageInfo<Sku> list(Sku sku, Integer pageNum, Integer pageSize);

	Integer saveOrUpdateSku(Sku sku);

	Map<String, Object> getSkuById(Integer id);

	Integer deleteSkuByIds(Integer[] ids);

	List<Sku> selectNews(int num);

}
