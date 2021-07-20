package mes.sal.inout.web;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
import mes.sal.inout.service.SalInoutService;
import mes.sal.inout.service.SalInoutVO;

/**
 * @Class Name : SalInoutController.java
 * @Description : SalInout Controller class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-28
 * @version 1.0
 * @see
 * 
 *      Copyright (C) All right reserved.
 */

@Controller
public class SalInoutController {

	@Resource(name = "salInoutService")
	private SalInoutService salInoutService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	//입고 전표번호
	@Resource(name = "mesSalInStatementIdGnrService")
	protected EgovIdGnrService salInStatementIdGnrService;
	
	//출고 전표번호
	@Resource(name = "mesSalOutStatementIdGnrService")
	protected EgovIdGnrService salOutStatementIdGnrService;
	
	//반품 전표번호
	@Resource(name = "mesSalReturnStatementIdGnrService")
	protected EgovIdGnrService salReturnStatementIdGnrService;
	
	ComFunc comFunc = new ComFunc();

	
//-----------------------조회------------------------------	
	// 주문목록조회 salesOrder grid
	@RequestMapping("ajax/sal/readSalesOrder")
	@ResponseBody
	public Map<String, Object> readSalesOrder(@ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {
		
		List<?> list = salInoutService.selectSalInoutList(searchVO);	

		return comFunc.sendResult(list);
	}

	// 주문목록조회 페이지
	@RequestMapping("/sal/salInout/salesOrderView.do")
	public String selectSalesOrderList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/sal/salInout/salesOrderView.page";
	}
	
	// 입출고목록조회 salesProduct grid
		@RequestMapping("/ajax/sal/readSalesProduct")
		@ResponseBody
		public Map<String, Object> readSalesProduct(@ModelAttribute("searchVO") SalInoutVO searchVO)
				throws Exception {
					
			List<?> list = salInoutService.selectSalProductInOutList(searchVO);

			return comFunc.sendResult(list);
		}
		
	// 입고목록조회 salesProduct grid
	@RequestMapping("/ajax/sal/readSalInList")
	@ResponseBody
	public Map<String, Object> readSalInList(@ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {
				
		List<?> list = salInoutService.selectSalProductInList(searchVO);
	
		return comFunc.sendResult(list);
	}
	
	// 출고목록조회 salesProduct grid
	@RequestMapping("/ajax/sal/readSalOutList")
	@ResponseBody
	public Map<String, Object> readSalOutList(@ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {
		
		List<?> list = salInoutService.selectSalProductOutList(searchVO);
		
		return comFunc.sendResult(list);
	}
	
	// 입출고조회 페이지
	@RequestMapping("/sal/salInout/salesProdView.do")
	public String selectSalesProductList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/sal/salInout/salesProdView.page";
	}

	// 입출고관리 페이지
	@RequestMapping("/sal/salInout/salesProdForm.do")
	public String selectSalesProductFormList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/sal/salInout/salesProdForm.page";
	}
	
	
	// 입고 후 출고할 LOT_NO 목록 조회 grid
	@RequestMapping("/ajax/insertSalOutList")
	@ResponseBody
	public Map<String, Object> insertSalOutList(@ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {
				
		List<?> list = salInoutService.selectSaloutList(searchVO);

		return comFunc.sendResult(list);
	}

	
	
	// 반품 목록 조회 grid
	@RequestMapping("/ajax/sal/readReturnProduct")
	@ResponseBody
	public Map<String, Object> readReturnProduct(@ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {
					
		List<?> list = salInoutService.selectSalReturnList(searchVO);

		return comFunc.sendResult(list);
	}
			
	// 반품 목록 조회 페이지
	@RequestMapping("/sal/salInout/retuProdView.do")
	public String selectSalesReturnList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/sal/salInout/retuProdView.page";
	}
		
	// 반품 목록 관리 페이지
	@RequestMapping("/sal/salInout/retuProdForm.do")
	public String selectSalesReturnFormList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/sal/salInout/retuProdForm.page";
	}
	
	
// ------------------------------관리--------------------------------
	
	// 입고목록 CRUD
	@PutMapping("/ajax/modifySalInList")
	@ResponseBody
	public Map<String, Object> modifySalInList(@RequestBody GridDataVO gd) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
						
		//C
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				String gubun = (String) ((LinkedHashMap)createdList.get(i)).get("salInoutGubun");
				
