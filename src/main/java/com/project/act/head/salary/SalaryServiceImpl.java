package com.project.act.head.salary;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.Emp_salaryDTO;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.EventDTO;
import com.project.act.models_dto.Monthly_goalDTO;

@Service
public class SalaryServiceImpl implements SalaryService{
	@Autowired
	private SalaryDAO salaryDAO;

	@Override
	public List<EventDTO> getSalaryList() throws Exception {
		return salaryDAO.getSalaryList();
	}

	@Override
	public List<Monthly_goalDTO> getMonthlyGoalList() throws Exception {
		return salaryDAO.getMonthlyGoalList();
	}


	@Override
	public void getTargetEmp(Monthly_goalDTO goalDTO) throws Exception {
		List<EmployeeDTO> empList = salaryDAO.getTargetEmp(goalDTO.getStoresDTO().getStore_name());
		
		for(int i = 0; i< empList.size(); i++) {
			EmployeeDTO emp_name = empList.get(i);
			Monthly_goalDTO mgDTO = salaryDAO.getTarget(goalDTO);
			mgDTO.setStoresDTO(goalDTO.getStoresDTO());
			mgDTO.setObject_month(goalDTO.getObject_month());
			mgDTO.setEmpDTO(emp_name);
			System.out.println("mgDTO★"+mgDTO);	
			long target = mgDTO.getMonthly_target();
			long income = mgDTO.getMonthly_income();
			
			long mothlySalary = salaryDAO.getMonthlySalary(emp_name.getEmp_id());
			
			if(income>=target) {
				Emp_salaryDTO salaryDTO = new Emp_salaryDTO();
		
				int bonus = (int)((income-target)/target*100/2);
				long totalSalary = mothlySalary + bonus;
				System.out.println("a====="+goalDTO.getObject_month());
				salaryDTO.setBs_month(goalDTO.getObject_month());
				salaryDTO.setEmpDTO(emp_name);
				salaryDTO.setMonthly_salary(totalSalary);
				
				salaryDAO.insertBonus(salaryDTO);
				
			}
			
		}
	}

	@Override
	public void updateYN(Monthly_goalDTO goalDTO) throws Exception {
		salaryDAO.updateYN(goalDTO);
		
	}

	@Override
	public List<Emp_salaryDTO> pastEmpSalaryList() throws Exception {
		return salaryDAO.pastEmpSalaryList();
	}

	@Override
	public long total_count(Map map) throws Exception {

		return salaryDAO.total_count(map);
	}

	@Override
	public List<Emp_salaryDTO> list_pg(Map map) throws Exception {

		return salaryDAO.list_pg(map);
	}

	@Override
	public List<String> select_store(String location_code) throws Exception {
		
		return salaryDAO.select_store(location_code);
	}
}
