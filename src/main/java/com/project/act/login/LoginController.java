package com.project.act.login;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.act.models_dto.CommuteDTO;
import com.project.act.models_dto.EmployeeDTO;


@Controller
@RequestMapping("login")
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;
	
	@GetMapping("/")
	public String login(HttpSession session, Model model) throws Exception{
		logger.info("login화면");
		
		if(session.getAttribute("userInfo")!=null) {
			model.addAttribute("msg","로그인 세션이 유효합니다.");
			model.addAttribute("url","../Intro/");
			return "result";
		}
		
		return "login/login.login_tiles";
	}
	
	@PostMapping("/")
	public String login(@ModelAttribute EmployeeDTO empDTO, @ModelAttribute CommuteDTO commuteDTO,  Model model,HttpSession session) throws Exception{
		logger.info("empDTO : " + empDTO.toString());
		
		try {
			EmployeeDTO userInfo = loginService.getUser(empDTO);
			logger.info("로그인====");
			logger.info(userInfo.toString());
			session.setAttribute("userInfo", userInfo);

			return "redirect:../Intro/";		
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg",e.getMessage());
			model.addAttribute("url","./");
			return "result";
			
		}
	
	}
	
	@GetMapping("/logout")
	public String logout(Model model,HttpSession session) throws Exception{
		
		session.invalidate();
		
		model.addAttribute("msg","로그아웃 되었습니다. ");
		model.addAttribute("url","./");
		return "result";
	
	}
}
