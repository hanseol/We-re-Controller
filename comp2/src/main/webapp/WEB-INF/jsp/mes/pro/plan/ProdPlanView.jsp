<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : ProPlanList.jsp
  * @Description : ProPlan List 화면
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
<title>목록</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */

function fn_egov_select(proPlanCode) {
	document.getElementById("listForm").proPlanCode.value = proPlanCode;
   	document.getElementById("listForm").action = "<c:url value='/proPlan/updateProPlanView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.getElementById("listForm").action = "<c:url value='/proPlan/addProPlanView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/proPlan/ProPlanList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>

<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<input type="hidden" name="proPlanCode" />
<div id="content_pop">
	<!-- 페이지 타이틀 -->
	<div id="title">
		<h2>
			생산 계획 조회
		</h2>
	</div>
	
	<!-- 디테일 테이블 -->
	<!-- List -->
	<div id="table">
		<table width="95%" border="1" >
			<colgroup>
				<col/>				
				<col/>				
				<col/>				
				<col/>				
			</colgroup>		  
			<tr>
				<th align="center">계획일자</th>
				<th align="center">계획번호</th>
				<th align="center">고객사명</th>
				<th align="center">제품코드</th>
				<th align="center">제품명</th>
				<th align="center">주문코드</th>
				<th align="center">납기일자</th>
				<th align="center">주문량</th>
				<th align="center">작업계획량</th>
				<th align="center">작업착수일</th>
				<th align="center">작업우선순위</th>
				
			</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td align="center" class="listtd"><c:out value="${result.proPlanDate}"/></a>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.proPlanCode}"/></a>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.erpCustomerCode}"/>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.erpProductCode}"/>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.erpProductName}"/>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.erpOrderCode}"/>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.erpProductDeadline}"/>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.erpOrderQty}"/>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.proPlanQty}"/></a>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.proWorkDate}"/>&nbsp;</td>
				<td align="center" class="listtd"><c:out value="${result.proPlanSeq}"/>&nbsp;</td>
   			</tr>
			</c:forEach>
		</table>
	</div>
	
	
	
	<!-- paging -->
	<div id="paging">
		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="image"
				   jsFunction="fn_egov_link_page"
				   />
		<form:hidden path="pageIndex" />
	</div>	
</div>
</form:form>
</body>
</html>
