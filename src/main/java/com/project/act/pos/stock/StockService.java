package com.project.act.pos.stock;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.Store_stockDTO;



public interface StockService {

	List<Store_stockDTO> getStock_list(Map<String, Object> map) throws SQLException;

	ProductDTO getDetail(String product_code) throws SQLException;

	List<String> getOther_store(String store_name) throws SQLException;


	long get_totalCount(Map<String, Object> map_search) throws SQLException;

}
