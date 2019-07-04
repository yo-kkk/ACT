package com.project.act.store.eventList;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.EventDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.StoresDTO;

@Controller
@RequestMapping("store/eventList/{pg}")
public class EventListController {
	private static final Logger logger = LoggerFactory.getLogger(EventListController.class);
	
	@Autowired
	private EventListService eventListService;
	
	@GetMapping("/")
	public String eventList(@PathVariable int pg, HttpSession session, Model model, HttpServletRequest request) throws Exception{
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		logger.info("Store : EventList Main Page ============ store_name : " + store_name);
		
		//현재 진행중인 event 출력
		List<EventDTO> curr_list = eventListService.curr_list(store_name);		
		
		//진행중이지 않은 event 출력
		long totalCount = eventListService.other_totalCount(store_name);
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
		
		Map map = new HashMap();
		
		map.put("store_name", store_name);
		map.put("pageDTO", pageDTO);
		List<EventDTO> list = eventListService.other_list(map);
		
		model.addAttribute("store_name", store_name);
		model.addAttribute("curr_list",curr_list);
		model.addAttribute("list",list);
		model.addAttribute("pageDTO",pageDTO);
				
		return "eventList/eventList.store";
	}
	
	@PostMapping("detail_modal")
	@ResponseBody
	public List<EventDTO>detail_modal(EventDTO eventDTO,HttpSession session) throws SQLException{
		
		logger.info("이벤트 디테일 보기! ============ eventDTO : " +eventDTO.toString());
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
		
		eventDTO.setStoresDTO(storeDTO);
		
		return eventListService.get_detail(eventDTO);
	}
	
	@PostMapping("search_event")
	@ResponseBody
	public List<EventDTO>search_event(String keyword, HttpSession session) throws SQLException{
		
		logger.info("이벤트 검색! ============ keyword : " + keyword);
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
		
		Map map = new HashMap();
		
		map.put("keyword", keyword);
		map.put("store_name", store_name);
		
		List<EventDTO> list = eventListService.search_event(map);
		logger.info(list.get(0).toString());
		
		return list;
	}
	
	@PostMapping("search_date")
	@ResponseBody
	public List<EventDTO>search_date(String keyword_date, HttpSession session) throws SQLException{
		
		logger.info("이벤트 날짜 검색! ============ keyword_date : " + keyword_date);
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
		
		Map map = new HashMap();
		
		map.put("keyword_date", keyword_date);
		map.put("store_name", store_name);
		
		List<EventDTO> list = eventListService.search_date(map);
		
		return list;
	}
	
}
