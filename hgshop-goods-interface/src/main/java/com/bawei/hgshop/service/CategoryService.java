package com.bawei.hgshop.service;

import java.util.List;
import java.util.Map;

import com.bawei.hgshop.pojo.Category;
import com.github.pagehelper.PageInfo;

public interface CategoryService {

	PageInfo<Category> list(Category category, Integer pageNum, Integer pageSize);
	
	List<Category> getAllCategories();

	Integer addCategory(Category category);

	Category getCategoryById(Integer id);
	
	Map<String, String> deleteCategory(Integer id);


}
