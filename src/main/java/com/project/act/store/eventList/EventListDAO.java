package com.project.act.store.eventList;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.EventDTO;

public interface EventListDAO {

	long other_totalCount(String store_name) throws SQLException;

	List<EventDTO> curr_list(String store_name) throws SQLException;

	List<EventDTO> other_list(Map map) throws SQLException;

	List<EventDTO> get_detail(EventDTO eventDTO) throws SQLException;

	List<EventDTO> search_event(Map map) throws SQLException;

	List<EventDTO> search_date(Map map) throws SQLException;

}
