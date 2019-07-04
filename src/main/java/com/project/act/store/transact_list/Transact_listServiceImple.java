package com.project.act.store.transact_list;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

@Service
public class Transact_listServiceImple implements Transact_listService {

	@Autowired
	private Transact_listDAO transact_listDAO;

	@Override
	public long get_totalCount(TransactDTO transactDTO) throws SQLException {
		
		return transact_listDAO.get_totalCount(transactDTO);
	}

	@Override
	public List<TransactDTO> get_List(TransactDTO transactDTO) throws SQLException {

		return transact_listDAO.get_List(transactDTO);
	}

	@Override
	public List<Transact_detailDTO> get_detail(long transaction_code) throws SQLException {
		
		return transact_listDAO.get_detail(transaction_code);
	}

	@Override
	public TransactDTO search(Map<String, String> map) throws SQLException {
		
		return transact_listDAO.search(map);
	}
}
