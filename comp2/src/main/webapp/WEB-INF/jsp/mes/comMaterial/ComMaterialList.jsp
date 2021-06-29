<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : ComMaterialList.jsp
  * @Description : ComMaterial List 화면
  * @Modification Information
  * 
  * @author sungwon
  * @since 20210629
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


function fn_egov_select(comMaterialCode) {
	document.getElementById("listForm").comMaterialCode.value = comMaterialCode;
   	document.getElementById("listForm").action = "<c:url value='/comMaterial/updateComMaterialView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.getElementById("listForm").action = "<c:url value='/comMaterial/addComMaterialView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/comMaterial/ComMaterialList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<input type="hidden" name="comMaterialCode" />
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt="title" /> List </li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<!-- List -->
	<div id="table">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<colgroup>
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
							</colgroup>		  
			<tr>
								<th align="center">ComMaterialCode</th>
								<th align="center">ComMaterialName</th>
								<th align="center">ComMaterialBarcode</th>
								<th align="center">ComMaterialSize</th>
								<th align="center">ComMaterialUnit</th>
								<th align="center">ComMaterialVendorCode</th>
								<th align="center">ComMaterialSafetyStock</th>
								<th align="center">ComMaterialMin</th>
								<th align="center">ComMaterialMax</th>
							</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
													<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.comMaterialCode}"/>')"><c:out value="${result.comMaterialCode}"/></a>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.comMaterialName}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.comMaterialBarcode}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.comMaterialSize}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.comMaterialUnit}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.comMaterialVendorCode}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.comMaterialSafetyStock}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.comMaterialMin}"/>&nbsp;</td>
						<td align="center" class="listtd"><c:out value="${result.comMaterialMax}"/>&nbsp;</td>
				    			</tr>
			</c:forEach>
		</table>
	</div>
	<!-- /List -->
	<div id="paging">
		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="image"
				   jsFunction="fn_egov_link_page"
				   />
		<form:hidden path="pageIndex" />
	</div>
	<div id="sysbtn1">
		<ul>
			<li>
				<div id="sysbtn">
					<span class="btn_blue_l"><a href="javascript:fn_egov_addView();">등록</a><img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" alt="" />
					</span>
				</div>
			</li>
		</ul>
	</div>
</div>
</form:form>
</body>
</html>
