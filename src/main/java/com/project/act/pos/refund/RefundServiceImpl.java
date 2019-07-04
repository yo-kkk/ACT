package com.project.act.pos.refund;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

@Service
public class RefundServiceImpl implements RefundService{
	private static final Logger logger = LoggerFactory.getLogger(RefundServiceImpl.class);

	@Autowired
	private RefundDAO refundDAO;

	@Override
	public List<TransactDTO> get_transact_list(TransactDTO transactDTO) throws SQLException {
		
		return refundDAO.get_transact_list(transactDTO);
	}
	
	@Override
	public long get_totalCount(String store_name) throws SQLException {

		return refundDAO.get_totalCount(store_name);
	}

	@Override
	public List<Transact_detailDTO> get_detail(long transaction_code) throws SQLException {
		
		return refundDAO.get_detail(transaction_code);
	}

	@Override
	public TransactDTO search(Map<String, String> map) throws SQLException {
		
		return refundDAO.search(map);
	}

	@Override
	public void refund_all(TransactDTO transactDTO) throws SQLException {
		
		//원래 transact 내역 update
		refundDAO.update_org(transactDTO);
		
		logger.info(transactDTO.getTotal_price()+"");

		//r_transaction_code insert
		refundDAO.insert_new(transactDTO);
	}

	@Override
	public List<TransactDTO> get_refund_list(TransactDTO transactDTO) throws SQLException {
		
		return refundDAO.get_refund_list(transactDTO);
	}
	
	@Override
	public long totalCount_refundList(String store_name) throws SQLException {
		
		return refundDAO.totalCount_refundList(store_name);
	}

	@Override
	public TransactDTO search_refund_list(String keyword) throws SQLException {
		
		return refundDAO.search_refund_list(keyword);
	}

	

}
