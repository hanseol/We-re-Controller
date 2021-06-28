<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>완제품 입출고목록 관리</title>

<!-- 2021.06. 28 값을 받아와 검색하기, 값을 입력하기 모두 이루어져야하므로 input 넣어야 함 -->

<!-- master. form action 넣어야 함 -->

<form id="searchForm" name="searchForm" action="./salesProdForm.jsp" method="post">
	
	<div id="master" name="master">
		<ul style="list-style: none">
			<li>
				<label class="headtext">전표번호</label>
				<input type="text" id="readonly_statement" name="readonly_statement" readonly="true" width="200px">
				&nbsp; &nbsp; &nbsp; 
				<label class="headtext">입출고구분</label>
				<label><input type="checkbox" name="gubun_check" value="1" id="gubun_in" checked="checked"> 완제품입고 </label>&nbsp;
				<label><input type="checkbox" name="gubun_check" value="2" id="gubun_out"> 완제품출고 </label>
			</li>

			<!-- 일자 -->
			<li>
				<label class="headtext">일자</label>
				<input type="date">&nbsp; &nbsp; ~ &nbsp; &nbsp; <input type="date">
			</li>
			<!-- //일자 -->


			<li>
				<label class="headtext">거래처코드</label>
				<input type="text" id="text_customerCode" name="text_customerCode">
				<button type="button" id="btn_customerCode" name="btn_customerCode">돋</button>
				&nbsp; &nbsp; &nbsp; 
				<label class="headtext">거래처명</label>
				<input type="text" id="text_customerName" name="text_customerName">
				<input type="text" id="readonly_productCode" name="readonly_productCode" readonly="true" width="200px">
			</li>
			
			<li>
				<div style="float:right">
					<input type="submit" value="조회"></button> &nbsp;
					<button type="button" id="update" name="update">추가</button> &nbsp;
					<input type="reset" value="삭제"></button>
				</div>
			</li>
		</ul>
	</div>
</form>
<!-- //master -->

<!-- detail -->
<div id="detail" name="detail">
			<!-- List -->
			<div id="con">				
			</div>
			<!-- /List -->
</div>


<!-- detail -->
