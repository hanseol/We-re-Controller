package mes.pro.order.web;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.cmmn.exception.FdlException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
import mes.pro.order.service.ProOrderService;
import mes.pro.order.service.ProOrderVO;

/**
 * @Class Name : ProOrderController.java
 * @Description : ProOrder Controller class
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
public class ProOrderController {

    @Resource(name = "proOrderService")
    private ProOrderService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    //전표번호 부여
    @Resource(name = "proOrderCodeService")
    protected EgovIdGnrService proOrderCodeService;
    
    @Resource(name = "proOrderCodeDetailService")
    protected EgovIdGnrService proOrderCodeDetailService;
    
    @Resource(name = "mesMatOutStatementIdGnrService")
    protected EgovIdGnrService mesMatOutStatementIdGnrService;
    
    @Resource(name = "productLotCodeService")
    protected EgovIdGnrService productLotCodeService;
    
    @Resource(name = "ProMaterialNoService")
    protected EgovIdGnrService ProMaterialNoService;
    
    
    
    ComFunc comFunc = new ComFunc();

      
    //proView.jsp
      
    //생산지시조회 페이지 호출(prodView.jsp)
    @RequestMapping("pro/order/prodView.do")
    public String prodView(Model model){
        return "mes/pro/order/prodView.page";
    }
    //생산지시리스트 조회
    @RequestMapping("pro/order/prodView")
    @ResponseBody
    public Map<String, Object> readOrder(@ModelAttribute("searchVO") ProOrderVO searchVO ) throws Exception {
    	List<?> list = service.selectProOrderList(searchVO);
    	return comFunc.sendResult(list);
    }
    
    
    
    //proForm.jsp
    
    //생산지시관리 페이지 호출(prodForm.jsp)
    @RequestMapping("pro/order/prodForm.do")
    public String prodForm(Model model){
        return "mes/pro/order/prodForm.page";
    }
    //생산지시관리 페이지에서 리스트 조회
    @RequestMapping("ajax/proOrder/prodFormList")
    @ResponseBody
    public Map<String, Object> readOrderForm(@ModelAttribute("searchVO") ProOrderVO searchVO) throws Exception {
    	List<?> list = service.selectOrderForm(searchVO);
    	return comFunc.sendResult(list);
    }
    
    //모달 호출1(생산지시코드로 검색)
    @GetMapping("pro/order/proOrderSearch.do")
    public String proOrderSearch() {
    	return "mes/pro/modal/proOrderSearch";
    }
    //모달 값 뿌리기1(생산지시코드로 검색)
    @RequestMapping("proOrderSearch")
    @ResponseBody
    public Map<String, Object> proOrderSearch(@ModelAttribute("searchVO") ProOrderVO searchVO) throws Exception {
    	List<?> list = service.selectOrderList(searchVO);
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }

    //모달 호출2(생산계획에서 작성된 제품리스트)
    @GetMapping("pro/order/planProductSearch.do")
    public String planProductSearch() {
    	return "mes/pro/modal/planProductSearch";
    }
    //모달 값 뿌리기2(생산계획에서 작성된 제품리스트)
    @RequestMapping("planProductSearch")
    @ResponseBody
    public Map<String, Object> planProductSearch(@ModelAttribute("searchVO") ProOrderVO searchVO){
    	List<?> list = service.selectPlanProductList(searchVO);
    	comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    // 2번 그리드에 값 뿌리기
    @RequestMapping("matBomList")
    @ResponseBody
    public Map<String, Object> matBomList(@ModelAttribute("searchVO") ProOrderVO searchVO) {
    	List<?> list = service.selectmatBomList(searchVO);
    	comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    // 3번 그리드에 값 뿌리기
    @RequestMapping("matLotList")
    @ResponseBody
    public Map<String, Object> matLotList(@ModelAttribute("searchVO") ProOrderVO searchVO) {
    	List<?> list = service.selectmatLotList(searchVO);
    	comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    
    
    // 생산지시리스트 추가, 수정, 삭제 (****수정하기)
    // 1번 그리드의 modify
	@PutMapping("ajax/proOrder/modifyProdOrder")
	@ResponseBody
	public Map<String, Object> modifyProdOrder(@RequestBody GridDataVO gd) throws Exception {

		Map<String, Object> map = new HashMap<>();
		
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
		

		//수정
		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateProOrder((LinkedHashMap) updatedList.get(i));
			}
		}
		
		//삭제
//		if (deletedList.size() != 0) {
//			for (int i = 0; i < deletedList.size(); i++) {
//				service.deleteProOrder((LinkedHashMap) deletedList.get(i));
//			}
//		}		

		//생성
		//시퀀스 포멧팅 
		if(createdList.size() != 0) { 
			String poId = null;
			
			poId = proOrderCodeService.getNextStringId();
			
			for(int i = 0; i < createdList.size(); i++) {
				((LinkedHashMap)createdList.get(i)).put("proOrderDate", gd.getProOrderDate());
				((LinkedHashMap)createdList.get(i)).put("proOrderCode", poId);
				((LinkedHashMap)createdList.get(i)).put("proOrderDetailCode", proOrderCodeDetailService.getNextStringId());
				((LinkedHashMap)createdList.get(i)).put("proProcessLotNo", productLotCodeService.getNextStringId());
				
				service.insertProOrder((LinkedHashMap)createdList.get(i));
			}
		 }
		map.put("result", true);
		
		return map;
	}
	
	
	// 생산지시리스트 추가, 수정, 삭제 (****수정하기)
    // 3번 그리드의 modify
	@PutMapping("ajax/proOrder/modifyMat")
	@ResponseBody
	public Map<String, Object> modifyMat(@RequestBody GridDataVO gd) throws Exception {

		Map<String, Object> map = new HashMap<>();
		
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		//생성
		//시퀀스 포멧팅  **수정하기
		if(createdList.size() != 0) { 
			
			for(int i = 0; i < createdList.size(); i++) {
				((LinkedHashMap)createdList.get(i)).put("matInoutStatement", mesMatOutStatementIdGnrService.getNextStringId());
				((LinkedHashMap)createdList.get(i)).put("matLotNo", productLotCodeService.getNextStringId());
				/*
				 * ((LinkedHashMap)createdList.get(i)).put("proMaterialNumber",
				 * ProMaterialNoService.getNextStringId());
				 */
				/* service.insertMat((LinkedHashMap)createdList.get(i)); */
			}
		 }
		
		map.put("result", true);
		return map;
	}
	
	@RequestMapping("/ajax/proOrder/insertMat")
	@ResponseBody
	public Map<String, Object> insertMat(@ModelAttribute("searchVO") ProOrderVO searchVO) throws FdlException {
		
		
		searchVO.setMatInoutStatement(mesMatOutStatementIdGnrService.getNextStringId());
		searchVO.setProProcessLotNo(productLotCodeService.getNextStringId());
		searchVO.setProMaterialNumber(ProMaterialNoService.getNextStringId());
		
		service.insertMat(searchVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("test", "test");
		return map;
	}
	
	
	
	
}
