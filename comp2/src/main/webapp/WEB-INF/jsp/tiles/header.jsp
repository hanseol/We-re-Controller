<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
.navbar-default .brand {
    padding: 30px 10px;
    height : 50px;
}
</style>
<!-- NAVBAR -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="brand">
				<a href="${pageContext.request.contextPath}/home.do"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Klorofil Logo" class="img-responsive logo"></a>
			</div>
			<div class="container-fluid">
				<div class="navbar-btn">
					<button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
				</div>
				
				<div id="navbar-menu">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
								<i class="lnr lnr-alarm"></i>
								<span class="badge bg-danger">${fn:length(session.macDateResultList)}</span>
							</a>
							<ul class="dropdown-menu notifications">
								<c:forEach var="item" items="${session.macDateResultList }">
									<c:choose>
										<c:when test="${item.dday < 0}">
											<li><a href="#" class="notification-item"><span class="dot bg-danger"></span>${item.result }</a></li>
										</c:when>
										<c:when test="${item.dday > 0}">
											<li><a href="#" class="notification-item"><span class="dot bg-success"></span>${item.result }</a></li>
										</c:when>
										<c:otherwise>
											<li><a href="#" class="notification-item"><span class="dot bg-warning"></span>${item.result }</a></li>
										</c:otherwise>
										
									</c:choose>	
								</c:forEach>
							</ul>
						</li>
						<li class="dropdown" id="member">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="${pageContext.request.contextPath}/resources/images/user.png" class="img-circle" alt="Avatar"> <span>${session.erpEmployeeId }</span> <i class="icon-submenu lnr lnr-chevron-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="#"><i class="lnr lnr-user"></i> <span>${session.erpEmployeeName }</span></a></li>
								<li><a href="#"><i class="lnr lnr-envelope"></i> <span>${session.erpEmployeePosition }</span></a></li>
								<li><a href="#"><i class="lnr lnr-cog"></i> <span></span>${session.erpDepartmentName }</a></li>
							</ul>
						</li>
						<li><button type="button" class="btn btn-primary" id="logout">Logout</button></li>
						<!-- <li>
							<a class="update-pro" href="https://www.themeineed.com/downloads/klorofil-pro-bootstrap-admin-dashboard-template/?utm_source=klorofil&utm_medium=template&utm_campaign=KlorofilPro" title="Upgrade to Pro" target="_blank"><i class="fa fa-rocket"></i> <span>UPGRADE TO PRO</span></a>
						</li> -->
					</ul>
				</div>
			</div>
		</nav>
		
		<script>
			$(document).ready(function(){
				$("#logout").on("click",function(){
					location.href="logout.do";
				});
			});
		</script>
<!-- END NAVBAR -->