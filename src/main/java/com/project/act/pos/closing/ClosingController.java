package com.project.act.pos.closing;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.Daily_incomeDTO;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.StoresDTO;
import com.project.act.models_dto.TransactDTO;
import com.project.act.models_dto.Transact_detailDTO;

@Controller
@RequestMapping("pos/closing/{pg}")
public class ClosingController {
	
	private static final Logger logger = LoggerFactory.getLogger(ClosingController.class);
	
	@Autowired()
	private ClosingService closingService;
	
	@GetMapping("/")
	public String closing(HttpSession session, @PathVariable int pg, Model model) throws Exception {
		logger.info("===closing main===");
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		String date_of_day = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
					
		TransactDTO transactDTO = new TransactDTO();
		transactDTO.setStoreDTO(storeDTO);
		
		Daily_incomeDTO daily_incomeDTO = closingService.getDaily_income(store_name);
		
		if(daily_incomeDTO==null) {
			logger.info("결산 안함//==================");
			long totalCount = closingService.get_totalCount(store_name);
			PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
			transactDTO.setPageDTO(pageDTO);
			
			List<TransactDTO> list = closingService.transact_daily_list(transactDTO);
			
			model.addAttribute("store_name", store_name);
			model.addAttribute("list", list);
			model.addAttribute("date_of_day", date_of_day);	
			model.addAttribute("daily_incomeDTO",daily_incomeDTO);
			model.addAttribute("pageDTO",pageDTO);
			
		}else{
			logger.info("결산 함//==================");
			logger.info("daily_incomeDTO : " + daily_incomeDTO.toString());
			
			transactDTO.setTrans_date(daily_incomeDTO.getReg_time());
			
			long totalCount = closingService.totalCount_before(transactDTO);
			PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
			transactDTO.setPageDTO(pageDTO);
			
			List<TransactDTO> list = closingService.transact_before_list(transactDTO);
			
			List<TransactDTO> after_list = closingService.transact_after_list(transactDTO);
			
			model.addAttribute("store_name", store_name);
			model.addAttribute("list", list);
			model.addAttribute("after_list",after_list);
			model.addAttribute("date_of_day", date_of_day);	
			model.addAttribute("daily_incomeDTO",daily_incomeDTO);
			model.addAttribute("pageDTO", pageDTO);
		}
		
		return "closing/closing.pos";
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
		
		List<Transact_detailDTO> list = closingService.get_detail(transaction_code);
		logger.info(list.get(0).toString());
		return list;
	}
	
	@PostMapping("closing")
	@ResponseBody
	public void closing_btn(HttpSession session) throws SQLException {
		Daily_incomeDTO daily_incomeDTO = new Daily_incomeDTO();
		//closing을 누르면 daily_income.total_income이 monthly_goal.total_income으로 들어가야함 
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name());
	
		daily_incomeDTO.setStoreDTO(storeDTO);
		daily_incomeDTO.setReg_time(new SimpleDateFormat("kk:mm:ss").format(new Date()));
		daily_incomeDTO.setClosing_id( ((EmployeeDTO) session.getAttribute("userInfo")).getEmp_id() );
		logger.info("closing btn : ======");
		logger.info("daily_incomeDTO : " + daily_incomeDTO.toString());
		
		closingService.closing_btn(daily_incomeDTO);
		
	}
	
	@PostMapping("delete_closing")
	@ResponseBody
	public void delete_closing(String store_name) throws SQLException {
		
		closingService.delete_closing(store_name);
		
	}
	
}
