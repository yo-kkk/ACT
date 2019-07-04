package com.project.act.models_dto;

import java.io.Serializable;

public class BoardDTO implements Serializable{
	private long boa_no;
	private String name;
	private int status;
	
	public BoardDTO() {}
	
	public BoardDTO(long boa_no, String name, int status) {
		super();
		this.boa_no = boa_no;
		this.name = name;
		this.status = status;
	}
	@Override
	public String toString() {
		return "BoardDTO [boa_no=" + boa_no + ", name=" + name + ", status=" + status + "]";
	}
	public long getBoa_no() {
		return boa_no;
	}
	public void setBoa_no(long boa_no) {
		this.boa_no = boa_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	

}
