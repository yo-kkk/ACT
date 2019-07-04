package com.project.act.head.daily;

import java.util.List;

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

import com.project.act.models_dto.Daily_incomeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.StoresDTO;

@Controller
@RequestMapping("head/daily/{pg}")
public class DailyController {
	private static final Logger logger = LoggerFactory.getLogger(DailyController.class);
	
	@Autowired
	private DailyService dailyservice;
	
	@GetMapping("/")
	public String Daily(HttpSession session, @PathVariable int pg, Model model, HttpServletRequest request) throws Exception{
		
		String when = request.getParameter("when");
		String store = request.getParameter("store");
		
		logger.info("Daily 메인화면 ======== when = " + when +" && store = " + store);
		
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store);
		
		Daily_incomeDTO daily_incomeDTO = new Daily_incomeDTO();
		daily_incomeDTO.setBs_date(when);
		daily_incomeDTO.setStoreDTO(storeDTO);
		
		long totalCount = dailyservice.get_totalCount(daily_incomeDTO);
		PageDTO pageDTO = new PageDTO(pg,20,5,totalCount);
		daily_incomeDTO.setPageDTO(pageDTO);
		
		List<Daily_incomeDTO> list = dailyservice.get_List(daily_incomeDTO);
		
		model.addAttribute("store_name", store);
		model.addAttribute("list", list);
		model.addAttribute("pageDTO",pageDTO);
		model.addAttribute("when",when);
		
		return "daily/daily.head";
	}
	
	@PostMapping("select_store")
	@ResponseBody
	public List<String> select_store(String location_code) throws Exception {
		
		logger.info("ajax == select_box 에 store_list 불러오기 =========== location_code : " + location_code );
		List<String> list = dailyservice.select_store(location_code);
		
		return list;

	}
	
}
