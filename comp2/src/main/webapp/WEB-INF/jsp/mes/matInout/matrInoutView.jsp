<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.my-panel {
	text-align: right;
	border-top: 1px solid gray;
	padding: 10px;
	margin-bottom: 10px;
	background-color: white;
}
</style>

<div class="content-fluid">
	<div>
		<h2>자재입출고조회</h2>
	</div>
</div>

<div class="content-fluid">
	<div>
		<div class="my-panel">
			<button type="button" class="btn btn-success">조회</button>
			<button type="button" class="btn btn-danger">새자료</button>
			<button type="button" class="btn btn-warning" id="insertRow">추가저장</button>
			<button type="button" class="btn btn-info" id="updateRow">수정저장</button>
		</div>
	</div>
</div>


<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-body">
			<div class="row">
				<div class="col-md-6">
					<form>
						* 계획일자 <input type="date" id="proPlanDate" name="proPlanDate">
					</form>
				</div>
				<div class="col-md-6">* 미생산계획</div>
			</div>
		</div>
	</div>
</div>

<div class="content-fluid">
	<div class="panel panel-headline">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-7">
					<p class="panel-subtitle">Grid 테스트</p>
					<input type="text" id="no" name="no">
				</div>
				<div class="col-md-5" align="right">
					<button type="button" id="findRow">조회</button>
					<button type="button" id="appendRow">추가</button>
					<button type="button" id="deleteRow">삭제</button>
				</div>
			</div>
			<div class="panel-body">
				<div id="grid"></div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {

		/* $(document).on("click", "button[id=appendRow]", function() {
			var rowData = [ {
				//여기 수정 해야함.
				발주일자 : "",
				발주번호 : "",
				자재코드 : "",
				자재명 : ""
			} ];
			grid.appendRow(rowData, {
				at : grid.getRowCount(),
				focus : true
			});
			grid.enable();
		}); */
		
		$(document).on("click", "button[id=insertRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('createData');
		});
		
		$(document).on("click", "button[id=deleteRow]", function() {
			grid.removeCheckedRows(false);
			grid.request('deleteData');
		});
		
		$(document).on("click", "button[id=updateRow]", function() {
			grid.finishEditing('rowKey','columnName');
			grid.request('updateData');
		});
		
		//검색데이터 전송
		$(document).on("click", "button[id=findRow]", function() {
			//데이터를 변수에 담아서 parameter로 만들기.
			var no = $("#no").val();
			console.log(no);
			var readParams = {
					'searchKeyword' : no
				};
			grid.readData(1, readParams, true);
		});
		
		const dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/mat/inout/readMatInout',
					method : 'GET'
				},
				createData : {
					url : '${pageContext.request.contextPath}/mat/inout/insertMatInout',
					method : 'POST'
				},
				deleteData : {
					url : '${pageContext.request.contextPath}/mat/inout/deleteMatInout',
					method : 'POST'
				},
				updateData : {
					url : '${pageContext.request.contextPath}/mat/inout/updateMatInout',
					method : 'PUT'
				}
			},
			contentType : "application/json"
		};

		const grid = new tui.Grid({
			el : document.getElementById('grid'),
			rowHeaders : [ 'checkbox' ],
			data : dataSource,
			columns : [ {
				header : '발주일자',
				name : 'erpMaterialOrderDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			},{
				header : '발주번호',
				name : 'erpMaterialOrderCode',
				editor : 'text'
			}, {
				header : '자재코드',
				name : 'comMaterialCode',
				editor : 'text'
			}, {
				header : '자재명',
				name : 'comMaterialName',
				editor : 'text'
			}, {
				header : '입고일자',
				name : 'matInoutDate',
				editor : {
					type : 'datePicker',
					options : {
						format : 'YYYY/MM/dd',
						language: 'ko'
					} 
				}
			}, {
				header : '발주량',
				name : 'erpMaterialOrderQty',
				editor : 'text'
			}, {
				header : '거래처명',
				name : 'erpVendorCode',
				editor : 'text'
			}, {
				header : '자재LOT_NO',
				name : 'matLotNo',
				editor : 'text'
			}, {
				header : '입고량',
				name : 'matInoutQuantity',
				editor : 'text'
			}
			]
		});
	
