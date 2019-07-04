package com.project.act.pos.stock;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.Store_stockDTO;

@Service
public class StockServiceImpl implements StockService{
	
	@Autowired
	private StockDAO stockDAO;

	@Override
	public List<Store_stockDTO> getStock_list(Map<String, Object> map) throws SQLException {
		
		List<Store_stockDTO> list = stockDAO.getStock_list(map);
		List<Store_stockDTO> resultList = new ArrayList<Store_stockDTO>();		
		
		for(Store_stockDTO stockDTO : list) {
			ProductDTO productDTO = stockDAO.getDetail(stockDTO.getProductDTO().getProduct_code());
			stockDTO.setProductDTO(productDTO);
			resultList.add(stockDTO);
		}
				
		return resultList;
	}

	@Override
	public ProductDTO getDetail(String product_code) throws SQLException {
		
		return stockDAO.getDetail(product_code);
	}

	@Override
	public List<String> getOther_store(String store_name) throws SQLException {
		
		return stockDAO.getOther_store(store_name);
	}


	@Override
	public long get_totalCount(Map<String, Object> map_search) throws SQLException {
		
		return stockDAO.get_totalCount(map_search);
	}



}
