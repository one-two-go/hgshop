package com.bawei.hgshop.pojo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

/**
 * spu实体类
 * @author coolface
 *
 */
@Document(indexName="docs",type="spu",shards=1,replicas=1)
public class ESSpu implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;  //id
	private Integer brandId;  //品牌Id
	private Integer categoryId;  //分类Id
	@Field(type=FieldType.Text,analyzer="ik_max_word")
	private String keyword;  //关键字
	@Field(type=FieldType.Text,analyzer="ik_max_word")
	private String title; //标题
	private List<Sku> skus;
	private Map<String, Object> specs;
		
	
	public ESSpu() {
		super();
		// TODO Auto-generated constructor stub
	}


	public ESSpu(Integer id, Integer brandId, Integer categoryId, String keyword, String title, List<Sku> skus,
			Map<String, Object> specs) {
		super();
		this.id = id;
		this.brandId = brandId;
		this.categoryId = categoryId;
		this.keyword = keyword;
		this.title = title;
		this.skus = skus;
		this.specs = specs;
	}





	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public Integer getBrandId() {
		return brandId;
	}


	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}


	public Integer getCategoryId() {
		return categoryId;
	}


	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}


	public String getKeyword() {
		return keyword;
	}


	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public List<Sku> getSkus() {
		return skus;
	}


	public void setSkus(List<Sku> skus) {
		this.skus = skus;
	}



	public Map<String, Object> getSpecs() {
		return specs;
	}


	public void setSpecs(Map<String, Object> specs) {
		this.specs = specs;
	}


	@Override
	public String toString() {
		return "ESSpu [id=" + id + ", brandId=" + brandId + ", categoryId=" + categoryId + ", keyword=" + keyword
				+ ", title=" + title + ", skus=" + skus + ", specs=" + specs + "]";
	}


	
}

