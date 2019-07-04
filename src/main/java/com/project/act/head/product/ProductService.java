package com.project.act.head.product;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.Head_orderDTO;
import com.project.act.models_dto.ProductDTO;

public interface ProductService {
	
	void productinsert(ProductDTO productDTO) throws Exception;

	//지울까?
	List<ProductDTO> productSearch(String keyword) throws Exception;

	ProductDTO getProNFactoryDetail(String product_code) throws Exception;

	ProductDTO getInfo(String product_code) throws Exception;

	void deleteProduct(ProductDTO productDTO) throws Exception;

	void editProduct(ProductDTO productDTO) throws Exception;
	
	void headOrder(Head_orderDTO head_orderDTO, String[] product_quantity) throws Exception;

	long get_totalCount(String keyword) throws Exception;

	List<ProductDTO> getProduct_list(Map<String, Object> map) throws Exception;

	void headOrder_single(Head_orderDTO head_orderDTO, String[] product_quantity) throws Exception;

	ProductDTO getProNFactoryDetailFromStore(Map<String, Object> map) throws Exception;

	void store_stock_insert(ProductDTO productDTO) throws Exception;
	
}
