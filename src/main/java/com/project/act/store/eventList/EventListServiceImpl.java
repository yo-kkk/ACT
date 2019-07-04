package com.project.act.store.eventList;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.EventDTO;

@Service
public class EventListServiceImpl implements EventListService {

	private static final Logger logger = LoggerFactory.getLogger(EventListServiceImpl.class);

	@Autowired
	private EventListDAO eventListDAO;

	@Override
	public long other_totalCount(String store_name) throws SQLException {

		return eventListDAO.other_totalCount(store_name);
	}

	@Override
	public List<EventDTO> curr_list(String store_name) throws SQLException {

		return eventListDAO.curr_list(store_name);
	}

	@Override
	public List<EventDTO> other_list(Map map) throws SQLException {
	
		return eventListDAO.other_list(map);
	}

	@Override
	public List<EventDTO> get_detail(EventDTO eventDTO) throws SQLException {
		
		return eventListDAO.get_detail(eventDTO);
	}

	@Override
	public List<EventDTO> search_event(Map map) throws SQLException {
		
		return eventListDAO.search_event(map);
	}

	@Override
	public List<EventDTO> search_date(Map map) throws SQLException {
		
		return eventListDAO.search_date(map);
	}
}
