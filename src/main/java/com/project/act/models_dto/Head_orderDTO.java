package com.project.act.models_dto;

import java.io.Serializable;

public class Head_orderDTO implements Serializable{
	private long head_order_code		;
	private ProductDTO productDTO       ;
	private long quantity               ;
	private FactoryDTO factoryDTO		;
	private String order_date           ;
	private String receive_yn           ;
	private EmployeeDTO EmpDTO			;
	
	public Head_orderDTO() {}
		
	public Head_orderDTO(long head_order_code, ProductDTO productDTO, long quantity, FactoryDTO factoryDTO,
			String order_date, String receive_yn, EmployeeDTO empDTO) {
		super();
		this.head_order_code = head_order_code;
		this.productDTO = productDTO;
		this.quantity = quantity;
		this.factoryDTO = factoryDTO;
		this.order_date = order_date;
		this.receive_yn = receive_yn;
		EmpDTO = empDTO;
	}

	@Override
	public String toString() {
		return "Head_orderDTO [head_order_code=" + head_order_code + ", productDTO=" + productDTO + ", quantity="
				+ quantity + ", factoryDTO=" + factoryDTO + ", order_date=" + order_date + ", receive_yn=" + receive_yn
				+ ", EmpDTO=" + EmpDTO + "]";
	}

	public EmployeeDTO getEmpDTO() {
		return EmpDTO;
	}

	public void setEmpDTO(EmployeeDTO empDTO) {
		EmpDTO = empDTO;
	}

	public long getHead_order_code() {
		return head_order_code;
	}
	public void setHead_order_code(long head_order_code) {
		this.head_order_code = head_order_code;
	}
	public ProductDTO getProductDTO() {
		return productDTO;
	}
	public void setProductDTO(ProductDTO productDTO) {
		this.productDTO = productDTO;
	}
	public long getQuantity() {
		return quantity;
	}
	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}
	public FactoryDTO getFactoryDTO() {
		return factoryDTO;
	}
	public void setFactoryDTO(FactoryDTO factoryDTO) {
		this.factoryDTO = factoryDTO;
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

	
	

}
