package com.project.act.models_dto;

import java.io.Serializable;

public class FactoryDTO implements Serializable{
	private long   factory_code			;
	private String factory_name         ;
	private String supervisor           ;
	private String address              ;
	private String phone                ;
	
	public FactoryDTO() {}
	
	public FactoryDTO(long factory_code, String factory_name, String supervisor, String address, String phone) {
		super();
		this.factory_code = factory_code;
		this.factory_name = factory_name;
		this.supervisor = supervisor;
		this.address = address;
		this.phone = phone;
	}
	
	@Override
	public String toString() {
		return "FactoryDTO [factory_code=" + factory_code + ", factory_name=" + factory_name + ", supervisor="
				+ supervisor + ", address=" + address + ", phone=" + phone + "]";
	}
	public long getFactory_code() {
		return factory_code;
	}
	public void setFactory_code(long factory_code) {
		this.factory_code = factory_code;
	}
	public String getFactory_name() {
		return factory_name;
	}
	public void setFactory_name(String factory_name) {
		this.factory_name = factory_name;
	}
	public String getSupervisor() {
		return supervisor;
	}
	public void setSupervisor(String supervisor) {
		this.supervisor = supervisor;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
}
