package com.project.act.models_dto;

import java.io.Serializable;

public class Store_stockDTO implements Serializable{
	private ProductDTO productDTO	;
	private StoresDTO storeDTO		;
	private long quantity			;
	private PageDTO pageDTO			;
	private EventDTO eventDTO		;
	
	public Store_stockDTO() {}

	@Override
	public String toString() {
		return "Store_stockDTO [productDTO=" + productDTO + ", storeDTO=" + storeDTO + ", quantity=" + quantity
				+ ", pageDTO=" + pageDTO + ", eventDTO=" + eventDTO + "]";
	}
	
	public Store_stockDTO(ProductDTO productDTO, StoresDTO storeDTO, long quantity, PageDTO pageDTO,
			EventDTO eventDTO) {
		super();
		this.productDTO = productDTO;
		this.storeDTO = storeDTO;
		this.quantity = quantity;
		this.pageDTO = pageDTO;
		this.eventDTO = eventDTO;
	}

	public ProductDTO getProductDTO() {
		return productDTO;
	}

	public StoresDTO getStoreDTO() {
		return storeDTO;
	}

	public long getQuantity() {
		return quantity;
	}

	public PageDTO getPageDTO() {
		return pageDTO;
	}

	public EventDTO getEventDTO() {
		return eventDTO;
	}

	public void setProductDTO(ProductDTO productDTO) {
		this.productDTO = productDTO;
	}

	public void setStoreDTO(StoresDTO storeDTO) {
		this.storeDTO = storeDTO;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

	public void setPageDTO(PageDTO pageDTO) {
		this.pageDTO = pageDTO;
	}

	public void setEventDTO(EventDTO eventDTO) {
		this.eventDTO = eventDTO;
	}
	
	
	

}
