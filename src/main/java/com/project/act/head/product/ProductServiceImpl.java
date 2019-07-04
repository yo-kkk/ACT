package com.project.act.head.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.FactoryDTO;
import com.project.act.models_dto.Head_orderDTO;
import com.project.act.models_dto.ProductDTO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDAO productDAO;
	
	@Override
	public void productinsert(ProductDTO productDTO) throws Exception {
		productDAO.productinsert(productDTO);
	}
	
	@Override
	public void store_stock_insert(ProductDTO productDTO) throws Exception {
		productDAO.store_stock_insert(productDTO);
	}
	
	@Override
	public List<ProductDTO> productSearch(String keyword) throws Exception {
		return productDAO.productSearch(keyword);
	}
	
	@Override
	public ProductDTO getProNFactoryDetail(String product_code) throws Exception {
		return productDAO.getProNFactoryDetail(product_code);
	}

	@Override
	public ProductDTO getInfo(String product_code) throws Exception {
		return productDAO.getInfo(product_code);
	}

	@Override
	public void deleteProduct(ProductDTO productDTO) throws Exception {
		productDAO.deleteProduct(productDTO);		
	}
	
	@Override
	public void headOrder(Head_orderDTO head_orderDTO, String[] product_quantity) throws Exception {
		
		ProductDTO productDTO = new ProductDTO();
		productDTO.setProduct_code(product_quantity[0].split(",")[0]);			
		head_orderDTO.setProductDTO(productDTO);
		
		head_orderDTO.setQuantity(Long.parseLong(product_quantity[0].split(",")[1]));
		
		FactoryDTO factoryDTO = new FactoryDTO();
		factoryDTO.setFactory_code(Long.parseLong(product_quantity[0].split(",")[3]));
		head_orderDTO.setFactoryDTO(factoryDTO);
				
		productDAO.head_order_basic(head_orderDTO);
	
			for(int i=1;i<product_quantity.length;i++) {			
				
				Map<String, Object> map = new HashMap();
				
				map.put("head_order_code",head_orderDTO.getHead_order_code());
				map.put("PRODUCT_CODE",product_quantity[i].split(",")[0]);
				map.put("QUANTITY", product_quantity[i].split(",")[1]);
				map.put("FACTORY_CODE",product_quantity[i].split(",")[3]);
				map.put("order_date", head_orderDTO.getOrder_date());
				map.put("emp_id", head_orderDTO.getEmpDTO().getEmp_id());
				
				productDAO.head_order_plus(map);
			}
	}

	@Override
	public void editProduct(ProductDTO productDTO) throws Exception {
		productDAO.editProduct(productDTO);		
	}

	@Override
	public long get_totalCount(String keyword) throws Exception {
		return productDAO.get_totalCount(keyword);
	}

	@Override
	public List<ProductDTO> getProduct_list(Map<String, Object> map) throws Exception {
		return productDAO.getProduct_list(map);
	}
	
	@Override
	public void headOrder_single(Head_orderDTO head_orderDTO, String[] product_quantity) throws Exception {
		ProductDTO productDTO = new ProductDTO();
		productDTO.setProduct_code(product_quantity[0]);
		
		FactoryDTO factoryDTO = new FactoryDTO();
		factoryDTO.setFactory_code(Long.parseLong(product_quantity[3]));
		
		head_orderDTO.setProductDTO(productDTO);
		head_orderDTO.setFactoryDTO(factoryDTO);
		head_orderDTO.setQuantity(Integer.parseInt(product_quantity[1]));
		
		productDAO.headOrder_single(head_orderDTO);
	}
	
	@Override
	public ProductDTO getProNFactoryDetailFromStore(Map<String, Object> map) throws Exception {
		return productDAO.getProNFactoryDetailFromStore(map);
	}

}
