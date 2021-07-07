package mes.pro.plan.web;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.jms.Session;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
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

    //전표번호 부여
	@Resource(name = "proPlanCodeService") 
	protected EgovIdGnrService proPlanCodeService;
	
	@Resource(name = "proPlanCodeDetailService") 
	protected EgovIdGnrService proPlanCodeDetailService;
	
    //공통함수
    ComFunc comFunc = new ComFunc();
    
    
    
    
    //proPlanView.jsp
    
    //생산계획조회 페이지로 이동 (prodPlanView.jsp)
    @RequestMapping("proPlan/ProdPlanView.do")
    public String prodPlanView( @ModelAttribute("searchVO") ProPlanVO searchVO, Model model){
        return "mes/pro/plan/prodPlanView.page";
    }
    
    //생산계획조회 페이지에서 리스트 조회
    @RequestMapping("proPlan/ProdPlanView")
    @ResponseBody
    public Map<String, Object> readPlan(@ModelAttribute("searchVO") ProPlanVO searchVO) throws Exception{
    	List<?> list = new ArrayList<>();
        list = service.selectProPlanList(searchVO);
        return comFunc.sendResult(list);
    }
    
    
    //proPlanForm.jsp
    
    //생산계획관리 페이지로 이동(prodPlanForm.jsp)
    @RequestMapping("proPlan/prodPlanForm.do")
    public String prodPlanForm( @ModelAttribute("searchVO") ProPlanVO searchVO, Model model){
        return "mes/pro/plan/prodPlanForm.page";
    }
    
    
    //생산계획관리 페이지에서 리스트 조회
    @RequestMapping("proPlan/ProdPlanFormList")
    @ResponseBody
    public Map<String, Object> readPlanForm(@ModelAttribute("searchVO") ProPlanVO searchVO) throws Exception{
    	List<?> list = new ArrayList<>();
        list = service.selectProPlanFormList(searchVO);
        return comFunc.sendResult(list);
    }
    
    //생산계획관리_모달(생산계획명 검색 페이지 호출)
    @GetMapping("proPlanName.do")
    public String proPlanName() {
    	return "mes/pro/modal/proPlanName";
    }
    
    //생산계획관리_모달(생산계획명 검색 페이지 결과 값 뿌리기)
    @RequestMapping("proPlanName")
    @ResponseBody
    public Map<String, Object> proPlanName(@ModelAttribute("searchVO") ProPlanVO searchVO) throws Exception {
    	List<?> list = service.selectPlanList(searchVO);
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    //생산계획관리_모달(erp제품모달 페이지 호출)
    @GetMapping("erpProductSearch.do")
    public String erpProductSearch() {
    	return "mes/pro/modal/erpProductSearch";
    }
    
    //생산계획관리_모달(erp제품모달 페이지 결과 값 뿌리기)
    @RequestMapping("erpProductSearch")
    @ResponseBody
    public Map<String, Object> erpProductSearch(@ModelAttribute("searchVO") ProPlanVO searchVO) throws Exception {
    	List<?> list = service.selectErpPordList(searchVO);
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    //생산계획관리_모달(제품리스트에서 한개의 제품정보 가져오기)
    @RequestMapping("SelectErpProduct")
    @ResponseBody
    public Map<String, Object> SelectErpProduct(){
    	
		return null;
    }
    
    //생산계획리스트 추가, 수정, 삭제 
	@PutMapping("proPlan/modifyProdPlan")
	@ResponseBody
	public void modifyProdPlan(@RequestBody GridDataVO gd) throws Exception {

		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		//수정
		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateProPlanD((LinkedHashMap) updatedList.get(i));
			}
		}
		//생성
		/*if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				service.insertProPlan((LinkedHashMap) createdList.get(i));
			}
		}*/
		//삭제
		if (deletedList.size() != 0) {
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteProPlan((LinkedHashMap) deletedList.get(i));
			}
		}
		
		//시퀀스 포멧팅(pro_plan테이블)
		if(createdList.size() != 0) { 
			String ppId = proPlanCodeService.getNextStringId();
			((LinkedHashMap)createdList.get(0)).put("proPlanDate", gd.getProPlanDate());
			((LinkedHashMap)createdList.get(0)).put("proPlanName", gd.getProPlanName());
			((LinkedHashMap)createdList.get(0)).put("proPlanCode", ppId);
			service.insertProPlanM((LinkedHashMap)createdList.get(0));
			
			for(int i = 0; i < createdList.size(); i++) {
				((LinkedHashMap)createdList.get(i)).put("proPlanCode", ppId);
				((LinkedHashMap)createdList.get(i)).put("proPlanDetailCode", proPlanCodeDetailService.getNextStringId());
				service.insertProPlan((LinkedHashMap)createdList.get(i)); 
			}
		 }
		 
	}
}
