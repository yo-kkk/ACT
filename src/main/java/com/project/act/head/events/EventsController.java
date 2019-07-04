package com.project.act.head.events;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.act.models_dto.EventDTO;
import com.project.act.models_dto.PageDTO;
import com.project.act.models_dto.ProductDTO;
import com.project.act.models_dto.StoresDTO;

@Controller
@RequestMapping("head/events/{pg}")
public class EventsController {
	private static final Logger logger = LoggerFactory.getLogger(EventsController.class);

	@Autowired
	private EventsService eventsService;

	@RequestMapping("/")
	public String eventList(@PathVariable int pg,@ModelAttribute EventDTO EventDTO, Model model, HttpSession session) throws Exception {

		logger.info("EVENT LIST(MAIN PAGE) ========= pg : " +pg);
		
		long totalcount = eventsService.list_count();
		PageDTO pageDTO = new PageDTO(pg, 20, 5, totalcount);	

		List<EventDTO> list = eventsService.getEventList(pageDTO);
		
		model.addAttribute("pageDTO",pageDTO);
		model.addAttribute("list", list);

		return "events/eventList.head";
	}

	@GetMapping("/addEvent")
	public String productInsert(@PathVariable int pg,Model model) throws Exception {
		logger.info("이벤트 등록 화면 호출");
				
		List<String> storeList = eventsService.getStoreList();

		model.addAttribute("storeList", storeList);

		return "events/addEvent.head";
	}

	@PostMapping("addEvent")
	@ResponseBody 
	public void addEvent(@ModelAttribute EventDTO eventDTO, String[] target_stores, String[] product_info,
			HttpSession session) throws Exception {
		logger.info("addEvent // Event 등록 ajax =====================");
		logger.info("eventDTO : " + eventDTO.toString());
		logger.info("target_stores :===== ");
		for(int i=0;i<target_stores.length;i++) {
			logger.info(target_stores[i]);
		}
		logger.info("product_info :===== ");
		for(int i=1;i<product_info.length;i++) {
			logger.info(product_info[i]);
		}
		
		eventsService.addEvent(eventDTO, target_stores, product_info);

	}

	@PostMapping("/product_list")
	@ResponseBody
	public List<ProductDTO> product_list(String keyword, int pg) throws Exception {
		if (keyword == null)
			keyword = "";
		logger.info("product_list modal 띄우기 ============ keyword = " + keyword + " && // pg = " + pg);

		Map<String, Object> map = new HashMap();
		map.put("keyword", keyword);

		long totalcount = eventsService.get_total_count(map);

		PageDTO pageDTO = new PageDTO(pg, 10, 3, totalcount);
		map.put("pageDTO", pageDTO);

		List<ProductDTO> list = eventsService.getProductList(map);

		ProductDTO productDTO = list.get(0);
		productDTO.setPageDTO(pageDTO);

		list.set(0, productDTO);

		return list;
	}

	@PostMapping("delete")
	@ResponseBody
	public Map addEvent(@RequestParam(required = false) String event_name) throws Exception {

		Map<String, String> result = new HashMap();
		try {
			eventsService.deleteEvent(event_name);
			result.put("msg", "success");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "error");
		}
		return result;
	}

	@PostMapping("detail")
	@ResponseBody
	public Map detailEvent(@RequestParam(required = false) String event_name, Model model) throws Exception {
		logger.info("event_name★:" + event_name.toString());

		Map<String, Object> resultMap = new HashMap();

		List<StoresDTO> storeList;
		List<EventDTO> productList;

		try {
			storeList = eventsService.getTargetStoreMap(event_name);
			productList = eventsService.getTargetProductMap(event_name);
			logger.info("productList★:" + productList.toString());
			resultMap.put("storeList", storeList);
			resultMap.put("productList", productList);
//			/*
//			 * logger.info("resultMap★:" + resultMap.get(key).toString());
//			 * logger.info("resultMap★:" + resultMap.toString());
//			 */
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultMap;

	}
	
	@PostMapping("select_store")
	@ResponseBody
	public List<String> select_store(String location_code) throws Exception {
		
		logger.info("ajax == select_box 에 store_list 불러오기 =========== location_code : " + location_code );
		List<String> list = eventsService.select_store(location_code);
		
		return list;

	}
}
