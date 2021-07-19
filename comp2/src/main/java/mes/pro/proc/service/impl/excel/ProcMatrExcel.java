package mes.pro.proc.service.impl.excel;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import mes.pro.proc.service.ProProcessVO;
import mes.pro.proc.service.impl.ProProcessMapper;

@Controller
public class ProcMatrExcel {

	@Autowired
	ProProcessMapper mapper;
	
	
	@RequestMapping("/procMatrExcel")
	public void ExcelCreate(HttpServletResponse response, ProProcessVO vo) throws IOException {
		response.setCharacterEncoding("utf-8");
		Workbook wb = new XSSFWorkbook(); 
		CellStyle cs = wb.createCellStyle();
		Font f2 = wb.createFont();
		f2.setFontName("궁서체");
		f2.setItalic(true);
		cs.setFont(f2);

		wb.createSheet("first sheet");

		String[] headers = { "com_code_detail_name", "pro_order_detail_code", "erp_product_code", 
				"erp_product_name", "mat_lot_no", "pro_work_date", "com_material_code",
				"com_material_name", "pro_plan_qty", "pro_order_qty" };

		Map<String, String> headerMap = new HashMap<>();
		// 헤더명 한글화 작업(수정해야됨)
		headerMap.put("com_code_detail_name", "공정명");
		headerMap.put("pro_order_detail_code", "지시번호");
		headerMap.put("erp_product_code", "제품코드");
		headerMap.put("erp_product_name", "제품명");
		headerMap.put("mat_lot_no", "자재로트번호");
		headerMap.put("pro_work_date", "작업일자");
		headerMap.put("com_material_code", "자재코드");
		headerMap.put("com_material_name", "자재명");
		headerMap.put("pro_plan_qty", "계획량");
		headerMap.put("pro_order_qty", "지시량");

		// 엑셀 헤더 출력
		Row row;
		Cell cell = null;
		Sheet sheet = wb.getSheetAt(0); // 시트번호
		int rowNum = 0; // 행번호
		if (headers != null) {
			row = sheet.createRow(rowNum++);
			int colNum = 0; // 가로 컬럼번호
			for (String header : headers) {
				row.createCell(colNum++).setCellValue(headerMap.get(header));
			}
		} // 헤더 출력 end

		// body부분 시작
		List<Map<String, Object>> list = mapper.procMatrExcel(vo); // db에서 리스트 받아옴 (수정해야됨)

		for (Map<String, Object> map : list) { // 리스트 결과 행수만큼 반복
			row = sheet.createRow(rowNum++); // 데이터 넣을 row(행) 생성 / 반복할때마다 다음 행 번호 ++
			int colNum = 0;
			for (String header : headers) { // 영어로된 헤더 배열크기만큼 반복
				cell = row.createCell(colNum++); // 데이터 넣을 cell 생성 / 다음 데이터 넣기위해 반복할 때마다 다음 컬럼 번호 ++

				Object field = map.get(header); // 리스트 결과에서 key값을 영어로 된 헤더명인 value 값 field에 담기

				if (field == null) { // field가 빈 값일 경우 공백
					field = "";
				} // field 타입에 맞춰 cell에 입력
				if (field instanceof String) {
					cell.setCellValue((String) field);
				} else if (field instanceof BigDecimal) {
					cell.setCellValue(((BigDecimal) field).doubleValue());
				} else if (field instanceof Date) {
					Date nowdate = (Date) field;
					SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
					cell.setCellValue(simple.format(nowdate));
				} else {
					cell.setCellValue(field.toString());
				}
			}
		}

		// 서버에 엑셀 파일 저장( 경로에 Temp 폴더 있는지 확인)
		String filename = "c:/Temp/excel_" + System.currentTimeMillis() + ".xlsx";
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(filename);
			try {
				wb.write(fos);
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		
		// 서버에 올려져있는 엑셀파일로 저장파일 내려받은 뒤 서버에있는 엑셀파일 삭제까지
		String downFileName = "공정별소요자재.xlsx"; // 저장 파일명 (수정해야함)
		String fileName2 = new String(downFileName.getBytes("UTF-8"), "ISO-8859-1"); //파일이름 인코딩
		File uFile = new File(filename);
		int fSize = (int) uFile.length(); // 파일크기
		BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
		String mimetype = "text/html";
		response.setBufferSize(fSize);
		response.setContentType(mimetype);
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName2 + "\"");
		response.setContentLength(fSize);
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
		uFile.delete(); // 파일삭제
		response.getOutputStream().flush();
		response.getOutputStream().close();

	}

	
}
