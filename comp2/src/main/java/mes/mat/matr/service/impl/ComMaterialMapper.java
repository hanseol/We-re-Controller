package mes.mat.matr.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mat.matr.service.ComMaterialDefaultVO;
import mes.mat.matr.service.ComMaterialVO;

/**
 * @Class Name : ComMaterialMapper.java
 * @Description : ComMaterial Mapper Class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("comMaterialMapper")
public interface ComMaterialMapper {

	/**
	 * COM_MATERIAL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComMaterialVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertComMaterial(ComMaterialVO vo) throws Exception;

    /**
	 * COM_MATERIAL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComMaterialVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateComMaterial(ComMaterialVO vo) throws Exception;

    /**
	 * COM_MATERIAL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComMaterialVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteComMaterial(ComMaterialVO vo) throws Exception;

    /**
	 * COM_MATERIAL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComMaterialVO
	 * @return 조회한 COM_MATERIAL
	 * @exception Exception
	 */
    public ComMaterialVO selectComMaterial(ComMaterialVO vo) throws Exception;

    /**
	 * COM_MATERIAL 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COM_MATERIAL 목록
	 * @exception Exception
	 */
    public List<?> selectComMaterialList(ComMaterialDefaultVO searchVO) throws Exception;

    /**
	 * COM_MATERIAL 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return COM_MATERIAL 총 갯수
	 * @exception
	 */
    public int selectComMaterialListTotCnt(ComMaterialDefaultVO searchVO);
    
    //리스트 전체 조회
    public List<?> selectMatList(ComMaterialDefaultVO searchVO) throws Exception;

}
