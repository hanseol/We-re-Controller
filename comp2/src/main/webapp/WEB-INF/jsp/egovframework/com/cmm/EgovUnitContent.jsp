<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovUnitContent.jsp
  * @Description : 로그인 성공후 컨텐츠 영역
  * @Modification Information
  * 
  * @수정일               수정자            수정내용
  *  ----------   --------   ---------------------------
  *  2020.06.23   신용호            세션만료시간 보여주기
  *
  *  @author 공통서비스 개발팀 신용호
  *  @since 2009.03.03
  *  @version 1.0
  *  @see
  *
  *  Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>eGovFrame <spring:message code="comCmm.unitContent.1"/></title>
<style type="text/css">
.pwdTitleClass .ui-widget-header
{
       background-color: #F9A7AE;
       background-image: none;
       color: Black;
}
</style>
<link type="text/css" rel="stylesheet" href="/egovframework-all-in-one/css/egovframework/com/cmm/jqueryui.css">
<script src="<c:url value='/js/egovframework/com/cmm/jquery.js' />"></script>
<script src="<c:url value='/js/egovframework/com/cmm/jqueryui.js' />"></script>
<script type="text/javascript">

	var $dialog;

    $(document).ready(function () {
	
    	// 파일검색 화면 호출 함수
    	//var page = $(this).attr("href");
        //var pagetitle = $(this).attr("title");
        var pagetitle = "<spring:message code="comCmm.unitContent.20"/>"; // 비밀번호 유효기간 만료 안내
        var page = "${pageContext.request.contextPath}/uat/uia/noticeExpirePwd.do";
        $dialog = $('<div style="overflow:hidden;padding: 0px 0px 0px 0px;"></div>')
				        .html('<iframe style="border: 0px; " src="' + page + '" width="100%" height="100%"></iframe>')
				        .dialog({
				        	autoOpen: false,
				            modal: true,
				            width: 600,
				            height: 550,
				            title: pagetitle,
				            dialogClass: 'pwdTitleClass'
				    	});
        
<c:if test="${loginVO != null}">
	if ( ${elapsedTimeExpiration} > 0 )
		$dialog.dialog('open');
</c:if>
    });
</script>
</head>
<body>
	<c:if test="${loginVO != null}">
		<jsp:forward page="/home.do"/> <!-- 20210717 김한설 -->
		
	</c:if>
	<c:if test="${loginVO == null }">
		<!-- 20210717 김한설 -->
		<jsp:forward page="/loginForm.do"/>
	</c:if>
	
</body>
</html>