				if(gubun.equals("INOUT002")) {
					((LinkedHashMap)createdList.get(i)).put("salInoutStatement", salInStatementIdGnrService.getNextStringId());	
					} else if(gubun.equals("INOUT003")) {
					((LinkedHashMap)createdList.get(i)).put("salInoutStatement", salOutStatementIdGnrService.getNextStringId());		
					}			
				salInoutService.insertSalInout((LinkedHashMap)(createdList.get(i)));
			}
		}
				
		//U
		if (updatedList.size() != 0) {
			for (int i=0; i<updatedList.size(); i++) {
				salInoutService.updateSalInout((LinkedHashMap) updatedList.get(i));
			}
		}
		
		//D
		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				salInoutService.deleteSalInout((LinkedHashMap) deletedList.get(i));
			}
		}
		
		map.put("result", true);
		return map;
		
	}
	
	// 출고목록 CRUD
		@PutMapping("/ajax/modifySalInoutList")
		@ResponseBody
		public Map<String, Object> modifySalInoutList(@RequestBody GridDataVO gd) throws Exception {
			
			Map<String, Object> map = new HashMap<>();
			
			List<?> updatedList = gd.getUpdatedRows();
			List<?> createdList = gd.getCreatedRows();
			List<?> deletedList = gd.getDeletedRows();
							
			//C
			if (createdList.size() != 0) {
				for (int i = 0; i < createdList.size(); i++) {
					String gubun = (String) ((LinkedHashMap)createdList.get(i)).get("salInoutGubun");
					
					if(gubun.equals("INOUT002")) {
						((LinkedHashMap)createdList.get(i)).put("salInoutStatement", salInStatementIdGnrService.getNextStringId());	
						} else if(gubun.equals("INOUT003")) {
						((LinkedHashMap)createdList.get(i)).put("salInoutStatement", salOutStatementIdGnrService.getNextStringId());		
						}			
					salInoutService.insertSalInout((LinkedHashMap)(createdList.get(i)));
				}
			}
					
			//U
			if (updatedList.size() != 0) {
				for (int i=0; i<updatedList.size(); i++) {
					salInoutService.updateSalInout((LinkedHashMap) updatedList.get(i));
				}
			}
			
			//D
			if (deletedList.size() != 0)
			{
				for (int i = 0; i < deletedList.size(); i++) {
					salInoutService.deleteSalInout((LinkedHashMap) deletedList.get(i));
				}
			}
			
			map.put("result", true);
			return map;
			
		}
	
	@PutMapping("/ajax/modifySalOutList")
	@ResponseBody
	public Map<String, Object> modifySalOutList(@RequestBody GridDataVO gd) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
						
		//C
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				String gubun = (String) ((LinkedHashMap)createdList.get(i)).get("salInoutGubun");
				
				if(gubun.equals("INOUT002")) {
					((LinkedHashMap)createdList.get(i)).put("salInoutStatement", salInStatementIdGnrService.getNextStringId());	
					} else if(gubun.equals("INOUT003")) {
					((LinkedHashMap)createdList.get(i)).put("salInoutStatement", salOutStatementIdGnrService.getNextStringId());		
					}			
				salInoutService.insertSalInout((LinkedHashMap)(createdList.get(i)));
			}
		}
		
		map.put("result", true);
		return map;
		
	}


	
	// 반품목록 수정
	@PutMapping("/ajax/modifySalReturnList")
	@ResponseBody
	public Map<String, Object> modifySalReturnList(@RequestBody GridDataVO gd) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
						
		//C
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {			
				((LinkedHashMap)createdList.get(i)).put("salInoutStatement", salReturnStatementIdGnrService.getNextStringId());						
				salInoutService.insertSalReturn((LinkedHashMap)(createdList.get(i)));
			}
		}
				
		//U
		if (updatedList.size() != 0) {
			for (int i=0; i<updatedList.size(); i++) {
				salInoutService.updateSalReturn((LinkedHashMap) updatedList.get(i));
			}
		}
		
		//D
		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				salInoutService.deleteSalReturn((LinkedHashMap) deletedList.get(i));
			}
		}
		
		map.put("result", true);
		return map;
	}
	

