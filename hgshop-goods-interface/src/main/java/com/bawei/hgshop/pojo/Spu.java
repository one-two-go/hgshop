package com.bawei.hgshop.pojo;

import java.io.Serializable;
import java.util.List;

/**
 * spu实体类
 * @author coolface
 *
 */
public class Spu implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;  //id
	private String goodsName;  //商品名称
	private String isMarketable;  //是否上架 0:上架 1:下架
	private Integer brandId;  //品牌Id
	private String caption;  //副标题
	private Integer categoryId;  //分类Id
	private String smallPic;  //商品图片
	//spu列表展示属性
	private String bName;
	private String cName;
	
	
	private List<Sku> skuList;
	
//	private List<List<Integer>> optionIds;
	
	private Integer optionId;
		
	private Double startPrice;
	private Double endPrice;
	
	
	public Spu() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Spu(Integer id, String goodsName, String isMarketable, Integer brandId, String caption, Integer categoryId,
			String smallPic) {
		super();
		this.id = id;
		this.goodsName = goodsName;
		this.isMarketable = isMarketable;
		this.brandId = brandId;
		this.caption = caption;
		this.categoryId = categoryId;
		this.smallPic = smallPic;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getIsMarketable() {
		return isMarketable;
	}
	public void setIsMarketable(String isMarketable) {
		this.isMarketable = isMarketable;
	}
	public Integer getBrandId() {
		return brandId;
	}
	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public Integer getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}
	public String getSmallPic() {
		return smallPic;
	}
	public void setSmallPic(String smallPic) {
		this.smallPic = smallPic;
	}
	public String getbName() {
		return bName;
	}
	public void setbName(String bName) {
		this.bName = bName;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	
	
	
	
	
	
	
//	public List<List<Integer>> getOptionIds() {
//		return optionIds;
//	}
//	public void setOptionIds(List<List<Integer>> optionIds) {
//		this.optionIds = optionIds;
//	}
	
	
	
	public Double getStartPrice() {
		return startPrice;
	}
	public Integer getOptionId() {
		return optionId;
	}
	public void setOptionId(Integer optionId) {
		this.optionId = optionId;
	}
	public void setStartPrice(Double startPrice) {
		this.startPrice = startPrice;
	}
	public Double getEndPrice() {
		return endPrice;
	}
	public void setEndPrice(Double endPrice) {
		this.endPrice = endPrice;
	}
	
	
	public List<Sku> getSkuList() {
		return skuList;
	}
	public void setSkuList(List<Sku> skuList) {
		this.skuList = skuList;
	}
	@Override
	public String toString() {
		return "Spu [id=" + id + ", goodsName=" + goodsName + ", isMarketable=" + isMarketable + ", brandId=" + brandId
				+ ", caption=" + caption + ", categoryId=" + categoryId + ", smallPic=" + smallPic + "]";
	}
	
	
}
