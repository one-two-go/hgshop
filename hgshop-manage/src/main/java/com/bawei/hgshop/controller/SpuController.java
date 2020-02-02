package com.bawei.hgshop.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bawei.hgshop.pojo.Spu;
import com.bawei.hgshop.service.SpuService;
import com.github.pagehelper.PageInfo;

@Controller
public class SpuController {

	@Reference(url="dubbo://localhost:20890",timeout=5000)
	private SpuService spuService;
	
	@RequestMapping("/showCategoryTree")
	public String showCategoryTree() {
		return "spu_list";
	}
	
	@RequestMapping("/spuList")
	public String spuList(Model model, Integer categoryId, Spu spu, @RequestParam(defaultValue="1")Integer pageNum, @RequestParam(defaultValue="2")Integer pageSize) {
		//1.设置spu中categoryId属性
		if (categoryId != null) {
			spu.setCategoryId(categoryId);
		}
		//2.查询列表
		PageInfo<Spu> pageInfo = spuService.list(spu, pageNum, pageSize);
		model.addAttribute("pageInfo", pageInfo);
		spu.setCategoryId(categoryId);
		model.addAttribute("spu", spu);
		return "spu_list1";
	}
	
	@RequestMapping("/spuAdd")
	@ResponseBody
	public boolean spuAdd(Spu spu, MultipartFile file) throws IllegalStateException, IOException {
		//1.如果有图片，就上传图片；如果没有，就跳过
		String fileName = file.getOriginalFilename();
		if (StringUtils.isNotBlank(fileName)) {
			//1.1.生成存放图片的路径
			//G://pic
			//G://pic/20200111
			//G://pic/20200112
			String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
			fileName = date + "/" + fileName;
			//File destFile = new File("G://pic"+File.separator+date, fileName);
			File destFile = new File("G://pic", fileName);
			
			if (!destFile.getParentFile().exists()) {
				destFile.getParentFile().mkdirs();
			}
			//1.2.上传图片
			file.transferTo(destFile);
			//1.3.如果是修改操作，并且替换成了新图片，需要删除之前的旧图片
			if (StringUtils.isNotBlank(spu.getSmallPic())) {
				//不好使,试试
//				new File("G://pic/" + spu.getSmallPic()).delete();
				//jetty:run 报错!
				//tomcat7:run 报错! 本地仓库的jar包替换一下
				FileUtils.forceDelete(new File("G://pic/" + spu.getSmallPic()));
			}
			//1.4.给spu的smallPic属性赋值
			spu.setSmallPic(fileName);
		}
		//2.保持spu信息
		return spuService.saveOrUpdateSpu(spu) > 0;
	}
	
	@RequestMapping("/getSpuById")
	@ResponseBody
	public Spu getSpuById(Integer id) {
		return spuService.getSpuById(id);
	}
	
	@RequestMapping("/spuDelete")
	@ResponseBody
	public boolean spuDelete(Integer[] ids) {
		return spuService.deleteSpuByIds(ids) > 0;
	}
	
	
	@RequestMapping("/spus")
	@ResponseBody
	public List<Spu> spus() {
		return spuService.spus();
	}
	
	
	
}
