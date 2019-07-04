package com.project.act.head.events;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.EventDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.StoresDTO;

public interface EventsDAO {

	List<EventDTO> getEventList(PageDTO pageDTO) throws SQLException;

	long get_total_count(Map<String, Object> map) throws SQLException;
	
	List<String> getStoreList()throws SQLException;

	List<ProductDTO> getProductList(Map<String, Object> map);
	
	void addEvents(EventDTO evDTO)throws SQLException;

	long getE_Code()throws SQLException;

	void deleteEvent(String event_name)throws SQLException;

	List<StoresDTO> getTargetStoreMap(String event_name)throws SQLException;

	List<EventDTO> getTargetProductMap(String event_name)throws SQLException;

	long list_count() throws SQLException;

	List<String> select_store(String location_code) throws SQLException;

}
