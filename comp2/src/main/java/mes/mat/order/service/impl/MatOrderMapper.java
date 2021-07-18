package mes.mat.order.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.mat.order.service.MatOrderVO;

/**
 * @Class Name : ErpMaterialOrderMapper.java
 * @Description : ErpMaterialOrder Mapper Class
 * @Modification Information
 *
 * @author sungwon
 * @since 20210628
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("matOrderMapper")
public interface MatOrderMapper {

	//등록
    public String insertMatOrder(LinkedHashMap vo) throws Exception;
    
    //수정
    public int updateMatOrder(LinkedHashMap vo) throws Exception;

    //삭제
    public int deleteMatOrder(LinkedHashMap vo) throws Exception;
    
    //전체 입출고 리스트
    public List<?> selectMatOrderList(MatOrderVO searchVO) throws Exception;
    
    //발주코드 모달
    public List<?> searchMatOrderCodeList(MatOrderVO searchVO) throws Exception;
    
    //순수발주코드 모달
    public List<?> searchMatOrderCodePureList(MatOrderVO searchVO) throws Exception;
}
