package mes.mat.lot.service;

import java.util.List;

import org.springframework.stereotype.Service;

import mes.main.map.ResultMapVO;

@Service("matLotService")
public interface MatLotService {

	List<?> selectMatLotList(ResultMapVO searchVO) throws Exception;
}
