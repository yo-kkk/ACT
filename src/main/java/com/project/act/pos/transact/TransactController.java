package com.project.act.pos.transact;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.Store_stockDTO;
import com.project.act.models_dto.TransactDTO;

@Controller
@RequestMapping("pos/transact")
public class TransactController {
	
	private static final Logger logger = LoggerFactory.getLogger(TransactController.class);
	
	@Autowired()
	private TransactService transactService;
	
	@GetMapping("/")
	public String transact(HttpSession session, Model model) throws Exception {
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		
		model.addAttribute("store_name", store_name);
		return "transact/transact.pos";
	}
	
	@PostMapping("product_list")
	@ResponseBody
	public List<Store_stockDTO> product_list(String keyword,String store_name,int pg) throws Exception {
		if(keyword==null) keyword="";
		logger.info("product_list modal 띄우기 ============ keyword = " + keyword + " && // store_name = " + store_name +" && // pg = " + pg);
		
				
		Map<String, Object> map = new HashMap();
		map.put("keyword",keyword);
		map.put("store_name",store_name);
		
		long totalcount = transactService.get_total_count(map);
		
		PageDTO pageDTO = new PageDTO(pg, 10, 3, totalcount);
		map.put("pageDTO",pageDTO);
		
		List<Store_stockDTO> list = transactService.product_list(map);
		
		Store_stockDTO storeStockDTO = list.get(0);
		storeStockDTO.setPageDTO(pageDTO);
		
		list.set(0, storeStockDTO);
		
		return list;
	}
	
	@PostMapping("transact_all")
	@ResponseBody
	public void transact_all(@ModelAttribute TransactDTO transactDTO,String[] product_quantity,HttpSession session) throws Exception {
		
		
		EmployeeDTO empDTO = (EmployeeDTO) session.getAttribute("userInfo");
		
		transactDTO.setStoreDTO(empDTO.getStoreDTO());
		transactDTO.setCasher_id(empDTO.getEmp_id());
		transactDTO.setTrans_date( new SimpleDateFormat("yy-MM-dd kk:mm:ss").format(new Date() ) );
		
		logger.info(transactDTO.toString());
		for(int i=1;i<product_quantity.length;i++) {
			logger.info(i+"==========");
			logger.info("p_c : " + product_quantity[i].split(",")[0]);
			logger.info("quant : " + product_quantity[i].split(",")[1]);
		}

		transactService.transact_all(transactDTO,product_quantity);
	}

}
