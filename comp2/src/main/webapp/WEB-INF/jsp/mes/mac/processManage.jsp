<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.modal {
		-webkit-border-radius: 0px;
		border-radius: 0px;
		overflow: visible;
		text-align: center;
		max-width: 1300px;
		width: 1200px;
		height: 100%;
	}

</style>	
<div class="content-fluid">
	<div class="panel panel-headline">
		<h3>공정관리 화면구상</h3>
	</div>
</div>

작업일자 공정명 작업자
지시번호 
작업시작시간
작업종료시간
현재실적량
달성률
불량량

	<!-- 정보 (테이블 출력) -->
<div class="panel">
	<div class="panel-body">
	<form name="frm" id="frm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
		<table class="table table-bordered" id="process">
			<thead>
			</thead>
			<tbody id="tbody">
				<tr>
					<th>공정명</th>
					<td><select name="comProcessCode" id="comProcessCode">
							<option value="">--------선택--------</option>
							<c:forEach var="procg" items="${procgs }">
							<option value="${procg.comProcessCode}">${procg.comProcessName}</option>
							</c:forEach>
						</select></td>
					<th>지시번호</th>
					<td>
						<select name="proOrderDetailCode" id="proOrderDetailCode">
							<option value="">--------선택--------</option>
						</select>
					</td>
					
				</tr>
				<tr>
					<th>라인번호</th>
					<td><input id="" name=""></td>
					<th>작업자</th>
					<td><input id="" name=""></td>
				</tr>
				<tr>
					<th>작업시작시간</th>
					<td><input id="" name="" style="width:40px;">시
									<input id="" name="" style="width:40px;">분
						<button type="button" id="registerMac" class="btn btn-danger">시작</button>
					</td>
					<th>작업종료시간</th>
					<td><input id="" name="" style="width:40px;">시
									<input id="" name="" style="width:40px;">분
						<button type="button" id="registerMac" class="btn btn-success">종료</button>
					</td>
				</tr>
				<tr>
					<th>현재실적량</th>
					<td><input id="" name=""></td>
					<th>달성율</th>
					<td><input id="" name=""></td>
				</tr>
			</tbody>
		</table>
		<div>
			<button type="button" id="registerMac" class="btn btn-info">등록</button>
		</div>
	</form>
	</div>
</div>
<!-- END 정보 -->

<div class="panel">
	<div class="panel-body">
		<div id="proOrderGrid"></div>
	</div>
</div>

<script>

	$(document).ready(function(){
		
		
		//1. 공정을 먼저 선택한다.
		$("#comProcessCode").on("change", function() {
			var comProcGubunCode = $("#comProcessCode option:selected").val();
			console.log(comProcGubunCode);
			
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/pro/getProOrderDetailCode',
				type: 'GET',
				contentType: "application/json",
				dataType : "json",
				data:{"comProcessCode": comProcGubunCode},
				success: function(result){
					
					console.log(result);
					//result 갯수만큼 select 태그에 option태그 붙여 줘야함..
					$("select[name='proOrderDetailCode']").empty(); //셀렉트박스 비우기
					$("select[name='proOrderDetailCode']").append('<option value="">--------선택--------</option>');
					
					//결과값을 select box option으로 넘겨주기.
					var data = result.list;
					$.each(data,function(index,item){
						var rdata = "<option value='"+item+"'>"+ item + "</option>";
						$("select[name='proOrderDetailCode']").append(rdata);
					});
					
				}
			});
			
		});
		
		$("#proOrderDetailCode").on("change", function() {
			var proOrderDetailCode = $("#proOrderDetailCode option:selected").val();
			console.log(proOrderDetailCode);
			
			var readParams = {
					'proOrderDetailCode' : proOrderDetailCode
			};
			proOrderGrid.readData(1, readParams, true);
		});

		const dataSource = {
				api : {
					readData : {
						url : '${pageContext.request.contextPath}/ajax/pro/readMaterial',
						method : 'GET'
					}
				},
				initialRequest : false,
				contentType : "application/json"
			};
		
		const proOrderGrid = new tui.Grid({
			el : document.getElementById('proOrderGrid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			scrollX : false,
			scrollY : true,
			columns : [ {
				header : '자재명',
				name : 'comMaterialName',
				align : 'center'
			}, {
				header : '자재LOT번호',
				name : 'matLotNo',
				align : 'center'
			} ]
		});
	});
</script>
