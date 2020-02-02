/**
 * 
 */
package com.bawei.hgshop.dao;

import java.util.List;

import com.bawei.hgshop.pojo.Sku;
import com.bawei.hgshop.pojo.SkuSpec;

/**
 * @author coolface
 *
 */
public interface SkuMapper {

	List<Sku> selectSkuList(Sku sku);

	Integer insertSku(Sku sku);

	Integer updateSku(Sku sku);

	void insertSkuSpec(SkuSpec skuSpec);

	void updateSkuSpec(SkuSpec skuSpec);

	Sku selectSkuById(Integer id);

	Integer deleteSkuByIds(Integer[] ids);

	void deleteSkuSpecBySkuIds(Integer[] ids);
	
	

	
	
	List<Sku> selectNews(int num);

	List<Sku> selectSkusBySpuId(Integer spuId);

	
}
