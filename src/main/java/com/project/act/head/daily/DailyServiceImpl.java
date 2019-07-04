package com.project.act.head.daily;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.Daily_incomeDTO;

@Service
public class DailyServiceImpl implements DailyService {
	private static final Logger logger = LoggerFactory.getLogger(DailyServiceImpl.class);

	@Autowired
	private DailyDAO dailyDAO;

	@Override
	public long get_totalCount(Daily_incomeDTO daily_incomeDTO) throws SQLException {

		return dailyDAO.get_totalCount(daily_incomeDTO);
	}

	@Override
	public List<Daily_incomeDTO> get_List(Daily_incomeDTO daily_incomeDTO) throws SQLException {

		return dailyDAO.get_List(daily_incomeDTO);
	}

	@Override
	public List<String> select_store(String location_code) throws SQLException {
		
		return dailyDAO.select_store(location_code);
	}
}
