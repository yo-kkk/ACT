package com.project.act.store.salary;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.Emp_salaryDTO;

@Service
public class StoreServiceImpl implements StoreSalaryService{
	
	@Autowired
	private StoreSalaryDAO storeSalaryDAO;
	
	
	@Override
	public List<Emp_salaryDTO> getMonthlySalaryList(String emp_id) throws Exception {
		return storeSalaryDAO.getMonthlySalaryList(emp_id);
	}


	@Override
	public List<CommuteDTO> getPartTimerCommuteList(String emp_id) throws Exception {
		return storeSalaryDAO.getPartTimerCommuteList(emp_id);
	}


	@Override
	public List<CommuteDTO> getSearchCommuteList(CommuteDTO commDTO) throws Exception {
		
		return storeSalaryDAO.getSearchCommuteList(commDTO);
	}


	@Override
	public void payAlbalSalary(Emp_salaryDTO salaryDTO) throws Exception {
		storeSalaryDAO.payAlbalSalary(salaryDTO);
		
	}


	@Override
	public long total_count(Map map) throws Exception {

		return storeSalaryDAO.total_count(map);
	}


	@Override
	public List<Emp_salaryDTO> list_pg(Map map) throws Exception {
		
		return storeSalaryDAO.list_pg(map);
	}



}
