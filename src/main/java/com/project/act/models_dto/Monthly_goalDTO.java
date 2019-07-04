package com.project.act.models_dto;

public class Monthly_goalDTO {
	
	private Daily_incomeDTO daily_incomeDTO;
	private StoresDTO storesDTO ;
	private String object_month ;
	private long monthly_target 	;
	private long monthly_income  ;
	private String pay_yn;
	private EmployeeDTO empDTO;
	private PageDTO pageDTO;
	public PageDTO getPageDTO() {
		return pageDTO;
	}



	public void setPageDTO(PageDTO pageDTO) {
		this.pageDTO = pageDTO;
	}



	public String getPay_yn() {
		return pay_yn;
	}



	public void setPay_yn(String pay_yn) {
		this.pay_yn = pay_yn;
	}
	private int count;
	

	
	public Monthly_goalDTO() {
		super();
	}


	
	public Monthly_goalDTO(Daily_incomeDTO daily_incomeDTO, StoresDTO storesDTO, String object_month,
			long monthly_target, long monthly_income, String pay_yn, EmployeeDTO empDTO, int count,PageDTO pageDTO) {
		super();
		this.daily_incomeDTO = daily_incomeDTO;
		this.storesDTO = storesDTO;
		this.object_month = object_month;
		this.monthly_target = monthly_target;
		this.monthly_income = monthly_income;
		this.pay_yn = pay_yn;
		this.empDTO = empDTO;
		this.count = count;
		this.pageDTO=pageDTO;
	}



	@Override
	public String toString() {
		return "Monthly_goalDTO [daily_incomeDTO=" + daily_incomeDTO + ", storesDTO=" + storesDTO + ", object_month="
				+ object_month + ", monthly_target=" + monthly_target + ", monthly_income=" + monthly_income
				+ ", pay_yn=" + pay_yn + ", empDTO=" + empDTO + ", pageDTO=" + pageDTO + ", count=" + count + "]";
	}



	public Daily_incomeDTO getDaily_incomeDTO() {
		return daily_incomeDTO;
	}
	public void setDaily_incomeDTO(Daily_incomeDTO daily_incomeDTO) {
		this.daily_incomeDTO = daily_incomeDTO;
	}
	public StoresDTO getStoresDTO() {
		return storesDTO;
	}
	public void setStoresDTO(StoresDTO storesDTO) {
		this.storesDTO = storesDTO;
	}
	public String getObject_month() {
		return object_month;
	}
	public void setObject_month(String object_month) {
		this.object_month = object_month;
	}
	public long getMonthly_target() {
		return monthly_target;
	}
	public void setMonthly_target(long monthly_target) {
		this.monthly_target = monthly_target;
	}
	public long getMonthly_income() {
		return monthly_income;
	}
	public void setMonthly_income(long monthly_income) {
		this.monthly_income = monthly_income;
	}
	public EmployeeDTO getEmpDTO() {
		return empDTO;
	}
	public void setEmpDTO(EmployeeDTO empDTO) {
		this.empDTO = empDTO;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

	
	
	
	
}
