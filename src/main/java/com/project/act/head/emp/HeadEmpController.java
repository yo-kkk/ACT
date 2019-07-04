package com.project.act.head.emp;

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

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.PositionDTO;
import com.project.act.models_dto.StoresDTO;

@Controller
@RequestMapping("head/emp")
public class HeadEmpController {
	private static final Logger logger = LoggerFactory.getLogger(HeadEmpController.class);
	
	@Autowired
	private HeadEmpService headEmpService;

	@GetMapping("/empInsert")
	public String headEmpInsert(Model model) throws Exception {
		logger.info("본사 직원 등록 화면 호출");

		return "emp/headEmpInsertPage.head";
	}

	@PostMapping("/empInsert")
	public String headEmpInsertAction(@ModelAttribute EmployeeDTO employeeDTO, Model model) throws Exception {
		logger.info("본사 직원 등록 처리 메서드로 옴");

		// 1. 사원 등록시 '초기 패스워드'를 사원의 생년월일(yyyymmdd)로 설정
		employeeDTO.setEmp_password(employeeDTO.getHire_date().toString().replace("-", ""));

		// 2. 사원 등록시 입력 받은 '직급'에 맞는 '직급정보DTO'을 가지고 와서 empDTO에 정보를 채운다
		PositionDTO positionDTO = headEmpService.getPositionInfo(employeeDTO.getPositionDTO().getPosition_code());
		employeeDTO.setSalary(positionDTO.getMin_sal());
		employeeDTO.getPositionDTO().setName(positionDTO.getName());
		String temploc = employeeDTO.getStoreDTO().getLocation();

		if (temploc.equals("000")) {
			StoresDTO storeDTO = new StoresDTO();
			storeDTO.setStore_name("본사");
			storeDTO.setLocation("000");
			employeeDTO.setStoreDTO(storeDTO);
		}

		// 3. 사원 정보 등록
		headEmpService.headEmpinsert(employeeDTO);

		logger.info("등록 처리 끝냄 + 등록한 정보 조회할 아이디 생성");
		String returnID = employeeDTO.getHire_date().toString().replace("-", "").substring(2) + employeeDTO.getIdx();

		// 4. DB에서 등록된 사원 정보 가져오기
		EmployeeDTO ResultEmpDTO = headEmpService.getEmpInfo(returnID);

		model.addAttribute("employeeDTO", ResultEmpDTO);

		return "emp/headEmpDetail.head";
	}

	@GetMapping("/empList/{pg}")
	public String productList(Model model, HttpSession session, @PathVariable int pg, HttpServletRequest request)
			throws Exception {

		String keyword = request.getParameter("keyword");
		logger.info("사원 리스트 화면 : keyword = " + keyword);
		logger.info(keyword);

		Map<String, Object> map = new HashMap();
		map.put("keyword", keyword);

		Long totalCount = headEmpService.searchCnt(map);

		PageDTO pageDTO = new PageDTO(pg, 10, 5, totalCount);
		map.put("pageDTO", pageDTO);

		List<EmployeeDTO> list = headEmpService.search(map);
		logger.info(list.toString());

		model.addAttribute("Emplist", list);
		model.addAttribute("pageDTO", pageDTO);

		return "emp/headEmpList.head";
	}

	@RequestMapping("/empDetail")
	public String headEmpDetail(@ModelAttribute EmployeeDTO employeeDTO, Model model) throws Exception {
		logger.info("본사 직원 정보 디테일 페이지로 옴");

		EmployeeDTO ResultEmpDTO = headEmpService.getEmpInfo(employeeDTO.getEmp_id());
		model.addAttribute("employeeDTO", ResultEmpDTO);

		return "emp/headEmpDetail.head";
	}

	@GetMapping("/empUpdate")
	@ResponseBody
	public EmployeeDTO headEmpUpdateModal(@ModelAttribute EmployeeDTO employeeDTO, Model model) throws Exception {
		logger.info("본사 직원 정보 수정 모달에 정보 전달 / 수정할 직원 코드 " + employeeDTO.getEmp_id());

		EmployeeDTO ResultEmpDTO = headEmpService.getEmpInfo(employeeDTO.getEmp_id());

		return ResultEmpDTO;
	}

	@PostMapping("/empUpdate")
	@ResponseBody
	public EmployeeDTO headEmpUpdateAction(@ModelAttribute EmployeeDTO employeeDTO, Model model) throws Exception {
		logger.info("본사 직원 정보 디테일 수정 처리");
		logger.info(employeeDTO.toString());

		headEmpService.updateEmpInfo(employeeDTO);

		EmployeeDTO ResultEmpDTO = headEmpService.getEmpInfo(employeeDTO.getEmp_id());
		logger.info("변경 후 :" + ResultEmpDTO);
		return ResultEmpDTO;
	}

	@RequestMapping("/retireEmp")
	@ResponseBody
	public Map<String, String> retireEmp(@ModelAttribute EmployeeDTO employeeDTO, Model model) throws Exception {
		logger.info("본사 직원 퇴사 처리");

		headEmpService.retireEmp(employeeDTO);

		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", employeeDTO.getEmp_id() + "사원이 퇴사처리 되었습니다.");
		map.put("url", "/act/head/emp/empList/1/?keyword=");

		logger.info(map.toString());
		return map;

	}

	@PostMapping("select_store")
	@ResponseBody
	public List<String> select_store(String location_code) throws Exception {
		logger.info(location_code);
		List<String> list = headEmpService.select_store(location_code);
		logger.info(list.get(0).toString());
		return list;

	}

	@PostMapping("search/{pg}")
	@ResponseBody
	public List<EmployeeDTO> search(String keyword, @PathVariable int pg) throws Exception {
		logger.info(keyword);

		Map<String, Object> map = new HashMap();
		map.put("name", keyword);
		Long totalCount = headEmpService.searchCnt(map);

		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
		map.put("pageDTO", pageDTO);

		List<EmployeeDTO> list = headEmpService.search(map);
		logger.info(list.toString());
		return list;
	}
	
	/*
	 * @GetMapping("/RetireEmpList/{pg}") public String getRetireEmpList(Model
	 * model, HttpSession session, @PathVariable int pg, HttpServletRequest request)
	 * throws Exception {
	 * 
	 * String keyword = request.getParameter("keyword");
	 * logger.info("사원 리스트 화면 : keyword = " + keyword); logger.info(keyword);
	 * 
	 * Map<String, Object> map = new HashMap(); map.put("keyword", keyword);
	 * 
	 * Long totalCount = headEmpService.getRetireEmpCnt(map);
	 * 
	 * PageDTO pageDTO = new PageDTO(pg, 10, 5, totalCount); map.put("pageDTO",
	 * pageDTO);
	 * 
	 * List<EmployeeDTO> list = headEmpService.search(map);
	 * logger.info(list.toString());
	 * 
	 * model.addAttribute("Emplist", list); model.addAttribute("pageDTO", pageDTO);
	 * 
	 * return "emp/headEmpList.head"; }
	 */

}