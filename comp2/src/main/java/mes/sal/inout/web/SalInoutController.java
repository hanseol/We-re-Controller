package mes.sal.inout.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mes.sal.inout.service.SalInoutDefaultVO;
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
@SessionAttributes(types = SalInoutVO.class)
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
	
	//주문목록 조회
	@RequestMapping(value = "/salInout/salesOrderView.do")
	public String selectSalesOrderList(@ModelAttribute("searchVO") SalInoutDefaultVO searchVO, ModelMap model)
			throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> salInoutList = salInoutService.selectSalInoutList(searchVO);
		model.addAttribute("resultList", salInoutList);

		int totCnt = salInoutService.selectSalInoutListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "mes/salInout/salesOrderView.page";
	}
	
	//입출고목록 조회
	@RequestMapping("/salInout/salesProdView.do")
	public String selectSalesProductList(@ModelAttribute("searchVO") SalInoutDefaultVO searchVO, ModelMap model) throws Exception {
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> salInoutList = salInoutService.selectSalInoutList(searchVO);
		model.addAttribute("productList", salInoutList);

		int totCnt = salInoutService.selectSalInoutListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "mes/salInout/salesProdView.page";
	}
	
	//반품 조회
	
	
	//관리 (CRUD)
	//입출고목록 조회
		@RequestMapping("/salInout/salesProdForm.do")
		public String selectSalesProductList2(@ModelAttribute("searchVO") SalInoutDefaultVO searchVO, ModelMap model) throws Exception {
			/** EgovPropertyService.sample */
			searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
			searchVO.setPageSize(propertiesService.getInt("pageSize"));

			/** pageing */
			PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());

			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			List<?> salInoutList = salInoutService.selectSalInoutList(searchVO);
			model.addAttribute("productList2", salInoutList);

			int totCnt = salInoutService.selectSalInoutListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);

			return "mes/salInout/salesProdForm.page";
		}
	
	//입출고목록 추가 
	@RequestMapping("/salInout/addSalInoutView.do")
	public String addSalInoutView(@ModelAttribute("searchVO") SalInoutDefaultVO searchVO, Model model)
			throws Exception {
		model.addAttribute("salInoutVO", new SalInoutVO());
		return "mes/salInout/salesProdView.page";
	}

	//입출고목록 추가-보여주기?
	@RequestMapping("/salInout/addSalInout.do")
	public String addSalInout(SalInoutVO salInoutVO, @ModelAttribute("searchVO") SalInoutDefaultVO searchVO,
			SessionStatus status) throws Exception {
		salInoutService.insertSalInout(salInoutVO);
		status.setComplete();
		return "forward:/salInout/salesProdView.do";
	}
	
	//입출고목록 수정
	@RequestMapping("/salInout/updateSalInoutView.do")
	public String updateSalInoutView(@RequestParam("salInoutStatement") java.lang.String salInoutStatement,
			@ModelAttribute("searchVO") SalInoutDefaultVO searchVO, Model model) throws Exception {
		SalInoutVO salInoutVO = new SalInoutVO();
		salInoutVO.setSalInoutStatement(salInoutStatement);
		// 변수명은 CoC 에 따라 salInoutVO
		model.addAttribute(selectSalInout(salInoutVO, searchVO));
		return "/salInout/SalInoutRegister";
	}

	//입출고목록 서비스로 보내
	@RequestMapping("/salInout/selectSalInout.do")
	public @ModelAttribute("salInoutVO") SalInoutVO selectSalInout(SalInoutVO salInoutVO,
			@ModelAttribute("searchVO") SalInoutDefaultVO searchVO) throws Exception {
		return salInoutService.selectSalInout(salInoutVO);
	}
	
	//입출고목록 수정해서 뿌려줘
	@RequestMapping("/salInout/updateSalInout.do")
	public String updateSalInout(SalInoutVO salInoutVO, @ModelAttribute("searchVO") SalInoutDefaultVO searchVO,
			SessionStatus status) throws Exception {
		salInoutService.updateSalInout(salInoutVO);
		status.setComplete();
		return "forward:/salInout/SalInoutList.do";
	}

	//입출고목록 삭제
	@RequestMapping("/salInout/deleteSalInout.do")
	public String deleteSalInout(SalInoutVO salInoutVO, @ModelAttribute("searchVO") SalInoutDefaultVO searchVO,
			SessionStatus status) throws Exception {
		salInoutService.deleteSalInout(salInoutVO);
		status.setComplete();
		return "forward:/salInout/SalInoutList.do";
	}
}
