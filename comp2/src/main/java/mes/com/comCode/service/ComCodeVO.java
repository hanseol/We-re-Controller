package mes.com.comCode.service;

import mes.main.service.SearchVO;

/**
 * @Class Name : ComCodeVO.java
 * @Description : ComCode VO class
 * @Modification Information
 *
 * @author 경윤수
 * @since 2021-06-30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class ComCodeVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    /** COM_CODE_ID */
    private java.lang.String comCodeId;
    
    /** COM_CODE_NAME */
    private java.lang.String comCodeName;
    
    /** COM_CODE_DESC */
    private java.lang.String comCodeDesc;
    
    /** COM_CODE_USEDCHK */
    private java.lang.String comCodeUsedchk;
    
    public java.lang.String getComCodeId() {
        return this.comCodeId;
    }
    
    public void setComCodeId(java.lang.String comCodeId) {
        this.comCodeId = comCodeId;
    }
    
    public java.lang.String getComCodeName() {
        return this.comCodeName;
    }
    
    public void setComCodeName(java.lang.String comCodeName) {
        this.comCodeName = comCodeName;
    }
    
    public java.lang.String getComCodeDesc() {
        return this.comCodeDesc;
    }
    
    public void setComCodeDesc(java.lang.String comCodeDesc) {
        this.comCodeDesc = comCodeDesc;
    }
    
    public java.lang.String getComCodeUsedchk() {
        return this.comCodeUsedchk;
    }
    
    public void setComCodeUsedchk(java.lang.String comCodeUsedchk) {
        this.comCodeUsedchk = comCodeUsedchk;
    }
    
}
