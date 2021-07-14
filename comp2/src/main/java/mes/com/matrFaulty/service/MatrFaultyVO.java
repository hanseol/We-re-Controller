package mes.com.matrFaulty.service;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.main.service.SearchVO;



@Data
@EqualsAndHashCode(callSuper=false)
public class MatrFaultyVO extends SearchVO{
    private static final long serialVersionUID = 1L;
    
    private int comMaterialFNo;
    private java.lang.String comMaterialFCode;
    private java.lang.String comMaterialFName;
    private java.lang.String comMaterialFDesc;
    
    
}
