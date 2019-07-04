package com.project.act.models_dto;

import java.io.Serializable;

public class PositionDTO implements Serializable{
	private int position_code	;
	private String name			;
	private long min_sal		;
	
	public PositionDTO() {}
	
	public PositionDTO(int position_code, String name, long min_sal) {
		super();
		this.position_code = position_code;
		this.name = name;
		this.min_sal = min_sal;
	}
	
	@Override
	public String toString() {
		return "PositionDTO [position_code=" + position_code + ", name=" + name + ", min_sal=" + min_sal + "]";
	}
	public int getPosition_code() {
		
		return position_code;
	}
	public void setPosition_code(int position_code) {
		this.position_code = position_code;
	}
	public void setPosition_code(String position_code) {	
		this.position_code = Integer.parseInt(position_code);
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public long getMin_sal() {
		return min_sal;
	}
	public void setMin_sal(long min_sal) {
		this.min_sal = min_sal;
	}
	
	
}
