package com.bawei.hgshop.pojo;

import java.io.Serializable;

/**
 * 规格参数选项实体类
 * @author coolface
 *
 */
public class SpecOption implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	private Integer id;  //id
	private String optionName;  //选项值
	private Integer specId;  //规格参数Id
	private Integer orders;  //排序字段
	public SpecOption() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SpecOption(Integer id, String optionName, Integer specId, Integer orders) {
		super();
		this.id = id;
		this.optionName = optionName;
		this.specId = specId;
		this.orders = orders;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOptionName() {
		return optionName;
	}
	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}
	public Integer getSpecId() {
		return specId;
	}
	public void setSpecId(Integer specId) {
		this.specId = specId;
	}
	public Integer getOrders() {
		return orders;
	}
	public void setOrders(Integer orders) {
		this.orders = orders;
	}
	@Override
	public String toString() {
		return "SpecOption [id=" + id + ", optionName=" + optionName + ", specId=" + specId + ", orders=" + orders
				+ "]";
	}
	
	
}
