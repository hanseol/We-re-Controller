package mes.main.map;

import lombok.Data;
import lombok.EqualsAndHashCode;
import mes.com.comCode.service.ComCodeVO;
import mes.main.service.SearchVO;
import mes.mat.inout.service.MatInoutVO;
import mes.mat.match.service.MatMatchVO;
import mes.mat.order.service.MaterialOrderVO;
import mes.qua.chk.service.QuaMaterialChkVO;

@Data
@EqualsAndHashCode(callSuper = false)
public class ResultMapVO extends SearchVO {

	private static final long serialVersionUID = 1L;
	private MatInoutVO matInoutVO;
	private QuaMaterialChkVO matrChkVO;
	private ComCodeVO comcodeVO;
	private MaterialOrderVO matOrderVO;
	private MatMatchVO matMatchVO;
}
