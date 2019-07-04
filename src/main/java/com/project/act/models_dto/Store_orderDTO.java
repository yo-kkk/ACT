package com.project.act.models_dto;

import java.io.Serializable;

public class Store_orderDTO implements Serializable{
	private long store_order_code		;
	private ProductDTO productDTO		;
	private StoresDTO storeDTO			;
	private long quantity				;
	private String order_date			;
	private String receive_yn			;
	private String send_yn				;
	private EmployeeDTO empDTO			;
	
	public Store_orderDTO() {}	

	public Store_orderDTO(long store_order_code, ProductDTO productDTO, StoresDTO storeDTO, long quantity,
			String order_date, String receive_yn, String send_yn, EmployeeDTO empDTO) {
		super();
		this.store_order_code = store_order_code;
		this.productDTO = productDTO;
		this.storeDTO = storeDTO;
		this.quantity = quantity;
		this.order_date = order_date;
		this.receive_yn = receive_yn;
		this.send_yn = send_yn;
		this.empDTO = empDTO;
	}

	public long getStore_order_code() {
		return store_order_code;
	}
	public void setStore_order_code(long store_order_code) {
		this.store_order_code = store_order_code;
	}
	public ProductDTO getProductDTO() {
		return productDTO;
	}
	public void setProductDTO(ProductDTO productDTO) {
		this.productDTO = productDTO;
	}
	public StoresDTO getStoreDTO() {
		return storeDTO;
	}
	public void setStoreDTO(StoresDTO storeDTO) {
		this.storeDTO = storeDTO;
	}
	public long getQuantity() {
		return quantity;
	}
	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getReceive_yn() {
		return receive_yn;
	}
	public void setReceive_yn(String receive_yn) {
		this.receive_yn = receive_yn;
	}

	public EmployeeDTO getEmpDTO() {
		return empDTO;
	}

	public void setEmpDTO(EmployeeDTO empDTO) {
		this.empDTO = empDTO;
	}
		

	public String getSend_yn() {
		return send_yn;
	}

	public void setSend_yn(String send_yn) {
		this.send_yn = send_yn;
	}

	@Override
	public String toString() {
		return "Store_orderDTO [store_order_code=" + store_order_code + ", productDTO=" + productDTO + ", storeDTO="
				+ storeDTO + ", quantity=" + quantity + ", order_date=" + order_date + ", receive_yn=" + receive_yn
				+ ", send_yn=" + send_yn + ", empDTO=" + empDTO + "]";
	}

	
}
