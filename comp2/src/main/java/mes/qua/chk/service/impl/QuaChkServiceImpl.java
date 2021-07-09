package mes.qua.chk.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import mes.main.service.GridDataVO;
import mes.qua.chk.service.QuaChkService;
import mes.qua.chk.service.QuaChkVO;
/**
 * @Class Name : QuaMaterialChkServiceImpl.java
 * @Description : QuaMaterialChk Business Implement class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("quaChkService")
public class QuaChkServiceImpl extends EgovAbstractServiceImpl implements
        QuaChkService {
	//자재입고전표번호 부여 객체
	@Resource(name = "mesMatInStatementIdGnrService")
	protected EgovIdGnrService mesMatInStatementIdGnrService;
	//발주입고전표번호 부여 객체
	@Resource(name = "mesQuaInStatementIdGnrService")
	protected EgovIdGnrService mesQuaInStatementIdGnrService;
	//자재LOT_NO 부여 객체
	@Resource(name = "mesMatLotStatementIdGnrService")
	protected EgovIdGnrService mesMatLotStatementIdGnrService;
    private static final Logger LOGGER = LoggerFactory.getLogger(QuaChkServiceImpl.class);

    @Resource(name="quaChkMapper")
    private QuaChkMapper quaChkMapper;
    
    //@Resource(name="quaMaterialChkDAO")
    //private QuaMaterialChkDAO quaMaterialChkDAO;
    
    /** ID Generation */
    //@Resource(name="{egovQuaMaterialChkIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	//등록
    public String insertQuaChk(GridDataVO gd) throws Exception {
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
    	
    	if (updatedList != null) {
			for (int i = 0; i < updatedList.size(); i++) {
				LinkedHashMap map =(LinkedHashMap) updatedList.get(i);
				//검사완료 업데이트
				quaChkMapper.updateQuaChk(map);
				
				//자재 입고 전표번호와 자재LOT_NO 담아서 자재입출고 테이블로 인서트 
				map.put("matInoutStatement", mesMatInStatementIdGnrService.getNextStringId());
				map.put("matLotNo", mesMatLotStatementIdGnrService.getNextStringId());
				quaChkMapper.insertQuaChkMatIn(map);
			}
		}
		
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				
				//더미데이터 추가할 때 쓰는 인서트
				((LinkedHashMap)createdList.get(i)).put("quaMaterialStatement", mesQuaInStatementIdGnrService.getNextStringId());
				quaChkMapper.insertQuaChk((LinkedHashMap) createdList.get(i));
			}
		}

		if (deletedList.size() != 0)
		{
			for (int i = 0; i < deletedList.size(); i++) {
				quaChkMapper.deleteQuaChk((LinkedHashMap) deletedList.get(i));
			}
		}
		return null;
    }
    
    //자재입출고로 등록
    public String insertQuaChkMatIn(LinkedHashMap vo) throws Exception {
    	
    	quaChkMapper.insertQuaChkMatIn(vo);
    	return null;
    }

    //수정
    public void updateQuaChk(LinkedHashMap vo) throws Exception {
    	quaChkMapper.updateQuaChk(vo);
    }

    //삭제
    public void deleteQuaChk(LinkedHashMap vo) throws Exception {
    	quaChkMapper.deleteQuaChk(vo);
    }


    //전체리스트 조회
    public List<?> selectQuaChkList(QuaChkVO searchVO) throws Exception {
        return quaChkMapper.selectQuaChkList(searchVO);
    }
    
    //전체리스트 조회
    public List<?> selectQuaChkPassList(QuaChkVO searchVO) throws Exception {
        return quaChkMapper.selectQuaChkPassList(searchVO);
    }
    
    
}
