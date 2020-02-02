package com.bawei.hgshop.pojo;

import java.io.Serializable;
import java.util.List;

/**
 * 规格参数实体类
 * @author coolface
 *
 */
public class Spec implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;	//id
	private String specName;  //规格参数名称
	private List<SpecOption> options;  //规格参数选项列表
	
	private String optionNames;
	
	public Spec() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Spec(Integer id, String specName, List<SpecOption> options) {
		super();
		this.id = id;
		this.specName = specName;
		this.options = options;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getSpecName() {
		return specName;
	}
	public void setSpecName(String specName) {
		this.specName = specName;
	}
	public List<SpecOption> getOptions() {
		return options;
	}
	public void setOptions(List<SpecOption> options) {
		this.options = options;
	}
	public String getOptionNames() {
		return optionNames;
	}
	public void setOptionNames(String optionNames) {
		this.optionNames = optionNames;
	}
	@Override
	public String toString() {
		return "Spec [id=" + id + ", specName=" + specName + ", options=" + options + "]";
	}
	
	
}
