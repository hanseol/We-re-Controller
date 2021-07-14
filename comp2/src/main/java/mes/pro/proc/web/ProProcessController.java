package mes.pro.proc.web;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.pro.order.service.ProOrderVO;
import mes.pro.proc.service.ProProcessService;
import mes.pro.proc.service.ProProcessVO;

/**
 * @Class Name : ProProcessController.java
 * @Description : ProProcess Controller class
 * @Modification Information
 *
 * @author dahee
 * @since 20210707
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=ProProcessVO.class)
public class ProProcessController {

    @Resource(name = "proProcessService")
    private ProProcessService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    ComFunc comFunc = new ComFunc();
	
    
    
    //공정별 자재 페이지 호출
    @RequestMapping("proProc/procMatView.do")
    public String procMatView(Model model){
        return "mes/pro/process/procMatrView.page";
    }
    
    //생산지시리스트 조회
    @RequestMapping("proProc/procMatView")
    @ResponseBody
    public Map<String, Object> readMatView(@ModelAttribute("searchVO") ProOrderVO searchVO ) throws Exception {
//    	List<?> list = service.""(searchVO);
//    	return comFunc.sendResult(list);
    	return null;
    }
    
}
