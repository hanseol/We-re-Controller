package mes.main.map;

import lombok.Data;
import mes.com.comCode.service.ComCodeVO;
import mes.mat.inout.service.MatInoutVO;
import mes.qua.chk.service.QuaMaterialChkVO;
@Data
public class ResultMapVO {
	private MatInoutVO matInoutVO;
	private QuaMaterialChkVO matrChkVO;
	private ComCodeVO comcodeVO;
}
