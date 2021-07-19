<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/linearicons/style.css">
<style>
	
	#wrapper #sidebar-nav, #wrapper .main {
    	padding-top: 100px;
	}
	
	.nav {
		font-family: 'Do Hyeon', sans-serif;
	}
	
	@media screen and (max-width: 1024px)
	#wrapper .sidebar {
    	left: -230px;
	}
	
	#wrapper .sidebar {
		width: 230px;
	}
</style>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/scripts/klorofil-common.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
</head>
<body>
<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav" id="leftMenu">

						<%-- <li>
							<a href="#subPages1" data-toggle="collapse" class="collapsed" id="comNav"><i class="lnr lnr-magic-wand"></i> <span>공통</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages1" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/com/comCode/ComCodeList.do" class="comCodeList">공통코드관리</a></li>
									<li><a href="${pageContext.request.contextPath}/com/matrDta/MatrDtaList.do" class="matrDtaList">자재정보/안전재고관리</a></li>
									<li><a href="${pageContext.request.contextPath}/com/prodUseMatr/ProdUseMatrForm.do" class="prodUseMatrForm">제품BOM관리</a></li>
									<li><a href="${pageContext.request.contextPath}/com/prodProc/prodProcFlowForm.do" class="prodProcFlowForm">제품공정흐름관리</a></li>
									<li><a href="${pageContext.request.contextPath}/com/prodFaulty/prodFaultyForm.do" class="prodFaultyForm">제품불량내역(코드)관리</a></li>
									<li><a href="${pageContext.request.contextPath}/com/matrFaulty/matrFaultyForm.do" class="matrFaultyForm">자재불량내역(코드)관리</a></li>
								</ul>
							</div>
						</li>
						--%>
					</ul>
				</nav>
			</div>
		</div>
<!-- END LEFT SIDEBAR -->
<script>
	$(document).ready(function(){
    	 $.ajax({
    		url : "${pageContext.request.contextPath}/mes/getMenuLeft.do",
    		contentType : "application/json",
    		success : function(result){
    			console.log(result);
    			var arr = result.menuList;
    			$.each(arr, function(index, item){
    				if(item.chkURL == "dir"){
    					$("#leftMenu").append('<li><a href="#subPages' + item.menuNo + '" data-toggle="collapse" class="collapsed" id="n' 
    										+ item.menuNo + '"><i class="lnr lnr-star-half"></i><span>'
    										+item.menuNm+'</span><i class="icon-submenu lnr lnr-chevron-left"></i></a>'
    										+ '<div id="subPages' + item.menuNo + '" class="collapse ">'
    										+ '<ul class="nav" id="u' + item.menuNo + '"></ul></div></li>');
    				
    				}else{
    					$("#u"+item.upperMenuNo).append('<li><a href="${pageContext.request.contextPath}' + item.chkURL + '">' + item.menuNm +'</a></li>');
    				}
    			});
    			
    		}
    		
    	}); 
	});
	
</script>
</body>

</html>
