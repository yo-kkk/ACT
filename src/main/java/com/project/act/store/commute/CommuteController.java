package com.project.act.store.commute;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;

@Controller
@RequestMapping("store/commute/{pg}")
public class CommuteController {
	private static final Logger logger = LoggerFactory.getLogger(CommuteController.class);
	
	@Autowired
	private StoreCommuteService storeCommuteService;
	
	@GetMapping("/")
	public String commute(Model model,HttpSession session,@PathVariable int pg) throws Exception{
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		logger.info("직원 출퇴근 List Page ================== store_name : " + store_name);
		
		long totalcount = storeCommuteService.list_count(store_name);
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalcount);
		
		Map map = new HashMap();
		
		map.put("store_name", store_name);
		map.put("pageDTO", pageDTO);
		
		List<CommuteDTO> list = storeCommuteService.getCommuteList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("pageDTO",pageDTO);
		model.addAttribute("store_name",store_name);
		
		return "commute/commuteList.store";
	}
	
	@PostMapping("edit")
	public String edit(@ModelAttribute CommuteDTO commuteDTO, @RequestParam(required = false) String emp_id,  Model model,HttpSession session) throws Exception{
		
		EmployeeDTO empDTO = new EmployeeDTO();
		empDTO.setEmp_id(emp_id);
		commuteDTO.setEmpDTO(empDTO);

		logger.info("수정하기 "+commuteDTO.toString());
		storeCommuteService.updateCommute(commuteDTO);

		
		return "commute/commuteList.store";
	}
	
	@GetMapping("/addComm")
	public String add(HttpSession session, Model model) throws Exception{
		
		//1. session에서 점장의 일하는 지점 뽑기
		String emp_id = ((EmployeeDTO) session.getAttribute("userInfo")).getEmp_id();
		
		//2. DB에서 점장과 같은 지점에서 일하는 EmpDTO를  List로 뽑기
		
		List<EmployeeDTO> list = storeCommuteService.getEmpList(emp_id);
		//3. list를 model.setattr~로 넘기기
	
		model.addAttribute("list", list);
		
		return "commute/addCommute.store";
	}
	
	@PostMapping("addComm")
	public String add(@ModelAttribute CommuteDTO commuteDTO, @RequestParam(required = false) String emp_id,	HttpSession session, Model model) throws Exception{
			
		EmployeeDTO empDTO = new EmployeeDTO();
		empDTO.setEmp_id(emp_id);
		commuteDTO.setEmpDTO(empDTO);
		logger.info(commuteDTO.toString());	
		storeCommuteService.addCommute(commuteDTO);

		model.addAttribute("url","../");
		model.addAttribute("msg","등록되었습니다.");
		return "result";
		
	}
	
	@PostMapping("delete")
	public String delete(@RequestParam(required = false) String emp_id, @RequestParam(required = false) String work_date, HttpSession session, Model model) throws Exception{
		
		CommuteDTO commuteDTO = new CommuteDTO();
		EmployeeDTO empDTO = new EmployeeDTO();
		
		empDTO.setEmp_id(emp_id);
		commuteDTO.setEmpDTO(empDTO);
		commuteDTO.setWork_date(work_date);
		
		logger.info("zzzzzzzzzzzzzzz"+commuteDTO.toString());
		storeCommuteService.delComm(commuteDTO);
		
		model.addAttribute("url","../");
		model.addAttribute("msg","삭제되었습니다.");
		return "result";
		
	}
		
}
