package mes.sal.inout.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
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

	/**
	 * SAL_INOUT 목록을 조회한다. (pageing)
	 * 
	 * @param searchVO - 조회할 정보가 담긴 SalInoutDefaultVO
	 * @return "/salInout/SalInoutList"
	 * @exception Exception
	 */

	// 주문목록조회 salesOrder grid
	@RequestMapping("/sal/inout/readSalesOrder")
	@ResponseBody
	public Map<String, Object> readSalesOrder(Model model, @ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {

		int rowSize = 0;
		List<?> list = new ArrayList<>();

		// 검색조건이 있을 경우
		if (!searchVO.getSearchKeyword().equals("")) {

			// mapper 조건에 따라 condition 설정 필요함.
			searchVO.setSearchCondition("0");

			rowSize = salInoutService.selectSalInoutListTotCnt(searchVO);
			searchVO.setLastIndex(rowSize);

			list = salInoutService.selectSalInoutList(searchVO);
			// 검색조건이 없을 경우
		} else {
			rowSize = salInoutService.selectSalInoutListTotCnt(searchVO);
			searchVO.setLastIndex(rowSize);

			list = salInoutService.selectSalInoutList(searchVO);
		}

		Map<String, Object> paging = new HashMap<>();
		paging.put("page", searchVO.getPageIndex());
		paging.put("totalCount", rowSize);

		Map<String, Object> data = new HashMap<>();
		data.put("contents", list);
		data.put("pagination", paging);

		Map<String, Object> map = new HashMap<>();
		map.put("result", true);
		map.put("data", data);

		return map;
	}

	// 주문목록조회 페이지
	@RequestMapping("/salInout/salesOrderView.do")
	public String selectSalesOrderList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/salInout/salesOrderView.page";
	}

	
	// 입출고목록조회 salesProduct grid
	@RequestMapping("/sal/inout/readSalesProduct")
	@ResponseBody
	public Map<String, Object> readSalesProduct(Model model, @ModelAttribute("searchVO") SalInoutVO searchVO)
			throws Exception {

		int rowSize = 0;
		List<?> list = new ArrayList<>();

		// 검색조건이 있을 경우
		if (!searchVO.getSearchKeyword().equals("")) {

			// mapper 조건에 따라 condition 설정 필요함.
			searchVO.setSearchCondition("0");

			rowSize = salInoutService.selectSalInoutListTotCnt(searchVO);
			searchVO.setLastIndex(rowSize);

			list = salInoutService.selectSalProductInoutList(searchVO);
			// 검색조건이 없을 경우
		} else {
			rowSize = salInoutService.selectSalInoutListTotCnt(searchVO);
			searchVO.setLastIndex(rowSize);

			list = salInoutService.selectSalProductInoutList(searchVO);
		}

		Map<String, Object> paging = new HashMap<>();
		paging.put("page", searchVO.getPageIndex());
		paging.put("totalCount", rowSize);

		Map<String, Object> data = new HashMap<>();
		data.put("contents", list);
		data.put("pagination", paging);

		Map<String, Object> map = new HashMap<>();
		map.put("result", true);
		map.put("data", data);

		return map;
	}

	// 입출고조회 페이지
	@RequestMapping("/salInout/salesProdView.do")
	public String selectSalesProductList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/salInout/salesProdView.page";
	}
	
	//입출고관리 페이지
	@RequestMapping("/salInout/salesProdForm.do")
	public String selectSalesProductFormList(@ModelAttribute("searchVO") SalInoutVO searchVO, ModelMap model)
			throws Exception {

		return "mes/salInout/salesProdForm.page";
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
