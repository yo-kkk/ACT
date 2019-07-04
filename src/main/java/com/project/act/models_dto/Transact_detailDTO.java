package com.project.act.models_dto;

import java.io.Serializable;

public class Transact_detailDTO implements Serializable{
	private TransactDTO transactDTO;
	private ProductDTO productDTO;
	private int quantity;
	private EventDTO eventDTO;
	
	@Override
	public String toString() {
		return "Transact_detailDTO [transactDTO=" + transactDTO + ", productDTO=" + productDTO + ", quantity="
				+ quantity + ", eventDTO=" + eventDTO + "]";
	}

	public Transact_detailDTO(TransactDTO transactDTO, ProductDTO productDTO, int quantity, EventDTO eventDTO) {
		super();
		this.transactDTO = transactDTO;
		this.productDTO = productDTO;
		this.quantity = quantity;
		this.eventDTO = eventDTO;
	}

	public Transact_detailDTO() {}

	public TransactDTO getTransactDTO() {
		return transactDTO;
	}

	public ProductDTO getProductDTO() {
		return productDTO;
	}

	public int getQuantity() {
		return quantity;
	}

	public EventDTO getEventDTO() {
		return eventDTO;
	}

	public void setTransactDTO(TransactDTO transactDTO) {
		this.transactDTO = transactDTO;
	}

	public void setProductDTO(ProductDTO productDTO) {
		this.productDTO = productDTO;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public void setEventDTO(EventDTO eventDTO) {
		this.eventDTO = eventDTO;
	}
	
	
	
}
