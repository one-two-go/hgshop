package com.bawei.hgshop.dao;

import java.util.List;

import com.bawei.hgshop.pojo.Brand;
import com.bawei.hgshop.pojo.Category;
import com.bawei.hgshop.pojo.Spu;

public interface SpuMapper {

	List<Spu> selectSpuList(Spu spu);

	Integer insertSpu(Spu spu);

	Spu selectSpuById(Integer id);

	Integer deleteSpuByIds(Integer[] ids);

	Integer updateSpu(Spu spu);

	List<Spu> selectSpus();
	
	
	

	List<Integer> selectSpuIdsBySearch(Spu spu);
	
	List<Spu> selectSpuByIds(List<Integer> spuIds);

	List<Category> selectCategoryBySpuIds(List<Integer> spuIds);

	List<Brand> selectBrandBySpuIds(List<Integer> spuIds);



}
