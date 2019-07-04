package com.project.act.store.transact_list;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

public interface Transact_listDAO {

	long get_totalCount(TransactDTO transactDTO) throws SQLException;

	List<TransactDTO> get_List(TransactDTO transactDTO) throws SQLException;

	List<Transact_detailDTO> get_detail(long transaction_code) throws SQLException;

	TransactDTO search(Map<String, String> map) throws SQLException;

}
