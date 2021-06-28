<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<title> <c:out value="${registerFlag}"/> </title>


<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/board/BoardList.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/board/deleteBoard.do'/>";
   	document.getElementById("detailForm").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("detailForm");

	/* TODO Validation기능 보완 */
	
  	frm.action = "<c:url value="${registerFlag == '등록' ? '/board/addBoard.do' : '/board/updateBoard.do'}"/>";
    frm.submit();

}
-->
</script>
<div class="main-content">
	<div class="container-fluid">
		<!-- BoardList -->
		<div class="panel panel-headline">
			<div class="panel-heading">
				<c:set var="registerFlag" value="${empty boardVO.no ? '등록' : '수정'}"/>
				<h3 class="panel-title"><c:out value="${registerFlag}"/></h3>
			</div>
			<div class="panel-body no-padding">
				<form:form commandName="boardVO" name="detailForm" id="detailForm" >
				<div>
					<div id="table" class="panel-body">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>NO *</th>
								<th>TITLE</th>
								<th>CONTENT</th>
								<th>WDATE</th>
							</tr>
						</thead>
						<tbody>
					   		<tr>
					   		<c:if test="${registerFlag == '수정'}">
							<td>
								<form:input path="no" cssClass="essentiality" readonly="true" />
							</td>	
							</c:if>
							<c:if test="${registerFlag == '등록'}">
					  		<td>
								<form:input path="no" cssClass="txt" readonly="false" />
							</td>			
							</c:if>
							<td>
								<form:input path="title" cssClass="txt"/>
								&nbsp;<form:errors path="title" />
							</td>
							<td>
								<form:input path="content" cssClass="txt"/>
								&nbsp;<form:errors path="content" />
							</td>	
							<td>
								<form:input path="wdate" cssClass="txt"/>
								&nbsp;<form:errors path="wdate" />
							</td>			
							</tr>
							<c:forEach var="board" items="${resultList }">
								<tr>
									<td>${board.no }</td>
									<td>${board.title }</td>
									<td>${board.content }</td>
									<td>${board.date }</td>
								</tr>
							</c:forEach>	
						</tbody>
					</table>
				  </div>
					<div id="sysbtn">
						<button class="btn btn-primary" onclick="javascript:fn_egov_selectList();">조회</button>
						<span class="btn_blue_l"><a href="javascript:fn_egov_save();"><c:out value='${registerFlag}'/></a></span>
						<button class="btn btn-success" onclick="javascript:fn_egov_save();"><c:out value='${registerFlag}'/></button>
						<c:if test="${registerFlag == '수정'}">
						<button type="button" class="btn btn-warning" onclick="javascript:fn_egov_delete();">삭제</button>
						</c:if>
						<button type="button" class="btn btn-secondary" onclick="javascript:document.detailForm.reset();">초기화</button>
					</div>
				</div>
				<!-- 검색조건 유지 -->
				<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
				<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
				</form:form>
			</div>
		</div>
	</div>
</div>

