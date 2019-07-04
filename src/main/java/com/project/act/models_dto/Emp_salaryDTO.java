package com.project.act.models_dto;

public class Emp_salaryDTO {
	private String bs_month         ;
	private long  monthly_salary   ;
	private String pay_yn           ;
	private EmployeeDTO empDTO;




	@Override
	public String toString() {
		return "Emp_salaryDTO [bs_month=" + bs_month + ", monthly_salary=" + monthly_salary + ", pay_yn=" + pay_yn
				+ ", empDTO=" + empDTO + "]";
	}


	public Emp_salaryDTO(String bs_month, long monthly_salary, String pay_yn, EmployeeDTO empDTO) {
		super();
		this.bs_month = bs_month;
		this.monthly_salary = monthly_salary;
		this.pay_yn = pay_yn;
		this.empDTO = empDTO;
	}


	public EmployeeDTO getEmpDTO() {
		return empDTO;
	}


	public void setEmpDTO(EmployeeDTO empDTO) {
		this.empDTO = empDTO;
	}


	public Emp_salaryDTO() {
		super();
	}

	
	public String getBs_month() {
		return bs_month;
	}

	public void setBs_month(String bs_month) {
		this.bs_month = bs_month;
	}

	public long getMonthly_salary() {
		return monthly_salary;
	}

	public void setMonthly_salary(long monthly_salary) {
		this.monthly_salary = monthly_salary;
	}

	public String getPay_yn() {
		return pay_yn;
	}

	public void setPay_yn(String pay_yn) {
		this.pay_yn = pay_yn;
	}

	

}
