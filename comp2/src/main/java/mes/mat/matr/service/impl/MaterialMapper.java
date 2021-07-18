package mes.mat.matr.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mat.matr.service.MaterialVO;

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

@Mapper("materialMapper")
public interface MaterialMapper {

	//등록
    public String insertMaterial(LinkedHashMap vo) throws Exception;

    //수정
    public int updateMaterial(LinkedHashMap vo) throws Exception;

    //삭제
    public int deleteMaterial(LinkedHashMap vo) throws Exception;

    //전체 리스트 출력
	public List<?> selectMaterialList(MaterialVO searchVO) throws Exception;		

}
