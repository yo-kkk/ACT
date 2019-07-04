package com.project.act.head.daily;

import java.sql.SQLException;
import java.util.List;

import com.project.act.models_dto.Daily_incomeDTO;

public interface DailyService {

	long get_totalCount(Daily_incomeDTO daily_incomeDTO) throws SQLException;

	List<Daily_incomeDTO> get_List(Daily_incomeDTO daily_incomeDTO) throws SQLException;

	List<String> select_store(String location_code) throws SQLException;

}
