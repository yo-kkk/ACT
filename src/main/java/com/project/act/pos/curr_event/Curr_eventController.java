package com.project.act.pos.curr_event;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.EventDTO;
import com.project.act.models_dto.StoresDTO;

@Controller
@RequestMapping("pos/curr_event")
public class Curr_eventController {
	private static final Logger logger = LoggerFactory.getLogger(Curr_eventController.class);
	
	@Autowired
	private Curr_eventService curr_eventService;
	
	@GetMapping("/")
	public String event(HttpSession session, Model model, HttpServletRequest request) throws Exception {
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		logger.info("포스:현재 진행중인 이벤트 페이지 ============ store_name : " + store_name);
		
		List<EventDTO> list = curr_eventService.getEvent_list(store_name);
		
		model.addAttribute("store_name", store_name);
		model.addAttribute("list",list);		
		
		return "curr_event/curr_event.pos";
	}
	
	@PostMapping("detail_modal")
	@ResponseBody
	public List<EventDTO>detail_modal(EventDTO eventDTO,HttpSession session) throws SQLException{
		
		logger.info("이벤트 디테일 보기! ============ eventDTO : " +eventDTO.toString());
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
		
		eventDTO.setStoresDTO(storeDTO);
		
		return curr_eventService.get_detail(eventDTO);
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
		
		List<EventDTO> list = curr_eventService.search_event(map);
		logger.info(list.get(0).toString());
		
		return list;
	}

}
