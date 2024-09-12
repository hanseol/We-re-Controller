<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta name="description" content="">
	<meta name="author" content="">

	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/linearicons/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/chartist/css/chartist-custom.css">
	<!-- MAIN CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
	<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/demo.css">
	<!-- GOOGLE FONTS -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
	<!-- ICONS -->
	<link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/resources/images/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/resources/images/favicon.png">
	
	<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
	<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
	<!-- JQuery Modal -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
   
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@700&display=swap" rel="stylesheet">
   
   
   
   
	<!-- JavaScript -->
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/chartist/js/chartist.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/scripts/klorofil-common.js"></script>
	<!-- ToastUi Grid -->
	<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
	<!-- jQuery Modal -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
	
	<style>
	
	/*
	탭 글씨 크기 조정
	*/
	.nav-tabs>li>a{
		cursor : pointer;
		font-size: 20px;
	}
	
	/*
	input 태그 속성
	*/
	.form-control{
		display: inline;
		font-size:17px; 
		width: 200px;
	}
	
	
	/*
	오른쪽 정렬
	*/
	.my-panel {
		text-align: right;
		padding: 10px;
		margin-bottom: 10px;
		background-color: white;
	}
	
	/*
	모달
	*/
	
	.modal {
		-webkit-border-radius: 0px;
		border-radius: 0px;
		overflow: visible;
		text-align: center;
		max-width: 900px;
		width: 900px;
	}
	
	.blocker {
		z-index: 1200;
	}
	
	/*
	header.jsp
	*/
	
	#navbar-menu #member{
		width: 200px;
		font-size :20px;
		text-align : center;
	}

	#logout {
		margin-top: 24px;
	}
	
	/*제목 폰트*/
	h1, h2, h3 {
		font-family: 'Do Hyeon', sans-serif;
		color : black;
	}
	
	.sidebar .nav span {
	    font-size: 17px;
	}
	
	div {
		font-family: 'Nanum Gothic Coding', monospace;
	}
</style>
</head>
<body> 
	<!-- WRAPPER -->
	<div id="wrapper">
		<tiles:insertAttribute name="header" />
		<tiles:insertAttribute name="navigation" />
		<div class="main">
			<div class="main-content">
			<tiles:insertAttribute name="body" />
			</div>
		</div>
		<div class="clearfix"></div>
		<tiles:insertAttribute name="footer" />
	</div>
	<!-- END WRAPPER -->
	
</body>

<script>

//그리드 테마 (2021-07-24 주성원 )
tui.Grid.applyTheme('default', 
   {   //행 기본색.
      row: {
             hover: {  //마우스를 올렸을 때 배경색
                background: "#cedeff"
             }
      },
      //셀 기본색.
      cell: {
         //전체적인 색
         normal: {
            border: "white", //전체 그리드의 테두리색(내부 경계선 포함).
            text: "black"
         },
         //헤더 색
         header: { //기본 헤더 배경색
            background: "#e0e0e0"
         },
         
         selectedHeader:{ //드래그 했을 때 헤더 배경색.
            background: "#e0e0e0"
         },
         //행 헤더 색
         rowHeader:{ // 행 헤더의 체크박스 부분 배경색.
            background: "white" 
         },
         //필수항목 셀
         required: { //필수항목 지정한 셀의 배경색
            background: "#fffaca"  
         },
         
         //클릭한 셀
         focused: {
            border: "#ffb8b8"  //클릭한 셀 테두리색.
         },
         
         
      },
      //드래그 셀 기본색
      selection: {
         background: "gray",  //드래그한 범위만큼의 셀 배경색(참고로 입력한 색에 투명도 더 입혀지는듯.)
         border: "black"  //드래그한 범위만큼의 테두리 색.
      }
 
});

//그리드 한글 설정
tui.Grid.setLanguage('ko');

</script>
</html>