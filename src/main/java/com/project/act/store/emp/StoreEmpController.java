package com.project.act.store.emp;

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

import com.project.act.head.emp.HeadEmpService;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.PositionDTO;

@Controller
@RequestMapping("store/emp")
public class StoreEmpController {
	private static final Logger logger = LoggerFactory.getLogger(StoreEmpController.class);

	@Autowired
	private StoreEmpService storeEmpService;
	
	@Autowired
	private HeadEmpService headEmpService;
	
	/*
	 * @GetMapping("/addComm") public String add(HttpSession session, Model model)
	 * throws Exception{
	 * 
	 * //1. session에서 점장의 일하는 지점 뽑기 String emp_id = ((EmployeeDTO)
	 * session.getAttribute("userInfo")).getEmp_id();
	 * 
	 * //2. DB에서 점장과 같은 지점에서 일하는 EmpDTO를 List로 뽑기
	 * 
	 * List<EmployeeDTO> list = storeEmpService.getEmpList(emp_id); //3. list를
	 * model.setattr~로 넘기기
	 * 
	 * model.addAttribute("list", list);
	 * 
	 * return "commute/addCommute.store"; }
	 */

	@GetMapping("/empList/{pg}")
	public String comList(Model model, HttpSession session, @PathVariable int pg, HttpServletRequest request)
			throws Exception {
		
		String keyword = request.getParameter("keyword");		
		logger.info("사원 리스트 화면 : keyword = " + keyword);			
		logger.info(keyword);
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();

		Map<String, Object> map = new HashMap();
		map.put("keyword",keyword);
		map.put("store_name",store_name);
		
		Long totalCount = storeEmpService.toca(map);
		
		PageDTO pageDTO = new PageDTO(pg, 10, 5, totalCount);		
		map.put("pageDTO",pageDTO);
		
		List<EmployeeDTO> list = storeEmpService.getcomList(map);
		logger.info(list.toString());
		
		model.addAttribute("Emplist", list);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("keyword",keyword);
		model.addAttribute("store_name",store_name);
		
		/*
		 * logger.info("pg." + pg); String keyword = request.getParameter("keyword");
		 * logger.info(keyword); EmployeeDTO employeeDTO = new EmployeeDTO();
		 * employeeDTO.setName(keyword);
		 * 
		 * Long totalCount = storeEmpService.toca(keyword); PageDTO pageDTO = new
		 * PageDTO(pg, 10, 5, totalCount); employeeDTO.setPageDTO(pageDTO);
		 * 
		 * List<EmployeeDTO> list = storeEmpService.getcomList(employeeDTO);
		 * 
		 * 
		 * Map<String, Object> map = new HashMap(); map.put("keyword",keyword);
		 * 
		 * 
		 * 
		 * for(EmployeeDTO employeeDTO1 : list) {System.out.println(employeeDTO1); }
		 * 
		 * 
		 * 
		 * PageDTO pageDTO = new PageDTO(pg, 10, 5, totalCount);
		 * map.put("pageDTO",pageDTO);
		 * 
		 * 
		 * model.addAttribute("Emplist", list); model.addAttribute("keyword", keyword);
		 * model.addAttribute("pageDTO", pageDTO);
		 */

		return "emp/comEmpList.store";

	}

	@GetMapping("/empUpdate")
	@ResponseBody
	public EmployeeDTO headEmpUpdateModal(@ModelAttribute EmployeeDTO employeeDTO, Model model) throws Exception {
		logger.info("본사 직원 정보 수정 모달에 정보 전달 / 수정할 직원 코드 " + employeeDTO.getEmp_id());

		EmployeeDTO ResultEmpDTO = storeEmpService.getEmpInfo(employeeDTO.getEmp_id());

		return ResultEmpDTO;
	}

