package com.project.act.pos.transact;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.Store_stockDTO;
import com.project.act.models_dto.TransactDTO;

@Service
public class TransactServiceImpl implements TransactService{
	
	private static final Logger logger = LoggerFactory.getLogger(TransactServiceImpl.class);
	
	@Autowired
	private TransactDAO transactDAO;

	@Override
	public List<Store_stockDTO> product_list(Map<String, Object> map) throws SQLException {

		return transactDAO.product_list(map);
	}
	
	@Override
	public long get_total_count(Map<String, Object> map) throws Exception {

		return transactDAO.get_total_count(map);
	}

	@Override
	public void transact_all(TransactDTO transactDTO, String[] product_quantity) throws SQLException {
		
		transactDAO.transact_basic(transactDTO);
		
		for(int i=1;i<product_quantity.length;i++) {
			Map<String, Object> map = new HashMap();
			map.put("store_name",transactDTO.getStoreDTO().getStore_name());
			map.put("transact_code", transactDTO.getTransaction_code() );
			map.put("product_code",product_quantity[i].split(",")[0] );
			map.put("quantity",product_quantity[i].split(",")[1] );
			
			transactDAO.transact_detail(map);
			transactDAO.transact_stock(map);
		}
		
	}

	
}
