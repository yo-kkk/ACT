package com.project.act.store.salary;

import java.io.Serializable;

public class SearchSalDTO implements Serializable{
	private String store_name;
	private String bs_month;
	
	public SearchSalDTO() {
		super();

	}

	public SearchSalDTO(String store_name, String bs_month) {
		super();
		this.store_name = store_name;
		this.bs_month = bs_month;
	}


	public String getStore_name() {
		return store_name;
	}


	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}


	public String getBs_month() {
		return bs_month;
	}


	public void setBs_month(String bs_month) {
		this.bs_month = bs_month;
	}


	@Override
	public String toString() {
		return "SearchSalDTO [store_name=" + store_name + ", bs_month=" + bs_month + "]";
	} 

}
