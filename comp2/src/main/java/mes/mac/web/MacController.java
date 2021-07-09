package mes.mac.web;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.mac.service.MacService;
import mes.mac.service.MacVO;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;

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
	
    
    
    
    /**
     * 조회
     * 
     */
    //설비 정보 조회 페이지를 연다.
    @RequestMapping("/mac/macInfoView.do")
    public String macInfoView() {

        return "mes/mac/macInfoView.page";
    } 
    
    //설비 조회 결과 값 전달 (1건 상세내용)
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
    //라인번호와 차기점검일로 검색가능.
  	@GetMapping("mac/openMacListModal.do")
  	public String showMacModal() {
  		
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
    
    
    /**
     *  수정
     * 
     * */
    
    //설비 정보 관리 페이지를 연다 
    @RequestMapping("/mac/macInfoForm.do")
    public String updateMacInfoForm(){
        return "mes/mac/macInfoForm.page";
    } 
    
    //(점검일, 차기점검일, 사용여부, 점검주기, 제작업체, 비상연락망 수정)
    @RequestMapping("/ajax/mac/modifyMacInfo")
    @ResponseBody
    public Map<String,Object> macInfoUpdate (@RequestBody GridDataVO gd) throws Exception{
    	
    	Map<String,Object> map = new HashMap<>();
		
		List<?> updatedList = gd.getUpdatedRows();
		List<?> deletedList = gd.getDeletedRows();

		//수정
		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				macService.updateMac((LinkedHashMap) updatedList.get(i));
			}
		}
		//삭제
		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				macService.deleteMac((LinkedHashMap) deletedList.get(i));
			}
		}
		
    	map.put("result", true);
		
		return map;
    }
    
    /**
     * 등록
     * @throws Exception 
     * 
     * */

    //등록 페이지
    @RequestMapping("mac/macRegisterForm.do")
    public String macRegisterForm() {
    	return "mes/mac/macRegisterForm.page";
    }
    
    @RequestMapping("ajax/mac/registerMac")
    @ResponseBody
    public Map<String, Object> macInsert (@RequestBody MacVO vo) throws Exception{
    	
    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	macService.insertMac(vo);
    	
		/*
		 * // 파일 업로드 처리 String fileName = null; MultipartFile uploadFile =
		 * testVO.getUploadFile(); if (!uploadFile.isEmpty()) { String originalFileName
		 * = uploadFile.getOriginalFilename(); String ext =
		 * FilenameUtils.getExtension(originalFileName); // 확장자 구하기 UUID uuid =
		 * UUID.randomUUID(); // UUID 구하기 fileName = uuid + "." + ext;
		 * uploadFile.transferTo(new File("C:\\upload\\" + fileName)); }
		 * testVO.setFileName(fileName);
		 */
    	
    	map.put("result", true);
    	
    	return map;
    }
}
