package com.project.act.store.daily_total;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.Daily_incomeDTO;

@Service
public class Daily_totalServiceImpl implements Daily_totalService{
	
	@Autowired
	private Daily_totalDAO daily_totalDAO;

	@Override
	public long get_totalCount(Daily_incomeDTO daily_incomeDTO) throws SQLException {
		
		return daily_totalDAO.get_totalCount(daily_incomeDTO);
	}

	@Override
	public List<Daily_incomeDTO> get_List(Daily_incomeDTO daily_incomeDTO) throws SQLException {
		
		return daily_totalDAO.get_List(daily_incomeDTO);
	}
	
	
}
