package mes.qua.chk.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.qua.chk.service.QuaMaterialChkService;
import mes.qua.chk.service.QuaMaterialChkVO;

/**
 * @Class Name : QuaMaterialChkController.java
 * @Description : QuaMaterialChk Controller class
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
@SessionAttributes(types=QuaMaterialChkVO.class)
public class QuaMaterialChkController {

    @Resource(name = "quaMaterialChkService")
    private QuaMaterialChkService quaMaterialChkService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /**
	 * QUA_MATERIAL_CHK 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 QuaMaterialChkDefaultVO
	 * @return "/quaMaterialChk/QuaMaterialChkList"
	 * @exception Exception
	 */
    //뷰페이지만 돌려준다.
    @RequestMapping(value="/quaMaterialChk/QuaMaterialChkList.do")
    public String selectQuaMaterialChkList(@ModelAttribute("searchVO") QuaMaterialChkVO searchVO, 
    		ModelMap model) {
        
        return "/quaMaterialChk/QuaMaterialChkList";
    } 

}
