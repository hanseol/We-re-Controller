package mes.pro.proc.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
public class ProProcessController {

    @Resource(name = "proProcessService")
    private ProProcessService service;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    ComFunc comFunc = new ComFunc();
	
    
    // 공정별 자재소요 페이지
    //공정별 자재 페이지 호출
    @RequestMapping("pro/proc/procMatView.do")
    public String procMatView(){
        return "mes/pro/proc/procMatrView.page";
    }
    
    //생산지시리스트 조회
    @RequestMapping("pro/proc/procMatView")
    @ResponseBody
    public Map<String, Object> readMatView(@ModelAttribute("searchVO") ProProcessVO searchVO ) throws Exception {
    	List<?> list = service.selectProcLot(searchVO);
    	return comFunc.sendResult(list);
    }
    
    //모달호출: 공정에서 작업이 끝난 지시리스트 불러오기
    @GetMapping("pro/proc/finishOrderSearch.do")
    public String finishOrderSearch() {
    	return "mes/pro/modal/finishOrderSearch";
    }
    
    //모달 내용 조회
    @RequestMapping("finishOrderSearch")
    @ResponseBody
    public Map<String, Object> finishOrderSearch(@ModelAttribute("SearchVO") ProProcessVO searchVO) {
    	List<?> list = service.selectfinishOrder(searchVO);
    	comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    
    
    
    
    
    
    // 생산관리 페이지
    //모니터링 페이지 호출(생산관리) > 선택가능한 지시정보를 가지고 옴
    @RequestMapping("pro/proc/mntView.do")
    public String mntView(Model model) {
    	
		List<ProProcessVO> procgList = service.selectProProcessName();
		
		model.addAttribute("procgs", procgList);
    	
		return "mes/pro/proc/mntView.page";
    }
    
    //공정명이 선택되면 해당 공정에 대기중인 작업지시 정보를 전달.
  	@RequestMapping("ajax/pro/getProOrderDetailCode")
  	@ResponseBody
  	public Map<String, Object> getProOrderDetailCode(@ModelAttribute ProProcessVO vo){
  		
  		List<String> orderCodeList = service.selectProOrderDetailCode(vo);
  		
  		Map<String,Object> map = new HashMap<String, Object>();
  		map.put("list", orderCodeList);
  		
  		return map;
  	}
  	
  	//작업지시가 선택되면 해당 작업에 필요한 자재 정보를 전달.
  	@RequestMapping("ajax/pro/readMaterial")
  	@ResponseBody
  	public Map<String, Object> readMaterial(@ModelAttribute ProProcessVO vo){
  		
  		List<ProProcessVO> list = service.selectMatrLot(vo);
  		return comFunc.sendResult(list);
  	}
  	
  	
  	//작업지시가 선택되면 해당 작업의 제품명을 조회
  	@RequestMapping("ajax/pro/readProdName")
  	@ResponseBody
  	public Map<String, Object> readProdName(@ModelAttribute ProProcessVO vo) {
  		
  		
  		String erpProductName = service.selectProdName(vo);
  		System.out.println(erpProductName);
  		Map<String, Object> map = new HashMap<String, Object>();
  		
  		map.put("erpProductName", erpProductName );
  		
  		return map;
  	}
  	
  	
  	
  	//선택한 작업지시가 start 되었을 때.
  	@RequestMapping("ajax/pro/startProProcess")
  	@ResponseBody
  	public Map<String,Object> startProProcess(ProProcessVO vo) throws Exception{
  		if(vo.getComProcessCode().equals("PROCG001")) {
  			service.insertProProcess(vo);
  		}else {
  			service.updateStartTime(vo);
  		}
  		
  		return null;
  	}
  	
  	//선택한 작업지시가 end 되었을 때.
  	@RequestMapping("ajax/pro/endProProcess")
  	@ResponseBody
  	public Map<String,Object> endProProcess(@ModelAttribute ProProcessVO vo) throws Exception{
  	
  		service.updateProProcess(vo);
  		
  		return null;
  	}
    
    
}
