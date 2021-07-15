package mes.mac.web;

import java.io.File;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.mac.service.MacService;
import mes.mac.service.MacVO;
import mes.main.service.ComFunc;
import mes.main.service.GridDataVO;
import mes.pro.proc.service.ProProcessService;
import mes.pro.proc.service.ProProcessVO;

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
 *      Copyright (C) All right reserved.
 */

@Controller
public class MacController {

	@Resource(name = "macService")
	private MacService macService;
	
	//생산
	@Resource(name = "proProcessService")
	private ProProcessService proProcService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	ComFunc comFunc = new ComFunc();
	
	/**
	 * 조회
	 * 
	 */
	// 설비 정보 조회 페이지를 연다.
	@RequestMapping("/mac/miv/macInfoView.do")
	public String macInfoView() {

		return "mes/mac/macInfoView.page";
	}

	// 설비 조회 결과 값 전달 (1건 상세내용)
	@RequestMapping("ajax/mac/macInfo")
	@ResponseBody
	public Map<String, Object> macInfo(@ModelAttribute("vo") MacVO vo) throws Exception {

		vo = macService.selectMac(vo);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		map.put("data", vo);

		return map;
	}

	// 설비 검색 버튼을 눌렀을 때 모달창 여는 동작
	// 라인번호와 차기점검일로 검색가능.
	@GetMapping("mac/miv/openMacListModal.do")
	public String showMacModal() {

		// 모달창에 띄워줄 view페이지 전달.
		return "mes/mac/searchMacCode";
	}

	// 모달창에 출력 할 설비 리스트 결과 전달
	@RequestMapping("ajax/mac/macList")
	@ResponseBody
	public Map<String, Object> macList(@ModelAttribute("searchVO") MacVO searchVO) throws Exception {

		List<?> list = macService.selectMacList(searchVO);

		ComFunc comFunc = new ComFunc();

		return comFunc.sendResult(list);
	}

	/**
	 * 수정
	 * 
	 */

	// 설비 정보 관리 페이지를 연다
	@RequestMapping("/mac/mim/macInfoForm.do")
	public String updateMacInfoForm() {
		return "mes/mac/macInfoForm.page";
	}

	// (점검일, 차기점검일, 사용여부, 점검주기, 제작업체, 비상연락망 수정)
	@RequestMapping("/ajax/mac/modifyMacInfo")
	@ResponseBody
	public Map<String, Object> macInfoUpdate(@RequestBody GridDataVO gd) throws Exception {

		Map<String, Object> map = new HashMap<>();

		List<?> updatedList = gd.getUpdatedRows();
		List<?> deletedList = gd.getDeletedRows();

		// 수정
		if (updatedList.size() != 0) {
			for (int i = 0; i < updatedList.size(); i++) {
				macService.updateMac((LinkedHashMap) updatedList.get(i));
			}
		}
		// 삭제
		if (deletedList.size() != 0) {
			for (int i = 0; i < deletedList.size(); i++) {
				macService.deleteMac((LinkedHashMap) deletedList.get(i));
			}
		}

		map.put("result", true);

		return map;
	}

	/**
	 * 등록
	 * 
	 * @throws Exception
	 * 
	 */

	// 등록 페이지
	@RequestMapping("mac/mim/macRegisterForm.do")
	public String macRegisterForm(HttpSession session) {
		return "mes/mac/macRegisterForm.page";
	}
	
	//등록 페이지에 필요한 정보 가져오기.
//	@RequestMapping("ajax/mac/getNextMacCode")
//	@ResponseBody 
//	public String getNextMacCode() throws Exception{
//		
//		String code = macService.selectNextMacCode();
//		return code;
//	}
	
	//등록 페이지에 필요한 정보 여러개 넘기기.
	@RequestMapping("ajax/mac/getInfo")
	@ResponseBody
	public Map<String,Object> getInfo() throws Exception{
		
		String code = macService.selectNextMacCode();
		List<String> model = macService.selectMacModel();
		List<String> size = macService.selectMacSize();
		List<String> usePurpose = macService.selectMacUsePurpose();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("code", code);
		map.put("model",model);
		map.put("size",size);
		map.put("usePurpose",usePurpose);
		
		return map;
	}

