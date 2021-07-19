<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
 .navbar-nav > li > logout {
    padding: 28px 20px;
}
 .navbar-default .brand {
    padding: 30px 10px;
    height : 50px;
}   

.navbar-nav > li > a img {
    width: 30px;
    margin-right: 2px;
} 
</style>

<!-- NAVBAR -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="brand">
				<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Klorofil Logo" class="img-responsive logo"></a>
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
								<span class="badge bg-danger">${fn:length(macLeftDate)}</span>
							</a>
							<ul class="dropdown-menu notifications">
								<c:forEach var="item" items="${macLeftDate }">
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
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="${pageContext.request.contextPath}/resources/images/maskuser.PNG" class="img-circle" alt="Avatar"> <span>${loginVO.name }</span> <i class="icon-submenu lnr lnr-chevron-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="#"><i class="lnr lnr-user"></i> <span>${loginVO.id }</span></a></li>
								<li><a href="#"><i class="lnr lnr-envelope"></i> <span>${loginVO.userSe }</span></a></li>
								<li><a href="#"><i class="lnr lnr-envelope"></i> <span>${loginVO.uniqId }</span></a></li>
							</ul>
						</li>
						<li><button type="button" id="logout" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/uat/uia/actionLogout.do'">Logout</button></li>
						
					</ul>
				</div>
			</div>
		</nav>
		
<!-- END NAVBAR -->
<script>
	$(document).ready(function(){
		$('.btn-toggle-fullwidth').on('click', function() {
			if(!$('body').hasClass('layout-fullwidth')) {
				$('body').addClass('layout-fullwidth');

			} else {
				$('body').removeClass('layout-fullwidth');
				$('body').removeClass('layout-default'); // also remove default behaviour if set
			}

			$(this).find('.lnr').toggleClass('lnr-arrow-left-circle lnr-arrow-right-circle');

			if($(window).innerWidth() < 1025) {
				if(!$('body').hasClass('offcanvas-active')) {
					$('body').addClass('offcanvas-active');
				} else {
					$('body').removeClass('offcanvas-active');
				}
			}
		});
	});
</script>