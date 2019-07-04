package com.project.act.head.goal;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.Daily_incomeDTO;
import com.project.act.models_dto.Monthly_goalDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.StoresDTO;

@Controller
@RequestMapping("head/goal")
public class HeadGoalController {

	private static final Logger logger = LoggerFactory.getLogger(HeadGoalController.class);

	@Autowired
	private HeadGoalService headGoalService;

	@GetMapping("/montlyGoal")
	public String headOrderList(Model model) throws Exception {
		logger.info("본사 발주 메인 리스트 화면 호출");

		return "goal/montlyGoal.head";
	}

	@PostMapping("/montlyGoal")
	public String goalInsert(@ModelAttribute Monthly_goalDTO monthly_goalDTO, Daily_incomeDTO daily_incomeDTO,
			Model model, HttpServletRequest httpServletRequest) throws Exception {

		logger.info("a");
		logger.info(monthly_goalDTO.toString());
		// 1.storeDTO에 정보를 채우자
		// 2.locationcode를 받아서 맞는 storeDTO의 정보를 가져와서 montly-goalDTO에 입력
		StoresDTO storesDTO = headGoalService.getStore(monthly_goalDTO.getStoresDTO().getStore_name());

		logger.info(storesDTO.toString());

		logger.info(monthly_goalDTO.toString());
		headGoalService.headGoalInsert(monthly_goalDTO);
		logger.info("저장되었습니다");
		
		return "redirect:./goalList/1/?store=&when=";

	}

	@PostMapping("/goalList/{pg}/select_store")
	@ResponseBody
	public List<String> select_store(String location_code) throws Exception {
		logger.info(location_code);
		List<String> list = headGoalService.select_store(location_code);
		logger.info(list.get(0).toString());
		return list;

	}

	@GetMapping("/goalList/{pg}")
	public String list(Model model, HttpSession session, @PathVariable int pg, HttpServletRequest request) throws Exception {
		logger.info("리스트화면호출");
	 System.out.println(pg);
		try {
			String when = request.getParameter("when");
			String store = request.getParameter("store");
			logger.info("Daily 메인화면 ======== when = " + when +" && store = " + store);
			logger.info(when);
			logger.info(store);
			StoresDTO storesDTO = new StoresDTO();
			storesDTO.setStore_name(store);
			
			Monthly_goalDTO monthly_goalDTO =new Monthly_goalDTO();
			logger.info(monthly_goalDTO.toString());
			
			monthly_goalDTO.setObject_month(when);
			monthly_goalDTO.setStoresDTO(storesDTO);
			logger.info(storesDTO.toString());
			
			long totalCount = headGoalService.get_totalCount(monthly_goalDTO);
			
			PageDTO pageDTO = new PageDTO(pg,20,5,totalCount);
			monthly_goalDTO.setPageDTO(pageDTO);

			
			List<Monthly_goalDTO> list = headGoalService.getGoalList(monthly_goalDTO);

			
			/*
			 * for(Monthly_goalDTO monthly_goalDTO: list) {
			 * System.out.println(monthly_goalDTO); }
			 */
			model.addAttribute("store_name", store);
			model.addAttribute("Emplist", list);
			model.addAttribute("pageDTO",pageDTO);
			model.addAttribute("when",when);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "goal/montlyGoalList.head";

	}

	@PostMapping("select_month")
	@ResponseBody
	public List<Monthly_goalDTO> select_month(String month) throws Exception {
		logger.info(month);
		Map<String, Object> map = new HashMap();
		map.put("object_month", month);
		List<Monthly_goalDTO> list = headGoalService.select_month(map);
		logger.info(list.toString());
		return list;
	}

}