package com.bawei.hgshop.pojo;

import java.io.Serializable;

/**
 * sku与规格参数关联的中间表
 * @author coolface
 *
 */
public class SkuSpec implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer skuId;	//sku的id
	private Integer specId;  //spec的id
	private Integer specOptionId;  //spec_option的id
	
	public SkuSpec() {
		super();
	}
	public SkuSpec(Integer id, Integer skuId, Integer specId, Integer specOptionId) {
		super();
		this.id = id;
		this.skuId = skuId;
		this.specId = specId;
		this.specOptionId = specOptionId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSkuId() {
		return skuId;
	}
	public void setSkuId(Integer skuId) {
		this.skuId = skuId;
	}
	public Integer getSpecId() {
		return specId;
	}
	public void setSpecId(Integer specId) {
		this.specId = specId;
	}
	public Integer getSpecOptionId() {
		return specOptionId;
	}
	public void setSpecOptionId(Integer specOptionId) {
		this.specOptionId = specOptionId;
	}
	
	@Override
	public String toString() {
		return "SkuSpec [id=" + id + ", skuId=" + skuId + ", specId=" + specId + ", specOptionId=" + specOptionId + "]";
	}
	
	
}
