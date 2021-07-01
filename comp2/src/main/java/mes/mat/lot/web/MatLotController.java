package mes.mat.lot.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.map.ResultMapVO;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
import mes.mat.lot.service.impl.MatLotMapper;

@Controller
public class MatLotController {
	
	ComFunc comFunc = new ComFunc();
	
	@Resource(name = "matLotMapper")
	private MatLotMapper service;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
    
	//뷰페이지만 넘겨준다.
    @RequestMapping(value="/matLot/matrLotView.do")
    public String selectMatLotList(@ModelAttribute("searchVO") ResultMapVO searchVO, 
    		ModelMap model) {

        return "mes/matLot/matrLotView.page";
    } 
	
	
	//자재LOT페이지 리스트 출력
    @RequestMapping(value="/mat/lot/readLotInout")
    @ResponseBody
    public Map<String, Object> matOrder(Model model, 
    		 @ModelAttribute("searchVO") ResultMapVO searchVO) throws Exception{

    	int rowSize = 0;
    	List<?> list = new ArrayList<>();
    	
    	//검색조건이 있을 경우
    	if(!searchVO.getSearchKeyword().equals("")) {
    	
    		//mapper 조건에 따라 condition 설정 필요함.
        	searchVO.setSearchCondition("0");
    		
    		rowSize = service.selectMatLotListTotCnt(searchVO);
        	searchVO.setLastIndex(rowSize);
        	
        	list = service.selectMatLotList(searchVO);
        //검색조건이 없을 경우
    	}else {
    		rowSize = service.selectMatLotListTotCnt(searchVO);
        	searchVO.setLastIndex(rowSize);
        	
        	list = service.selectMatLotList(searchVO);
    	}
    	
    	Map<String, Object> paging = new HashMap<>();
    	paging.put("page", searchVO.getPageIndex());
    	paging.put("totalCount", rowSize);
    	
    	Map<String,Object> data = new HashMap<>();
    	data.put("contents", list);
    	data.put("pagination", paging);
    	
    	Map<String,Object> map = new HashMap<>();
    	map.put("result", true);
    	map.put("data", data);
        
    	return map;
    }


    /*
	 * 테이블 행 추가.
	 * @return "map"
	 * @exception Exception
	 */
	@PostMapping("/ajax/insertMatLot")
    @ResponseBody
    public Map<String,Object> insertMatLot(@RequestBody GridDataVO gd) throws Exception {
    
    	List<?> list = gd.getCreatedRows();
    	
    	for(int i=0;i<list.size();i++) {
    		service.insertMatLot( (LinkedHashMap) list.get(i));
    	}
    	
    	return comFunc.sendResult(list);
    }
    
    
    /*
	 * 테이블 행 삭제.
	 * @return "map"
	 * @exception Exception
	 */
    @PostMapping("/ajax/deleteMatLot")
    @ResponseBody
    public Map<String,Object> deleteMatLot(@RequestBody GridDataVO gd) throws Exception {
    	
    	List<?> list = gd.getDeletedRows();
    	for(int i=0; i<list.size(); i++) {
    		service.deleteMatLot((LinkedHashMap) list.get(i));
    	}
    	
    	return comFunc.sendResult(list);
    }
    
    /*
	 * 테이블 행 업데이트.
	 * @return "map"
	 * @exception Exception
	 */
    @PutMapping("/ajax/updateMatLot")
    @ResponseBody
    public Map<String,Object> updateMatLot(@RequestBody GridDataVO gd) throws Exception {
    	
    	List<?> list = gd.getUpdatedRows();
    	//전달받은 데이터 수 만큼.
    	for(int i=0; i<list.size(); i++) {
    		service.updateMatLot((LinkedHashMap) list.get(i));
    	}
    	
    	return comFunc.sendResult(list);
    }
    


}
