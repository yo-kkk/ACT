package com.project.act.models_dto;

import java.io.Serializable;

public class StoresDTO implements Serializable{
	private String store_name		 	;
	private EmployeeDTO supervisorDTO	;
	private String phone				;
	private String address				;
	private String location				;
	
	public StoresDTO() {}

	public StoresDTO(String store_name, EmployeeDTO supervisorDTO, String phone, String address, String location) {
		super();
		this.store_name = store_name;
		this.supervisorDTO = supervisorDTO;
		this.phone = phone;
		this.address = address;
		this.location = location;
	}


	@Override
	public String toString() {
		return "StoresDTO [store_name=" + store_name + ", supervisorDTO=" + supervisorDTO + ", phone=" + phone
				+ ", address=" + address + ", location=" + location + "]";
	}


	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public EmployeeDTO getSupervisorDTO() {
		return supervisorDTO;
	}

	public void setSupervisorDTO(EmployeeDTO supervisorDTO) {
		this.supervisorDTO = supervisorDTO;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
	
	
}
