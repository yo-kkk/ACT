package com.project.act.models_dto;

import java.io.Serializable;

public class TransactDTO implements Serializable{
	private String transaction_code;
	private StoresDTO storeDTO;
	private String ages;
	private String sex;
	private String payment;
	private String trans_date;
	private String refund_yn;
	private String refund_date;
	private long total_price;
	private String casher_id;
	private PageDTO pageDTO;
	
	public TransactDTO() {}
	
	public TransactDTO(String transaction_code, StoresDTO storeDTO, String ages, String sex, String payment,
			String trans_date, String refund_yn, String refund_date, long total_price, String casher_id,
			PageDTO pageDTO) {
		super();
		this.transaction_code = transaction_code;
		this.storeDTO = storeDTO;
		this.ages = ages;
		this.sex = sex;
		this.payment = payment;
		this.trans_date = trans_date;
		this.refund_yn = refund_yn;
		this.refund_date = refund_date;
		this.total_price = total_price;
		this.casher_id = casher_id;
		this.pageDTO = pageDTO;
	}



	@Override
	public String toString() {
		return "TransactDTO [transaction_code=" + transaction_code + ", storeDTO=" + storeDTO + ", ages=" + ages
				+ ", sex=" + sex + ", payment=" + payment + ", trans_date=" + trans_date + ", refund_yn=" + refund_yn
				+ ", refund_date=" + refund_date + ", total_price=" + total_price + ", casher_id=" + casher_id
				+ ", pageDTO=" + pageDTO + "]";
	}



	public String getTransaction_code() {
		return transaction_code;
	}

	public StoresDTO getStoreDTO() {
		return storeDTO;
	}

	public String getAges() {
		return ages;
	}

	public String getSex() {
		return sex;
	}

	public String getPayment() {
		return payment;
	}

	public String getTrans_date() {
		return trans_date;
	}

	public String getRefund_yn() {
		return refund_yn;
	}

	public String getRefund_date() {
		return refund_date;
	}

	public long getTotal_price() {
		return total_price;
	}

	public String getCasher_id() {
		return casher_id;
	}

	public PageDTO getPageDTO() {
		return pageDTO;
	}

	public void setTransaction_code(String transaction_code) {
		this.transaction_code = transaction_code;
	}

	public void setStoreDTO(StoresDTO storeDTO) {
		this.storeDTO = storeDTO;
	}

	public void setAges(String ages) {
		this.ages = ages;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public void setTrans_date(String trans_date) {
		this.trans_date = trans_date;
	}

	public void setRefund_yn(String refund_yn) {
		this.refund_yn = refund_yn;
	}

	public void setRefund_date(String refund_date) {
		this.refund_date = refund_date;
	}

	public void setTotal_price(long total_price) {
		this.total_price = total_price;
	}

	public void setCasher_id(String casher_id) {
		this.casher_id = casher_id;
	}

	public void setPageDTO(PageDTO pageDTO) {
		this.pageDTO = pageDTO;
	}

	
	
	
}
