package com.project.act.store.salary;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.Emp_salaryDTO;

public interface StoreSalaryService {

	List<Emp_salaryDTO> getMonthlySalaryList(String emp_id) throws Exception;

	List<CommuteDTO> getPartTimerCommuteList(String emp_id)throws Exception;

	List<CommuteDTO> getSearchCommuteList(CommuteDTO commDTO)throws Exception;

	void payAlbalSalary(Emp_salaryDTO salaryDTO)throws Exception;

	long total_count(Map map) throws Exception;

	List<Emp_salaryDTO> list_pg(Map map) throws Exception;


}
