package com.bawei.hgshop.service;

import java.util.List;

import com.bawei.hgshop.pojo.Brand;
import com.github.pagehelper.PageInfo;

public interface BrandService {

	/**
	 * 获取品牌列表(分页)
	 * @param brand
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	PageInfo<Brand> list(Brand brand, Integer pageNum, Integer pageSize);

	/**
	 * 添加或更新品牌
	 * @param brand
	 * @return
	 */
	Integer saveOrUpdateBrand(Brand brand);
	
	/**
	 * 查看详情
	 * @param id
	 * @return
	 */
	Brand getBrandById(Integer id);

	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	Integer deleteBrandByIds(Integer[] ids);

	List<Brand> getAllBrands();
}
