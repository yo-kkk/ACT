package com.project.act.head.emp;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PositionDTO;

public interface HeadEmpService {

	void headEmpinsert(EmployeeDTO employeeDTO) throws Exception;

	PositionDTO getPositionInfo(int position_code_forminsal) throws Exception;

	List<EmployeeDTO> getEmpList() throws Exception;

	EmployeeDTO getEmpInfo(String emp_id) throws Exception;

	void updateEmpInfo(EmployeeDTO employeeDTO) throws Exception;

	void retireEmp(EmployeeDTO employeeDTO) throws Exception;

	List<String> select_store(String location_code) throws Exception;

	List<EmployeeDTO> search(Map<String, Object> map) throws Exception;

	Long searchCnt(Map<String, Object> map) throws Exception;




	
}
