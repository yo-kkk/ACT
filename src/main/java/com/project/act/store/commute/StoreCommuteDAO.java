package com.project.act.store.commute;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PositionDTO;


public interface StoreCommuteDAO {

	List<CommuteDTO> getCommuteList(Map map)throws SQLException;
	List<EmployeeDTO> getEmpList(String emp_id)throws SQLException;
	void addCommute(CommuteDTO commuteDTO)throws SQLException;
	void updateCommute(CommuteDTO commuteDTO)throws SQLException;

	PositionDTO getPositionInfo(int position_code)throws Exception;
	void storeCommuteInsert(EmployeeDTO employeeDTO)throws Exception;
	EmployeeDTO getEmpInfo(String returnID)throws Exception;
	List<String> select_store(String location_code)throws SQLException;
	List<EmployeeDTO> getcomList()throws SQLException;
	void delComm(CommuteDTO commuteDTO)throws SQLException;
	long list_count(String store_name);

}
