package mes.pro.proc.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import mes.pro.proc.service.ProProcessVO;
import mes.pro.proc.service.ProProcessDefaultVO;

/**
 * @Class Name : ProProcessDAO.java
 * @Description : ProProcess DAO Class
 * @Modification Information
 *
 * @author dahee
 * @since 20210707
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("proProcessDAO")
public class ProProcessDAO extends EgovAbstractDAO {

	/**
	 * PRO_PROCESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 ProProcessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertProProcess(ProProcessVO vo) throws Exception {
        return (String)insert("proProcessDAO.insertProProcess_S", vo);
    }

    /**
	 * PRO_PROCESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 ProProcessVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateProProcess(ProProcessVO vo) throws Exception {
        update("proProcessDAO.updateProProcess_S", vo);
    }

    /**
	 * PRO_PROCESS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 ProProcessVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteProProcess(ProProcessVO vo) throws Exception {
        delete("proProcessDAO.deleteProProcess_S", vo);
    }

    /**
	 * PRO_PROCESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 ProProcessVO
	 * @return 조회한 PRO_PROCESS
	 * @exception Exception
	 */
    public ProProcessVO selectProProcess(ProProcessVO vo) throws Exception {
        return (ProProcessVO) select("proProcessDAO.selectProProcess_S", vo);
    }

    /**
	 * PRO_PROCESS 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_PROCESS 목록
	 * @exception Exception
	 */
    public List<?> selectProProcessList(ProProcessDefaultVO searchVO) throws Exception {
        return list("proProcessDAO.selectProProcessList_D", searchVO);
    }

    /**
	 * PRO_PROCESS 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return PRO_PROCESS 총 갯수
	 * @exception
	 */
    public int selectProProcessListTotCnt(ProProcessDefaultVO searchVO) {
        return (Integer)select("proProcessDAO.selectProProcessListTotCnt_S", searchVO);
    }

}
