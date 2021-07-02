package mes.sal.inout.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.pro.plan.service.ProPlanVO;
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
	public Map<String, Object> readSalesOrder(Model model, @ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {
		
		List<?> list = salInoutService.selectSalInoutList(searchVO);	

		ComFunc comFunc = new ComFunc();
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
    	
    	ComFunc comFunc = new ComFunc();
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

		ComFunc comFunc = new ComFunc();
		return comFunc.sendResult(list);
	}
			
	// 입출고목록조회 salesProduct grid
	@RequestMapping("/ajax/sal/readSalesProduct")
	@ResponseBody
	public Map<String, Object> readSalesProduct(Model model, @ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {

		List<?> list = new ArrayList<>();

		ComFunc comFunc = new ComFunc();
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

		ComFunc comFunc = new ComFunc();
		return comFunc.sendResult(list);
	}

	// 반품 조회 (수정해야 함)
	@RequestMapping("/salMatch/salesMatchView.do")
	public String selectSalesMatchList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/salMatch/salesMatchView.page";
	}

	// 관리 (CRUD)
	// 입출고목록 추가
	@RequestMapping("/salInout/addSalInoutView.do")
	public String addSalInoutView(@ModelAttribute("searchVO") SalInoutVO searchVO, Model model) throws Exception {
		model.addAttribute("salInoutVO", new SalInoutVO());
		return "mes/salInout/salesProdView.page";
	}

	// 입출고목록 추가-보여주기?
	@RequestMapping("/salInout/addSalInout.do")
	public String addSalInout(SalInoutVO salInoutVO, @ModelAttribute("searchVO") SalInoutVO searchVO,
			SessionStatus status) throws Exception {
		salInoutService.insertSalInout(salInoutVO);
		status.setComplete();
		return "forward:/salInout/salesProdView.do";
	}

	// 입출고목록 수정
	@RequestMapping("/salInout/updateSalInoutView.do")
	public String updateSalInoutView(@RequestParam("salInoutStatement") java.lang.String salInoutStatement,
			@ModelAttribute("searchVO") SalInoutVO searchVO, Model model) throws Exception {
		SalInoutVO salInoutVO = new SalInoutVO();
		salInoutVO.setSalInoutStatement(salInoutStatement);
		// 변수명은 CoC 에 따라 salInoutVO
		model.addAttribute(selectSalInout(salInoutVO, searchVO));
		return "/salInout/SalInoutRegister";
	}

	// 입출고목록 서비스로 보내
	@RequestMapping("/salInout/selectSalInout.do")
	public @ModelAttribute("salInoutVO") SalInoutVO selectSalInout(SalInoutVO salInoutVO,
			@ModelAttribute("searchVO") SalInoutVO searchVO) throws Exception {
		return salInoutService.selectSalInout(salInoutVO);
	}

	// 입출고목록 수정해서 뿌려줘
	@RequestMapping("/salInout/updateSalInout.do")
	public String updateSalInout(SalInoutVO salInoutVO, @ModelAttribute("searchVO") SalInoutVO searchVO,
			SessionStatus status) throws Exception {
		salInoutService.updateSalInout(salInoutVO);
		status.setComplete();
		return "forward:/salInout/SalInoutList.do";
	}

	// 입출고목록 삭제
	@RequestMapping("/salInout/deleteSalInout.do")
	public String deleteSalInout(SalInoutVO salInoutVO, @ModelAttribute("searchVO") SalInoutVO searchVO,
			SessionStatus status) throws Exception {
		salInoutService.deleteSalInout(salInoutVO);
		status.setComplete();
		return "forward:/salInout/SalInoutList.do";
	}
}
