package com.project.act.store.storeOrder;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
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

import com.project.act.head.product.ProductService;
import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.Store_orderDTO;

@Controller
@RequestMapping("store/order")
public class StoreOrderController {

	private static final Logger logger = LoggerFactory.getLogger(StoreOrderController.class);

	@Autowired()
	private StoreOrderService storeOrderService;

	@Autowired
	private ProductService productService;	
	
	@GetMapping("{pg}")
	public String stock(Model model, HttpSession session, @PathVariable int pg, 
			 HttpServletRequest request) throws Exception {
		String keyword = request.getParameter("keyword");		
		logger.info("지점에서 본사로 보낸 발주 리스트 화면 : ======== keyword = " + keyword);
		
		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		logger.info(store_name);
	
		Map<String, Object> map = new HashMap();
		
		map.put("store_name",store_name);
		map.put("keyword",keyword);
		
		long totalCount = storeOrderService.getFromStoreToHeadOrder_cnt(map);
		
		logger.info("" + totalCount);
		
		PageDTO pageDTO = new PageDTO(pg, 10, 3, totalCount);
		
		map.put("pageDTO", pageDTO);
		
		List<Store_orderDTO> list = storeOrderService.getFromStoreToHeadOrder_list(map);
		
		for(Store_orderDTO a : list) {
			logger.info(a.toString());
		}
		
		model.addAttribute("list", list);
		model.addAttribute("store_name", store_name);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("keyword",keyword);

		return "order/orderList.store";
	}

	// 지점에서 본사로 발주시 사용
	 @PostMapping("store_order_all")	 
	 @ResponseBody
	 public void store_order_all(String[] product_quantity,String total_price, 
			String arrayYN, HttpSession session) throws Exception {
		 logger.info("지점에서 본사로 발주 controller");
			EmployeeDTO empDTO = (EmployeeDTO) session.getAttribute("userInfo");
	
			Store_orderDTO store_orderDTO = new Store_orderDTO();
			store_orderDTO.setStoreDTO(empDTO.getStoreDTO());
			store_orderDTO.setEmpDTO(empDTO);
			store_orderDTO.setOrder_date(new SimpleDateFormat("yyyy-MM-dd kk:mm:ss").format(new Date()));
			logger.info(store_orderDTO.toString());
			logger.info(Arrays.deepToString(product_quantity));
			
			if(Integer.parseInt(arrayYN) >= 2) {				
				storeOrderService.fromStoreToHeadOrder(store_orderDTO,product_quantity);		
			} else {
				storeOrderService.fromStoreToHeadOrder_single(store_orderDTO, product_quantity);		
			}
			
			session.removeAttribute("orderListMap"); 
			
			List<Object> orderListMap = new ArrayList<Object>();
			
			session.setAttribute("orderListMap", orderListMap);
			
	}
		 
	@PostMapping("/getDetail")
	@ResponseBody 
	public ProductDTO getDetail(String product_code) throws Exception{ 
	logger.info(product_code); 
	ProductDTO productDTO = new	ProductDTO();
	
	productDTO = productService.getProNFactoryDetail(product_code);
	
	return productDTO; 
	}
	
	@PostMapping("/updateReceive")
	public String updateReceive(Store_orderDTO store_orderDTO, Model model, HttpSession session) throws Exception {
		logger.info("수령/미수령 처리");
		logger.info(store_orderDTO.toString());
		
		storeOrderService.updateReceive(store_orderDTO);
		
		if(store_orderDTO.getReceive_yn().equals("n")) {
			model.addAttribute("msg", store_orderDTO.getStore_order_code() + "번 발주 건이 미수령 처리되었습니다.");
		}else {
			model.addAttribute("msg", store_orderDTO.getStore_order_code() + "번 발주 건이 수령 처리되었습니다.");
		}
		model.addAttribute("url", "1/?keyword=");
		
		return "result";
	}
	
	// 제품 상세 정보 호출
	@PostMapping("/getDetailofStore")
	@ResponseBody
	public ProductDTO getStoreProductDetail(String product_code, String store_name) throws Exception {
		logger.info(product_code);
		logger.info(store_name);
		ProductDTO productDTO = new ProductDTO();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("product_code", product_code);
		map.put("store_name", store_name);
		
		productDTO = productService.getProNFactoryDetailFromStore(map);
		logger.info(productDTO.toString());

		return productDTO;
	}
	
}
