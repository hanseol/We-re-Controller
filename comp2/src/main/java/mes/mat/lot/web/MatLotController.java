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
    
	//정산입고전표번호 부여 객체
	@Resource(name = "mesMatMatchInStatementIdGnrService")
	protected EgovIdGnrService mesMatMatchInStatementIdGnrService;
	
	//정산출고전표번호 부여 객체
	@Resource(name = "mesMatMatchOutStatementIdGnrService")
	protected EgovIdGnrService mesMatMatchOutStatementIdGnrService;
	
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

//--------------------------------------조회 페이지-------------------------------------
    
    //페이지 넘겨주기
    @RequestMapping("/mat/lot/matrLotView.do")
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
    @RequestMapping("/mat/lot/matrLotForm.do")
    public String selectMatLotForm(@ModelAttribute("searchVO") MatLotVO searchVO, 
    		ModelMap model) {

        return "mes/mat/matLot/matrLotForm.page";
    }
  	
  	//자재 정산 [관리] 등록 수정 삭제 
    @PutMapping("/ajax/modifyMatLot")
	@ResponseBody
	public void modifyMatLot(@RequestBody GridDataVO gd) throws Exception {
    	
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();

		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				service.updateMatLot((LinkedHashMap)updatedList.get(i));
				service.updateMatInout((LinkedHashMap)updatedList.get(i));
			}
		}
		
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
			String gubun = (String) ((LinkedHashMap)createdList.get(i)).get("matMatchInout");
			
			if(gubun.equals("INOUT004")) {
				((LinkedHashMap)createdList.get(i)).put("matMatchStatement", mesMatMatchInStatementIdGnrService.getNextStringId());
			} else if(gubun.equals("INOUT005")) {
				((LinkedHashMap)createdList.get(i)).put("matMatchStatement", mesMatMatchOutStatementIdGnrService.getNextStringId());
			}
			service.insertMatLot((LinkedHashMap)createdList.get(i));
			service.updateMatInout((LinkedHashMap)createdList.get(i));
				
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
