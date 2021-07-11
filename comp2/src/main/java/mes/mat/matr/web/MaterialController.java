package mes.mat.matr.web;

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
import mes.mat.matr.service.MaterialService;
import mes.mat.matr.service.MaterialVO;

/**
 * @Class Name : ComMaterialController.java
 * @Description : ComMaterial Controller class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class MaterialController {
	
	//공통함수 객체 생성
	ComFunc comFunc = new ComFunc();
	
    @Resource(name = "materialService")
    private MaterialService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * COM_MATERIAL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ComMaterialDefaultVO
	 * @return "/comMaterial/ComMaterialList"
	 * @exception Exception
	 */

    



//--------------------------------------조회 페이지-------------------------------------
    
    //페이지 넘겨주기
    @RequestMapping("/matMatr/matrView.do")
    public String selectMaterialList(@ModelAttribute("searchVO") MaterialVO searchVO, 
    		ModelMap model) {

        return "mes/mat/matMatr/matrView.page";
    }
    //자재입출고조회 리스트
    @RequestMapping("/ajax/readMatMatr")
    @ResponseBody
    public Map<String, Object> Material(Model model, 
    		 @ModelAttribute("searchVO") MaterialVO searchVO) throws Exception{

    	List<?> list = service.selectMaterialList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
  	

}
