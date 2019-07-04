package com.project.act.pos.stock;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.Store_stockDTO;
import com.project.act.models_dto.StoresDTO;

@Controller
@RequestMapping("pos/stock/{pg}")
public class StockController {

	private static final Logger logger = LoggerFactory.getLogger(StockController.class);

	@Value("${upload.url}")
	private String uploadUrl;
	
	@Autowired()
	private StockService stockService;

	@GetMapping("/")
	public String stock(HttpSession session, @PathVariable int pg, Model model, HttpServletRequest request) throws Exception {
		
		String keyword = request.getParameter("keyword");
		
		logger.info("stock 메인화면 : ======== keyword = " + keyword);

		String store_name = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();

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
		logger.info(store_list.toString());
		
		
		
		model.addAttribute("list", list);
		model.addAttribute("store_name", store_name);
		model.addAttribute("store_list", store_list);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("keyword",keyword);

		return "stock/stock.pos";
	}

	@GetMapping("/{other_select}")
	public String stock_other(@PathVariable String other_select,HttpSession session, @PathVariable int pg, Model model, HttpServletRequest request) throws Exception {
		String keyword = request.getParameter("keyword");
		
		String store_name = other_select;
		String my_store = ((EmployeeDTO) session.getAttribute("userInfo")).getStoreDTO().getStore_name();
		
		logger.info("stock_other 메인화면 : ======== keyword = " + keyword +" && store_name = " + store_name);
		
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
		logger.info(store_list.toString());

		model.addAttribute("list", list);
		model.addAttribute("store_name", store_name);
		model.addAttribute("store_list", store_list);
		model.addAttribute("my_store", my_store);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("keyword",keyword);
		

		return "stock/stock_other.pos";
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

	@PostMapping("getDetail")
	@ResponseBody
	public ProductDTO getDetail(String product_code) throws SQLException {
		logger.info(product_code);
		ProductDTO productDTO = new ProductDTO();

		productDTO = stockService.getDetail(product_code.trim());

		return productDTO;
	}

}
