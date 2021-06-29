package mes.main.service;

import java.util.List;

import mes.board.service.BoardVO;

public class GridDataVO {
	List<BoardVO> updatedRows;
	List<BoardVO> createdRows;
	List<BoardVO> deletedRows;
	
	
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


	public List<BoardVO> getDeletedRows() {
		return deletedRows;
	}


	public void setDeletedRows(List<BoardVO> deletedRows) {
		this.deletedRows = deletedRows;
	}
	
	
	
	
}
