package com.project.act.head.events;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.act.models_dto.EventDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.StoresDTO;


@Service
public class EventsServiceImpl implements EventsService {
	@Autowired
	private EventsDAO eventsDAO;

	@Override
	public List<EventDTO> getEventList(PageDTO pageDTO) throws Exception {
		return eventsDAO.getEventList(pageDTO);
	}

	@Override
	public List<String> getStoreList() throws Exception {
		return eventsDAO.getStoreList();
	}

	@Override
	public List<ProductDTO> getProductList(Map<String, Object> map) throws Exception {
		return eventsDAO.getProductList(map);
	}

	@Override
	public long get_total_count(Map<String, Object> map) throws Exception {
		return eventsDAO.get_total_count(map);
	}

	@Override
	public void addEvent(EventDTO eventDTO, String[] target_stores, String[] product_info) throws Exception {
		System.out.println("Event addEvent Impl ====== "+eventDTO.toString());
		long eventCode = eventsDAO.getE_Code();
		String evName = eventDTO.getEvent_name();
		String evStartDate = eventDTO.getStart_date();
		String evEndDate = eventDTO.getEnd_date();
		
		for(int i=0;i<target_stores.length;i++) { 
			EventDTO evDTO = new EventDTO();
			evDTO.setEvent_code(eventCode);
			evDTO.setEvent_name(evName);
			evDTO.setStart_date(evStartDate);
			evDTO.setEnd_date(evEndDate);
			
			StoresDTO stDTO = new StoresDTO();
			stDTO.setStore_name(target_stores[i]);
			evDTO.setStoresDTO(stDTO);
			
			for(int j=1; j<product_info.length; j++){
				ProductDTO pDTO = new ProductDTO();
				pDTO.setProduct_code(product_info[j].split(",")[0]);
				evDTO.setProductDTO(pDTO);
				evDTO.setDiscount_rate(Integer.parseInt(product_info[j].split(",")[1]));
				
				System.out.println("event 들어가기전 정보! "+evDTO.toString());
				
				eventsDAO.addEvents(evDTO);
			}
			
		}
		
	}

	@Override
	public void deleteEvent(String event_name) throws Exception {
		eventsDAO.deleteEvent(event_name);
		
	}

	@Override
	public List<StoresDTO> getTargetStoreMap(String event_name) throws Exception {
		System.out.println("impl"+event_name);
		return eventsDAO.getTargetStoreMap(event_name);
		
	}

	@Override
	public List<EventDTO> getTargetProductMap(String event_name) throws Exception {
		return eventsDAO.getTargetProductMap(event_name);
		
	}

	@Override
	public long list_count() throws Exception {

		return eventsDAO.list_count();
	}

	@Override
	public List<String> select_store(String location_code) throws Exception {
		
		return eventsDAO.select_store(location_code);
	}

}
