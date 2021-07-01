package mes.mat.matr.service;

import java.util.List;

/**
 * @Class Name : ComMaterialService.java
 * @Description : ComMaterial Business class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210629
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface MaterialService {
	
	/**
	 * COM_MATERIAL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ComMaterialVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertComMaterial(MaterialVO vo) throws Exception;
    
    /**
	 * COM_MATERIAL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ComMaterialVO
	 * @return void형
	 * @exception Exception
	 */
    void updateComMaterial(MaterialVO vo) throws Exception;
    
    /**
	 * COM_MATERIAL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ComMaterialVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteComMaterial(MaterialVO vo) throws Exception;
    
    /**
	 * COM_MATERIAL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ComMaterialVO
	 * @return 조회한 COM_MATERIAL
	 * @exception Exception
	 */
    MaterialVO selectComMaterial(MaterialVO vo) throws Exception;
    
    /**
	 * COM_MATERIAL 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COM_MATERIAL 목록
	 * @exception Exception
	 */
    List selectComMaterialList(MaterialVO searchVO) throws Exception;
    
    /**
	 * COM_MATERIAL 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return COM_MATERIAL 총 갯수
	 * @exception
	 */
    int selectComMaterialListTotCnt(MaterialVO searchVO);
    
    //리스트 전체 조회
    List<?> selectMatList(MaterialVO searchVO) throws Exception;
}
