package com.project.act.store.commute;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PositionDTO;


@Service
public class StoreCommuteServiceImpl implements StoreCommuteService{
	
	@Autowired
	private StoreCommuteDAO storeCommuteDAO;

	@Override
	public List<CommuteDTO> getCommuteList(Map map) throws SQLException {
		
		return storeCommuteDAO.getCommuteList(map);
	}

	@Override
	public void addCommute(CommuteDTO commuteDTO) throws SQLException {

		storeCommuteDAO.addCommute(commuteDTO);
	}

	@Override
	public List<EmployeeDTO> getEmpList(String emp_id) throws SQLException {
		return storeCommuteDAO.getEmpList(emp_id);
	}

	@Override
	public void updateCommute(CommuteDTO commuteDTO) throws SQLException {
		storeCommuteDAO.updateCommute(commuteDTO);
		
	}


	@Override
	public PositionDTO getPositionInfo(int position_code_forminsal)throws Exception {
		
		return storeCommuteDAO.getPositionInfo(position_code_forminsal);
	}

	@Override
	public void storeCommuteInsert(EmployeeDTO employeeDTO) throws Exception {
		// TODO Auto-generated method stub
		storeCommuteDAO.storeCommuteInsert(employeeDTO);

	}

	@Override
	public EmployeeDTO getEmpInfo(String returnID)throws Exception {
		// TODO Auto-generated method stub
		return storeCommuteDAO.getEmpInfo(returnID);
	}

	@Override
	public List<String> select_store(String location_code)throws SQLException {
		// TODO Auto-generated method stub
		return storeCommuteDAO.select_store(location_code);
	}

	@Override
	public List<EmployeeDTO> getcomList() throws SQLException{
		// TODO Auto-generated method stub
		return storeCommuteDAO.getcomList();
	}
	@Override
	public void delComm(CommuteDTO commuteDTO) throws SQLException {
		storeCommuteDAO.delComm(commuteDTO);
		
	}

	@Override
	public long list_count(String store_name) throws SQLException {

		return storeCommuteDAO.list_count(store_name);
	}



}
