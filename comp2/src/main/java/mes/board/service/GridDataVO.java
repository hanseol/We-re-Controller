package mes.board.service;

import java.util.List;

public class GridDataVO {
	List<BoardVO> updatedRows;
	List<BoardVO> createdRows;
	List<BoardVO> deltedRows;
	
	
	public GridDataVO() {}
	
	public List<BoardVO> getUpdatedRows() {
		return updatedRows;
	}
	public void setUpdatedRows(List<BoardVO> updatedRows) {
		this.updatedRows = updatedRows;
	}
	public List<BoardVO> getCreatedRows() {
		return createdRows;
	}
	public void setCreatedRows(List<BoardVO> createdRows) {
		this.createdRows = createdRows;
	}
	public List<BoardVO> getDeltedRows() {
		return deltedRows;
	}
	public void setDeltedRows(List<BoardVO> deltedRows) {
		this.deltedRows = deltedRows;
	}
	
	
}
