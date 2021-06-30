package mes.board.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.board.service.BoardVO;
import mes.main.service.SearchVO;

/**
 * @Class Name : BoardMapper.java
 * @Description : Board Mapper Class
 * @Modification Information
 *
 * @author kym
 * @since 20210621
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Mapper("boardMapper")
public interface BoardMapper {

	/**
	 * BOARD을 등록한다.
	 * @param vo - 등록할 정보가 담긴 BoardVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void insertBoard(LinkedHashMap vo) throws Exception;

    /**
	 * BOARD을 수정한다.
	 * @param vo - 수정할 정보가 담긴 BoardVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateBoard(BoardVO vo) throws Exception;

    /**
	 * BOARD을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 BoardVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteBoard(BoardVO vo) throws Exception;

    /**
	 * BOARD을 조회한다.
	 * @param vo - 조회할 정보가 담긴 BoardVO
	 * @return 조회한 BOARD
	 * @exception Exception
	 */
    public BoardVO selectBoard(SearchVO vo) throws Exception;

    /**
	 * BOARD 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return BOARD 목록
	 * @exception Exception
	 */
    public List<?> selectBoardList(SearchVO searchVO) throws Exception;

    /**
	 * BOARD 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return BOARD 총 갯수
	 * @exception
	 */
    public int selectBoardListTotCnt(SearchVO searchVO);

}
