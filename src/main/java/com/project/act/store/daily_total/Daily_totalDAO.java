package com.project.act.store.daily_total;

import java.sql.SQLException;
import java.util.List;

import com.project.act.models_dto.Daily_incomeDTO;

public interface Daily_totalDAO {

	long get_totalCount(Daily_incomeDTO daily_incomeDTO) throws SQLException;

	List<Daily_incomeDTO> get_List(Daily_incomeDTO daily_incomeDTO) throws SQLException;

}
