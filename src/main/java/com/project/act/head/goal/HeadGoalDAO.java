package com.project.act.head.goal;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.Monthly_goalDTO;
import com.project.act.models_dto.StoresDTO;

public interface HeadGoalDAO {

//	List<String> select_store(String location_code);

	void headGoalInsert(Monthly_goalDTO monthly_goalDTO) throws Exception;

	StoresDTO getStore(String store_name);

	List<String> select_store(String location_code);

	Monthly_goalDTO overlap(String store_name);

	List<Monthly_goalDTO> getGoalList(Monthly_goalDTO monthly_goalDTO);

	List<Monthly_goalDTO> select_month(Map<String, Object> map) throws Exception;

	void totalIncome(Monthly_goalDTO dto)throws Exception;

	Monthly_goalDTO totalIncome(long monthly_income, String store_name);

	List<Monthly_goalDTO> getStoreObject();

	long get_totalCount(Monthly_goalDTO monthly_goalDTO)throws SQLException;

}
