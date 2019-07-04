package com.project.act.head.emp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.HeadEmpDAO;
import com.project.act.models_dto.PositionDTO;

@Service
public class HeadEmpServiceImpl implements HeadEmpService{
	@Autowired
	private HeadEmpDAO headEmpDAO;

	@Override
	public void headEmpinsert(EmployeeDTO employeeDTO) throws Exception {
		headEmpDAO.headEmpinsert(employeeDTO);
	}

	@Override
	public PositionDTO getPositionInfo(int position_code_forminsal) throws Exception {
		return headEmpDAO.getPositionInfo(position_code_forminsal);
	}
	
	@Override
	public List<EmployeeDTO> getEmpList() throws Exception {
		
		return headEmpDAO.getEmpList();
	}
	
	@Override
	public EmployeeDTO getEmpInfo(String emp_id) throws Exception {
		return headEmpDAO.getEmpInfo(emp_id);
	}
	
	@Override
	public void updateEmpInfo(EmployeeDTO employeeDTO) throws Exception {
		headEmpDAO.updateEmpInfo(employeeDTO);
	}
	
	@Override
	public void retireEmp(EmployeeDTO employeeDTO) throws Exception {
		headEmpDAO.retireEmp(employeeDTO);
	}
	
	@Override
	public List<EmployeeDTO> search(Map<String, Object> map) throws Exception {	
		return headEmpDAO.search(map);
	}

	@Override
	public List<String> select_store(String location_code) throws Exception {
		return headEmpDAO.select_store(location_code);
	}
	
	@Override
	public Long searchCnt(Map<String, Object> map) throws Exception {
		return headEmpDAO.searchCnt(map);
	}
		
}
