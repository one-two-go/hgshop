package com.bawei.hgshop.controller;

import java.util.List;

import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bawei.hgshop.pojo.Brand;
import com.bawei.hgshop.service.BrandService;
import com.github.pagehelper.PageInfo;

@Controller
public class BrandController {

	@Reference(url="dubbo://localhost:20890",timeout=5000)
	private BrandService brandService;
	
	@RequestMapping("/brandList")
	public String brandList(Model model, Brand brand, @RequestParam(defaultValue="1")Integer pageNum, @RequestParam(defaultValue="3")Integer pageSize) {
		//1.获取数据
		PageInfo<Brand> pageInfo = brandService.list(brand, pageNum, pageSize);
		//2.填充数据
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("brand", brand);
		return "brand_list";
	}
	
	/**
	 * 添加商品时查询所有的品牌列表
	 * @return
	 */
	@RequestMapping("/getAllBrands")
	@ResponseBody
	public List<Brand> getAllBrands() {
		return brandService.getAllBrands();
	}
	
	@RequestMapping("/brandAdd")
	@ResponseBody
	public boolean brandAdd(Brand brand) {
		return brandService.saveOrUpdateBrand(brand) > 0;
	}
	
	@RequestMapping("/getBrandById")
	@ResponseBody
	public Brand getBrandById(Integer id) {
		return brandService.getBrandById(id);
	}
	
	@RequestMapping("/brandDelete")
	@ResponseBody
	public boolean brandDelete(Integer[] ids) {
		return brandService.deleteBrandByIds(ids) > 0;
	}
	
}
