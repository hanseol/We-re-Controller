package mes.main.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/*
 * 2021-07-01 공통 함수 정의
 * 김한설
 * 
 */


public class ComFunc {
	
	public Map<String, Object> sendResult(List<?> list, String cud){

		Map<String, Object> paging = new HashMap<>();
		Map<String,Object> data = new HashMap<>();
    	Map<String,Object> map = new HashMap<>();
		
		if(cud.equals("select")) {
			paging.put("page", 1);
			paging.put("totalCount", 100);
			
			data.put("pagination", paging);
		}
		
		data.put("contents", list);
		
    	map.put("result", true);
		map.put("data", data);
    	
		
		return map;
	};
	
}
