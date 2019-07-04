package com.project.act.pos.curr_event;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.EventDTO;

@Service
public class Curr_eventServiceImpl implements Curr_eventService {
	
	private static final Logger logger = LoggerFactory.getLogger(Curr_eventService.class);

	@Autowired
	private Curr_eventDAO curr_eventDAO;

	@Override
	public List<EventDTO> getEvent_list(String store_name) throws SQLException {

		return curr_eventDAO.getEvent_list(store_name);
	}

	@Override
	public List<EventDTO> get_detail(EventDTO eventDTO) throws SQLException {
		
		return curr_eventDAO.get_detail(eventDTO);
	}

	@Override
	public List<EventDTO> search_event(Map map) throws SQLException {
		
		return curr_eventDAO.search_event(map);
	}
}
