package com.project.act.models_dto;

import java.io.Serializable;
import java.sql.Date;



public class CommuteDTO implements Serializable{
	private EmployeeDTO empDTO			;
	private String work_date				;
	private String start_time			;
	private String end_time				;
	private String etc					;
	private String work_minute 			;
	
	public CommuteDTO() {}

	public CommuteDTO(EmployeeDTO empDTO, String work_date, String start_time, String end_time, String etc,
			String work_minute) {
		super();
		this.empDTO = empDTO;
		this.work_date = work_date;
		this.start_time = start_time;
		this.end_time = end_time;
		this.etc = etc;
		this.work_minute = work_minute;
	}

	@Override
	public String toString() {
		return "CommuteDTO [empDTO=" + empDTO + ", work_date=" + work_date + ", start_time=" + start_time
				+ ", end_time=" + end_time + ", etc=" + etc + ", work_minute=" + work_minute + "]";
	}


	public String getWork_minute() {
		return work_minute;
	}



	public void setWork_minute(String work_minute) {
		this.work_minute = work_minute;
	}



	public EmployeeDTO getEmpDTO() {
		return empDTO;
	}

	public void setEmpDTO(EmployeeDTO empDTO) {
		this.empDTO = empDTO;
	}

	public String getWork_date() {
		return work_date;
	}

	public void setWork_date(String work_date2) {
		this.work_date = work_date2;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	
	
}
