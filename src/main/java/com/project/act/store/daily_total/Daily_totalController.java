package com.project.act.store.daily_total;

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
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.act.models_dto.Daily_incomeDTO;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.StoresDTO;

@Controller
@RequestMapping("store/daily_total/{pg}")
public class Daily_totalController {
private static final Logger logger = LoggerFactory.getLogger(Daily_totalController.class);
	
	@Autowired
	private Daily_totalService daily_totalService;

	@GetMapping("/")
	public String Daily_total(HttpSession session, @PathVariable int pg, Model model, HttpServletRequest request) throws Exception{
		
		String when = request.getParameter("when");
		
		logger.info("Daily_total 메인화면 : =============== when = " + when);
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();		
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
				
		Daily_incomeDTO daily_incomeDTO = new Daily_incomeDTO();
		daily_incomeDTO.setBs_date(when);
		daily_incomeDTO.setStoreDTO(storeDTO);
			
		long totalCount = daily_totalService.get_totalCount(daily_incomeDTO);
		PageDTO pageDTO = new PageDTO(pg,20,5,totalCount);
		daily_incomeDTO.setPageDTO(pageDTO);
		
		List<Daily_incomeDTO> list = daily_totalService.get_List(daily_incomeDTO);
		
		model.addAttribute("store_name", store_name);
		model.addAttribute("list", list);
		model.addAttribute("pageDTO",pageDTO);
		model.addAttribute("when",when);
		
		return "daily_total/daily_total.store";
	}

}
