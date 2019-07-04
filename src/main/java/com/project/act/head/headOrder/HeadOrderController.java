package com.project.act.head.headOrder;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.head.product.ProductService;
import com.project.act.models_dto.Head_orderDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.Store_orderDTO;
import com.project.act.store.storeOrder.StoreOrderService;

@Controller
@RequestMapping("head/order")
public class HeadOrderController {

	private static final Logger logger = LoggerFactory.getLogger(HeadOrderController.class);

	@Value("${upload.url}")
	private String uploadUrl;
	
	@Autowired
	private HeadOrderService headOrderService;

	@Autowired
	private ProductService productService;	
	
	@Autowired
	private StoreOrderService storeOrderService;
	
	@GetMapping("/toFactory/{pg}")
	public String toFactory(Model model, HttpSession session, @PathVariable int pg,
			@RequestParam(required = false) String keyword) throws Exception {
		logger.info("본사/ 공장으로 보낸 발주 목록");
		logger.info("pg : " + pg + "// " + "keyword = " + keyword);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		
		long totalCount = headOrderService.getSearchTotalCnt(map);
		
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
		
		logger.info(pageDTO.toString());
		map.put("pageDTO", pageDTO);
		
		List<Head_orderDTO> list = headOrderService.getToFactoryOrderList(map);
		
		for(Head_orderDTO a : list) {
			a.getReceive_yn();
		}
		
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("list",list);
		
		return "order/toFactory.head";
	}
	
	// 상세정보에 이미지 출력
	@RequestMapping("download")
	public void download(String fileName, HttpServletResponse response) throws IOException {
		
		File file = new File(uploadUrl, fileName);
		response.setContentLength((int)file.length());
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName,"UTF-8"));
		
		InputStream is = new FileInputStream(file);
		OutputStream os = response.getOutputStream();
		FileCopyUtils.copy(is, os);
		
		os.flush();
		if (os != null) try {os.close();} catch(Exception e) {}
		if (is != null) try {is.close();} catch(Exception e) {}
	}
	
	@PostMapping("/toFactory/cancelHeadOrder")
	public String canceltoFactory(Head_orderDTO head_orderDTO,Model model, HttpSession session) throws Exception {
		logger.info("본사/ 공장으로 보낸 발주" + head_orderDTO.getHead_order_code() + " 취소 처리");

		headOrderService.deleteToFactoryOrder(head_orderDTO);
		
		model.addAttribute("msg", head_orderDTO.getHead_order_code() + "번" +
		 head_orderDTO.getProductDTO().getProduct_code() + "발주 건이 취소 처리되었습니다.");
		model.addAttribute("url", "1/?keyword=");
		return "result";
	}
	
	@PostMapping("/getDetail")
	@ResponseBody
	public ProductDTO getDetail(String product_code) throws Exception {
		logger.info(product_code);
		ProductDTO productDTO = new ProductDTO();

		productDTO = productService.getProNFactoryDetail(product_code);
		logger.info(productDTO.toString());

		return productDTO;
	}
	
	@PostMapping("/toFactory/updateReceive")
	public String updateReceive(Head_orderDTO head_orderDTO, Model model, HttpSession session) throws Exception {
		logger.info("수령/미수령 처리");
		logger.info(head_orderDTO.toString());
		
		headOrderService.updateReceive(head_orderDTO);
		
		if(head_orderDTO.getReceive_yn().equals("n")) {
			model.addAttribute("msg", head_orderDTO.getHead_order_code() + "번 발주 건이 미수령 처리되었습니다.");
		}else {
			model.addAttribute("msg", head_orderDTO.getHead_order_code() + "번 발주 건이 수령 처리되었습니다.");
		}
		model.addAttribute("url", "1/?keyword=");
		
		return "result";
	}
	
	@GetMapping("/fromStore/{pg}")
	public String fromStore(Model model, HttpSession session, @PathVariable int pg,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false) String store_name) throws Exception {
		logger.info("본사/ 지점으로부터 받은 수주 목록");
		logger.info("pg : " + pg + "// " + "keyword = " + keyword + " // store_name : " + store_name);
			
		Map<String, Object> map = new HashMap();
		
		map.put("store_name",store_name);
		map.put("keyword",keyword);
		
		long totalCount = storeOrderService.getFromStoreToHeadOrder_cnt(map);
		
		logger.info("" + totalCount);
		
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
		
		map.put("pageDTO", pageDTO);
		
		List<Store_orderDTO> list = storeOrderService.getFromStoreToHeadOrder_list(map);
	
		model.addAttribute("list", list);
		model.addAttribute("store_name", store_name);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("keyword",keyword);
		
		return "order/fromStore.head";
	}
	
	@PostMapping("/sendAction")
	public String sendAction(Model model, HttpSession session, 
			Store_orderDTO store_orderDTO) throws Exception {
		logger.info("본사 -> 지점 제품 발송/발송보류 처리");
		logger.info(store_orderDTO.toString());
		
		headOrderService.updateSendYN(store_orderDTO);
		
		if(store_orderDTO.getSend_yn().equals("n")) {
			model.addAttribute("msg", store_orderDTO.getStore_order_code() + "번 배송이 보류 처리되었습니다.");
		}else {
			model.addAttribute("msg", store_orderDTO.getStore_order_code() + "번 수주가 배송 처리되었습니다.");
		}
		model.addAttribute("url", "fromStore/1/?keyword=");		
		return "result";
	}

}
