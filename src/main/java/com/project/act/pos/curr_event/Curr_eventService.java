package com.project.act.pos.curr_event;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.project.act.models_dto.EventDTO;

public interface Curr_eventService {

	List<EventDTO> getEvent_list(String store_name) throws SQLException;

	List<EventDTO> get_detail(EventDTO eventDTO) throws SQLException;

	List<EventDTO> search_event(Map map) throws SQLException;

}
