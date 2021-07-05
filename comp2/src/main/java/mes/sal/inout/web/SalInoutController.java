package mes.sal.inout.web;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	ComFunc comFunc = new ComFunc();

	/**
	 * SAL_INOUT 목록을 조회한다. (pageing)
	 * 
	 * @param searchVO - 조회할 정보가 담긴 SalInoutDefaultVO
	 * @return "/salInout/SalInoutList"
	 * @exception Exception
	 */

	// 주문목록조회 salesOrder grid
	@RequestMapping("ajax/sal/readSalesOrder")
	@ResponseBody
	public Map<String, Object> readSalesOrder(@ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {
		
		List<?> list = salInoutService.selectSalInoutList(searchVO);	

		return comFunc.sendResult(list);
	}

	// 주문목록조회 페이지
	@RequestMapping("/salInout/salesOrderView.do")
	public String selectSalesOrderList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/salInout/salesOrderView.page";
	}
	
	// 모달 : 제품코드 조회
	@GetMapping("/salInout/searchProductCode.do")
	public String searchProductCode() {
		
		//모달창 띄워주는 페이지
		return "mes/salInout/searchProductCode";
	}
	
	// 모달 : 제품코드 조회값 전달
	@RequestMapping("mes/salInout/searchProductCode")
	@ResponseBody
	public Map<String, Object> searchProduct(Model model, 
   		@ModelAttribute("searchVO") SalInoutVO searchVO) throws Exception {
		
    	List<?> list = salInoutService.searchProductList(searchVO);
    	
    	return comFunc.sendResult(list);
	}

	// 모달 : 고객코드 조회
	@GetMapping("/salInout/searchCustomerCode.do")
	public String searchCustomerCode() {

		// 모달창 띄워주는 페이지
		return "mes/salInout/searchCustomerCode";
	}

	// 모달 : 고객코드 조회값 전달
	@RequestMapping("mes/salInout/searchCustomerCode")
	@ResponseBody
	public Map<String, Object> searchCustomer(Model model, @ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {

		List<?> list = salInoutService.searchCustomerList(searchVO);

		return comFunc.sendResult(list);
	}
			
	// 입출고목록조회 salesProduct grid
	@RequestMapping("/ajax/sal/readSalesProduct")
	@ResponseBody
	public Map<String, Object> readSalesProduct(@ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {
			
		List<?> list = salInoutService.selectSalProductInoutList(searchVO);

		return comFunc.sendResult(list);
	}


	// 입출고조회 페이지
	@RequestMapping("/salInout/salesProdView.do")
	public String selectSalesProductList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/salInout/salesProdView.page";
	}

	// 입출고관리 페이지
	@RequestMapping("/salInout/salesProdForm.do")
	public String selectSalesProductFormList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/salInout/salesProdForm.page";
	}
	
	// 모달 : 완제품 LOT_NO 조회
	@GetMapping("/salInout/searchProductLotNo.do")
	public String searchProductLotNoView() {

		// 모달창 띄워주는 페이지
		return "mes/salInout/searchProductLotNo";
	}

	// 모달 : 완제품 LOT_NO 조회값 전달
	@RequestMapping("mes/salInout/searchProductLotNo")
	@ResponseBody
	public Map<String, Object> searchProductLotNo(Model model, @ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {

		List<?> list = salInoutService.searchProductLotNoList(searchVO);

		return comFunc.sendResult(list);
	}

	// 반품 조회 (수정해야 함)
	@RequestMapping("/salMatch/salesMatchView.do")
	public String selectSalesMatchList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/salMatch/salesMatchView.page";
	}

	// 관리
	// 입출고목록 수정
	@PutMapping("/ajax/modifySalInoutList")
	@ResponseBody
	public void modifySalInoutList(@RequestBody GridDataVO gd) throws Exception {
		
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
						
		//C
		
				
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
		
	}

	// 모달 : 생산지시디테일코드 조회
		@GetMapping("/salInout/searchOrderCode.do")
		public String searchOrderCode() {

			// 모달창 띄워주는 페이지
			return "mes/salInout/searchOrderCode";
		}

		// 모달 : 생산지시디테일코드 조회값 전달
		@RequestMapping("mes/salInout/searchOrderCode")
		@ResponseBody
		public Map<String, Object> searchOrderCodeList(@ModelAttribute("searchVO") SalInoutVO searchVO)
				throws Exception {

			List<?> list = salInoutService.searchProductCodeList(searchVO);

			return comFunc.sendResult(list);
		}
}
