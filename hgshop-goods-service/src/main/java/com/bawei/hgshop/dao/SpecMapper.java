package com.bawei.hgshop.dao;

import java.util.List;

import com.bawei.hgshop.pojo.Spec;
import com.bawei.hgshop.pojo.SpecOption;

public interface SpecMapper {

	List<Spec> selectSpecList(Spec spec);

	Integer insertSpec(Spec spec);

	void insertSpecOption(SpecOption specOption);

	Spec selectSpecById(Integer id);

	Integer updateSpec(Spec spec);

	void deleteSpecOptionBySpecId(Integer specId);

	Integer deleteSpecByIds(Integer[] ids);

	void deleteSpecOptionBySpecIds(Integer[] specIds);

	List<Spec> selectSpecByIds(List<Integer> specIds);

	List<Spec> selectSpecs();
	
	
	
	
	
	
	

	List<Spec> selectSpecBySpuIds(List<Integer> spuIds);

}
