package mes.mat.lot.service.impl;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import mes.main.map.ResultMapVO;

@Mapper("matLotMapper")
public interface MatLotMapper {
	public List<?> selectMatLotList(ResultMapVO searchVO) throws Exception;
}
