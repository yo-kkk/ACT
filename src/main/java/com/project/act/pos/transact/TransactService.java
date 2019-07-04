package com.project.act.pos.transact;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.Store_stockDTO;
import com.project.act.models_dto.TransactDTO;


public interface TransactService {

	List<Store_stockDTO> product_list(Map<String, Object> map) throws SQLException;

	void transact_all(TransactDTO transactDTO, String[] product_quantity) throws Exception;

	long get_total_count(Map<String, Object> map) throws Exception;

}
