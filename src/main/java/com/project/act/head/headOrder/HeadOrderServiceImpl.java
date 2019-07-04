package com.project.act.head.headOrder;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.act.models_dto.Head_orderDTO;
import com.project.act.models_dto.Store_orderDTO;

@Service
public class HeadOrderServiceImpl implements HeadOrderService{

	@Autowired
	private HeadOrderDAO headOrderDAO;

	@Override
	public List<Head_orderDTO> getToFactoryOrderList(Map<String, Object> map) throws Exception {
		return headOrderDAO.getToFactoryOrderList(map);
	}

	@Override
	public List<Store_orderDTO> getFromStoreOrderList() throws Exception {
		return headOrderDAO.getFromStoreOrderList();
	}

	@Override
	public long getSearchTotalCnt(Map<String, Object> map) throws Exception {
		return headOrderDAO.getSearchTotalCnt(map);
	}
	
	@Override
	public void deleteToFactoryOrder(Head_orderDTO head_orderDTO) throws Exception {
		headOrderDAO.deleteToFactoryOrder(head_orderDTO);
	}
	
	@Transactional
	@Override
	public void updateReceive(Head_orderDTO head_orderDTO) throws Exception {
		headOrderDAO.updateReceive(head_orderDTO);
		headOrderDAO.updateHeadStockbyfac(head_orderDTO);
	}
	
	@Transactional
	@Override
	public void updateSendYN(Store_orderDTO store_orderDTO) throws Exception {
		headOrderDAO.updateSendYN(store_orderDTO);
		headOrderDAO.updateHeadStock(store_orderDTO);
	}
}