	@GetMapping("/commuteInsert")
	public String commuteInsert(HttpSession session, Model model) throws Exception {
		logger.info("지점 직원 등록 화면 호출");
		EmployeeDTO empDTO01 = ((EmployeeDTO) session.getAttribute("userInfo"));

		String emp_id = (String) empDTO01.getEmp_id();

		EmployeeDTO empDTO = storeEmpService.getStoreList(emp_id);

		// 3. list를 model.setattr~로 넘기기

		model.addAttribute("list", empDTO);
		return "emp/commuteInsertPage.store";
	}

	@PostMapping("/commuteInsert")
	public String commuteInsertAction(@ModelAttribute EmployeeDTO employeeDTO, HttpSession session, Model model)
			throws Exception {
		session.getAttribute("userInfo.userId");
		employeeDTO.setEmp_password(employeeDTO.getHire_date().toString().replace("-", ""));

		logger.info(employeeDTO.toString());
		// 멀가져오냐면.... positionDTO에서 Position_code를 가져와야해 그걸
		// 아르바이트만 넣는건 jsp에서 처리하자
		PositionDTO positionDTO = storeEmpService.getPositionInfo(employeeDTO.getPositionDTO().getPosition_code());
		logger.info("a");
		employeeDTO.setSalary(positionDTO.getMin_sal());
		employeeDTO.getPositionDTO().setName(positionDTO.getName());
		// 3.사원정보 등록
		logger.info("b");
		storeEmpService.storeCommuteInsert(employeeDTO);
		logger.info("a");
		// 1.사원이름 2.지점명(일단) 3.직급은 아르바이트만 4.생년월일 5. 거주지 6
		// 6.연락처 7.입사일
		// 아르바이트 기본급은 list에 뿌려야함... 일단 dto 에 넣습니당
		logger.info("등록 처리 끝냄 + 등록한 정보 조회할 아이디 생성");
		String returnID = employeeDTO.getHire_date().toString().replace("-", "").substring(2) + employeeDTO.getIdx();
		logger.info(returnID);
		logger.info("a");

		EmployeeDTO ResultEmpDTO = storeEmpService.getEmpInfo(returnID);
		model.addAttribute("employeeDTO", ResultEmpDTO);
		System.out.println("완료~~");
		return "emp/commuteDetail.store";

	}

	@RequestMapping("/commuteDetail")
	public String commuteDetail(@ModelAttribute EmployeeDTO employeeDTO, Model model) throws Exception {
		EmployeeDTO ResultEmpDTO = storeEmpService.getEmpInfo(employeeDTO.getEmp_id());
		logger.info("들어오나?");
		model.addAttribute("employeeDTO", ResultEmpDTO);

		return "emp/commuteDetail.store";
	}

	@PostMapping("select_store")
	@ResponseBody
	public List<String> select_store(String location_code) throws Exception {

		List<String> list = storeEmpService.select_store(location_code);

		return list;

	}
	@PostMapping("search/{pg}")
	@ResponseBody
	public List<EmployeeDTO> search (String keyword, @PathVariable int pg) throws Exception{
		logger.info(keyword);

		Map<String, Object> map = new HashMap();
		map.put("name",keyword);
		Long totalCount = storeEmpService.toca(map);
		
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);		
		map.put("pageDTO",pageDTO);
		
		List<EmployeeDTO> list = storeEmpService.getcomList(map);
		logger.info(list.toString());
		return list;		
	}
	
	@RequestMapping("retireEmp")
	@ResponseBody
	public Map<String, String> retireEmp(@ModelAttribute EmployeeDTO employeeDTO, Model model) throws Exception {
		logger.info("지점 직원 퇴사 처리");
		logger.info(employeeDTO.toString());
		headEmpService.retireEmp(employeeDTO);

		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", employeeDTO.getEmp_id() + "사원이 퇴사처리 되었습니다.");
		map.put("url", "/act/store/emp/empList/1/?keyword=");

		logger.info(map.toString());
		return map;
	}

}
