package com.project.act.head.salary;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.Emp_salaryDTO;
import com.project.act.models_dto.EventDTO;
import com.project.act.models_dto.Monthly_goalDTO;

public interface SalaryService {

	List<EventDTO> getSalaryList()throws Exception;

	List<Monthly_goalDTO> getMonthlyGoalList()throws Exception;

	

	void getTargetEmp(Monthly_goalDTO goalDTO)throws Exception;

	void updateYN(Monthly_goalDTO goalDTO)throws Exception;

	List<Emp_salaryDTO> pastEmpSalaryList()throws Exception;

	long total_count(Map map) throws Exception;

	List<Emp_salaryDTO> list_pg(Map map) throws Exception;

	List<String> select_store(String location_code) throws Exception;

}