/* 	grid.on('response', ev => {
		  const {response} = ev.xhr;
		  const responseObj = JSON.parse(response);

		  console.log('result : ', responseObj.result);
		  console.log('data : ', responseObj.data);
		});
	
	grid.on('check', (ev) => {
		  alert(`check: ${ev.rowKey}`);
	}); */
	
}); //end of document ready
</script>
<%-- <body>
	<div>
		<main>
			<div>
				<h2>자재입출고조회</h2>
				<!-- 검색(Master) -->
				<form id="masterForm" name="masterForm" method="post">
					<table class="table table-bbs table-write" summary="">
						<caption></caption>
						<colgroup>
							<col width="8%">
							<col width="19%">
							<col width="8%">
							<col width="65%">
						</colgroup>
						<tbody>
							<tr>
								<th>해당일자 <strong class="blue">*</strong></th>
								<td colspan="3">
									<div
										class="tui-datepicker-input tui-datetime-input tui-has-focus"
										style="width: 140px;">
										<input type="text" id="dDate" name="dDate"
											aria-label="Date-Time" tabindex="1"
											onkeyup="javascript:tab(this, event);"> <span
											class="tui-ico-date"></span>
									</div>
									<div id="dDate-wrapper" style="margin-top: -1px;">
										<div class="tui-datepicker" style="display: none;">
											<div class="tui-datepicker-body tui-datepicker-type-date">
												<div class="tui-calendar">
													<div class="tui-calendar-header">
														<div class="tui-calendar-header-inner">
															<a href="#" class="tui-calendar-btn-prev-month">Prev
																month</a> <em
																class="tui-calendar-title tui-calendar-title-month">2021.06</em>
															<a href="#" class="tui-calendar-btn-next-month">Next
																month</a>
														</div>

														<div class="tui-calendar-header-info">
															<p class="tui-calendar-title-today">오늘: 2021.06.28
																(월)</p>
														</div>
													</div>
													<div class="tui-calendar-body">
														<table class="tui-calendar-body-inner" cellspacing="0"
															cellpadding="0">
															<caption>
																<span>Dates</span>
															</caption>
															<thead class="tui-calendar-body-header">
																<tr>
																	<th class="tui-sun" scope="col">일</th>
																	<th scope="col">월</th>
																	<th scope="col">화</th>
																	<th scope="col">수</th>
																	<th scope="col">목</th>
																	<th scope="col">금</th>
																	<th class="tui-sat" scope="col">토</th>
																</tr>
															</thead>
															<tbody>
																<tr class="tui-calendar-week">
																	<td
																		class="tui-calendar-date tui-calendar-prev-month tui-calendar-sun tui-is-selectable"
																		data-timestamp="1622300400000">30</td>
																	<td
																		class="tui-calendar-date tui-calendar-prev-month tui-is-selectable"
																		data-timestamp="1622386800000">31</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1622473200000">1</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1622559600000">2</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1622646000000">3</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1622732400000">4</td>
																	<td
																		class="tui-calendar-date tui-calendar-sat tui-is-selectable"
																		data-timestamp="1622818800000">5</td>
																</tr>
																<tr class="tui-calendar-week">
																	<td
																		class="tui-calendar-date tui-calendar-sun tui-is-selectable"
																		data-timestamp="1622905200000">6</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1622991600000">7</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1623078000000">8</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1623164400000">9</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1623250800000">10</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1623337200000">11</td>
																	<td
																		class="tui-calendar-date tui-calendar-sat tui-is-selectable"
																		data-timestamp="1623423600000">12</td>
																</tr>
																<tr class="tui-calendar-week">
																	<td
																		class="tui-calendar-date tui-calendar-sun tui-is-selectable"
																		data-timestamp="1623510000000">13</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1623596400000">14</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1623682800000">15</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1623769200000">16</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1623855600000">17</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1623942000000">18</td>
																	<td
																		class="tui-calendar-date tui-calendar-sat tui-is-selectable"
																		data-timestamp="1624028400000">19</td>
																</tr>
																<tr class="tui-calendar-week">
																	<td
																		class="tui-calendar-date tui-calendar-sun tui-is-selectable"
																		data-timestamp="1624114800000">20</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1624201200000">21</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1624287600000">22</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1624374000000">23</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1624460400000">24</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1624546800000">25</td>
																	<td
																		class="tui-calendar-date tui-calendar-sat tui-is-selectable"
																		data-timestamp="1624633200000">26</td>
																</tr>
																<tr class="tui-calendar-week">
																	<td
																		class="tui-calendar-date tui-calendar-sun tui-is-selectable"
																		data-timestamp="1624719600000">27</td>
																	<td
																		class="tui-calendar-date tui-calendar-today tui-is-selectable tui-is-selected"
																		data-timestamp="1624806000000">28</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1624892400000">29</td>
																	<td class="tui-calendar-date tui-is-selectable"
																		data-timestamp="1624978800000">30</td>
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-is-selectable"
																		data-timestamp="1625065200000">1</td>
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-is-selectable"
																		data-timestamp="1625151600000">2</td>
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-calendar-sat tui-is-selectable"
																		data-timestamp="1625238000000">3</td>
																</tr>
																<tr class="tui-calendar-week">
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-calendar-sun tui-is-selectable"
																		data-timestamp="1625324400000">4</td>
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-is-selectable"
																		data-timestamp="1625410800000">5</td>
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-is-selectable"
																		data-timestamp="1625497200000">6</td>
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-is-selectable"
																		data-timestamp="1625583600000">7</td>
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-is-selectable"
																		data-timestamp="1625670000000">8</td>
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-is-selectable"
																		data-timestamp="1625756400000">9</td>
																	<td
																		class="tui-calendar-date tui-calendar-next-month tui-calendar-sat tui-is-selectable"
																		data-timestamp="1625842800000">10</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
									</div> <input id="date" name="date" type="hidden">
								</td>
							</tr>
							<tr>
								<th>자료구분 <strong class="blue">*</strong></th>
								<td>
									<div class="form-group border">
										<label class="ml-1" for="radio-4">
										<input
											class="form-radio-input-small" type="radio" name="dDiv"
											value="4" id="radio-4" style="margin: 1px 5px; opacity: 3;"
											checked="" tabindex="2"
											onkeyup="javascript:tab(this, event);"> <span
											style="margin: 3px 30px;">출고</span>
										</label>
										<label for="radio-5"> <input
											class="form-radio-input-small" type="radio" name="dDiv"
											value="5" id="radio-5" style="margin: 1px 5px; opacity: 6;"
											tabindex="3" onkeyup="javascript:tab(this, event);">
											<span style="margin: 3px 30px;">반품</span>
										</label>
									</div>
								</td>
								<th>출고경로 <strong class="blue">*</strong></th>
								<td>
									<div class="form-group border">
										<label for="radio-1"> <input
											class="form-radio-input-small" type="radio" name="dOutDiv"
											value="1" id="radio-1" style="margin: 1px 5px; opacity: 1;"
											checked="" tabindex="4"
											onkeyup="javascript:tab(this, event);"> <span
											style="margin: 3px 30px;">공정</span>
										</label> <label for="radio-2"> <input
											class="form-radio-input-small" type="radio" name="dOutDiv"
											value="2" id="radio-2" style="margin: 1px 5px; opacity: 2;"
											tabindex="5" onkeyup="javascript:tab(this, event);">
											<span style="margin: 3px 30px;">부서</span>
										</label> <label for="radio-3"> <input
											class="form-radio-input-small" type="radio" name="dOutDiv"
											value="3" id="radio-3" style="margin: 1px 5px; opacity: 3;"
											tabindex="6" onkeyup="javascript:tab(this, event);">
											<span style="margin: 3px 30px;">협력사</span>
										</label>
									</div>
								</td>
							</tr>
							<tr id="procsTr">
								<th>출고공정 <strong class="blue">*</strong></th>
								<td data-input="search" data-fn-name="fnEntrpsSearchView()"
									inputmode="search"><input id="procsCd" name="procsCd"
									type="text" autocomplete="new-password" title="출고공정"
									class="form-control w120" data-origin="" tabindex="7"
									onkeyup="javascript:tab(this, event);">
									<button type="button" id="proscPopBtn"
										class="btn btn-find-small">찾아보기</button></td>
								<th>공정명</th>
								<td><input id="procsNm" name="procsNm" type="text"
									readonly="readonly" class="form-control" style="width: 350px;">
								</td>
							</tr>
							<tr id="deptTr" style="display: none;">
								<th>출고부서 <strong class="blue">*</strong></th>
								<td data-input="search" data-fn-name="fnEntrpsSearchView()"
									inputmode="search"><input id="deptCd" name="deptCd"
									type="text" autocomplete="new-password" title="출고부서"
									class="form-control w120" data-origin="" tabindex="8"
									onkeyup="javascript:tab(this, event);">
									<button type="button" id="deptPopBtn"
										class="btn btn-find-small">찾아보기</button></td>
								<th>부서명</th>
								<td><input id="deptNm" name="deptNm" type="text"
									readonly="readonly" class="form-control" style="width: 350px;">
								</td>
							</tr>
							<tr id="companyTr" style="display: none;">
								<th>출고업체 <strong class="blue">*</strong></th>
								<td data-input="search" data-fn-name="fnEntrpsSearchView()"
									inputmode="search"><input id="dCompany" name="dCompany"
									type="text" autocomplete="new-password" title="출고업체"
									class="form-control w120" data-origin="" tabindex="9"
									onkeyup="javascript:tab(this, event);">
									<button type="button" id="entrpsPopBtn"
										class="btn btn-find-small">찾아보기</button></td>
								<th>업체명</th>
								<td><input id="dCompanyNm" name="dCompanyNm" type="text"
									title="업체명" readonly="readonly" class="form-control"
									style="width: 350px;">
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<form id="detailForm" name="detailForm" method="post" action="">
					<div>
						<table class="dataTable" border="1" align="center">
							<thead>
								<tr>
									<th>일자</th>
									<th>자재코드</th>
									<th>입출고</th>
									<th>수량</th>
									<th>자재LOT_NO</th>
									<th>공정코드</th>
									<th>단가</th>
									<th>금액</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="inout">
									<tr>
