package com.project.act.store.transact_list;

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

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.StoresDTO;
import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

@Controller
@RequestMapping("store/transact_list/{pg}")
public class Transact_listController {
private static final Logger logger = LoggerFactory.getLogger(Transact_listController.class);
	
	@Autowired
	private Transact_listService transact_listService;

	@GetMapping("/")
	public String trans_list(HttpSession session, @PathVariable int pg, Model model, HttpServletRequest request) throws Exception{
		
		String when = request.getParameter("when");
		
		logger.info("Transact_list 메인화면 : =============== when = " + when);
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();		
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
				
		TransactDTO transactDTO = new TransactDTO();
		transactDTO.setTrans_date(when);
		transactDTO.setStoreDTO(storeDTO);
		
		long totalCount = transact_listService.get_totalCount(transactDTO);
		PageDTO pageDTO = new PageDTO(pg,20,5,totalCount);
		transactDTO.setPageDTO(pageDTO);	
		List<TransactDTO> list = transact_listService.get_List(transactDTO);
		
		model.addAttribute("store_name", store_name);
		model.addAttribute("list", list);
		model.addAttribute("pageDTO",pageDTO);
		model.addAttribute("when",when);
		
		return "transact_list/transact_list.store";
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
		
		logger.info("detail : " + transaction_code);
		
		List<Transact_detailDTO> list = transact_listService.get_detail(transaction_code);
		
		return list;
	}
	
	@PostMapping("search")
	@ResponseBody
	public TransactDTO search (String keyword,HttpSession session) throws SQLException{
		logger.info("search// keyword : " + keyword);
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		
		Map<String,String> map = new HashMap();
		map.put("keyword", keyword);
		map.put("store_name",store_name);
		
		TransactDTO transDTO = transact_listService.search(map);
		logger.info(transDTO.toString());
		
		return transDTO;
	}

}
