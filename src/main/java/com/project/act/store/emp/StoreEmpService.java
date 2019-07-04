package com.project.act.store.emp;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PositionDTO;

public interface StoreEmpService {

	//public List<EmployeeDTO> getcomList(Map<String, Object> map)  throws SQLException;

	public EmployeeDTO getEmpInfo(String emp_id) throws Exception;

	public PositionDTO getPositionInfo(int position_code) throws  Exception;

	public void storeCommuteInsert(EmployeeDTO employeeDTO) throws Exception ;
	
	public List<String> select_store(String location_code) throws SQLException;

	public EmployeeDTO getStoreList(String emp_id) throws Exception;

	//public Long toca(String keyword)throws Exception;

	List<EmployeeDTO> getcomList(Map<String, Object> map) throws SQLException;

	public Long toca(Map<String, Object> map);

	public void updateEmpInfo(EmployeeDTO employeeDTO);

	

}
