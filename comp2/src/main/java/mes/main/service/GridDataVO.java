package mes.main.service;

import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

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
	private String matInoutStatus;
	private String proPlanDate;
	private String proPlanName;
	private String proOrderDate;
	
	private String comProductCode;
	private String salInoutDate;
	private String salInoutQuantity;
	private String salInoutCode;
	private String salInoutGubun;
	private String proProcessLotNo;
	private String salWriteDate;
}
