package com.project.act.models_dto;

import java.io.Serializable;

public class EventDTO implements Serializable{
	private long event_code				;
	private StoresDTO storesDTO         ;
	private ProductDTO productDTO       ;
	private String event_name           ;
	private String start_date           ;
	private String end_date             ;
	private int discount_rate           ; 
	private PageDTO pageDTO	;
	
	public EventDTO() {
		super();
	}

	public EventDTO(long event_code, StoresDTO storesDTO, ProductDTO productDTO, String event_name, String start_date,
			String end_date, int discount_rate, PageDTO pageDTO) {
		super();
		this.event_code = event_code;
		this.storesDTO = storesDTO;
		this.productDTO = productDTO;
		this.event_name = event_name;
		this.start_date = start_date;
		this.end_date = end_date;
		this.discount_rate = discount_rate;
		this.pageDTO = pageDTO;
	}

	@Override
	public String toString() {
		return "EventDTO [event_code=" + event_code + ", storesDTO=" + storesDTO + ", productDTO=" + productDTO
				+ ", event_name=" + event_name + ", start_date=" + start_date + ", end_date=" + end_date
				+ ", discount_rate=" + discount_rate + ", pageDTO=" + pageDTO + "]";
	}

	public long getEvent_code() {
		return event_code;
	}

	public void setEvent_code(long event_code) {
		this.event_code = event_code;
	}

	public StoresDTO getStoresDTO() {
		return storesDTO;
	}

	public void setStoresDTO(StoresDTO storesDTO) {
		this.storesDTO = storesDTO;
	}

	public ProductDTO getProductDTO() {
		return productDTO;
	}

	public void setProductDTO(ProductDTO productDTO) {
		this.productDTO = productDTO;
	}

	public String getEvent_name() {
		return event_name;
	}

	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public int getDiscount_rate() {
		return discount_rate;
	}

	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}

	public PageDTO getPageDTO() {
		return pageDTO;
	}

	public void setPageDTO(PageDTO pageDTO) {
		this.pageDTO = pageDTO;
	}
	
	
	
	
}