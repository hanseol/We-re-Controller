<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">

<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>

<script>
	$(document).ready(function() {
		$('#table_id').DataTable({
			ajax: {
				url :'ajax/EgovCcmCmmnCodeAll',
				dataSrc: 'codes'
			},
			columns: [
				{data: 'clCodeNm'},
				{data: 'codeId'},
				{data: 'codeIdNm'},
				{data: 'useAt'}]
			});
	});
</script>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table id="table_id" class="display">
		<thead>
			<tr>
				<th>분류코드명</th>
				<th>코드ID</th>
				<th>코드ID명</th>
				<th>사용여부</th>
			</tr>
		</thead>
		<tbody>
			<%-- <c:forEach var="code" items="${codeList }">
				<tr>
					<td>${code.clCodeNm}</td>
					<td>${code.codeId}</td>
					<td>${code.codeIdNm}</td>
					<td>${code.useAt}</td>
				</tr>
			</c:forEach> --%>
		</tbody>
	</table>
</body>
</html>