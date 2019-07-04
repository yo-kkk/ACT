package com.project.act.head.factory;

import java.util.List;

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

import com.project.act.models_dto.FactoryDTO;
import com.project.act.models_dto.PageDTO;

@Controller
@RequestMapping("head/factory/{pg}")
public class FactoryController {
	
		private static final Logger logger = LoggerFactory.getLogger(FactoryController.class);
		
		@Autowired
		private FactoryService factoryService;
		
		@RequestMapping("/")
		public String factoryList(Model model,HttpSession session,@PathVariable int pg) throws Exception{	
		
		logger.info("Factory List main page===============");
			
		long totalcount = factoryService.get_total_count();
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalcount);	
		
		List<FactoryDTO> list = factoryService.getFactoryList(pageDTO);
		
		model.addAttribute("list", list);
		model.addAttribute("pageDTO",pageDTO);
		
		return "factory/factoryList.head";
		
		}
		
		@GetMapping("/addFactory")
		public String addFactory() throws Exception{	
			
		return "factory/addFactory.head";
		}
		
		@PostMapping("/addFactory")
		public String addFactory(@ModelAttribute FactoryDTO factoryDTO ,Model model,HttpSession session) throws Exception{	

		factoryService.addFactory(factoryDTO);
		
		model.addAttribute("url","../factory/");
		model.addAttribute("msg","등록되었습니다.");
		return "result";
		}
		
		@PostMapping("/deleteFactory")
		public String deleteFactory(@ModelAttribute FactoryDTO factoryDTO ,Model model,HttpSession session) throws Exception{	
		
		factoryService.deleteFactory(factoryDTO);
		
		model.addAttribute("url","../");
		model.addAttribute("msg","삭제되었습니다.");
		return "result";
		}
		
		@GetMapping("/editFactory")
		public String editFactory(@ModelAttribute FactoryDTO factoryDTO , Model model,HttpSession session) throws Exception{	

		return "factory/editFactory.head";
		}
		
	
		@PostMapping("/editFactory") 
		public String editFactoryAction(@ModelAttribute FactoryDTO factoryDTO, Model model,HttpSession session) throws Exception{ 
	
		factoryService.editFactory(factoryDTO);
		
		model.addAttribute("url","../1/");
		model.addAttribute("msg","수정되었습니다. .");
		return "result";
		}
	
}