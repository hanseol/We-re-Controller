package mes.main.web;



import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import mes.mac.service.MacService;
import mes.main.service.MacDateResultVO;
import mes.pro.plan.service.ProPlanService;

/*
 *  작성자 : hanseol
 *  작성일자 : 2021-06-28
 *  설명 : 시작화면
 *  수정일자 : 2021-06-30 뷰페이지에 모달창 출력.
 */

@Controller
public class HomeController {

	@Resource
	private ProPlanService service;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	//권한별 메뉴 목록 조회
	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;
	
	//설비 점검일 조회
	@Resource(name = "macService")
	private MacService macService;
	
	/**
	 * 홈 
	 * 
	 * */
	
	//권한별 메뉴 목록 조회
	@RequestMapping("/mes/getMenuLeft.do")
	@ResponseBody
	public Map<String,Object> getMenuLeft(ModelMap model,
			@ModelAttribute("menuManageVO") MenuManageVO menuManageVO) throws Exception {
		
		//현재 로그인 된 사용자의 정보.
		LoginVO user =
				(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		//menuManageVO의 tmpUniqId에 현재 로그인된 사용자의 uniqId를 부여.
    	menuManageVO.setTmpUniqId(user == null ? "" : EgovStringUtil.isNullToString(user.getUniqId()));
    	
    	menuManageVO.setTmpId(user == null ? "" : EgovStringUtil.isNullToString(user.getId()));
    	menuManageVO.setTmpPassword(user == null ? "" : EgovStringUtil.isNullToString(user.getPassword()));
    	menuManageVO.setTmpUserSe(user == null ? "" : EgovStringUtil.isNullToString(user.getUserSe()));
    	menuManageVO.setTmpName(user == null ? "" : EgovStringUtil.isNullToString(user.getName()));
    	menuManageVO.setTmpEmail(user == null ? "" : EgovStringUtil.isNullToString(user.getEmail()));
    	menuManageVO.setTmpOrgnztId(user == null ? "" : EgovStringUtil.isNullToString(user.getOrgnztId()));
		
		//tmpUniqId에 따른 메뉴 리스트 조회
		List<?> list = menuManageService.selectMainMenuLeft(menuManageVO);
		
		//결과 전송.
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menuList",list);
		
		return map;
	}
	
	//메인 화면 (로그인 성공 시 첫 페이지)
	@RequestMapping("/home.do")
	public String setContent(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		//다음 설비 점검일 d-day 조회.
		List<MacDateResultVO> list = macService.selectLeftDate();
		//session에 조회 결과를 저장시켜서 화면 header에서 알림으로 보여주기.
		request.getSession().setAttribute("macLeftDate", list);
		
		return "tiles/home.page";
	}
	
	/**
     * security check.
     * 로그인이 안되어 있을 때 - loginForm
     * 접근 권한이 없을 때 - accessDenied
     * */
    @RequestMapping("/loginForm.do")
  	public String loginForm(Model model) {
  		return "mes/member/loginForm";
  	}
    @RequestMapping("/accessDenied.do")
  	public String accessDenied(Model model) {
  		return "mes/member/denied.page";
  	}

    //파일 다운로드
    @RequestMapping(value = "/mes/fileDown.do")
	public void getDown(HttpServletResponse response, @RequestParam String fileName) throws Exception{
		String serverSubPath  = "e:/upload";
		String downFileName = serverSubPath + "/" + fileName;

		File file = new File(EgovWebUtil.filePathBlackList(downFileName));

		if (!file.exists()) {
			throw new FileNotFoundException(downFileName);
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(downFileName);
		}

		byte[] b = new byte[8192];

		String original = fileName.replaceAll("\r", "").replaceAll("\n", "");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + original + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			fin = new BufferedInputStream(new FileInputStream(file));
			outs = new BufferedOutputStream(response.getOutputStream());

			int read = 0;

			while ((read = fin.read(b)) != -1) {
				outs.write(b, 0, read);
			}
		} finally {
			EgovResourceCloseHelper.close(outs, fin);
		}
	}
    
}
