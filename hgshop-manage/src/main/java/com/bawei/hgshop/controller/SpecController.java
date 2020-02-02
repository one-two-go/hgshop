package com.bawei.hgshop.controller;

import java.util.List;

import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bawei.hgshop.pojo.Spec;
import com.bawei.hgshop.service.SpecService;
import com.github.pagehelper.PageInfo;

@Controller
public class SpecController {

	@Reference(url="dubbo://localhost:20890",timeout=5000)
	private SpecService specService;
	
	@RequestMapping("/specList")
	public String list(Model model, Spec spec, @RequestParam(defaultValue="1")Integer pageNum, @RequestParam(defaultValue="2")Integer pageSize) {
		PageInfo<Spec> pageInfo = specService.list(spec, pageNum, pageSize);
		model.addAttribute("spec", spec);
		model.addAttribute("pageInfo", pageInfo);
		return "spec_list";
	}
	
	@RequestMapping("/specAdd")
	@ResponseBody
	public boolean specAdd(Spec spec){
		return specService.saveOrUpdateSpec(spec) > 0;
	}
	
	@RequestMapping("/getSpecById")
	@ResponseBody
	public Spec getSpecById(Integer id) {
		return specService.getSpecById(id);
	}
	
	@RequestMapping("/specDelete")
	@ResponseBody
	public boolean specDelete(Integer[] ids){
		return specService.deleteSpecByIds(ids) > 0;
	}

	/**
	 * 添加sku页面获取规格列表
	 * @return
	 */
	@RequestMapping("/specs")
	@ResponseBody
	public List<Spec> specs() {
		return specService.specs();
	}
}
