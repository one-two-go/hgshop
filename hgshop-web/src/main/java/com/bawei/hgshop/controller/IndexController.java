package com.bawei.hgshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.dubbo.common.utils.StringUtils;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bawei.hgshop.pojo.Category;
import com.bawei.hgshop.pojo.Sku;
import com.bawei.hgshop.pojo.Spu;
import com.bawei.hgshop.service.CategoryService;
import com.bawei.hgshop.service.SkuService;
import com.bawei.hgshop.service.SpuService;

@Controller
public class IndexController {

	@Reference(url="dubbo://localhost:20890")
	private CategoryService categoryService;
	
	@Reference(url="dubbo://localhost:20890")
	private SkuService skuService;
	
	@Reference(url="dubbo://localhost:20890")
	private SpuService spuService;
	
	/**
	 * 前台首页
	 * @param request
	 * @return
	 */
	@RequestMapping("/")
	public String index(HttpServletRequest request) {
		//1.查询导航中的数据
		List<Category> navCategories = categoryService.getAllCategories();
		
		//2.查询最新商品数据
		List<Sku> newSkus = skuService.selectNews(4);
		
//		List<Sku> hotSkus = spuSkuService.selectHots(4);
		
		//存储数据
		request.setAttribute("navCategories", navCategories);
		request.setAttribute("newSkus", newSkus);
//		request.setAttribute("hotSkus", hotSkus);

		return "index";
	}
	/**
	 * 搜索页
	 * @param sku
	 * @param keyword
	 * @param pageNum
	 * @param pageSize
	 * @param request
	 * @return
	 */
	@RequestMapping("/list")
	public String list(String keyword, Integer brandId, Integer categoryId, Integer optionId, @RequestParam(defaultValue="1")Integer pageNum, @RequestParam(defaultValue="3")Integer pageSize, HttpServletRequest request) {
		Spu spu = new Spu();
		spu.setGoodsName(keyword);
		spu.setBrandId(brandId);
		spu.setCategoryId(categoryId);
		spu.setOptionId(optionId);
//		List<Integer> optionIdList = new ArrayList<>();
//		List<List<Integer>> optionIds = new ArrayList<>();
//		optionIds.add(optionIdList);
//		spu.setOptionIds(optionIds);
		Map<String, Object> map = spuService.getSpuList(spu, pageNum, pageSize);
		request.setAttribute("map", map);
		request.setAttribute("keyword", keyword);
		return "list";
	}
	
	@RequestMapping("/list2")
	public String list2(String keyword, Integer brandId, Integer categoryId, String k, String v, @RequestParam(defaultValue="1")Integer pageNum, @RequestParam(defaultValue="3")Integer pageSize, HttpServletRequest request) {
		Map<String, String> filter = new HashMap<>();
		if (brandId != null) filter.put("brandId", brandId+"");
		if (categoryId != null) filter.put("categoryId", categoryId+"");
		if (StringUtils.isNotEmpty(k) && StringUtils.isNotEmpty(v)) filter.put(k, v);
		Map<String, Object> map = spuService.search(keyword, pageNum, pageSize, filter);
		request.setAttribute("map", map);
		request.setAttribute("keyword", keyword);
		return "list2";
	}
	
	/**
	 * 详情页
	 * @param request
	 * @param id
	 * @param optionIds
	 * @return
	 */
	@RequestMapping("/page")
	public String page(HttpServletRequest request, Integer id, Integer[] optionIds) {
		Map<String, Object> map = new HashMap<>();
		if (id != null) {
			//通过skuId查询
			map = skuService.getSkuById1(id);
		} else {
			//通过规格参数选项ids查询
			map = skuService.getSkuBySpecOptionIds(optionIds);
		}
		
		request.setAttribute("map", map);
		return "page";
	}
}
