<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li>
							<a href="#subPages0" data-toggle="collapse" class="collapsed" id="memberNav"><i class="lnr lnr-file-empty"></i> <span>테스트얌</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages0" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/home.do" class="boardList">BOARD</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages1" data-toggle="collapse" class="collapsed"><i class="lnr lnr-file-empty"></i> <span>공통</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
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
							<a href="#subPages2" data-toggle="collapse" class="collapsed"><i class="lnr lnr-file-empty"></i> <span>영업</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages2" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/salInout/salesOrderView.do" class="salesOrderView">주문내역</a></li>
									<li><a href="${pageContext.request.contextPath}/salInout/salesProdView.do" class="salesProdView">완제품입출고</a></li>
									<li><a href="${pageContext.request.contextPath}/salInout/retuProdView.do" class="retuProdView">반품목록</a></li>
									<li><a href="${pageContext.request.contextPath}/salInout/matchProdView.do" class="matchProdView">재고품조정</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages3" data-toggle="collapse" class="collapsed"><i class="lnr lnr-file-empty"></i> <span>자재</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages3" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/erpMaterialOrder/ErpMaterialOrderList.do" class="">자재발주</a></li>
									<li><a href="${pageContext.request.contextPath}/matInout/matrInoutView.do" class="">자재입출고</a></li>
									<li><a href="${pageContext.request.contextPath}/matLot/matrLotForm.do" class="">자재LOT재고조정</a></li>
									<li><a href="${pageContext.request.contextPath}/matMatr/matrView.do" class="">자재재고조회</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages4" data-toggle="collapse" class="collapsed"><i class="fa fa-line-chart"></i> <span>생산</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages4" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/proPlan/prodPlanForm.do" class="">생산계획</a></li>
									<li><a href="${pageContext.request.contextPath}/proOrder/prodForm.do" class="">생산지시</a></li>
									<li><a href="#" class="">공정자재소요</a></li>
									<li><a href="#" class="">설비비가동 </a></li>
									<li><a href="#" class="">공정불량 </a></li>
									<li><a href="#" class="">모니터링 </a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages5" data-toggle="collapse" class="collapsed"><i class="lnr lnr-file-empty"></i> <span>설비</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages5" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/mac/macInfoForm.do" class="">설비정보</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages6" data-toggle="collapse" class="collapsed"><i class="lnr lnr-file-empty"></i> <span>품질</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages6" class="collapse ">
								<ul class="nav">
									<li><a href="#" class="">자재입고검사</a></li>
									<li><a href="#" class="">자재불량조회</a></li>
								</ul>
							</div>
						</li>
					</ul>
				</nav>
			</div>
		</div>
<!-- END LEFT SIDEBAR -->