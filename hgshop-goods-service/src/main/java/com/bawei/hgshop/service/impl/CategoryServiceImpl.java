package com.bawei.hgshop.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.dubbo.config.annotation.Service;

import com.bawei.hgshop.dao.CategoryMapper;
import com.bawei.hgshop.pojo.Category;
import com.bawei.hgshop.service.CategoryService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Resource
	private CategoryMapper categoryMapper;
	
	@Override
	public PageInfo<Category> list(Category category, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Category> list = categoryMapper.selectCategoryList(category);
		PageInfo<Category> pageInfo = new PageInfo<Category>(list);
		return pageInfo;
	}
	
	@Override
	public List<Category> getAllCategories() {
		return categoryMapper.selectAllCategories();
	}

	/**
	 * 数据库中添加和修改分类
	 */
	@Override
	public Integer addCategory(Category category) {
		Integer count = null;
		if (category.getId() == null) {
			//新增
			if (category.getParentId() == null) {
				category.setParentId(0);
			}
			count = categoryMapper.insertCategory(category);
		} else {
			//修改
			count = categoryMapper.updateCategory(category);
		}
		
		return count;
	}

	@Override
	public Category getCategoryById(Integer id) {
		return categoryMapper.selectCategoryById(id);
	}
	
	@Override
	public Map<String, String> deleteCategory(Integer id) {
		Map<String, String> map = new HashMap<>();
	
		//1.判定当前分类节点是否有子分类。如果有，不能删除，提示有叶子节点
		Integer count = categoryMapper.getChildCategoryCount(id);
		if (count > 0) {
			map.put("code", "20011");
			map.put("msg", "该分类不是叶子节点");
			return map;
		}
		//2.如果当前分类下没有子分类，将该分类下所有商品信息中category_id设置为null
		
		//3.删除该分类
		count = categoryMapper.deleteCategoryById(id);
		if (count > 0) {
			map.put("code", "20010");
			map.put("msg", "删除分类成功");
		} else {
			map.put("code", "20012");
			map.put("msg", "删除分类失败");
		}
		return map;
	}

}
