package com.bawei.hgshop.pojo;

import java.io.Serializable;

public class Cart implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;
	private Integer uid;
	private Integer skuId;
	private Integer pnum;
	private String createTime;
	private String updateTime;
	
	private String image;
	private String title;
	private Integer price;
	private Integer subPrice;
	
	
	public Cart() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Cart(Integer id, Integer uid, Integer skuId, Integer pnum, String createTime, String updateTime) {
		super();
		this.id = id;
		this.uid = uid;
		this.skuId = skuId;
		this.pnum = pnum;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public Integer getSkuId() {
		return skuId;
	}
	public void setSkuId(Integer skuId) {
		this.skuId = skuId;
	}
	public Integer getPnum() {
		return pnum;
	}
	public void setPnum(Integer pnum) {
		this.pnum = pnum;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getSubPrice() {
		return subPrice;
	}
	public void setSubPrice(Integer subPrice) {
		this.subPrice = subPrice;
	}
	@Override
	public String toString() {
		return "Cart [id=" + id + ", uid=" + uid + ", skuId=" + skuId + ", pnum=" + pnum + ", createTime=" + createTime
				+ ", updateTime=" + updateTime + "]";
	}
	
	
	
	
	
	
}
