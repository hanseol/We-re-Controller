package mes.mat.lot.web;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
import mes.mat.lot.service.MatLotService;
import mes.mat.lot.service.MatLotVO;

@Controller
public class MatLotController {
	//공통함수 객체 생성
	ComFunc comFunc = new ComFunc();
	
    @Resource(name = "matLotService")
    private MatLotService service;
    
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

//--------------------------------------조회 페이지-------------------------------------
    
    //페이지 넘겨주기
    @RequestMapping("/matLot/matrLotView.do")
    public String selectMatLotList(@ModelAttribute("searchVO") MatLotVO searchVO, 
    		ModelMap model) {

        return "mes/mat/matLot/matrLotView.page";
    }
    //자재입출고조회 리스트
    @RequestMapping("/ajax/readMatLot")
    @ResponseBody
    public Map<String, Object> matLot(Model model, 
    		 @ModelAttribute("searchVO") MatLotVO searchVO) throws Exception{

    	List<?> list = service.selectMatLotList(searchVO);
    	
    	//공통함수 객체 생성
    	ComFunc comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
  	

//--------------------------------------관리 페이지--------------------------------------    
    
  	//자재입출고 [관리] 페이지
    @RequestMapping("/matLot/matrLotForm.do")
    public String selectMatLotForm(@ModelAttribute("searchVO") MatLotVO searchVO, 
    		ModelMap model) {

        return "mes/mat/matLot/matrLotForm.page";
    }
  	
  	//자재입출고 [관리] 등록 수정 삭제 
    @PutMapping("/ajax/modifyMatLot")
	@ResponseBody
	public void modifyMatLot(@RequestBody GridDataVO gd) throws Exception {
    	
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateMatLot((LinkedHashMap) updatedList.get(i));
			}
		}
		
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				service.insertMatLot((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				service.deleteMatLot((LinkedHashMap) deletedList.get(i));
			}
		}
	}



    

}
