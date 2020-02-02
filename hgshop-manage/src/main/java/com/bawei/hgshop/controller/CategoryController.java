package com.bawei.hgshop.controller;

import java.util.List;
import java.util.Map;

import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bawei.hgshop.pojo.Category;
import com.bawei.hgshop.service.CategoryService;
import com.github.pagehelper.PageInfo;

/**
 * 分类控制层
 * @author coolface
 *
 */
@Controller
public class CategoryController {

	@Reference(url="dubbo://localhost:20890",timeout=5000)
	private CategoryService categoryService;
	
	/**
	 * 分类分页列表
	 * @param model
	 * @param category
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("/categoryList")
	public String categoryList(Model model, Category category, @RequestParam(defaultValue="1")Integer pageNum, @RequestParam(defaultValue="3")Integer pageSize) {
		//1.获取数据
		PageInfo<Category> pageInfo = categoryService.list(category, pageNum, pageSize);
		//2.填充数据
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("category", category);
		return "category_list";
	}
	
	
	/**
	 * 分类添加或编辑页面显示tree
	 * @return
	 */
	@RequestMapping("/getAllCategories")
	@ResponseBody
	public List<Category> getAllCategories(){
		return categoryService.getAllCategories();
	}
	
	/**
	 * 用于在spu管理中，控制一级二级分类不能选中
	 * @return
	 */
	@RequestMapping("/getAllCategories1")
	@ResponseBody
	public List<Category> getAllCategories1(){
		List<Category> list = categoryService.getAllCategories();
		list.forEach(c1 -> {
			c1.setSelectable(false);
			c1.getChilds().forEach(c2 -> c2.setSelectable(false));
		});
		
//		for (Category c1 : list) {
//			c1.setSelectable(false);
//			List<Category> c2s = c1.getChilds();
//			for (Category c2 : c2s) {
//				c2.setSelectable(false);
//			}
//		}
		return list;
	}
	
	
	/**
	 * 添加或编辑分类
	 * @param category
	 * @return
	 */
	@RequestMapping("/categoryAdd")
	@ResponseBody
	public boolean categoryAdd(Category category){
		return categoryService.addCategory(category) > 0;
	}
	
	/**
	 * 修改回显和详情
	 * @param id
	 * @return
	 */
	@RequestMapping("/getCategoryById")
	@ResponseBody
	public Category getCategoryById(Integer id) {
		return categoryService.getCategoryById(id);
	}
	
	/**
	 * 删除分类
	 * @param id
	 * @return
	 */
	@RequestMapping("/categoryDelete")
	@ResponseBody
	public Map<String, String> categoryDelete(Integer id){
		return categoryService.deleteCategory(id);
	}
	
	
}
