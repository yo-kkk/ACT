package com.project.act.pos.refund;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@RequestMapping("pos/refund/{pg}")
public class RefundController {
	
	private static final Logger logger = LoggerFactory.getLogger(RefundController.class);
	
	@Autowired()
	private RefundService refundService;
	
	@GetMapping("/")
	public String refund(HttpSession session,@PathVariable int pg, Model model) throws Exception {
		
		logger.info("refund 메인화면 : ==============");
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
						
		long totalCount = refundService.get_totalCount(store_name);
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
		
		TransactDTO transactDTO = new TransactDTO();
		transactDTO.setStoreDTO(storeDTO);
		transactDTO.setPageDTO(pageDTO);		
		
		List<TransactDTO> list = refundService.get_transact_list(transactDTO);
		
		model.addAttribute("store_name", store_name);
		model.addAttribute("list", list);
		model.addAttribute("pageDTO", pageDTO);
		
		return "refund/refund.pos";
	}
	
	@PostMapping("transact_Detail")
	@ResponseBody
	public List<Transact_detailDTO> detail (long transaction_code) throws SQLException{
		
		logger.info("detail : " + transaction_code);
		
		List<Transact_detailDTO> list = refundService.get_detail(transaction_code);
		logger.info(list.get(0).toString());
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
		
		TransactDTO transDTO = refundService.search(map);
		logger.info(transDTO.toString());
		
		return transDTO;
	}
	

	@PostMapping("refund_all")
	@ResponseBody
	public void refund_all(String transaction_code,HttpSession session) throws SQLException{
		
		logger.info("refund_all -- transaction_code : " + transaction_code);
		
		EmployeeDTO empDTO = (EmployeeDTO) session.getAttribute("userInfo");
		
		TransactDTO transactDTO = new TransactDTO();
		transactDTO.setTransaction_code(transaction_code);
		transactDTO.setTrans_date( new SimpleDateFormat("yy-MM-dd kk:mm:ss").format(new Date()) );
		transactDTO.setStoreDTO(empDTO.getStoreDTO());
		transactDTO.setCasher_id(empDTO.getEmp_id());
		
		refundService.refund_all(transactDTO);
	}
	
	@GetMapping("/list")
	public String refund_list(HttpSession session, Model model, @PathVariable int pg) throws Exception {
				
		logger.info("refund list화면 : ================");
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		logger.info("store_name : " + store_name);
		
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
		
		long totalCount = refundService.totalCount_refundList(store_name);
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
						
		TransactDTO transactDTO = new TransactDTO();
		transactDTO.setStoreDTO(storeDTO);
		transactDTO.setPageDTO(pageDTO);
		
		List<TransactDTO> list = refundService.get_refund_list(transactDTO);
		
		model.addAttribute("store_name", store_name);
		model.addAttribute("list", list);
		model.addAttribute("pageDTO", pageDTO);
		
		return "refund/refund_list.pos";
	}
	
	@PostMapping("search_refund_list")
	@ResponseBody
	public TransactDTO search_refund_list (String keyword) throws SQLException{
		logger.info("search// keyword : " + keyword);
		
		TransactDTO transDTO = refundService.search_refund_list(keyword);
		logger.info(transDTO.toString());
		
		return transDTO;
	}
	
}
