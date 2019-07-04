package com.project.act.pos.refund;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

public interface RefundDAO {

	List<TransactDTO> get_transact_list(TransactDTO transactDTO) throws SQLException;
	
	long get_totalCount(String store_name) throws SQLException;
	
	List<Transact_detailDTO> get_detail(long transaction_code) throws SQLException;

	TransactDTO search(Map<String, String> map) throws SQLException;

	void update_org(TransactDTO transactDTO) throws SQLException;

	void insert_new(TransactDTO transactDTO) throws SQLException;

	List<TransactDTO> get_refund_list(TransactDTO transactDTO) throws SQLException;

	TransactDTO search_refund_list(String keyword) throws SQLException;

	long totalCount_refundList(String store_name) throws SQLException;

	
}
