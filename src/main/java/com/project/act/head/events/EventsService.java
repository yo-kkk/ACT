package com.project.act.head.events;

import java.util.List;
import java.util.Map;

import com.project.act.models_dto.EventDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.StoresDTO;

public interface EventsService {

	List<EventDTO> getEventList(PageDTO pageDTO)throws Exception;

	List<String> getStoreList() throws Exception;

	List<ProductDTO> getProductList(Map<String, Object> map) throws Exception;
	
	long get_total_count(Map<String, Object> map)throws Exception;

	void addEvent(EventDTO eventDTO, String[] target_stores, String[] product_info)throws Exception;

	void deleteEvent(String event_name)throws Exception;

	List<StoresDTO> getTargetStoreMap(String event_name)throws Exception;

	List<EventDTO> getTargetProductMap(String event_name)throws Exception;

	long list_count() throws Exception;

	List<String> select_store(String location_code) throws Exception;
	
}
