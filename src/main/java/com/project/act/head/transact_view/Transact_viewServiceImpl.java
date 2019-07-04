package com.project.act.head.transact_view;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

@Service
public class Transact_viewServiceImpl implements Transact_viewService {
	
	@Autowired
	private Transact_viewDAO transact_viewDAO;

	@Override
	public long get_totalCount(TransactDTO transactDTO) throws SQLException {
		
		return transact_viewDAO.get_totalCount(transactDTO);
	}

	@Override
	public List<TransactDTO> get_List(TransactDTO transactDTO) throws SQLException {
		
		return transact_viewDAO.get_List(transactDTO);
	}

	@Override
	public List<Transact_detailDTO> get_detail(long transaction_code) throws SQLException {
		
		return transact_viewDAO.get_detail(transaction_code);
	}

	@Override
	public List<String> select_store(String location_code) throws SQLException {
		
		return transact_viewDAO.select_store(location_code);
	}

	@Override
	public TransactDTO search(Map<String, String> map) throws SQLException {
		
		return transact_viewDAO.search(map);
	}

}
