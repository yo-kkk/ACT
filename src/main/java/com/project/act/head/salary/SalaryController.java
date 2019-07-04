package com.project.act.head.salary;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.Emp_salaryDTO;
import com.project.act.models_dto.Monthly_goalDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.StoresDTO;

@Controller
@RequestMapping("head/salary")
public class SalaryController {
	private static final Logger logger = LoggerFactory.getLogger(SalaryController.class);

	@Autowired
	private SalaryService salaryService;

	@RequestMapping("/")
	public String eventList(Model model, HttpSession session) throws Exception {

		List<Monthly_goalDTO> MonthlyMonthlyGoalList = salaryService.getMonthlyGoalList();
		logger.info("월급 리스트");
		model.addAttribute("list",MonthlyMonthlyGoalList);

		logger.info(MonthlyMonthlyGoalList.toString());
		return "salary/salaryList.head";
	}
	
	@PostMapping("paySalary")
	public String agreePay(@RequestParam(required = false) String[] checkMember, Model model, HttpSession session) throws Exception {
		logger.info("지급 점포 리스트");
		
		for(int i =0; i<checkMember.length; i++) {
			logger.info(checkMember[i].toString());
			int idx = checkMember[i].indexOf("_"); 

	        String objMonth = checkMember[i].substring(0, idx).trim();
	        String StoreName = checkMember[i].substring(idx+1).trim();
	        
	        Monthly_goalDTO goalDTO = new Monthly_goalDTO();
	        StoresDTO StoreDTO = new StoresDTO();
	        
	        StoreDTO.setStore_name(StoreName);
	   
	        goalDTO.setObject_month(objMonth);
	        goalDTO.setStoresDTO(StoreDTO);
	        
	        
	        salaryService.getTargetEmp(goalDTO);
	        salaryService.updateYN(goalDTO);
	       
		}
		
		return "redirect:../";
	}
	
	@GetMapping("/pastSalaryList/{pg}")
	public String pastSalaryList(HttpSession session,Model model,@PathVariable int pg,HttpServletRequest request) throws Exception {
		
		String when = request.getParameter("when");
		String store_name = request.getParameter("store");
		
		logger.info("=========== Store 월급 list page ========== store : "+ store_name + "&& when : " + when);
		
		Map map = new HashMap();
		map.put("when",when);
		map.put("store_name",store_name);
		
		long totalcount = salaryService.total_count(map);
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalcount);
		
		map.put("pageDTO",pageDTO);

		List<Emp_salaryDTO> list = salaryService.list_pg(map);
		
		model.addAttribute("pageDTO",pageDTO);
		model.addAttribute("store_name",store_name);
		model.addAttribute("list",list);
		model.addAttribute("when",when);
		
		return "salary/pastSalaryList.head";
		
	}
	
	@PostMapping("/select_store")
	@ResponseBody
	public List<String> select_store(String location_code) throws Exception {
		
		logger.info("ajax == select_box 에 store_list 불러오기 =========== location_code : " + location_code );
		List<String> list = salaryService.select_store(location_code);
		
		return list;

	}
	
}
