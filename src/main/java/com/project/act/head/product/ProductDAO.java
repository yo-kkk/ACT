package com.project.act.head.product;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.Head_orderDTO;
import com.project.act.models_dto.ProductDTO;

public interface ProductDAO {
	
	void productinsert(ProductDTO productDTO) throws Exception;
	
	List<ProductDTO> productSearch(String keyword) throws Exception;

	ProductDTO getProNFactoryDetail(String product_code) throws Exception;

	ProductDTO getInfo(String product_code) throws Exception;

	void deleteProduct(ProductDTO productDTO) throws Exception;

	void editProduct(ProductDTO productDTO) throws Exception;
	
	void head_order_basic(Head_orderDTO head_orderDTO) throws Exception;

	void head_order_plus(Map<String, Object> map) throws Exception;

	long get_totalCount(String keyword) throws Exception;

	List<ProductDTO> getProduct_list(Map<String, Object> map) throws Exception;

	void headOrder_single(Head_orderDTO head_orderDTO) throws Exception;

	ProductDTO getProNFactoryDetailFromStore(Map<String, Object> map) throws Exception;

	void store_stock_insert(ProductDTO productDTO) throws Exception;


}
