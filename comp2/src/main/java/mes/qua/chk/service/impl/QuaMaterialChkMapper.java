package mes.qua.chk.service.impl;

import java.util.List;

import mes.qua.chk.service.QuaMaterialChkVO;
import mes.qua.chk.service.QuaMaterialChkDefaultVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * @Class Name : QuaMaterialChkMapper.java
 * @Description : QuaMaterialChk Mapper Class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("quaMaterialChkMapper")
public interface QuaMaterialChkMapper {

	/**
	 * QUA_MATERIAL_CHK을 등록한다.
	 * @param vo - 등록할 정보가 담긴 QuaMaterialChkVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertQuaMaterialChk(QuaMaterialChkVO vo) throws Exception;

    /**
	 * QUA_MATERIAL_CHK을 수정한다.
	 * @param vo - 수정할 정보가 담긴 QuaMaterialChkVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateQuaMaterialChk(QuaMaterialChkVO vo) throws Exception;

    /**
	 * QUA_MATERIAL_CHK을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 QuaMaterialChkVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteQuaMaterialChk(QuaMaterialChkVO vo) throws Exception;

    /**
	 * QUA_MATERIAL_CHK을 조회한다.
	 * @param vo - 조회할 정보가 담긴 QuaMaterialChkVO
	 * @return 조회한 QUA_MATERIAL_CHK
	 * @exception Exception
	 */
    public QuaMaterialChkVO selectQuaMaterialChk(QuaMaterialChkVO vo) throws Exception;

    /**
	 * QUA_MATERIAL_CHK 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return QUA_MATERIAL_CHK 목록
	 * @exception Exception
	 */
    public List<?> selectQuaMaterialChkList(QuaMaterialChkDefaultVO searchVO) throws Exception;

    /**
	 * QUA_MATERIAL_CHK 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return QUA_MATERIAL_CHK 총 갯수
	 * @exception
	 */
    public int selectQuaMaterialChkListTotCnt(QuaMaterialChkDefaultVO searchVO);

}
