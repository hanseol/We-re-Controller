<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 이동표</title>
<style>
	table {
		width : 80%;
		height : 300px;
	}
	
	th {
		width : 20%;
	}
	
	td {
		text-align : center;
	}
</style>
</head>
<body>
<div align="center"> 
<h1>완제품 이동표</h1>
<table border="1">
	<tr>
		<th>품명</th>
		<td>${vo.erpProductName }</td>
		<th>수량</th>
		<td>${vo.proProcessQuantity }</td>
	</tr>
	<tr>
		<th>생산일</th>
		<td>${vo.proProcessStartTime }</td>
		<th>LOT-NO</th>
		<td>${vo.proProcessLotNo }</td>
	</tr>
	<tr>
		<th>고객사명</th>
		<td>${vo.erpCustomerName }</td>
		<th>주문코드</th>
		<td><%-- ${vo.erpOrderCode } --%></td>
	</tr>
	<tr>
		<th>판정</th>
		<td><h4>포 장 완 료</h4></td>
		<td colspan="2"><img src="data:image/png;base64,${barcode }"/></td>
	</tr>
</table>

${vo.proOrderDetailCode }

</div>
</body>
</html>