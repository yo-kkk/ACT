package com.project.act.pos.closing;

import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.Daily_incomeDTO;
import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

@Service
public class ClosingServiceImpl implements ClosingService{
	private static final Logger logger = LoggerFactory.getLogger(ClosingServiceImpl.class);

	@Autowired
	private ClosingDAO closingDAO;

	@Override
	public List<TransactDTO> transact_daily_list(TransactDTO transactDTO) throws SQLException {

		return closingDAO.transact_daily_list(transactDTO);
	}
	
	@Override
	public long get_totalCount(String store_name) throws SQLException {

		return closingDAO.get_totalCount(store_name);
	}

	
	@Override
	public List<TransactDTO> transact_before_list(TransactDTO transactDTO) throws SQLException {

		return closingDAO.transact_before_list(transactDTO);
	}
	
	@Override
	public List<TransactDTO> transact_after_list(TransactDTO transactDTO) throws SQLException {

		return closingDAO.transact_after_list(transactDTO);
	}
	
	@Override
	public Daily_incomeDTO getDaily_income(String store_name) throws SQLException {
		
		return closingDAO.getDaily_income(store_name);
	}

	@Override
	public List<Transact_detailDTO> get_detail(long transaction_code) throws SQLException {

		return closingDAO.get_detail(transaction_code);
	}

	@Override
	public void closing_btn(Daily_incomeDTO daily_incomeDTO) throws SQLException {
		
		closingDAO.closing_btn(daily_incomeDTO);
		
	}

	@Override
	public void delete_closing(String store_name) throws SQLException {
		
		closingDAO.delete_closing(store_name);
	}

	@Override
	public long totalCount_before(TransactDTO transactDTO) throws SQLException {
		
		return closingDAO.totalCount_before(transactDTO);
	}

	
}
