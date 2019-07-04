package com.project.act.head.goal;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.Monthly_goalDTO;
import com.project.act.models_dto.StoresDTO;

@Service
public class HeadGoalServiceImpl implements HeadGoalService {

	@Autowired
	private HeadGoalDAO headGoalDAO;

	@Override
	public StoresDTO getStore(String store_name) {
		// TODO Auto-generated method stub
		return headGoalDAO.getStore(store_name);
	}

	@Override
	public List<String> select_store(String location_code) {
		// TODO Auto-generated method stub
		return headGoalDAO.select_store(location_code);
	}

	@Override
	public void headGoalInsert(Monthly_goalDTO monthly_goalDTO) throws Exception {
		// TODO Auto-generated method stub

		headGoalDAO.headGoalInsert(monthly_goalDTO);
	}

	@Override
	public Monthly_goalDTO overlap(String store_name) {
		// TODO Auto-generated method stub
		return headGoalDAO.overlap(store_name);

	}

	@Override
	public List<Monthly_goalDTO> getGoalList(Monthly_goalDTO monthly_goalDTO) throws Exception {

		// TODO Auto-generated method stub

		List<Monthly_goalDTO> list = headGoalDAO.getStoreObject();
	
		for (Monthly_goalDTO dto : list) {
			headGoalDAO.totalIncome(dto);
		}

		
		return headGoalDAO.getGoalList(monthly_goalDTO);
	}

	@Override
	public List<Monthly_goalDTO> select_month(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return headGoalDAO.select_month(map);
	}
	/*
	 * @Override public void totalIncome(Monthly_goalDTO monthly_goalDTO) throws
	 * Exception { headGoalDAO.totalIncome(monthly_goalDTO);
	 * 
	 * }
	 */

	/*
	 * @Override public void totalIncome(Monthly_goalDTO monthly_goalDTO) throws
	 * Exception { // TODO Auto-generated method stub
	 * 
	 * }
	 */

	@Override
	public Monthly_goalDTO totalIncome(long monthly_income, String store_name) {
		// TODO Auto-generated method stub
		return headGoalDAO.totalIncome(monthly_income, store_name);
	}

	@Override
	public long get_totalCount(Monthly_goalDTO monthly_goalDTO) throws SQLException {
		// TODO Auto-generated method stub
		return headGoalDAO.get_totalCount(monthly_goalDTO);
	}

}
