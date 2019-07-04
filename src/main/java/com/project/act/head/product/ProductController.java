package com.project.act.head.product;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.project.act.models_dto.EmployeeDTO;
import com.project.act.models_dto.FactoryDTO;
import com.project.act.models_dto.Head_orderDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.ProductDTO;

@Controller
@RequestMapping("head/product")
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	private ProductService productService;
	
	@Value("${upload.url}")
	private String uploadUrl;
	
	@RequestMapping("/{pg}")
	public String productList(Model model, HttpSession session, @PathVariable int pg, HttpServletRequest request) throws Exception{	
		
		String keyword = request.getParameter("keyword");		
		logger.info("제품 목록 화면 : keyword = " + keyword);
			
		long totalCount = productService.get_totalCount(keyword);
		
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalCount);
		
		Map<String, Object> map = new HashMap();
		map.put("keyword", keyword);
		map.put("pageDTO", pageDTO);
		
		List<ProductDTO> list = productService.getProduct_list(map);
		
		model.addAttribute("Productlist", list);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageDTO", pageDTO);
		
		return "product/productList.head";	
	}

//*** 제품 등록
	// 1. 제품 등록 페이지 호출
	@GetMapping("/productInsert")	
	public String productInsert(Model model) throws Exception{	
		
		return "product/productInsert.head";
	}
	
	// 2. 제품 등록시 입력 완료 버튼 클릭시 호출
	@PostMapping("/upload")
	public String productInsertAction(@ModelAttribute FileDTO fileDTO, @ModelAttribute ProductDTO productDTO, @ModelAttribute FactoryDTO factoryDTO, Model model) throws Exception{
		
		logger.info(productDTO.toString());
		
		productDTO.setFactoryDTO(factoryDTO);
		productService.productinsert(productDTO);
		
		// 제품 등록 시 매장 제품 재고 목록에도 제품 정보 추가
		productService.store_stock_insert(productDTO);
		
		logger.info("제품 등록 시 생성된 product_code : " + productDTO.getProduct_code());
		
		model.addAttribute("productDTO", productDTO);
		
		return "product/fileUpload.head";
	}

	// 3-1. 제품 등록 이미지 업로드 처리 
	@PostMapping("/productList")
	public String upload(FileDTO fileDTO, @ModelAttribute ProductDTO productDTO, @ModelAttribute FactoryDTO factoryDTO, Model model, HttpSession session) throws Exception {
		
		logger.info("제품 등록에서 받은 product_code : " + productDTO.getProduct_code());
		
		CommonsMultipartFile cmf = fileDTO.getUpFile();
		
		String originalName = cmf.getOriginalFilename();
		logger.info("기존 파일명 : " + originalName);	
		
		String saveName = productDTO.getProduct_code() + ".jpg";
		logger.info("저장 파일명 : " + saveName);
		
		File file = new File(uploadUrl + "/", saveName);
		try {
			cmf.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:1/?keyword=";
	}
	
	// 3-2. 제품 등록 이미지 다운로드 처리(상세정보에 이미지 출력하기 위함) 
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
	
	@PostMapping("/getInfo")
	@ResponseBody
	public ProductDTO getInfo(String product_code) throws Exception {
		logger.info(product_code);
		ProductDTO productDTO = new ProductDTO();

		productDTO = productService.getInfo(product_code);

		return productDTO;
	}		
		
//*** 제품 삭제
	@PostMapping("/deleteProduct")
	public String deleteProduct(@ModelAttribute ProductDTO productDTO, Model model, HttpSession session) throws Exception{	
		logger.info(productDTO.toString());
		productService.deleteProduct(productDTO);
		
		model.addAttribute("url","../");
		model.addAttribute("msg","삭제되었습니다.");
		
		return "product/productList.head";
	}

//*** 제품 수정	
	// 제품 수정 페이지 호출
	@GetMapping("/{pg}/editProduct")
	public String editProduct(@RequestParam(required = false) String product_code, Model model, HttpSession session) throws Exception{
		ProductDTO productDTO = productService.getProNFactoryDetail(product_code);
		model.addAttribute("productDTO", productDTO);
		
		return "product/editProduct.head";
	}
	
	// 제품 수정 처리
	@PostMapping("/{pg}/editProduct")
	public String editProductAction(@ModelAttribute ProductDTO productDTO, Model model, HttpSession session) throws Exception{ 		
		logger.info("edit product action : " + productDTO);
		productService.editProduct(productDTO);
		
		model.addAttribute("url","../1/?keyword=");
		model.addAttribute("msg","제품 정보가 수정되었습니다.");
		
		return "result";
	}	

//*** 전 제품 재고 확인 & 발주	
	// 본사 재고 확인 및 발주 페이지 Controller
	@GetMapping("/stockAndOrder")
	public String stockAndOrder(HttpSession session, Model model ) throws Exception {
		logger.info("===stockAndOrder 컨트롤러==========");
		
		return "product/stockAndOrder.head";
	}
	
	// 본사 재고 페이지 모달창 데이터 controller
	@PostMapping("product_list")	
	@ResponseBody 
	public List<ProductDTO> product_list(@RequestParam String keyword, 
			HttpSession session, int pg) throws Exception {
		
		long totalCount = productService.get_totalCount(keyword);
		
		PageDTO pageDTO = new PageDTO(pg, 10, 3, totalCount);	
				
		Map<String, Object> map = new HashMap();
		map.put("keyword",keyword);
		map.put("pageDTO",pageDTO);
		
		List<ProductDTO> productList = productService.getProduct_list(map);
		ProductDTO productDTO = productList.get(0);
		productDTO.setPageDTO(pageDTO);
		
		productList.set(0, productDTO);	
		
		return productList;
	}
	
	// 본사에서 제조사로 발주시 사용
	 @PostMapping("head_order_all")	 
	 @ResponseBody
	 public void head_order_all(String[] product_quantity,String total_price, 
			 String arrayYN, HttpSession session) throws Exception {
			EmployeeDTO empDTO = (EmployeeDTO) session.getAttribute("userInfo");
			
			Head_orderDTO head_orderDTO = new Head_orderDTO();
			head_orderDTO.setEmpDTO(empDTO);
			head_orderDTO.setOrder_date(new SimpleDateFormat("yyyy-MM-dd kk:mm:ss").format(new Date()));
			
			if(Integer.parseInt(arrayYN) >= 2) {				
				productService.headOrder(head_orderDTO,product_quantity);		
			} else {
				productService.headOrder_single(head_orderDTO, product_quantity);		
			}
			 
	 }
	
	
//** 제품 search & detail	
	// 지울까?
	@PostMapping("/search")
	@ResponseBody
	public List<ProductDTO> HeadProductSearch (String keyword) throws Exception{
		logger.info(keyword);	
		
		List<ProductDTO> list = productService.productSearch(keyword);
		
		return list;
	}

	// 

	// 제품 상세 정보 호출
	@PostMapping("/getDetail")
	@ResponseBody
	public ProductDTO getDetail(String product_code) throws Exception {
		logger.info(product_code);
		ProductDTO productDTO = new ProductDTO();

		productDTO = productService.getProNFactoryDetail(product_code);
		logger.info(productDTO.toString());

		return productDTO;
	}
	

}//--class end

	


