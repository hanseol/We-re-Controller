<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : ProOrderDetailRegister.jsp
  * @Description : ProOrderDetail Register 화면
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

<c:set var="registerFlag" value="${empty proOrderDetailVO.proOrderDetailCode ? '등록' : '수정'}"/>

<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script -->
<!-- validator:javascript formName="proOrderDetailVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/proOrderDetail/ProOrderDetailList.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/proOrderDetail/deleteProOrderDetail.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("detailForm");

	/* TODO Validation기능 보완 */
	
  	frm.action = "<c:url value="${registerFlag == '등록' ? '/proOrderDetail/addProOrderDetail.do' : '/proOrderDetail/updateProOrderDetail.do'}"/>";
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="proOrderDetailVO" name="detailForm" id="detailForm" >
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images//title_dot.gif'/>" alt="" /><c:out value="${registerFlag}"/></li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<div id="table">
	<table width="100%" border="1" cellpadding="0" cellspacing="0" >
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
			
		<c:if test="${registerFlag == '수정'}">
	   <tr>
			<th>PRO_ORDER_DETAIL_CODE *</th>
			<td>
				<form:input path="proOrderDetailCode" cssClass="essentiality" readonly="true" />
			</td>			
		</tr>	
		</c:if>
		<c:if test="${registerFlag == '등록'}">
	   <tr>
			<th>PRO_ORDER_DETAIL_CODE *</th>
			<td>
				<form:input path="proOrderDetailCode" cssClass="txt" readonly="false" />
			</td>			
		</tr>	
		</c:if>		
		<tr>
			<th>PRO_ORDER_CODE</th>
			<td>
				<form:input path="proOrderCode" cssClass="txt"/>
				&nbsp;<form:errors path="proOrderCode" />
			</td>
		</tr>	
		<tr>
			<th>PRO_PLAN_DETAIL_CODE</th>
			<td>
				<form:input path="proPlanDetailCode" cssClass="txt"/>
				&nbsp;<form:errors path="proPlanDetailCode" />
			</td>
		</tr>	
		<tr>
			<th>ERP_PRODUCT_DEADLINE</th>
			<td>
				<form:input path="erpProductDeadline" cssClass="txt"/>
				&nbsp;<form:errors path="erpProductDeadline" />
			</td>
		</tr>	
		<tr>
			<th>PRO_ORDER_DATE</th>
			<td>
				<form:input path="proOrderDate" cssClass="txt"/>
				&nbsp;<form:errors path="proOrderDate" />
			</td>
		</tr>	
		<tr>
			<th>ERP_CUSTOMER_CODE</th>
			<td>
				<form:input path="erpCustomerCode" cssClass="txt"/>
				&nbsp;<form:errors path="erpCustomerCode" />
			</td>
		</tr>	
		<tr>
			<th>PRO_ORDER_EXPECT_QTY</th>
			<td>
				<form:input path="proOrderExpectQty" cssClass="txt"/>
				&nbsp;<form:errors path="proOrderExpectQty" />
			</td>
		</tr>	
		<tr>
			<th>PRO_ORDER_DAY_QTY</th>
			<td>
				<form:input path="proOrderDayQty" cssClass="txt"/>
				&nbsp;<form:errors path="proOrderDayQty" />
			</td>
		</tr>	
		<tr>
			<th>PRO_ORDER_SEQ</th>
			<td>
				<form:input path="proOrderSeq" cssClass="txt"/>
				&nbsp;<form:errors path="proOrderSeq" />
			</td>
		</tr>	
		<tr>
			<th>PRO_ORDER_ORDER_QTY</th>
			<td>
				<form:input path="proOrderOrderQty" cssClass="txt"/>
				&nbsp;<form:errors path="proOrderOrderQty" />
			</td>
		</tr>	
		<tr>
			<th>PRO_ORDER_QTY</th>
			<td>
				<form:input path="proOrderQty" cssClass="txt"/>
				&nbsp;<form:errors path="proOrderQty" />
			</td>
		</tr>	
	</table>
  </div>
	<div id="sysbtn">
		<ul>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_selectList();">List</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_save();"><c:out value='${registerFlag}'/></a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li>
			<c:if test="${registerFlag == '수정'}">
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_delete();">삭제</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li>
			</c:if>
			<li><span class="btn_blue_l"><a href="javascript:document.detailForm.reset();">Reset</a><img src="<c:url value='/images//btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

