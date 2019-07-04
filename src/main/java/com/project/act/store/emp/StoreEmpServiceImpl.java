package com.project.act.store.emp;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PositionDTO;
@Service
public class StoreEmpServiceImpl implements StoreEmpService{

	@Autowired
	private StoreEmpDAO storeEmpDAO;
	
	
	@Override
	public EmployeeDTO getEmpInfo(String returnID)throws Exception {
		
		return storeEmpDAO.getEmpInfo(returnID);
	}

	@Override
	public PositionDTO getPositionInfo(int position_code_forminsal)throws Exception {
		
		return storeEmpDAO.getPositionInfo(position_code_forminsal);
	}

	@Override
	public void storeCommuteInsert(EmployeeDTO employeeDTO) throws Exception {

		storeEmpDAO.storeCommuteInsert(employeeDTO);

	}

	@Override
	public List<String> select_store(String location_code)throws SQLException {
		return storeEmpDAO.select_store(location_code);
	}

	@Override
	public EmployeeDTO getStoreList(String emp_id) throws Exception {
		return storeEmpDAO.getStoreList(emp_id);
	}




//	@Override
//	public Long toca(String keyword) throws Exception {
//		// TODO Auto-generated method stub
//		return storeEmpDAO.toca(keyword);
//	}

	/*
	 * @Override public List<EmployeeDTO> getcomList(EmployeeDTO employeeDTO) throws
	 * SQLException { // TODO Auto-generated method stub return
	 * storeEmpDAO.getcomList(employeeDTO); }
	 */
	@Override
	public Long toca(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return storeEmpDAO.toca(map);
	}

	@Override
	public List<EmployeeDTO> getcomList(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return storeEmpDAO.getcomList(map);

	}

	@Override
	public void updateEmpInfo(EmployeeDTO employeeDTO) {
		 storeEmpDAO.updateEmpInfo(employeeDTO);
		
	}



}
