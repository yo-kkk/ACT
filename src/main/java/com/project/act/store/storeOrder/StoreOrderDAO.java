package com.project.act.store.storeOrder;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.Store_orderDTO;

public interface StoreOrderDAO {

	List<Store_orderDTO> getFromStoreToHeadOrder_list(Map<String, Object> map_search) throws Exception;

	long getFromStoreToHeadOrder_cnt(Map<String, Object> map) throws Exception;

	void fromStoreToHeadOrder_basic(Store_orderDTO store_orderDTO) throws Exception;

	void fromStoreToHeadOrder_plus(Map<String, Object> map) throws Exception;

	void fromStoreToHeadOrder_single(Store_orderDTO store_orderDTO) throws Exception;

	void updateReceiveStore(Store_orderDTO store_orderDTO) throws Exception;

	void updateStoreStock(Store_orderDTO store_orderDTO) throws Exception;

}
