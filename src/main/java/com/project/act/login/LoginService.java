package com.project.act.login;

import java.sql.SQLException;
import java.util.List;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.EmployeeDTO;

public interface LoginService {

	EmployeeDTO getUser(EmployeeDTO empDTO) throws SQLException;
	void go_work(CommuteDTO commuteDTO) throws SQLException;
	void leave_work(CommuteDTO commuteDTO) throws SQLException;
	List<CommuteDTO> getCommuteInfo(GetInfoDTO getInfoDTO)throws SQLException;
	List<CommuteDTO> main_list(String emp_id) throws SQLException;
}
