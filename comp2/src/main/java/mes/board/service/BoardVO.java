package mes.board.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import mes.main.service.SearchVO;

//test
/**
 * @Class Name : BoardVO.java
 * @Description : Board VO class
 * @Modification Information
 *
 * @author kym
 * @since 20210621
 * @version 1.0
 * @see
 * 
 *      Copyright (C) All right reserved.
 */
@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class BoardVO extends SearchVO{
	private static final long serialVersionUID = 1L;

	/** NO */
	private Integer no;

	/** TITLE */
	private java.lang.String title;

	/** CONTENT */
	private java.lang.String content;

	/** WDATE */
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:SS")
	private Date wdate;

}