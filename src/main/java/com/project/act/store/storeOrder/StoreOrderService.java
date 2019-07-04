package com.project.act.store.storeOrder;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.Store_orderDTO;

public interface StoreOrderService {

	List<Store_orderDTO> getFromStoreToHeadOrder_list(Map<String, Object> map_search) throws Exception;

	long getFromStoreToHeadOrder_cnt(Map<String, Object> map) throws Exception;

	void fromStoreToHeadOrder(Store_orderDTO store_orderDTO, String[] product_quantity) throws Exception;

	void fromStoreToHeadOrder_single(Store_orderDTO store_orderDTO, String[] product_quantity)  throws Exception;

	void updateReceive(Store_orderDTO store_orderDTO) throws Exception;

}