	@RequestMapping(value="ajax/mac/registerMac", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> macInsert(MacVO vo) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		
		 // 파일 업로드 처리
		String fileName = null; 
		MultipartFile uploadFile = vo.getUploadFile(); 
		if (uploadFile!=null && !uploadFile.isEmpty() && uploadFile.getSize()>0) {
			String originalFileName = uploadFile.getOriginalFilename(); 
			System.out.println("originalFileName:" + originalFileName);
			String ext = FilenameUtils.getExtension(originalFileName); // 확장자 구하기 
			UUID uuid = UUID.randomUUID(); // UUID 구하기 
			System.out.println("UUID: "+ uuid);
			fileName = uuid + "." + ext;
			uploadFile.transferTo(new File("C:\\eGovFrameDev-3.10.0-64bit\\workspace\\We-re-Controller\\comp2\\src\\main\\webapp\\resources\\images\\upload\\" + fileName));
		 }
		
		 vo.setMacImage(fileName);
		
		 macService.insertMac(vo);
		
		 map.put("result", true);

		 return map;
	}
	
	
//	/***
//	 * 생산 모니터링 화면 
//	 * 
//	 */
//	@RequestMapping("/mac/monitoringView.do")
//	public String monitoringView(){
//		return "mes/mac/monitoring.page";
//	}
//	
//	@RequestMapping("/mac/openPerformance.do")
//	public String openPerformance() {
//		return "mes/mac/performance";
//	}
//	
//	
//	/**
//	 * 공정 관리 화면 
//	 * 
//	 * */
//
//	//모달창을 열 때 선택가능한 공정명 정보를 전달.
//	@RequestMapping("/pro/openProcessManage.do")
//	public String openProcessmanage(Model model) {
//
//		List<ProProcessVO> procgList = proProcService.selectProProcessName();
//		
//		model.addAttribute("procgs", procgList);
//		return "mes/mac/processManage";
//	}
//	
//	//공정명이 선택되면 해당 공정에 대기중인 작업지시 정보를 전달.
//	@RequestMapping("ajax/pro/getProOrderDetailCode")
//	@ResponseBody
//	public Map<String, Object> getProOrderDetailCode(@ModelAttribute ProProcessVO vo){
//		
//		List<String> orderCodeList = proProcService.selectProOrderDetailCode(vo);
//		
//		Map<String,Object> map = new HashMap<String, Object>();
//		map.put("list", orderCodeList);
//		
//		return map;
//	}
//	
//	//작업지시가 선택되면 해당 작업에 필요한 자재 정보를 전달.
//	@RequestMapping("ajax/pro/readMaterial")
//	@ResponseBody
//	public Map<String, Object> readMaterial(@ModelAttribute ProProcessVO vo){
//		
//		List<ProProcessVO> list = proProcService.selectMatrLot(vo);
//		return comFunc.sendResult(list);
//	}
//	
//	//선택한 작업지시가 start 되었을 때.
//	@RequestMapping("ajax/pro/startProProcess")
//	@ResponseBody
//	public Map<String,Object> startProProcess(ProProcessVO vo) throws Exception{
//		if(vo.getComProcessCode().equals("PROCG001")) {
//			proProcService.insertProProcess(vo);
//		}else {
//			proProcService.updateStartTime(vo);
//		}
//		
//		return null;
//	}
//	
//	//선택한 작업지시가 end 되었을 때.
//	@RequestMapping("ajax/pro/endProProcess")
//	@ResponseBody
//	public Map<String,Object> endProProcess(@ModelAttribute ProProcessVO vo) throws Exception{
//	
//		proProcService.updateProProcess(vo);
//		
//		return null;
//	}
	
	
	/**
	 * 설비 점검일 알림 
	 * @throws Exception 
	 * 
	 * */
//	@RequestMapping("ajax/mac/macChkLeftday")
//	@ResponseBody
//	public Map<String, Object> macChkLeftday (MacVO searchVO) throws Exception{
//		
//		//설비코드와 설비구분, 라인번호, d-day를 select (asc)
//		List<MacVO> list = macService.selectLeftDate(searchVO);
//		
//		return comFunc.sendResult(list);
//	}
}
