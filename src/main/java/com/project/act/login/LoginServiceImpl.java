package com.project.act.login;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.EmployeeDTO;

@Service
public class LoginServiceImpl implements LoginService{
	
	@Autowired
	private LoginDAO loginDAO;

	@Override
	public EmployeeDTO getUser(EmployeeDTO empDTO) throws SQLException {
		EmployeeDTO userInfo = loginDAO.getUser(empDTO);
		
		if(userInfo==null) {
			throw new RuntimeException("사번 혹은 비밀번호가 틀립니다");
		}
		
		return loginDAO.getUser(empDTO);
	}

	@Override
	public void go_work(CommuteDTO commuteDTO) throws SQLException {
		loginDAO.go_work(commuteDTO);
	}

	@Override
	public void leave_work(CommuteDTO commuteDTO) throws SQLException {
		
		if(loginDAO.leave_work(commuteDTO)==0) {
			throw new RuntimeException("Nothing to update, didn't go work");
		}
		
	}

	@Override
	public List<CommuteDTO> getCommuteInfo(GetInfoDTO getInfoDTO)throws SQLException {
		return loginDAO.getCommuteInfo(getInfoDTO);
	}

	@Override
	public List<CommuteDTO> main_list(String emp_id) throws SQLException {

		return loginDAO.main_list(emp_id);
	}

}
