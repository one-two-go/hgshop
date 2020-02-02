package com.bawei.hgshop.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.dubbo.config.annotation.Service;

import com.bawei.hgshop.dao.BrandMapper;
import com.bawei.hgshop.pojo.Brand;
import com.bawei.hgshop.service.BrandService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 品牌服务层
 * @author coolface
 *
 */
@Service
public class BrandServiceImpl implements BrandService {

	@Resource
	private BrandMapper brandMapper;
	
	/**
	 * 获取品牌列表(分页)
	 */
	@Override
	public PageInfo<Brand> list(Brand brand, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Brand> list = brandMapper.selectBrandList(brand);
		PageInfo<Brand> pageInfo = new PageInfo<Brand>(list);
		return pageInfo;
	}

	/**
	 * 添加或修改品牌
	 */
	@Override
	public Integer saveOrUpdateBrand(Brand brand) {
		if (brand.getId() == null) {
			brand.setDeletedFlag(0);
			return brandMapper.insertBrand(brand);
		} else {
			return brandMapper.updateBrand(brand);
		}
	}

	/**
	 * 获取品牌详情
	 */
	@Override
	public Brand getBrandById(Integer id) {
		return brandMapper.selectBrandById(id);
	}

	/**
	 * 批量删除(假删除)
	 */
	@Override
	public Integer deleteBrandByIds(Integer[] ids) {
		return brandMapper.deleteBrandByIds(ids);
	}

	@Override
	public List<Brand> getAllBrands() {
		return brandMapper.selectAllBrands();
	}

}
