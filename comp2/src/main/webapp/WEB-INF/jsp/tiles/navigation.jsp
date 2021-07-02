<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<nav>
					<ul class="nav">
						<li>
							<a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-file-empty"></i> <span>공통</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/comCode/ComCodeList.do" class="">공통코드관리</a></li>
									<li><a href="#" class="">자재정보/안전재고관리</a></li>
									<li><a href="#" class="">제품BOM관리</a></li>
									<li><a href="#" class="">제품공정흐름관리</a></li>
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
									<li><a href="${pageContext.request.contextPath}/salInout/salesOrderView.do" class="">주문내역</a></li>
									<li><a href="${pageContext.request.contextPath}/salInout/salesProdView.do" class="">완제품입출고</a></li>
									<li><a href="${pageContext.request.contextPath}/salInout/retuProdView.do" class="">반품목록</a></li>
									<li><a href="${pageContext.request.contextPath}/salInout/matchProdView.do" class="">재고품조정</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages3" data-toggle="collapse" class="collapsed"><i class="lnr lnr-file-empty"></i> <span>자재</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages3" class="collapse ">
								<ul class="nav">
									<li><a href="${pageContext.request.contextPath}/erpMaterialOrder/ErpMaterialOrderList.do" class="">자재발주</a></li>
									<li><a href="#" class="">자재입출고</a></li>
									<li><a href="#" class="">자재LOT재고</a></li>
									<li><a href="#" class="">자재재고</a></li>
								</ul>
							</div>
						</li>
						<li>
							<a href="#subPages4" data-toggle="collapse" class="collapsed"><i class="fa fa-line-chart"></i> <span>생산</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages4" class="collapse ">
								<ul class="nav">
									<li><a href="#" class="">생산계획</a></li>
									<li><a href="${pageContext.request.contextPath}/proOrder/addProOrderView.do" class="">생산지시</a></li>
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
									<li><a href="#" class="">설비정보</a></li>
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

						<li><a href="tables.html" class=""><i class="lnr lnr-dice"></i> <span>관리자</span></a></li>
						<!-- <li><a href="typography.html" class=""><i class="lnr lnr-text-format"></i> <span>Typography</span></a></li>
						<li><a href="icons.html" class=""><i class="lnr lnr-linearicons"></i> <span>Icons</span></a></li> -->
					</ul>
				</nav>
			</div>
		</div>
<!-- END LEFT SIDEBAR -->