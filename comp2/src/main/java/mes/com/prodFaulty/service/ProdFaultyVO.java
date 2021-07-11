package mes.com.prodFaulty.service;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;



@Data
@EqualsAndHashCode(callSuper=false)
public class ProdFaultyVO extends SearchVO{
    private static final long serialVersionUID = 1L;

    private java.lang.String comProductFCode;
    private java.lang.String comProductFName;
    private java.lang.String comProductFDetail;
    private java.lang.String comProductFProcessCode;
    private java.lang.String comProductFProcessName;
    private java.lang.String comProductFEtc;
    private java.math.BigDecimal comProductFSeq;
    
    
}
