package mes.mat.lot.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.rte.fdl.property.EgovPropertyService;
import mes.main.map.ResultMapVO;
import mes.mat.lot.service.impl.MatLotMapper;

@Controller
public class MatLotController {
	@Resource(name = "matLotMapper")
	private MatLotMapper matLotMapper;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	//자재LOT페이지 리스트 출력
	@RequestMapping("/matLot/matLotView.do")
	public String selectMatInoutList(@ModelAttribute("searchVO") ResultMapVO searchVO, ModelMap model)
			throws Exception {
		List<?> selectMatLotList = matLotMapper.selectMatLotList(searchVO);
		model.addAttribute("selectMatLotList", selectMatLotList);

		return "mes/matLot/matrLotView.page";
	}

}
