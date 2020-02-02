package com.bawei.hgshop.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.dubbo.config.annotation.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.bawei.hgshop.dao.SpecMapper;
import com.bawei.hgshop.pojo.Spec;
import com.bawei.hgshop.pojo.SpecOption;
import com.bawei.hgshop.service.SpecService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class SpecServiceImpl implements SpecService {

	@Autowired
	private SpecMapper specMapper;
	
	@Override
	public PageInfo<Spec> list(Spec spec, Integer pageNum, Integer pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Spec> list = specMapper.selectSpecList(spec);
		PageInfo<Spec> pageInfo = new PageInfo<>(list);
		return pageInfo;
	}

	@Override
	public Integer saveOrUpdateSpec(Spec spec) {
		Integer count = null;
		if (spec.getId() == null) {
			//1.新增
			//1.1.插入hg_spec
			count = specMapper.insertSpec(spec);
		} else {
			//2.修改
			//2.1.修改hg_spec
			count = specMapper.updateSpec(spec);
			//2.2.删除对应的hg_spec_option所有的记录
			specMapper.deleteSpecOptionBySpecId(spec.getId());
		}
		//3.批量插入hg_spec_option
		for (SpecOption specOption : spec.getOptions()) {
			if (StringUtils.isNotBlank(specOption.getOptionName())) {
				specOption.setSpecId(spec.getId());
				specMapper.insertSpecOption(specOption);
			}
		}
		return count;
	}

	@Override
	public Spec getSpecById(Integer id) {
		return specMapper.selectSpecById(id);
	}

	@Override
	public Integer deleteSpecByIds(Integer[] ids) {
		Integer count = specMapper.deleteSpecByIds(ids);
		specMapper.deleteSpecOptionBySpecIds(ids);
		return count;
	}

	@Override
	public List<Spec> specs() {
		return specMapper.selectSpecs();
	}

}
