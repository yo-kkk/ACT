package com.project.act.models_dto;

import java.io.Serializable;
import java.sql.Date;

import org.apache.commons.codec.digest.DigestUtils;

public class EmployeeDTO implements Serializable{
	private String emp_id				;
	private String emp_password         ;
	private String name                 ;
	private PositionDTO positionDTO     ;
	private String phone                ;
	private String address              ;
	private Date birthday       	    ;
	private Date hire_date           	;
	private Date retire_date	        ;
	private StoresDTO storeDTO      	;
	private long salary					;
	private int idx						;
	private PageDTO pageDTO				;
	
	public PageDTO getPageDTO() {
		return pageDTO;
	}

	public void setPageDTO(PageDTO pageDTO) {
		this.pageDTO = pageDTO;
	}

	public EmployeeDTO() {}
	


	public EmployeeDTO(String emp_id, String emp_password, String name, PositionDTO positionDTO, String phone,
			String address, Date birthday, Date hire_date, Date retire_date, StoresDTO storeDTO, long salary, int idx,
			PageDTO pageDTO) {
		super();
		this.emp_id = emp_id;
		this.emp_password = emp_password;
		this.name = name;
		this.positionDTO = positionDTO;
		this.phone = phone;
		this.address = address;
		this.birthday = birthday;
		this.hire_date = hire_date;
		this.retire_date = retire_date;
		this.storeDTO = storeDTO;
		this.salary = salary;
		this.idx = idx;
		this.pageDTO = pageDTO;
	}

	@Override
	public String toString() {
		return "EmployeeDTO [emp_id=" + emp_id + ", emp_password=" + emp_password + ", name=" + name + ", positionDTO="
				+ positionDTO + ", phone=" + phone + ", address=" + address + ", birthday=" + birthday + ", hire_date="
				+ hire_date + ", retire_date=" + retire_date + ", storeDTO=" + storeDTO + ", salary=" + salary
				+ ", idx=" + idx + ", pageDTO=" + pageDTO + "]";
	}



	public String getEmp_id() {
		return emp_id;
	}

	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}

	public String getEmp_password() {
		return emp_password;
	}

	public void setEmp_password(String emp_password) {
		this.emp_password = DigestUtils.sha512Hex(emp_password);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public PositionDTO getPositionDTO() {
		return positionDTO;
	}

	public void setPositionDTO(PositionDTO positionDTO) {
		this.positionDTO = positionDTO;
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

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Date getHire_date() {
		return hire_date;
	}

	public void setHire_date(Date hire_date) {
		this.hire_date = hire_date;
	}

	public Date getRetire_date() {
		return retire_date;
	}

	public void setRetire_date(Date retire_date) {
		this.retire_date = retire_date;
	}

	public StoresDTO getStoreDTO() {
		return storeDTO;
	}

	public void setStoreDTO(StoresDTO storeDTO) {
		this.storeDTO = storeDTO;
	}

	public long getSalary() {
		return salary;
	}

	public void setSalary(long salary) {
		this.salary = salary;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	
	
}
