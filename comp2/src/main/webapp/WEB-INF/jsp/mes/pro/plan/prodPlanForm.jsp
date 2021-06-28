<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : ProPlanRegister.jsp
  * @Description : ProPlan Register 화면
  * @Modification Information
  * 
  * @author dahee
  * @since 20210628
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<c:set var="registerFlag" value="${empty proPlanVO.proPlanCode ? '등록' : '수정'}"/>

<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script -->
<!-- validator:javascript formName="proPlanVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/proPlan/ProPlanList.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/proPlan/deleteProPlan.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("detailForm");

	/* TODO Validation기능 보완 */
	
  	frm.action = "<c:url value="${registerFlag == '등록' ? '/proPlan/addProPlan.do' : '/proPlan/updateProPlan.do'}"/>";
    frm.submit();

}

// -->
</script>
</head>

<body>
<form:form commandName="proPlanVO" name="detailForm" id="detailForm" >
<div id="content_pop">
	<!-- 페이지 타이틀 -->
	<div id="title">
		<h2>
			생산 계획 관리
		</h2>
	</div>
	
	<!-- 상단버튼(팝업기능) -->	
	<hr/>
	<div align="right">
		<h4>
			<button type="button" id="" name="">조회</button> &nbsp;&nbsp;
			<button type="button" id="" name="">등록</button> &nbsp;&nbsp;
			<button type="button" id="" name="">삭제</button> &nbsp;&nbsp;
		</h4>
	</div>
	<hr/>
	
	<!-- 마스터 테이블 -->
  <div id="table" align="center" >
	<table width="95%" border="1" >
		<tr>
			<th>
				계획일자
			</th>
			<td>
				<input type="date" />
			</td>
		</tr>
		<tr>
			<th>
				생산계획명
			</th>
			<td>
				<input type="text" />
			</td>
		</tr>
	</table>
  </div>
	
	<!-- 디테일 테이블의 추가, 삭제 버튼 -->
  <hr/>
	<div align="right">
		<h4>
			<button type="button" id="" name="">추가</button> &nbsp;&nbsp;
			<button type="button" id="" name="">삭제</button> &nbsp;&nbsp;
		</h4>
	</div>
  <hr/>

	<!--디테일 테이블 -->
  <div id="table" align="center" >
	<table width="95%" border="1" >
		<tr>
			<th><input type="checkbox" value=""/></th>
			<th>제품코드</th>
			<th>제품명</th>
			<th>주문코드</th>
			<th>납기일자</th>
			<th>주문량</th>
			<th>작업량</th>
			<th>일생산량</th>
			<th>작업착수일자</th>
			<th>작업우선순위</th>
		</tr>
	</table>
  </div>

</div>









<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>


</body>
</html>

