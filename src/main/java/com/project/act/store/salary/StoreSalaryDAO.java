package com.project.act.store.salary;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.Emp_salaryDTO;

public interface StoreSalaryDAO {

	List<Emp_salaryDTO> getMonthlySalaryList(String emp_id) throws SQLException;

	List<CommuteDTO> getPartTimerCommuteList(String emp_id)throws SQLException;

	List<CommuteDTO> getSearchCommuteList(CommuteDTO commDTO)throws SQLException;

	void payAlbalSalary(Emp_salaryDTO salaryDTO)throws SQLException;

	long total_count(Map map) throws SQLException;

	List<Emp_salaryDTO> list_pg(Map map) throws SQLException;

}
