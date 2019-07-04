package com.project.act.models_dto;

import java.io.Serializable;

public class Daily_incomeDTO implements Serializable{
	private StoresDTO storeDTO		;
	private String bs_date			;
	private long total_income		;
	private String reg_time			;
	private long remain_cash		;
	private String closing_id		;
	private PageDTO pageDTO			;
	
	
	
	
	@Override
	public String toString() {
		return "Daily_incomeDTO [storeDTO=" + storeDTO + ", bs_date=" + bs_date + ", total_income=" + total_income
				+ ", reg_time=" + reg_time + ", remain_cash=" + remain_cash + ", closing_id=" + closing_id
				+ ", pageDTO=" + pageDTO + "]";
	}

	public Daily_incomeDTO(StoresDTO storeDTO, String bs_date, long total_income, String reg_time, long remain_cash,
			String closing_id, PageDTO pageDTO) {
		super();
		this.storeDTO = storeDTO;
		this.bs_date = bs_date;
		this.total_income = total_income;
		this.reg_time = reg_time;
		this.remain_cash = remain_cash;
		this.closing_id = closing_id;
		this.pageDTO = pageDTO;
	}

	public Daily_incomeDTO() {}

	public StoresDTO getStoreDTO() {
		return storeDTO;
	}

	public String getBs_date() {
		return bs_date;
	}

	public long getTotal_income() {
		return total_income;
	}

	public String getReg_time() {
		return reg_time;
	}

	public long getRemain_cash() {
		return remain_cash;
	}

	public String getClosing_id() {
		return closing_id;
	}

	public PageDTO getPageDTO() {
		return pageDTO;
	}

	public void setStoreDTO(StoresDTO storeDTO) {
		this.storeDTO = storeDTO;
	}

	public void setBs_date(String bs_date) {
		this.bs_date = bs_date;
	}

	public void setTotal_income(long total_income) {
		this.total_income = total_income;
	}

	public void setReg_time(String reg_time) {
		this.reg_time = reg_time;
	}

	public void setRemain_cash(long remain_cash) {
		this.remain_cash = remain_cash;
	}

	public void setClosing_id(String closing_id) {
		this.closing_id = closing_id;
	}

	public void setPageDTO(PageDTO pageDTO) {
		this.pageDTO = pageDTO;
	}
	
}
