package mes.qua.flty.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.qua.flty.service.QuaFltyService;
import mes.qua.flty.service.QuaFltyVO;

/**
 * @Class Name : matQuaController.java
 * @Description : matQua Controller class
 * @Modification Information
 * 
 * @author sungwon  
 * @since 20210625
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class QuaFltyController {
	//공통함수 객체
	ComFunc comFunc = new ComFunc();

	

    @Resource(name = "quaFltyService")
    private QuaFltyService service;
    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

//--------------------------------------조회 페이지-------------------------------------
    
    //페이지 넘겨주기
    @RequestMapping("/qua/flty/matrFaultyView.do")
    public String selectmatQuaList(@ModelAttribute("searchVO") QuaFltyVO searchVO, 
    		ModelMap model) {

        return "mes/qua/quaFlty/matrFaultyView.page";
    }
    //자재입고검사 중 불량이 있는 리스트 조회
    @RequestMapping("/ajax/readQuaFlty")
    @ResponseBody
    public Map<String, Object> matFlty(Model model, 
    		 @ModelAttribute("searchVO") QuaFltyVO searchVO) throws Exception{

    	List<?> list = service.selectQuaFltyList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    //불량 리스트 조회
    @RequestMapping("/ajax/readMatFltyDetail")
    @ResponseBody
    public Map<String, Object> matFltyDetail(Model model, 
    		 @ModelAttribute("searchVO") QuaFltyVO searchVO) throws Exception{

    	List<?> list = service.selectQuaFltyDetailList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
}
