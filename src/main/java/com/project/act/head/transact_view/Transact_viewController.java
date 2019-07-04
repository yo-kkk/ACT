package com.project.act.head.transact_view;

import java.sql.SQLException;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.StoresDTO;
import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

@Controller
@RequestMapping("head/transact_view/{pg}")
public class Transact_viewController {
	private static final Logger logger = LoggerFactory.getLogger(Transact_viewController.class);

	@Autowired
	private Transact_viewService transact_viewService;
	
	@GetMapping("/")
	public String trans_view(HttpSession session, @PathVariable int pg, Model model, HttpServletRequest request) throws Exception{
		String when = request.getParameter("when");
		String store = request.getParameter("store");
		
		logger.info("Transact_view(head) 메인화면 : =============== when = " + when +" && store = " + store);
		
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store);
		
		TransactDTO transactDTO = new TransactDTO();
		transactDTO.setTrans_date(when);
		transactDTO.setStoreDTO(storeDTO);
		
		long totalCount = transact_viewService.get_totalCount(transactDTO);
		PageDTO pageDTO = new PageDTO(pg,20,5,totalCount);
		transactDTO.setPageDTO(pageDTO);	
		List<TransactDTO> list = transact_viewService.get_List(transactDTO);
		
		model.addAttribute("store_name", store);
		model.addAttribute("list", list);
		model.addAttribute("pageDTO",pageDTO);
		model.addAttribute("when",when);		
		
		return "transact_view/transact_view.head";
	}
	
	@PostMapping("transact_Detail")
	@ResponseBody
	public List<Transact_detailDTO> detail (String transact_code) throws SQLException{
		
		long transaction_code = 0;
		
		if(transact_code.charAt(0)=='r') {
			transaction_code = Long.parseLong( transact_code.substring(2,transact_code.length()));
		}else {
			transaction_code= Long.parseLong(transact_code);
		}
		
		logger.info("Transact_view(head)_detail ajax화면 : =============== transact_code = " + transact_code);
			
		List<Transact_detailDTO> list = transact_viewService.get_detail(transaction_code);
		
		return list;
	}
	
	@PostMapping("select_store")
	@ResponseBody
	public List<String> select_store(String location_code) throws Exception {
		
		logger.info("ajax == select_box 에 store_list 불러오기 =========== location_code : " + location_code );
		List<String> list = transact_viewService.select_store(location_code);
		
		return list;

	}
	
	@PostMapping("search")
	@ResponseBody
	public TransactDTO search (String keyword,HttpSession session) throws SQLException{
		logger.info("search// keyword : " + keyword);
		
		Map<String,String> map = new HashMap();
		map.put("keyword", keyword);
		
		TransactDTO transDTO = transact_viewService.search(map);
		logger.info(transDTO.toString());
		
		return transDTO;
	}

}
