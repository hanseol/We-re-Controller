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
    
	//모디1 등록
    public String insertQuaChk(GridDataVO gd) throws Exception {
    	
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
    	
    	if (updatedList != null) {
			for (int i = 0; i < updatedList.size(); i++) {
				LinkedHashMap updatedMap =(LinkedHashMap) updatedList.get(i);
				int passQty =  Integer.parseInt(String.valueOf(updatedMap.get("quaMaterialPQty")));
				int fltyQty =  Integer.parseInt(String.valueOf(updatedMap.get("quaMaterialFQty")));
				int quaChk = Integer.parseInt(String.valueOf(updatedMap.get("quaMaterialChk")));
				if (quaChk == 0) { //검사완료가 아니면
					quaChkMapper.updateQuaChk(updatedMap); //검사테이블 업데이트만 하고
				} else if (quaChk == 1) { //검사완료된 거라면
					if(fltyQty == 0) {//불량이 없는 것은
						
						quaChkMapper.updateQuaChk(updatedMap);//검사테이블에 업데이트하고

						//합격량만큼 반복 인서트
						for(int j = 0; j < passQty;j++) {
							//자재 입고 전표번호와 자재LOT_NO 담아서 자재입출고 테이블로 인서트
							updatedMap.put("quaMaterialPQty", 1);//수량을 1로 치환하고 인서트
							updatedMap.put("matInoutStatement", mesMatInStatementIdGnrService.getNextStringId());
							updatedMap.put("matLotNo", mesMatLotStatementIdGnrService.getNextStringId());
							quaChkMapper.insertQuaChkMatIn(updatedMap);

						}
											
					}else if ((fltyQty != 0)&&(passQty != 0)) {//불량이 있는데 합격량도 있는 것은
						//검사완료 업데이트
						quaChkMapper.updateQuaChk(updatedMap);
						//자재 불량으로 인서트
						updatedMap.put("quaMaterialFQty",fltyQty); //불량량을 담고 인서트 
						quaChkMapper.insertMatFlty(updatedMap);
						//합격량만큼 반복 인서트
						for(int j = 0; j < passQty;j++) {
							//자재 입고 전표번호와 자재LOT_NO 담아서 자재입출고 테이블로 인서트
							updatedMap.put("quaMaterialPQty", 1);//수량을 1로 치환하고 인서트
							updatedMap.put("matInoutStatement", mesMatInStatementIdGnrService.getNextStringId());
							updatedMap.put("matLotNo", mesMatLotStatementIdGnrService.getNextStringId());
							quaChkMapper.insertQuaChkMatIn(updatedMap);
						}

						
						///////////////////불량내역과 입고내역을 분리 할 수 있는 방법(계산) 알아내기.///////////////////
						
						
					}else if ((fltyQty != 0)&&(passQty == 0)) { //전부 불량인 것은
						//검사완료 업데이트
						quaChkMapper.updateQuaChk(updatedMap);
						//자재 불량으로 인서트
						quaChkMapper.insertMatFlty(updatedMap);
					}
				}
				
			}
		}
		
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				LinkedHashMap createdMap =(LinkedHashMap) createdList.get(i);
				//더미데이터 추가할 때 쓰는 인서트
				createdMap.put("quaMaterialStatement", mesQuaInStatementIdGnrService.getNextStringId());
				quaChkMapper.insertQuaChk(createdMap);
			}
		}

		if (deletedList.size() != 0) {
			for (int i = 0; i < deletedList.size(); i++) {
				LinkedHashMap deletedMap =(LinkedHashMap) deletedList.get(i);
				quaChkMapper.deleteQuaChk(deletedMap);
			}
		}
		return null;
    }
    
  //모디2 등록
    public String insertQuaChkPass(GridDataVO gd) throws Exception {
    	
		List<?> updatedList = gd.getUpdatedRows();
		List<?> createdList = gd.getCreatedRows();
		List<?> deletedList = gd.getDeletedRows();
    	
    	if (updatedList != null) {
			for (int i = 0; i < updatedList.size(); i++) {
				LinkedHashMap updatedMap =(LinkedHashMap) updatedList.get(i);
				quaChkMapper.updateQuaChk(updatedMap);
				
			}
		}
		
		if (createdList.size() != 0) {
			for (int i = 0; i < createdList.size(); i++) {
				LinkedHashMap createdMap =(LinkedHashMap) createdList.get(i);
				quaChkMapper.insertQuaChk(createdMap);
			}
		}

		if (deletedList.size() != 0) {
			for (int i = 0; i < deletedList.size(); i++) {
				LinkedHashMap deletedMap =(LinkedHashMap) deletedList.get(i);
				quaChkMapper.deleteQuaChk(deletedMap);
			}
		}
		return null;
    }
    
    
    //자재입출고로 등록
    public void insertQuaChkMatIn(LinkedHashMap vo) throws Exception {
    	
    	quaChkMapper.insertQuaChkMatIn(vo);
    }
    //자재불량으로 등록
	/*
	 * public String insertMatFlty(LinkedHashMap vo) throws Exception {
	 * quaChkMapper.insertMatFlty(vo); return null; }
	 */
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
    
    //모달 자재불량코드 리스트 출력
	public List<?> searchMatFltyCodeList(QuaChkVO searchVO) throws Exception {
		return quaChkMapper.searchMatFltyCodeList(searchVO);
	}
    //모달 자재불량코드 리스트 출력
	public List<?> searchMatFltyCodeQtyList(QuaChkVO searchVO) throws Exception {
		return quaChkMapper.searchMatFltyCodeQtyList(searchVO);
	}
    
}
