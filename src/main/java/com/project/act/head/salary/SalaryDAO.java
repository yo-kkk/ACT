package com.project.act.head.salary;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.Emp_salaryDTO;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.EventDTO;
import com.project.act.models_dto.Monthly_goalDTO;

public interface SalaryDAO {

	List<EventDTO> getSalaryList()throws SQLException;

	List<Monthly_goalDTO> getMonthlyGoalList()throws SQLException;

	List<EmployeeDTO> getTargetEmp(String storeName)throws SQLException;

	Monthly_goalDTO getTarget(Monthly_goalDTO goalDTO)throws SQLException;

	void insertBonus(Emp_salaryDTO salaryDTO)throws SQLException;

	long getMonthlySalary(String emp_id)throws SQLException;

	void updateYN(Monthly_goalDTO goalDTO)throws SQLException;

	List<Emp_salaryDTO> pastEmpSalaryList()throws SQLException;

	long total_count(Map map) throws SQLException;

	List<Emp_salaryDTO> list_pg(Map map) throws SQLException;

	List<String> select_store(String location_code) throws SQLException;

}
