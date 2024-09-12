package mes.main.service;

import java.io.Serializable;
import org.apache.commons.lang3.builder.ToStringBuilder;

import lombok.Data;

/**
 * @Class Name : BoardDefaultVO.java
 * @Description : Board Default VO class
 * @Modification Information
 *
 * @author kym
 * @since 20210621
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
@Data
public class SearchVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 10;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 100;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    private String startDate;
    private String endDate;
}
