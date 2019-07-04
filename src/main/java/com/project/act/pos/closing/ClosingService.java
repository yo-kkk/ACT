package com.project.act.pos.closing;

import java.sql.SQLException;
import java.util.List;

import com.project.act.models_dto.Daily_incomeDTO;
import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

public interface ClosingService {

	List<TransactDTO> transact_daily_list(TransactDTO transactDTO) throws SQLException;
	
	long get_totalCount(String store_name) throws SQLException;
	
	List<Transact_detailDTO> get_detail(long transaction_code) throws SQLException;

	void closing_btn(Daily_incomeDTO daily_incomeDTO) throws SQLException;

	Daily_incomeDTO getDaily_income(String store_name) throws SQLException;

	void delete_closing(String store_name) throws SQLException;

	List<TransactDTO> transact_after_list(TransactDTO transactDTO) throws SQLException;

	List<TransactDTO> transact_before_list(TransactDTO transactDTO) throws SQLException;

	long totalCount_before(TransactDTO transactDTO) throws SQLException;

	

}
