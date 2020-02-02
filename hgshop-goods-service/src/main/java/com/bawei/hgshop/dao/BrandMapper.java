package com.bawei.hgshop.dao;

import java.util.List;

import com.bawei.hgshop.pojo.Brand;

public interface BrandMapper {

	List<Brand> selectBrandList(Brand brand);

	Integer insertBrand(Brand brand);

	Integer updateBrand(Brand brand);

	Brand selectBrandById(Integer id);

	Integer deleteBrandByIds(Integer[] ids);

	List<Brand> selectAllBrands();

	List<Brand> selectBrandByIds(List<Long> brandIds);

}
