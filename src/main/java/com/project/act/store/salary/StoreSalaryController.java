package com.project.act.store.salary;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.Emp_salaryDTO;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.store.commute.StoreCommuteService;


@Controller
@RequestMapping("store/salary/")
public class StoreSalaryController {
	private static final Logger logger = LoggerFactory.getLogger(StoreSalaryController.class);
	List<CommuteDTO> SearchSalaryList;
	@Autowired
	private StoreSalaryService storeSalaryService;
	
	@Autowired
	private StoreCommuteService storeCommuteService;
	
	@GetMapping("/")
	public String storeSalaryList(Model model, HttpSession session) throws Exception {
		logger.info("지점 알바 월급 지급 리스트");
		
		String emp_id = ((EmployeeDTO) session.getAttribute("userInfo")).getEmp_id();
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		
		//2. 점장이 고용중인 알바생들 알바생 목록
		List<EmployeeDTO> emp_list = storeCommuteService.getEmpList(emp_id);
		model.addAttribute("emp_list", emp_list);
		model.addAttribute("store_name", store_name);
		

		return "salary/payPartTimeSalary.store";
		
	}
	
	
	@RequestMapping("/addSalary")
	public String addSalary(@ModelAttribute Emp_salaryDTO salaryDTO, @RequestParam String emp_id,HttpSession session) throws Exception {
		logger.info("지점 알바 월급 지급 기능");
		EmployeeDTO empDTO = new EmployeeDTO();
		
		empDTO.setEmp_id(emp_id);
		salaryDTO.setEmpDTO(empDTO);
		logger.info(salaryDTO.toString());
		storeSalaryService.payAlbalSalary(salaryDTO);
		
		
		return "salary/storePastSalary.store";
		
		
	}
	
	@GetMapping("/pastSalaryList/{pg}")
	public String pastSalaryList(HttpSession session,Model model,@PathVariable int pg,HttpServletRequest request) throws Exception {
		
		String when = request.getParameter("when");
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		
		logger.info("=========== Store 월급 list page ========== store : "+ store_name + " && when : " + when);
		
		Map map = new HashMap();
		map.put("store_name",store_name);
		map.put("when",when);
		
		long totalcount = storeSalaryService.total_count(map);
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalcount);
		
		map.put("pageDTO",pageDTO);

		List<Emp_salaryDTO> list = storeSalaryService.list_pg(map);
		
		model.addAttribute("pageDTO",pageDTO);
		model.addAttribute("store_name",store_name);
		model.addAttribute("list",list);
		model.addAttribute("when",when);
		
		return "salary/storePastSalary.store";
		
	}
	
	
	
	@PostMapping("/seachCommList")
	@ResponseBody
	public List<CommuteDTO> seachComm(@ModelAttribute CommuteDTO commDTO, @RequestParam String emp_id, Model model, HttpSession session) throws Exception {
		logger.info("지점 직원 월급 지급 페이지");
		EmployeeDTO empDTO = new EmployeeDTO();
		empDTO.setEmp_id(emp_id);
		commDTO.setEmpDTO(empDTO);
		logger.info("commDTO_____"+commDTO.toString());
		
		//2. 점장이 고용중인 알바생들 알바비 지급 목록 가져오기
		SearchSalaryList = storeSalaryService.getSearchCommuteList(commDTO);
		logger.info("#########"+SearchSalaryList);
		//점장이 고용중인 알바생들 알바비 지급 목록 전달
		model.addAttribute("list",SearchSalaryList);

		
		return SearchSalaryList;
		
		
	}
	
	@PostMapping("/payPartSalary")
	@ResponseBody
	public String payPartSalary( HttpSession session) throws Exception {
		logger.info("SearchSalaryList^^^"+SearchSalaryList.toString());
		
		return "redirect:../";
		
		
	}
}
