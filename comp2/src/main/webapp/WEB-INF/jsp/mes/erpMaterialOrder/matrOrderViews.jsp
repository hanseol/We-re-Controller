<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script language="javascript"
	src="<c:url value='/js/egovframework/com/main.js' />"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/select-box/latest/toastui-select-box.css">
<script
	src="https://uicdn.toast.com/select-box/latest/toastui-select-box.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
<script
	src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <script type="text/javascript">
	function adminUserShowing() {

		$.ajax({
			type : 'POST',
			cache : false,
			url : '/erpMaterialOrder/ErpMaterialOrderList.do',
			dataType : 'data',
			success : function(data) {
				// DB 처리 성공 시 수행 내용 작성
				$(data).find('#selectErpMaterialOrder').each(function() {
					//var link = $(this).find("link").text();
					//var title = $(this).find("title").text();
					//var description = $(this).find("description").text();
					//var tag = $(this).find("tag").text();
				});
			},
			error : function() {
				alret
				return false;
			}
		});
	}
</script> -->
</head>
<body>
	<div>
		<main>
			<div>
				<h2>발주관리 참조</h2>
				<!-- 검색(Master) -->
				<form id="masterForm" name="masterForm" method="post">
					<div>
						<label>해당일자</label>
						<div class="tui-datepicker-input tui-datetime-input tui-has-focus"
							style="width: 140px;">
							<input type="text" id="tui-date-picker-target"
								aria-label="Date-Time"> <span class="tui-ico-date"></span>
						</div>
						<label>발주코드</label> <input type="text" id="searchOrderCode"
							name="searchOrderCode">
						<button type="button" id="searchPopBtn">검색</button>
						<label>자재코드</label> <input type="text" id="searchMatrCode"
							name="searchMatrCode">
						<button type="button" id="searchPopBtn">검색</button>
					</div>
					<div align="right">
						<button>조회</button>
						&nbsp;&nbsp;&nbsp;
						<button>초기화</button>
						&nbsp;&nbsp;&nbsp;
						<button>Exel</button>
						&nbsp;&nbsp;&nbsp;
						<button>인쇄</button>
					</div>
				</form>
				<form id="detailForm" name="detailForm" method="post" action="">
					<div>
						<table class="dataTable" border="1" align="center">
							<thead>
								<tr>
									<th>발주일자</th>
									<th>발주번호</th>
									<th>자재코드</th>
									<th>자재명</th>
									<th>입고일자</th>
									<th>발주량</th>
									<th>거래처명</th>
									<th>자재LOT_NO</th>
									<th>입고량</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${selectOrderList}" var="order">
									<tr>
										<td>${order.orderVO.erpMaterialOrderDate }</td>
										<td>${order.orderVO.erpMaterialOrderCode }</td>
										<td>${order.orderVO.comMaterialCode }</td>
										<%-- <td>${order.matInoutVO.comMaterialName }</td>--%>
										<td>${order.matInoutVO.matInoutDate }</td>
										<td>${order.orderVO.erpMaterialOrderQty }</td>
										<td>${order.orderVO.erpVendorCode }</td>
										<td>${order.matInoutVO.matLotNo }</td>
										<td>${order.matInoutVO.matInoutQuantity }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>${selectOrderList}
				</form>
			</div>
		</main>
	</div>
</body>
</html>