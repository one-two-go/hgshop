package com.bawei.hgshop.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.bawei.hgshop.pojo.Spu;
import com.github.pagehelper.PageInfo;

public interface SpuService {
	PageInfo<Spu> list(Spu spu, Integer pageNum, Integer pageSize);

	Integer saveOrUpdateSpu(Spu spu);

	Spu getSpuById(Integer id);

	Integer deleteSpuByIds(Integer[] ids);

	List<Spu> spus();
	
	void saveOrUpdateESSpu(Integer spuId) throws IOException;
	
	
	
	
	
	Map<String, Object> getSpuList(Spu spu, Integer pageNum, Integer pageSize);

	Map<String, Object> search(String keyword, Integer pageNum, Integer pageSize, Map<String, String> filter);


}
