package com.project.act.login;

public class GetInfoDTO {
	private String emp_id;
	private String start;
	private String end;
	
	public GetInfoDTO() {}


	public GetInfoDTO(String emp_id, String start, String end) {
		super();
		this.emp_id = emp_id;
		this.start = start;
		this.end = end;
	}

	@Override
	public String toString() {
		return "GetInfoDTO [emp_id=" + emp_id + ", start=" + start + ", end=" + end + "]";
	}



	public String getEmp_id() {
		return emp_id;
	}



	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}



	public String getStart() {
		return start;
	}



	public void setStart(String start) {
		this.start = start;
	}



	public String getEnd() {
		return end;
	}



	public void setEnd(String end) {
		this.end = end;
	}
	
	
	
}
