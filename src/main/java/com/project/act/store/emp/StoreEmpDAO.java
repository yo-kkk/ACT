package com.project.act.store.emp;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PositionDTO;

public interface StoreEmpDAO {

	//public List<EmployeeDTO> getcomList();
	public EmployeeDTO getEmpInfo(String returnID) ;
	public PositionDTO getPositionInfo(int position_code_forminsal);
	public void storeCommuteInsert(EmployeeDTO employeeDTO);
	public List<String> select_store(String location_code);
	public EmployeeDTO getStoreList(String emp_id);
	public Long toca(Map<String, Object> map);
	public List<EmployeeDTO> getcomList(Map<String, Object> map);
	public void updateEmpInfo(EmployeeDTO employeeDTO);

	
	
}
