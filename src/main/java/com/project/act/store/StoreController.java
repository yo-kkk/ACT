package com.project.act.store;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.act.login.LoginController;
import com.project.act.models_dto.EmployeeDTO;

@Controller
@RequestMapping("store")
public class StoreController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@GetMapping("/")
	public String pos_main(HttpSession session, Model model) throws Exception{
		logger.info("Store화면");
		
		EmployeeDTO empDTO = (EmployeeDTO) session.getAttribute("userInfo");
		
		if(empDTO.getPositionDTO().getPosition_code()<4||
		   empDTO.getPositionDTO().getPosition_code() == 6) {
			
			model.addAttribute("msg","권한이 없습니다.");
			model.addAttribute("url","/act/Intro/");
			return "result";
		}
		
		return "main/store_main.store";
	}

}
