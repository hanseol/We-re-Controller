package mes.pro.plan.web;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import mes.board.service.BoardVO;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
import mes.main.service.SearchVO;
import mes.pro.plan.service.ProPlanService;
import mes.pro.plan.service.ProPlanVO;

/**
 * @Class Name : ProPlanController.java
 * @Description : ProPlan Controller class
 * @Modification Information
 *
 * @author dahee
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class ProPlanController {
	
    @Resource(name = "proPlanService")
    private ProPlanService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    ComFunc comFunc = new ComFunc();
   
    //생산계획관리 페이지로 이동(prodPlanForm.jsp)
    @RequestMapping("proPlan/prodPlanForm.do")
    public String prodPlanForm( @ModelAttribute("searchVO") ProPlanVO searchVO, Model model){
        return "mes/pro/plan/prodPlanForm.page";
    }
    
    //생산계획조회 페이지로 이동 (prodPlanView.jsp)
    @RequestMapping("proPlan/ProdPlanView.do")
    public String prodPlanView( @ModelAttribute("searchVO") ProPlanVO searchVO, Model model){
        return "mes/pro/plan/prodPlanView.page";
    }
    
    //생산계획조회
    @RequestMapping("proPlan/ProdPlanView")
    @ResponseBody
    public Map<String, Object> readBoard(Model model, @ModelAttribute("searchVO") ProPlanVO searchVO) throws Exception{

    	List<?> list = new ArrayList<>();
    	
    	//검색조건이 있을 경우
    	if(!searchVO.getSearchKeyword().equals("")) {
    		//mapper 조건에 따라 condition 설정 필요함.
        	searchVO.setSearchCondition("0");
        	list = service.selectProPlanList(searchVO);
        //검색조건이 없을 경우
    	}else {
        	list = service.selectProPlanList(searchVO);
    	}
    	return comFunc.sendResult(list);
    }

    
    //생산계획리스트 추가, 수정, 삭제 (****수정하기)
	@PutMapping("proOrder/modifyProdPlan")
	@ResponseBody
	public void modifyProdPlan(@RequestBody GridDataVO gd) throws Exception {

		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateProPlan((LinkedHashMap) updatedList.get(i));
			}
		}

		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				service.insertProPlan((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteProPlan((LinkedHashMap) deletedList.get(i));
			}
		}
	}
}
