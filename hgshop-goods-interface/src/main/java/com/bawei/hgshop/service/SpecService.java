package com.bawei.hgshop.service;

import java.util.List;

import com.bawei.hgshop.pojo.Spec;
import com.github.pagehelper.PageInfo;

public interface SpecService {
	PageInfo<Spec> list(Spec spec, Integer pageNum, Integer pageSize);

	Integer saveOrUpdateSpec(Spec spec);

	Spec getSpecById(Integer id);

	Integer deleteSpecByIds(Integer[] ids);

	List<Spec> specs();
}
