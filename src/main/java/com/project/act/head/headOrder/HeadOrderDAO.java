package com.project.act.head.headOrder;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.Head_orderDTO;
import com.project.act.models_dto.Store_orderDTO;

public interface HeadOrderDAO {

	List<Head_orderDTO> getToFactoryOrderList(Map<String, Object> map) throws Exception;

	List<Store_orderDTO> getFromStoreOrderList() throws Exception;

	long getSearchTotalCnt(Map<String, Object> map) throws Exception;

	void deleteToFactoryOrder(Head_orderDTO head_orderDTO) throws Exception;

	void updateReceive(Head_orderDTO head_orderDTO) throws Exception;

	void updateSendYN(Store_orderDTO store_orderDTO) throws Exception;

	void updateHeadStock(Store_orderDTO store_orderDTO) throws Exception;

	void updateHeadStockbyfac(Head_orderDTO head_orderDTO) throws Exception;

}
