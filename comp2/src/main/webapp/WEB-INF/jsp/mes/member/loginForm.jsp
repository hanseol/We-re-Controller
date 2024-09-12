<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html class="fullscreen-bg">
<head>
	<title>Login | We're Controller - MES SYSTEM</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta name="description" content="">
	<meta name="author" content="">

	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/linearicons/style.css">
	<!-- MAIN CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
	<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/demo.css">
	<!-- GOOGLE FONTS -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
	<!-- ICONS -->
	<link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/resources/images/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/resources/images/favicon.png">
   
	<!-- JavaScript -->
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/scripts/klorofil-common.js"></script>
<script>
function actionLogin() {
	if (document.loginForm.id.value =="") {
        alert("<spring:message code="comUatUia.validate.idCheck" />"); <%-- 아이디를 입력하세요 --%>
    } else if (document.loginForm.password.value =="") {
        alert("<spring:message code="comUatUia.validate.passCheck" />"); <%-- 비밀번호를 입력하세요 --%>
    } else {
        document.loginForm.action="<c:url value='/uat/uia/actionLogin.do'/>";
        document.loginForm.submit();
    }
}
</script>
</head>

<body>
	<!-- WRAPPER -->
	<div id="wrapper">
		<div class="vertical-align-wrap">
			<div class="vertical-align-middle">
				<div class="auth-box ">
					<div class="left">
						<div class="content">
							<!-- 로그인폼 -->
							<form class="form-auth-small" name="loginForm" id="loginForm" method="post">
							<!-- 메시지-->
							<input type="hidden" id="message" name="message" value="<c:out value='${message}'/>">
							<div>
								<p>${loginMessage }</p>
							</div>
							<fieldset>
								<div class="header">
									<div class="logo text-center"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Klorofil Logo"></div>
									<p class="lead">Login to your account</p>
								</div>
								
								<div class="login_input">
									<!-- 아이디 -->
									<div class="form-group">
										<c:set var="title"><spring:message code="comUatUia.loginForm.id"/></c:set>
										<label for="id" class="control-label sr-only">${title}</label>
										<input type="text" class="form-control" name="id" id="id" maxlength="20" title="${title} ${inputTxt}" placeholder="${title} ${inputTxt}">
									</div>
									<!-- 비밀번호 -->
									<div class="form-group">
										<c:set var="title"><spring:message code="comUatUia.loginForm.pw"/></c:set>
										<label for="password" class="control-label sr-only">${title}</label>
										<input type="password" class="form-control" id="password" name="password" maxlength="20" title="${title} ${inputTxt}" placeholder="${title} ${inputTxt}">
									</div>
									<!-- 로그인 -->
									<div>
										<input type="button" class="btn_login btn btn-primary btn-lg btn-block" value="<spring:message code="comUatUia.loginForm.login"/>" onclick="actionLogin()"> 
									</div>
								</div>
							</fieldset>
								<input name="userSe" type="hidden" value="USR"/> <!-- USR: 업무사용자 -->
								<input name="j_username" type="hidden"/>
							</form>
						</div>
					</div>
					<div class="right">
						<div class="overlay"></div>
						<div class="content text">
							<h1 class="heading">MES SYSTEM</h1>
							<p>by We're Controller </p>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- END WRAPPER -->
</body>
</html>
