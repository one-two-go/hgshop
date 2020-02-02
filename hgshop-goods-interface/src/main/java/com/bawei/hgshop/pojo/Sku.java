package com.bawei.hgshop.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * sku实体类
 * @author coolface
 *
 */
public class Sku implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;  //id
	private String title;  //标题
	private String sellPoint;  //卖点
	private Integer price;  //价格
	private Integer stockCount;  //库存
	private String barcode;  //条形码
	private String image;  //图片
	private String status;  //状态 0:上架 1:下架
	private Date createTime; //创建时间
	private Date updateTime; //修改时间
	private Integer costPrice; //成本价格
	private Integer marketPrice; //市场价格
	private Integer spuId; //spuId
	private String cartThumbnail; //购物车页面展示的缩略图
	
	private List<SkuSpec> skuSpec; //sku对应的规格参数列表
	
	
	
	public Sku() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Sku(Integer id, String title, String sellPoint, Integer price, Integer stockCount, String barcode,
			String image, String status, Date createTime, Date updateTime, Integer costPrice, Integer marketPrice,
			Integer spuId, String cartThumbnail) {
		super();
		this.id = id;
		this.title = title;
		this.sellPoint = sellPoint;
		this.price = price;
		this.stockCount = stockCount;
		this.barcode = barcode;
		this.image = image;
		this.status = status;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.costPrice = costPrice;
		this.marketPrice = marketPrice;
		this.spuId = spuId;
		this.cartThumbnail = cartThumbnail;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSellPoint() {
		return sellPoint;
	}
	public void setSellPoint(String sellPoint) {
		this.sellPoint = sellPoint;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getStockCount() {
		return stockCount;
	}
	public void setStockCount(Integer stockCount) {
		this.stockCount = stockCount;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getCostPrice() {
		return costPrice;
	}
	public void setCostPrice(Integer costPrice) {
		this.costPrice = costPrice;
	}
	public Integer getMarketPrice() {
		return marketPrice;
	}
	public void setMarketPrice(Integer marketPrice) {
		this.marketPrice = marketPrice;
	}
	public Integer getSpuId() {
		return spuId;
	}
	public void setSpuId(Integer spuId) {
		this.spuId = spuId;
	}
	public String getCartThumbnail() {
		return cartThumbnail;
	}
	public void setCartThumbnail(String cartThumbnail) {
		this.cartThumbnail = cartThumbnail;
	}
	
	
	public List<SkuSpec> getSkuSpec() {
		return skuSpec;
	}
	public void setSkuSpec(List<SkuSpec> skuSpec) {
		this.skuSpec = skuSpec;
	}
	
	
	@Override
	public String toString() {
		return "Sku [id=" + id + ", title=" + title + ", sellPoint=" + sellPoint + ", price=" + price + ", stockCount="
				+ stockCount + ", barcode=" + barcode + ", image=" + image + ", status=" + status + ", createTime="
				+ createTime + ", updateTime=" + updateTime + ", costPrice=" + costPrice + ", marketPrice="
				+ marketPrice + ", spuId=" + spuId + ", cartThumbnail=" + cartThumbnail + "]";
	}
	
	
}
