package mes.main.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/*
 *  작성자 : hanseol
 *  작성일자 : 2021-06-28
 *  설명 : 시작화면
 */

@Controller
public class HomeController {

	
	@RequestMapping("home.do")
	public String home(Model model) {
		
		return "tiles/home.page";
	}
}
