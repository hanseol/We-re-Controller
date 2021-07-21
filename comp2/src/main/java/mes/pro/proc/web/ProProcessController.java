package mes.pro.proc.web;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.java8.Base64;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.service.ComFunc;
import mes.pro.proc.service.ProProcessService;
import mes.pro.proc.service.ProProcessVO;
import net.sourceforge.barbecue.Barcode;
import net.sourceforge.barbecue.BarcodeFactory;
import net.sourceforge.barbecue.BarcodeImageHandler;

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
    
    //생산지시에 등록한 로트 조회 (완료 조회)
    @RequestMapping("pro/proc/procMatView")
    @ResponseBody
    public Map<String, Object> readMatView(@ModelAttribute("searchVO") ProProcessVO searchVO ) throws Exception {
    	List<?> list = service.selectProcLot(searchVO);
    	return comFunc.sendResult(list);
    }
    
    //모달호출: 공정에서 작업이 끝난 지시리스트 불러오기(완료 조회)
    @GetMapping("pro/proc/finishOrderSearch.do")
    public String finishOrderSearch() {
    	return "mes/pro/modal/finishOrderSearch";
    }
    
    //모달 내용 조회(완료 조회)
    @RequestMapping("finishOrderSearch")
    @ResponseBody
    public Map<String, Object> finishOrderSearch(@ModelAttribute("SearchVO") ProProcessVO searchVO) {
    	List<?> list = service.selectfinishOrder(searchVO);
    	comFunc = new ComFunc();
    	return comFunc.sendResult(list);
    }
    
    //생산지시에 등록한 로트 조회 (전체 조회)
    @RequestMapping("pro/proc/totalProcLot")
    @ResponseBody
    public Map<String, Object> totalProcLot(@ModelAttribute("searchVO") ProProcessVO searchVO ) throws Exception {
    	List<?> list = service.selectTotalProcLot(searchVO);
    	return comFunc.sendResult(list);
    }
    
    
    //모달호출: 모든 지시 디테일코드 조회(전체 조회)
    @GetMapping("pro/proc/totalOrderSearch.do")
    public String totalOrderSearch() {
    	return "mes/pro/modal/PODSearch";
    }
    
    @RequestMapping("totalOrderSearch")
    @ResponseBody
    public Map<String, Object> totalOrderSearch(@ModelAttribute("searchVO") ProProcessVO searchVO) {
    	List<?> list = service.selectTotalOrder(searchVO);
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
  	
  	//공정명이 선택되면 해당 공정의 설비리스트를 조회
  	@RequestMapping("ajax/pro/getMacCode")
  	@ResponseBody
  	public Map<String, Object> getMacCode(@ModelAttribute ProProcessVO vo) {
  		
  		List<String> MacCodeList = service.selectMacCode(vo);
  		
  		Map<String, Object> map = new HashMap<String, Object>();
  		map.put("list", MacCodeList);
  		
  		return map;
  	}
  	
  	//설비코드가 선택이 되면 라인번호 알아오기
  	@RequestMapping("ajax/pro/readLineNo")
  	@ResponseBody
  	public Map<String, Object> readLinNo(@ModelAttribute ProProcessVO vo) {
		String macLineNo = service.selectLineNo(vo);
		System.out.println(macLineNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("macLineNo", macLineNo);
		
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
  		
  		List<?> list = service.selectProdName(vo);
  		System.out.println(list);
  		Map<String, Object> map = new HashMap<String, Object>();
  		
  		map.put("list", list );
  		
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
  	
  	
  //공정이동표 발행
    @RequestMapping("pro/proc/printProcessMove.do")
    public String printProcessMove(ProProcessVO vo, Model model) {

    //지시번호와 공정코드 값을 저장한다.
       String str = vo.getProOrderDetailCode();
       str += vo.getComProcessCode();
      
       //저장된 값으로 바코드를 생성한다.
       try{
          Barcode barcode = BarcodeFactory.createCode128B(str);
          barcode.setBarHeight(80);
          barcode.setLabel("barcode createTEST");
       
          //파일이름을 랜덤으로 생성 후 이미지를 저장한다.
          UUID uuid = UUID.randomUUID();
          File file = new File(EgovProperties.getProperty("Globals.fileStorePath"), uuid.toString()+".jpg");
          BarcodeImageHandler.saveJPEG(barcode, file);
          
          byte[] bc = FileUtils.readFileToByteArray(file);
          byte[] test = Base64.getEncoder().encode(bc);
          
          //페이지에 결과 전송.
          String base64DataString = new String(test , "UTF-8");

          model.addAttribute("barcode", base64DataString);
          model.addAttribute("vo", vo);
          
          //생성된 파일 삭제.
          file.delete();
       }catch (Exception e) {
          e.printStackTrace();
       }
    
       return "mes/pro/proc/printProcessMove";
    }
      
    
}
