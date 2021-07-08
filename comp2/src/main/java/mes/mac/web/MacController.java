package mes.mac.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.mac.service.MacService;
import mes.mac.service.MacVO;
import mes.main.service.ComFunc;

/**
 * @Class Name : MacController.java
 * @Description : Mac Controller class
 * @Modification Information
 *
 * @author hanseol
 * @since 20210708
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class MacController {

    @Resource(name = "macService")
    private MacService macService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    //설비 정보 조회 페이지를 연다.
    @RequestMapping("/mac/macInfoForm.do")
    public String selectMacList(@ModelAttribute("searchVO") MacVO searchVO)
            throws Exception {

        return "mes/mac/MacList.page";
    } 
    
    //조회 결과 값 전달.
    @RequestMapping("ajax/mac/macInfo")
    @ResponseBody
    public Map<String, Object> macInfo(@ModelAttribute("vo") MacVO vo) throws Exception{
    	
    	vo = macService.selectMac(vo);
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("result", true);
    	map.put("data", vo);
    	return map;
    }
    
    //설비 검색 버튼을 눌렀을 때 모달창 여는 동작
  	@GetMapping("mac/openMacListModal.do")
  	public String testModal() {
  		
  		//모달창에 띄워줄 view페이지 전달.
  		return "mes/mac/searchMacCode";
  	}
  	
  	//모달창에 출력 할 설비 리스트 결과 전달
    @RequestMapping("ajax/mac/macList")
    @ResponseBody
    public Map<String,Object> macList(@ModelAttribute("searchVO") MacVO searchVO) throws Exception{
    	
    	List<?> list = macService.selectMacList(searchVO);
    	
    	ComFunc comFunc = new ComFunc();
    	
    	return comFunc.sendResult(list);
    }
    
    

}