<<<<<<< HEAD
										<td>${inout.matrVO.comMaterialCode }</td>
										<td>${inout.matrVO.comMaterialName }</td>
										<td>${inout.matrVO.comMaterialSize }</td>
										<td>${inout.matrVO.comMaterialUnit }</td>
										<td>${inout.orderVO.erpMaterialOrderCode }</td>
										<td>${inout.matInoutVO.matInoutQuantity }</td>
										<td>${inout.matInoutVO.matInoutUnitPrice }</td>
										<td>${inout.matInoutVO.matInoutPrice }</td>
										<td>${inout.matInoutVO.matLotNo }</td>
										<td>현재고는 계산</td>
=======
										<td>${inout.erp_material_order_date }</td>
										<td>${inout.erp_material_order_code }</td>
										<td>${inout.com_material_code }</td>
										<td>${inout.com_material_name }</td>
										<td>${inout.mat_inout_date }</td>
										<td>${inout.erp_material_order_qty }</td>
										<td>${inout.erp_vendor_code }</td>
										<td>${inout.mat_lot_no }</td>
										<td>${inout.mat_inout_quantity }</td>
>>>>>>> branch 'master' of https://github.com/hanseol/We-re-Controller.git
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</form>
			</div>
		</main>
	</div>
</body>
</html> --%>