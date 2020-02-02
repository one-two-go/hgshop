package com.bawei.hgshop.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bawei.hgshop.pojo.Sku;
import com.bawei.hgshop.service.SkuService;
import com.github.pagehelper.PageInfo;

@Controller
public class SkuController {
	
	@Reference(url="dubbo://localhost:20890",timeout=5000)
	private SkuService skuService;
	
	@RequestMapping("/skuList")
	public String skuList(Model model, Integer categoryId, Sku sku, @RequestParam(defaultValue="1")Integer pageNum, @RequestParam(defaultValue="2")Integer pageSize) {
		PageInfo<Sku> pageInfo = skuService.list(sku, pageNum, pageSize);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("sku", sku);
		return "sku_list";
	}
	
	@RequestMapping("/skuAdd")
	@ResponseBody
	public boolean skuAdd(Sku sku, MultipartFile file) throws IllegalStateException, IOException {
		String originalFilename = file.getOriginalFilename();
		if (StringUtils.isNotBlank(originalFilename)) {
			String fileName = UUID.randomUUID() + "_" + originalFilename;
			File destFile = new File("G://pic/", fileName);
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			file.transferTo(destFile);
			
			String oldPath = sku.getImage();
			if (StringUtils.isNotBlank(oldPath)) {
				FileUtils.forceDelete(new File("G://pic/" + oldPath));
			}
			sku.setImage(fileName);
		}
		return skuService.saveOrUpdateSku(sku) > 0;
	}
	
	@RequestMapping("/getSkuById")
	@ResponseBody
	public Map<String, Object> getSkuById(Integer id) {
		return skuService.getSkuById(id);
	}
	
	@RequestMapping("/skuDelete")
	@ResponseBody
	public boolean skuDelete(Integer[] ids) {
		return skuService.deleteSkuByIds(ids) > 0;
	}
}
