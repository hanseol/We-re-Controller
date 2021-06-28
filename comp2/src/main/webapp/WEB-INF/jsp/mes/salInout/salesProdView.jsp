<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<title>완제품 입출고목록 조회</title>

<!-- 2021.06.28 조회페이지이므로 마찬가지로 값을 뿌려주기만 하면 됨 -->

<!-- master -->
<form id="searchForm">
	<div id="master" name="master">
		<ul style="list-style: none">
			<li>
				<label class="headtext">전표번호</label>
				<input type="text" id="text_statement" name="text_statement">
				<button type="button" id="btn_statement" name="btn_statement">돋</button>
				&nbsp; &nbsp; &nbsp; 
				<label class="headtext">입출고구분</label>
				<input type="radio" name="gubun_radio" value="1" id="gubun_in" checked="checked"> 완제품입고 &nbsp;
				<input type="radio" name="gubun_radio" value="2" id="gubun_out"> 완제품출고 &nbsp;
			</li>

			<!-- 일자 -->
			<li>
				<label class="headtext">일자</label>
				<input type="text">&nbsp; &nbsp; ~ &nbsp; &nbsp; <input type="text">
			</li>
			<!-- //일자 -->

			<li>
				<label class="headtext">거래처코드</label>
				<input type="text" id="text_customerCode" name="text_customerCode">
				<button type="button" id="btn_customerCode" name="btn_customerCode">돋</button>
				<input type="text" id="readonly_customerCode" name="readonly_customerCode" readonly="true" width="200px">
				&nbsp; &nbsp; &nbsp; 
				<label class="headtext">제품코드</label>
				<input type="text" id="text_productCode" name="text_productCode">
				<button type="button" id="btn_productCode" name="btn_productCode">돋</button>
				<input type="text" id="readonly_productCode" name="readonly_productCode" readonly="true" width="200px">
			</li>
			
			<li>
				<div style="float:right">
					<button type="button" id="btn_reset">초기화</button> &nbsp;
					<button type="button" id="btn_select">조회</button> &nbsp;
					<button type="button" id="btn_excel">Excel</button> &nbsp;
					<button type="button" id="btn_print">인쇄</button>
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
