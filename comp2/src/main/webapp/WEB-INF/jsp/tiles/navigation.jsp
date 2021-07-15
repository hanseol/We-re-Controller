<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<style>
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
<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li>
							<a href="#subPages1" data-toggle="collapse" class="collapsed"><i class="lnr lnr-magic-wand"></i> <span>공통</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages1" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/comCode/ComCodeList.do" class="comCodeList">공통코드관리</a></li>
									<li><a href="${pageContext.request.contextPath}/matrDta/MatrDtaList.do" class="matrDtaList">자재정보/안전재고관리</a></li>
									<li><a href="${pageContext.request.contextPath}/prodUseMatr/ProdUseMatrForm.do" class="prodUseMatrForm">제품BOM관리</a></li>
									<li><a href="${pageContext.request.contextPath}/prodProc/prodProcFlowForm.do" class="prodProcFlowForm">제품공정흐름관리</a></li>
									<li><a href="#" class="">제품불량내역(코드)관리</a></li>
									<li><a href="#" class="">자재불량내역(코드)관리</a></li>
									<li><a href="#" class="">품질표준서</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages2" data-toggle="collapse" class="collapsed" id="salNav"><i class="lnr lnr-store"></i> <span>영업</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages2" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/salInout/salesOrderView.do" class="salesOrderView">주문내역</a></li>
									<li><a href="${pageContext.request.contextPath}/salInout/salesProdView.do" class="salesProdView">완제품입출고</a></li>
									<li><a href="${pageContext.request.contextPath}/salInout/retuProdView.do" class="retuProdView">반품목록</a></li>
									<li><a href="${pageContext.request.contextPath}/salMatch/matchProdView.do" class="matchProdView">재고품조정</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages3" data-toggle="collapse" class="collapsed" id="matNav"><i class="lnr lnr-pushpin"></i> <span>자재</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages3" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/matOrder/matrOrderView.do" class="matrOrder">자재발주</a></li>
									<li><a href="${pageContext.request.contextPath}/matInout/matrInoutView.do" class="matrInout">자재입출고</a></li>
									<li><a href="${pageContext.request.contextPath}/matLot/matrLotForm.do" class="matrLot">자재LOT재고조정</a></li>
									<li><a href="${pageContext.request.contextPath}/matMatr/matrView.do" class="matrView">자재재고조회</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages4" data-toggle="collapse" class="collapsed" id="proNav"><i class="fa fa-line-chart"></i> <span>생산</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages4" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/pro/plan/ProdPlanView.do" class="proProdPlan">생산계획</a></li>
									<li><a href="${pageContext.request.contextPath}/pro/order/prodView.do" class="proProdOrder">생산지시</a></li>
									<li><a href="${pageContext.request.contextPath}/pro/proc/procMatView.do" class="">공정자재소요</a></li>
									<li><a href="${pageContext.request.contextPath}/pro/proc/mntView.do" class="">모니터링 </a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages5" data-toggle="collapse" class="collapsed" id="macNav"><i class="lnr lnr-cog"></i> <span>설비</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages5" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/mac/macInfoView.do" class="macInfo">설비관리</a></li>
									<li><a href="${pageContext.request.contextPath}/mac/monitoringView.do" class="macInfo">모니터링테스트</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages6" data-toggle="collapse" class="collapsed" id="quaNav"><i class="lnr lnr-star-half"></i> <span>품질</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages6" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/quaChk/matrQuaForm.do" class="matrQua">자재입고검사</a></li>
									<li><a href="${pageContext.request.contextPath}/quaFlty/matrFaultyView.do" class="matrFaulty">자재불량조회</a></li>
								</ul>
							</div>
						</li>
					</ul>
				</nav>
			</div>
		</div>
<!-- END LEFT SIDEBAR -->