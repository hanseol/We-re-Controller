package mes.main.map;

import lombok.Data;
import mes.mat.inout.service.MatInoutVO;
import mes.mat.matr.service.ComMaterialVO;
import mes.mat.order.service.ErpMaterialOrderVO;
import mes.qua.chk.service.QuaMaterialChkVO;
@Data
public class ResultMapVO {
	private ErpMaterialOrderVO orderVO;
	private MatInoutVO matInoutVO;
	private ComMaterialVO matrVO;
	private QuaMaterialChkVO matrChkVO;
}