//------------------------------------모달---------------------------------------
		
		// 모달 : 제품코드 조회
		@GetMapping("sal/salInout/searchProductCode.do")
		public String searchProductCode() {
			
			//모달창 띄워주는 페이지
			return "mes/sal/modal/searchProductCode";
		}
		
		// 모달 : 제품코드 조회값 전달
		@RequestMapping("/ajax/searchProductCode")
		@ResponseBody
		public Map<String, Object> searchProduct(@ModelAttribute("searchVO") SalInoutVO searchVO) throws Exception {
			
	    	List<?> list = salInoutService.searchProductList(searchVO);
	    	
	    	return comFunc.sendResult(list);
		}

		
		// 모달 : 고객코드 조회
		@GetMapping("sal/salInout/searchCustomerCode.do")
		public String searchCustomerCode() {

			// 모달창 띄워주는 페이지
			return "mes/sal/modal/searchCustomerCode";
		}

		// 모달 : 고객코드 조회값 전달
		@RequestMapping("/ajax/searchCustomerCode")
		@ResponseBody
		public Map<String, Object> searchCustomer(@ModelAttribute("searchVO") SalInoutVO searchVO)
				throws Exception {

			List<?> list = salInoutService.searchCustomerList(searchVO);

			return comFunc.sendResult(list);
		}
				
		
		
		// 모달 : 완제품 LOT_NO 조회
		@GetMapping("sal/salInout/searchProductLotNo.do")
		public String searchProductLotNoView() {

			// 모달창 띄워주는 페이지
			return "mes/sal/modal/searchProductLotNo";
		}

		// 모달 : 완제품 LOT_NO 조회값 전달
		@RequestMapping("/ajax/searchProductLotNo")
		@ResponseBody
		public Map<String, Object> searchProductLotNo(@ModelAttribute("searchVO") SalInoutVO searchVO)
				throws Exception {

			List<?> list = salInoutService.searchProductLotNoList(searchVO);

			return comFunc.sendResult(list);
		}
		
		
		// 모달 : 출고시 완제품 LOT_NO 조회
		@GetMapping("sal/salInout/modSearchProductLotNo.do")
		public String searchModProductLotNoView() {
	
			// 모달창 띄워주는 페이지
			return "mes/sal/modal/modSearchProductLotNo";
		}
	
		// 모달 : 출고시 완제품 LOT_NO 조회값 전달
		@RequestMapping("/ajax/modSearchProductLotNo")
		@ResponseBody
		public Map<String, Object> searchModProductLotNo(@ModelAttribute("searchVO") SalInoutVO searchVO)
				throws Exception {
	
			List<?> list = salInoutService.searchModProductLotNoList(searchVO);
	
			return comFunc.sendResult(list);
		}
		
		//모달 : 제품주문서 목록 조회
		@GetMapping("sal/salInout/searchOrderList.do")
		public String searchOrderListView() {
			
			return "mes/sal/modal/searchOrderList";
		}
		
		//모달 : 제품주문서 목록 조회값 전달
		@RequestMapping("/ajax/searchOrderList")
		@ResponseBody
		public Map<String, Object> searchOrderList(@ModelAttribute("searchVO") SalInoutVO searchVO)
				throws Exception {
			
			List<?> list = salInoutService.searchOrderList(searchVO);
			
			return comFunc.sendResult(list);			
		}

		
		
		// 모달 : 생산지시디테일코드 조회
		@GetMapping("sal/salInout/searchOrderCode.do")
		public String searchOrderCode() {

			// 모달창 띄워주는 페이지
			return "mes/sal/modal/searchOrderCode";
		}

		// 모달 : 생산지시디테일코드 조회값 전달
		@RequestMapping("/ajax/searchOrderCode")
		@ResponseBody
		public Map<String, Object> searchOrderCodeList(@ModelAttribute("searchVO") SalInoutVO searchVO)
				throws Exception {

			List<?> list = salInoutService.searchProductCodeList(searchVO);

			return comFunc.sendResult(list);
		}
		
		
		
		//모달 : 전표번호 조회(반품페이지) ...(x)
		@GetMapping("sal/salInout/searchInoutStatement.do")
		public String searchInoutStatementView() {

			// 모달창 띄워주는 페이지
			return "mes/sal/modal/searchInoutStatement";
		}

		// 모달 : 전표번호 값 전달
		@RequestMapping("/ajax/searchInoutStatement")
		@ResponseBody
		public Map<String, Object> searchInoutStatement(@ModelAttribute("searchVO") SalInoutVO searchVO)
				throws Exception {

			List<?> list = salInoutService.searchInoutStatement(searchVO);

			return comFunc.sendResult(list);
		}
				
}
