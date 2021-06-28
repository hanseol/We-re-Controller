package mes.mat.order.service;

import lombok.Data;
import mes.mat.inout.service.MatInoutVO;

@Data
public class resultMapVO {
	private ErpMaterialOrderVO orderVO;
	private MatInoutVO matInoutVO;
}
