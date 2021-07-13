package mes.sal.match.web;

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
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
import mes.sal.inout.service.SalInoutVO;
import mes.sal.match.service.SalMatchService;
import mes.sal.match.service.SalMatchVO;

/**
 * @Class Name : SalMatchController.java
 * @Description : SalMatch Controller class
 * @Modification Information
 *
 * @author hk
 * @since 2021-06-29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class SalMatchController {

    @Resource(name = "salMatchService")
    private SalMatchService salMatchService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    //정산입고 전표번호
    @Resource(name = "mesSalMatchInStatementIdGnrService")
	protected EgovIdGnrService salMatchInStatementIdGnrService;
    
    //정산출고 전표번호
    @Resource(name = "mesSalMatchOutStatementIdGnrService")
	protected EgovIdGnrService salMatchOutStatementIdGnrService;
    
    ComFunc comFunc = new ComFunc();

//----------------------------조회--------------------------------
    
    //정산입출록조회 salesMatch grid
    @RequestMapping("ajax/sal/readSalesMatch")
    @ResponseBody
    public Map<String, Object> readSalesMatch(@ModelAttribute("searchVO") SalMatchVO searchVO) throws Exception {
    	
    	List<?> list = salMatchService.selectSalMatchList(searchVO);
    	
    	return comFunc.sendResult(list);
    }
    
    //정산입출고조회 페이지
    @RequestMapping("/salMatch/matchProdView.do")
    public String selectSalesMatchList(@ModelAttribute("searchVO") SalMatchVO searchVO) throws Exception {
    	
    	return "mes/sal/salMatch/matchProdView.page";
    }
    
    // 정산입출고관리 페이지
 	@RequestMapping("/salMatch/matchProdForm.do")
 	public String selectSalesProductFormList(@ModelAttribute("searchVO") SalMatchVO searchVO, ModelMap model)
 			throws Exception {

 		return "mes/sal/salMatch/matchProdForm.page";
 	}

//-----------------------------관리-------------------------------------
    
 	// 정산입출고관리 페이지
 	@PutMapping("/ajax/sal/modifySalMatchList")
	@ResponseBody
	public void modifySalMatchList(@RequestBody GridDataVO gd) throws Exception {
		
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
						
		//C
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				String gubun = (String) ((LinkedHashMap)createdList.get(i)).get("salMatchInout");
						
				if(gubun.equals("INOUT004")) {
					((LinkedHashMap)createdList.get(i)).put("salMatchStatement", salMatchInStatementIdGnrService.getNextStringId());
					} else if(gubun.equals("INOUT005")) {
						((LinkedHashMap)createdList.get(i)).put("salMatchStatement", salMatchOutStatementIdGnrService.getNextStringId());
					}			
					salMatchService.insertSalMatch((LinkedHashMap)(createdList.get(i)));
				}
		}
				
		//U
		if (updatedList.size() != 0) {
			for (int i=0; i<updatedList.size(); i++) {
				salMatchService.updateSalMatch((LinkedHashMap) updatedList.get(i));
			}
		}
		
		//D
		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				salMatchService.deleteSalMatch((LinkedHashMap) deletedList.get(i));
			}
		}
		
	}
    
        
//--------------------------- 모달 -------------------------------
    // 모달 : 완제품 LOT_NO 조회
 	@GetMapping("/salMatch/searchProductLotNo.do")
 	public String searchProductLotNoView() {

 		// 모달창 띄워주는 페이지
 		return "mes/sal/modal/searchProductLotNo";
 	}

 	// 모달 : 완제품 LOT_NO 조회값 전달
 	@RequestMapping("mes/salMatch/searchProductLotNo")
 	@ResponseBody
 	public Map<String, Object> searchProductLotNo(@ModelAttribute("searchVO") SalMatchVO searchVO) throws Exception {

 		List<?> list = salMatchService.searchProductLotNoList(searchVO);

 		return comFunc.sendResult(list);
 	}
 	
 	// 모달 : 제품코드 조회
 	@GetMapping("/salMatch/searchProductCode.do")
 	public String searchProductCode() {
 		
 		//모달창 띄워주는 페이지
 		return "mes/sal/modal/searchProductCode"; //수정
 	}
 	
 	// 모달 : 제품코드 조회값 전달
 	@RequestMapping("mes/salMatch/searchProductCode") //수정
 	@ResponseBody
 	public Map<String, Object> searchProduct(@ModelAttribute("searchVO") SalMatchVO searchVO) throws Exception {
 		
     	List<?> list = salMatchService.searchProductList(searchVO);
     	
     	return comFunc.sendResult(list);
 	}

}
