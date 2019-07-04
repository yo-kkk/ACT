package com.project.act.models_dto;

import java.io.Serializable;
import java.sql.Date;

public class ProductDTO implements Serializable{
	private String product_code 		;
	private String product_name         ;
	private int manufact_year     	    ;
	private String manufact_seas        ;
	private String sex                  ;
	private String category1            ;
	private String category2            ;
	private String fit                  ;
	private String color                ;
	private String sizes                ;
	private FactoryDTO factoryDTO       ;
	private Date reg_date		        ;
	private String season_off           ;
	private long head_stock_quantity    ;
	private String img_name             ;
	private int    price				;
	private PageDTO pageDTO				;
	
	public ProductDTO() {}
	
	public ProductDTO(String product_code, String product_name, int manufact_year, String manufact_seas, String sex,
			String category1, String category2, String fit, String color, String sizes, FactoryDTO factoryDTO,
			Date reg_date, String season_off, long head_stock_quantity, String img_name, int price, PageDTO pageDTO) {
		super();
		this.product_code = product_code;
		this.product_name = product_name;
		this.manufact_year = manufact_year;
		this.manufact_seas = manufact_seas;
		this.sex = sex;
		this.category1 = category1;
		this.category2 = category2;
		this.fit = fit;
		this.color = color;
		this.sizes = sizes;
		this.factoryDTO = factoryDTO;
		this.reg_date = reg_date;
		this.season_off = season_off;
		this.head_stock_quantity = head_stock_quantity;
		this.img_name = img_name;
		this.price = price;
		this.pageDTO = pageDTO;
	}

	@Override
	public String toString() {
		return "ProductDTO [product_code=" + product_code + ", product_name=" + product_name + ", manufact_year="
				+ manufact_year + ", manufact_seas=" + manufact_seas + ", sex=" + sex + ", category1=" + category1
				+ ", category2=" + category2 + ", fit=" + fit + ", color=" + color + ", sizes=" + sizes
				+ ", factoryDTO=" + factoryDTO + ", reg_date=" + reg_date + ", season_off=" + season_off
				+ ", head_stock_quantity=" + head_stock_quantity + ", img_name=" + img_name + ", price=" + price
				+ ", pageDTO=" + pageDTO + "]";
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getManufact_year() {
		return manufact_year;
	}

	public void setManufact_year(int manufact_year) {
		this.manufact_year = manufact_year;
	}

	public String getManufact_seas() {
		return manufact_seas;
	}

	public void setManufact_seas(String manufact_seas) {
		this.manufact_seas = manufact_seas;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getCategory1() {
		return category1;
	}

	public void setCategory1(String category1) {
		this.category1 = category1;
	}

	public String getCategory2() {
		return category2;
	}

	public void setCategory2(String category2) {
		this.category2 = category2;
	}

	public String getFit() {
		return fit;
	}

	public void setFit(String fit) {
		this.fit = fit;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getSizes() {
		return sizes;
	}

	public void setSizes(String sizes) {
		this.sizes = sizes;
	}

	public FactoryDTO getFactoryDTO() {
		return factoryDTO;
	}

	public void setFactoryDTO(FactoryDTO factoryDTO) {
		this.factoryDTO = factoryDTO;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public String getSeason_off() {
		return season_off;
	}

	public void setSeason_off(String season_off) {
		this.season_off = season_off;
	}

	public long getHead_stock_quantity() {
		return head_stock_quantity;
	}

	public void setHead_stock_quantity(long head_stock_quantity) {
		this.head_stock_quantity = head_stock_quantity;
	}

	public String getImg_name() {
		return img_name;
	}

	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public PageDTO getPageDTO() {
		return pageDTO;
	}

	public void setPageDTO(PageDTO pageDTO) {
		this.pageDTO = pageDTO;
	}

}
