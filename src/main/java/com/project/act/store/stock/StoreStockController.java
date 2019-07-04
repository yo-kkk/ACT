package com.project.act.store.stock;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.Store_stockDTO;
import com.project.act.models_dto.StoresDTO;
import com.project.act.pos.stock.StockService;

@Controller
@RequestMapping("store/stock")
public class StoreStockController {

	private static final Logger logger = LoggerFactory.getLogger(StoreStockController.class);

	@Autowired()
	private StockService stockService;

	@GetMapping("{pg}")
	public String stock(Model model, HttpSession session, @PathVariable int pg, 
			 HttpServletRequest request) throws Exception {
		String keyword = request.getParameter("keyword");		
		logger.info("StoreStockController 메인화면 : ======== keyword = " + keyword);
				
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		logger.info(store_name);
		// 재고 list 출력
		
		Store_stockDTO stockDTO = new Store_stockDTO();
		StoresDTO storeDTO = new StoresDTO();
		storeDTO.setStore_name(store_name);
		stockDTO.setStoreDTO(storeDTO);
				
		Map<String, Object> map_search = new HashMap();
		
		map_search.put("store_name",store_name);
		map_search.put("keyword",keyword);
		
		long totalCount = stockService.get_totalCount(map_search);

		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
		
		stockDTO.setPageDTO(pageDTO);
		
		Map<String, Object> map = new HashMap();
		map.put("keyword",keyword);
		map.put("stockDTO",stockDTO);
		
		List<Store_stockDTO> list = stockService.getStock_list(map);

		// 다른 매장 list 출력
		List<String> store_list = stockService.getOther_store(store_name);
		
		model.addAttribute("list", list);
		model.addAttribute("store_name", store_name);
		model.addAttribute("store_list", store_list);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("keyword",keyword);

		return "stock/stock.store";
	}

	@PostMapping("/getDetail")
	@ResponseBody
	public ProductDTO getDetail(String product_code) throws SQLException {
		logger.info(product_code);
		ProductDTO productDTO = new ProductDTO();

		productDTO = stockService.getDetail(product_code.trim());

		return productDTO;
	}
	
	 // 지점 재고 페이지 모달창 데이터 controller
		@PostMapping("store_product_list")	
		@ResponseBody 
		public List<Store_stockDTO> store_product_list(@RequestParam String keyword, 
				HttpSession session, int pg) throws Exception {
			
			String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();							
			logger.info(store_name);
				
			Map<String, Object> map = new HashMap();
			map.put("keyword",keyword);
			map.put("store_name",store_name);
			
			long totalCount = stockService.get_totalCount(map);
			logger.info(""+totalCount);
			
			PageDTO pageDTO = new PageDTO(pg, 10, 3, totalCount);	
			map.put("pageDTO",pageDTO);
			Store_stockDTO stockDTO = new Store_stockDTO();
			stockDTO.setPageDTO(pageDTO);
			StoresDTO storeDTO = new StoresDTO();
			storeDTO.setStore_name(store_name);			
			stockDTO.setStoreDTO(storeDTO);
			
			map.put("stockDTO",stockDTO);
			
			List<Store_stockDTO> list = stockService.getStock_list(map);
			
			Store_stockDTO store_stockDTO = list.get(0);			
			store_stockDTO.setPageDTO(pageDTO);
			
			list.set(0, store_stockDTO);	
			
			return list;
		}
	

}
