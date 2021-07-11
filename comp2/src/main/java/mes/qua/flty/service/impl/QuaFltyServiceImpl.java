package mes.qua.flty.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import mes.main.service.GridDataVO;
import mes.qua.flty.service.QuaFltyService;
import mes.qua.flty.service.QuaFltyVO;
/**
 * @Class Name : QuaMaterialFltyServiceImpl.java
 * @Description : QuaMaterialFlty Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("quaFltyService")
public class QuaFltyServiceImpl extends EgovAbstractServiceImpl implements
        QuaFltyService {
	//자재입고전표번호 부여 객체
	@Resource(name = "mesMatInStatementIdGnrService")
	protected EgovIdGnrService mesMatInStatementIdGnrService;
	//발주입고전표번호 부여 객체
	@Resource(name = "mesQuaInStatementIdGnrService")
	protected EgovIdGnrService mesQuaInStatementIdGnrService;
	//자재LOT_NO 부여 객체
	@Resource(name = "mesMatLotStatementIdGnrService")
	protected EgovIdGnrService mesMatLotStatementIdGnrService;
    private static final Logger LOGGER = LoggerFactory.getLogger(QuaFltyServiceImpl.class);

    @Resource(name="quaFltyMapper")
    private QuaFltyMapper quaFltyMapper;
    
    //@Resource(name="quaMaterialFltyDAO")
    //private QuaMaterialFltyDAO quaMaterialFltyDAO;
    
    /** ID Generation */
    //@Resource(name="{egovQuaMaterialFltyIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	//등록
    public String insertQuaFlty(GridDataVO gd) throws Exception {
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
    	
    	if (updatedList != null) {
			for (int i = 0; i < updatedList.size(); i++) {
				LinkedHashMap updatedMap =(LinkedHashMap) updatedList.get(i);
				
				//검사완료 업데이트
				quaFltyMapper.updateQuaFlty(updatedMap);
				
				//자재 입고 전표번호와 자재LOT_NO 담아서 자재입출고 테이블로 인서트 
				updatedMap.put("matInoutStatement", mesMatInStatementIdGnrService.getNextStringId());
				updatedMap.put("matLotNo", mesMatLotStatementIdGnrService.getNextStringId());
				quaFltyMapper.insertQuaFltyMatIn(updatedMap);
			}
		}
		
		if (createdList != null) {
			for (int i = 0; i < createdList.size(); i++) {
				LinkedHashMap createdMap =(LinkedHashMap) createdList.get(i);
				//더미데이터 추가할 때 쓰는 인서트
				createdMap.put("quaMaterialStatement", mesQuaInStatementIdGnrService.getNextStringId());
				quaFltyMapper.insertQuaFlty(createdMap);
			}
		}

		if (deletedList != null) {
			for (int i = 0; i < deletedList.size(); i++) {
				LinkedHashMap deletedMap =(LinkedHashMap) createdList.get(i);
				quaFltyMapper.deleteQuaFlty(deletedMap);
			}
		}
		return null;
    }
    
    //자재입출고로 등록
    public String insertQuaFltyMatIn(LinkedHashMap vo) throws Exception {
    	
    	quaFltyMapper.insertQuaFltyMatIn(vo);
    	return null;
    }

    //수정
    public void updateQuaFlty(LinkedHashMap vo) throws Exception {
    	quaFltyMapper.updateQuaFlty(vo);
    }

    //삭제
    public void deleteQuaFlty(LinkedHashMap vo) throws Exception {
    	quaFltyMapper.deleteQuaFlty(vo);
    }


    //검사완료 목록 중 불량이 있는 리스트 조회
    public List<?> selectQuaFltyList(QuaFltyVO searchVO) throws Exception {
        return quaFltyMapper.selectQuaFltyList(searchVO);
    }
    
    //불량 리스트 조회
    public List<?> selectQuaFltyDetailList(QuaFltyVO searchVO) throws Exception {
        return quaFltyMapper.selectQuaFltyDetailList(searchVO);
    }
    
    
}
