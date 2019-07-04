package com.project.act.store.storeOrder;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.Store_orderDTO;

@Service
public class StoreOrderServiceImpl implements StoreOrderService {
	
	@Autowired
	private StoreOrderDAO storeOrderDAO;
	
	 @Override
	public List<Store_orderDTO> getFromStoreToHeadOrder_list(Map<String, Object> map_search) throws Exception {
		return storeOrderDAO.getFromStoreToHeadOrder_list(map_search);
	}
	
	@Override
	public long getFromStoreToHeadOrder_cnt(Map<String, Object> map) throws Exception {
		return storeOrderDAO.getFromStoreToHeadOrder_cnt(map);
	}

	@Override
	public void fromStoreToHeadOrder(Store_orderDTO store_orderDTO, String[] product_quantity) throws Exception {		
		ProductDTO productDTO = new ProductDTO();
		productDTO.setProduct_code(product_quantity[0].split(",")[0]);			
		store_orderDTO.setProductDTO(productDTO);
		
		store_orderDTO.setQuantity(Long.parseLong(product_quantity[0].split(",")[1]));
		
		System.out.println(store_orderDTO.toString());
		
		storeOrderDAO.fromStoreToHeadOrder_basic(store_orderDTO);
	
			for(int i=1;i<product_quantity.length;i++) {			
				
				Map<String, Object> map = new HashMap();
				
				map.put("store_order_code",store_orderDTO.getStore_order_code());
				map.put("product_code",product_quantity[i].split(",")[0]);
				map.put("store_name",store_orderDTO.getStoreDTO().getStore_name());
				map.put("quantity", product_quantity[i].split(",")[1]);
				map.put("order_date", store_orderDTO.getOrder_date());
				map.put("emp_id", store_orderDTO.getEmpDTO().getEmp_id());
				
				storeOrderDAO.fromStoreToHeadOrder_plus(map);
			}
	}

	@Override
	@Transactional
	public void fromStoreToHeadOrder_single(Store_orderDTO store_orderDTO, String[] product_quantity) throws Exception {
		ProductDTO productDTO = new ProductDTO();
		productDTO.setProduct_code(product_quantity[0]);
		
		store_orderDTO.setProductDTO(productDTO);
		store_orderDTO.setQuantity(Integer.parseInt(product_quantity[1]));
		
		storeOrderDAO.fromStoreToHeadOrder_single(store_orderDTO);
	}

	@Override
	@Transactional
	public void updateReceive(Store_orderDTO store_orderDTO) throws Exception {
		System.out.println("------------서비스------------" + store_orderDTO.toString());
		storeOrderDAO.updateReceiveStore(store_orderDTO);
		storeOrderDAO.updateStoreStock(store_orderDTO);		
	}
	
}
