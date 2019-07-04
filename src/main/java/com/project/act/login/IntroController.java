package com.project.act.login;


import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.EmployeeDTO;


@Controller
@RequestMapping("Intro")
public class IntroController {

	private static final Logger logger = LoggerFactory.getLogger(IntroController.class);
	
	@Autowired
	private LoginService loginService;
	
	@GetMapping("/")
	public String selectView(HttpSession session,Model model) throws Exception{
		if(session.getAttribute("userInfo")==null) {
			model.addAttribute("msg","로그인이 필요합니다.");
			model.addAttribute("url","../login/");
			return "result";
		}
		
		EmployeeDTO empDTO = (EmployeeDTO) session.getAttribute("userInfo");
		
		List<CommuteDTO> list = loginService.main_list(empDTO.getEmp_id());
		
		model.addAttribute("userInfo", empDTO);
		model.addAttribute("list" , list);		
	
		return "login/intro.intro_tiles";
	}
	
	@RequestMapping("go")
	@ResponseBody
	public String go(Model model,HttpSession session) throws Exception{
		EmployeeDTO userInfo = (EmployeeDTO) session.getAttribute("userInfo");
		
		logger.info("aaaaaaaaaa"+userInfo.toString());
		Date date = new Date();
		
		SimpleDateFormat sdf =  new SimpleDateFormat("kk:mm:ss");
		SimpleDateFormat today =  new SimpleDateFormat("yyyy/MM/dd");
		String start_time = sdf.format(date);
		String work_date = today.format(date);
		
		CommuteDTO commuteDTO = new CommuteDTO();
		commuteDTO.setEmpDTO(userInfo);
		commuteDTO.setStart_time(start_time);
		commuteDTO.setWork_date(work_date);
		logger.info(commuteDTO.toString());
		loginService.go_work(commuteDTO);
		
		logger.info(commuteDTO.toString());
		model.addAttribute("commuteInfo", commuteDTO);
		return start_time;
		
	}
	
	@RequestMapping("leave")
	@ResponseBody
	public String leave(Model model,HttpSession session) throws SQLException{
		EmployeeDTO userInfo = (EmployeeDTO) session.getAttribute("userInfo");
		
		Date date = new Date();
		SimpleDateFormat sdf =  new SimpleDateFormat("kk:mm:ss");
		SimpleDateFormat today =  new SimpleDateFormat("yyyy/MM/dd");
		String end_time = sdf.format(date);
		String work_date = today.format(date);
		
		CommuteDTO commuteDTO = new CommuteDTO();
		commuteDTO.setEmpDTO(userInfo);
		commuteDTO.setEnd_time(end_time);
		commuteDTO.setWork_date(work_date);
		logger.info("봐라아ㅏ아아아아"+commuteDTO.toString());
		loginService.leave_work(commuteDTO);

		logger.info(commuteDTO.toString());
		model.addAttribute("commuteInfo", commuteDTO);
		return end_time;
		
	}
	@RequestMapping("commute")
	@ResponseBody
	public List<CommuteDTO> commute(@RequestParam(required = false) String start, @RequestParam(required = false) String end, Model model,HttpSession session) throws Exception{

		EmployeeDTO userInfo = (EmployeeDTO) session.getAttribute("userInfo");
		String emp_id = userInfo.getEmp_id();
		
		GetInfoDTO getInfoDTO = new GetInfoDTO();
		getInfoDTO.setEmp_id(emp_id);
		getInfoDTO.setStart(start);
		getInfoDTO.setEnd(end);
		
		logger.info("getInfoDTO : "+getInfoDTO.toString());
		
		
		List<CommuteDTO> commuteInfo = loginService.getCommuteInfo(getInfoDTO);
		
		logger.info("commuteInfo : " + commuteInfo.toString());
				
		return commuteInfo;		
			

	}

}
