package mes.main.service;

import java.util.List;

import lombok.Data;
import mes.board.service.BoardVO;

/*
 * ToastUi Grid
 * C,U,D 결과값을 LinkedHashMap으로 담는 VO 
 * 2021-06-28 김한설
 * 
 * */

@Datapublic class GridDataVO {
	List<?> updatedRows;
	List<?> createdRows;
	List<?> deletedRows;
	private Integer no;
}
