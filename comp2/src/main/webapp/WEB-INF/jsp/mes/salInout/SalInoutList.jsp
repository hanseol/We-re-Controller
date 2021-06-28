<html lang="ko">
<head>
<title>주문관리참조 조회</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<meta name="format-detection" content="telephone=no">

<link rel="stylesheet" type="text/css" href="/nxn/css/normal2.css">
<link rel="stylesheet" type="text/css" href="/nxn/css/style2.css">
<link rel="stylesheet" type="text/css" href="/nxn/css/layout2.css">
<link rel="stylesheet" type="text/css" href="/nxn/css/logoset.css">

<script type="text/javascript" src="/tui/babel.min.js"></script>
<script type="text/javascript" src="/tui/jquery.js"></script>

<!-- dev area start -->


<!-- comm -->

<script type="text/javaScript" src="/js/comm/json.min.js"></script>

<script type="text/javascript" src="/js/comm/jquery.form.js"></script>


<script type="text/javascript" src="/tui/tui-code-snippet.js"></script>


<link rel="stylesheet" type="text/css" href="/toastr/toastr.min.css">
<script type="text/javascript" src="/toastr/toastr.min.js"></script>

<script type="text/javascript" src="/nxn/js/nxnComm.js"></script>

<script type="text/javaScript" src="/js/comm/moment.js"></script>
<style type="text/css">
.cell_blue>div {
	color: blue;
}

.cell_bold>div {
	font-weight: bold;
}
</style>


<script type="text/javascript">
jQuery.fn.serializeObject = function() {
    var obj = {};
    var arr = this.serializeArray();
    arr.forEach(function(item, index) {
        if (obj[item.name] === undefined) { // New
            obj[item.name] = item.value || '';
        } else {                            // Existing
            if (!obj[item.name].push) {
                obj[item.name] = [obj[item.name]];
            }
            obj[item.name].push(item.value || '');
        }
    });
    return obj;
};

//
/**
 * option success, info, warning, error
 * toastr.info......
 */
toastr.options = {
        closeButton: true,
        progressBar: true,
        showMethod: 'slideDown',
        timeOut: 1000,
        positionClass : "toast-top-center",
    };

</script>
<link rel="stylesheet" type="text/css" href="/css/comm/jquery.toast.css">
<script type="text/javascript" src="/js/comm/jquery.toast.js"></script>


<script type="text/javascript">

var cUrl = '';

</script>


<style type="text/css" id="tui-grid-theme-style">
.tui-grid-border-line-top {
	border-top: 1px solid #aaa
}

.tui-grid-no-scroll-x .tui-grid-border-line-bottom {
	border-bottom: 1px solid #aaa
}

.tui-grid-frozen-border {
	background-color: #aaa
}

.tui-grid-container ::-webkit-scrollbar {
	background-color: #fff
}

.tui-grid-container ::-webkit-scrollbar-thumb {
	background-color: #ddd
}

.tui-grid-container ::-webkit-scrollbar-thumb:hover {
	background-color: #ddd
}

.tui-grid-container {
	scrollbar-3dlight-color: #fff;
	scrollbar-darkshadow-color: #fff;
	scrollbar-track-color: #fff;
	scrollbar-shadow-color: #fff;
	scrollbar-face-color: #ddd;
	scrollbar-highlight-color: #ddd;
	scrollbar-arrow-color: #ddd
}

.tui-grid-border-line-bottom {
	border-bottom: 1px solid #eee
}

.tui-grid-content-area {
	border-color: #eee
}

.tui-grid-scrollbar-y-inner-border {
	background-color: #eee
}

.tui-grid-scrollbar-y-outer-border {
	background-color: #eee
}

.tui-grid-scrollbar-right-top {
	background-color: #f9f9f9;
	border-color: #eee
}

.tui-grid-scrollbar-right-bottom {
	background-color: #f9f9f9;
	border-color: #eee
}

.tui-grid-scrollbar-left-bottom {
	background-color: #f9f9f9;
	border-color: #eee
}

.tui-grid-scrollbar-frozen-border {
	background-color: #f9f9f9;
	border-color: #eee
}

.tui-grid-height-resize-handle {
	background-color: #fff;
	border-color: #fff
}

.tui-grid-pagination {
	background-color: transparent;
	border-color: transparent
}

.tui-grid-layer-selection {
	background-color: #00A9ff;
	border-color: #00a9ff
}

.tui-grid-header-area {
	background-color: #fff;
	border-color: #ccc
}

.tui-grid-body-area {
	background-color: #fff
}

.tui-grid-summary-area {
	background-color: #fff;
	border-color: #eee
}

.tui-grid-has-summary-top .tui-grid-body-area {
	border-color: #eee
}

.tui-grid-cell {
	background-color: #f4f4f4;
	border-color: #eee;
	border-left-width: 0;
	border-right-width: 0;
	border-top-width: 1px;
	border-bottom-width: 1px;
	color: #333
}

.tui-grid-cell-editable {
	background-color: #fff
}

.tui-grid-show-lside-area .tui-grid-lside-area .tui-grid-header-area .tui-grid-table
	{
	border-right-style: solid
}

.tui-grid-cell-header {
	background-color: #fff;
	border-color: #eee;
	border-left-width: 1px;
	border-right-width: 1px;
	border-top-width: 1px;
	border-bottom-width: 1px;
	color: #222
}

.tui-grid-show-lside-area .tui-grid-lside-area .tui-grid-body-area .tui-grid-table
	{
	border-right-style: hidden
}

.tui-grid-cell-row-header {
	background-color: #fff;
	border-color: #eee;
	border-left-width: 0;
	border-right-width: 0;
	border-top-width: 1px;
	border-bottom-width: 1px;
	color: #333
}

.tui-grid-show-lside-area .tui-grid-lside-area .tui-grid-summary-area .tui-grid-table
	{
	border-right-style: hidden
}

.tui-grid-cell-summary {
	background-color: #fff;
	border-color: #eee;
	border-left-width: 0;
	border-right-width: 0;
	color: #333
}

.tui-grid-cell-required {
	background-color: #fffdeb
}

.tui-grid-cell-disabled {
	background-color: #e0dede;
	color: #858585
}

.tui-grid-cell-invalid.tui-grid-cell {
	background-color: #ffe5e5
}

.tui-grid-cell-header.tui-grid-cell-selected {
	background-color: #e5f6ff
}

.tui-grid-cell-row-header.tui-grid-cell-selected {
	background-color: #e5f6ff
}

.tui-grid-layer-focus-border {
	background-color: #00a9ff
}

.tui-grid-layer-editing {
	border-color: #00a9ff
}

.tui-grid-layer-focus-deactive .tui-grid-layer-focus-border {
	background-color: #aaa
}

.tui-grid-cell-dummy {
	background-color: #fff
}
</style>
</head>

<body class="desktop" style="">
	<div class="wrap">


<!-- 헤더부분 -->
		<script type="text/javascript">
    $(document).on( 'click', '#logoutBtn' , function() {
    	//window.location.href = '/man/login/logout.do';
        sessionStorage.clear();
    	window.location.href = '/uat/uia/actionLogout.do';
        self.close();
    });
</script>

		<form id="leftMenuForm" name="leftMenuForm"
			action="/man/main/movePage.do" method="post">
			<input type="hidden" name="layoutMenuId"> <input
				type="hidden" name="seq">
		</form>
		<form id="srLinkForm" name="srLinkForm" method="post">
			<input type="hidden" id="SrLinkUserId" name="SrLinkUserId" value="">
			<input id="authorCode" name="authorCode" type="hidden" size="30"
				maxlength="30" title="권한코드" value="ROLE_ADMIN" readonly="readonly">
		</form>

		<!-- header -->
		<header class="header">
			<div class="btn-snb-toggle-wrap">
				<button type="button" class="btn-snb-toggle open"
					style="display: block;" onclick="myFunction()">왼쪽메뉴 접기</button>
			</div>
			<div class="util-present">
				<div>
					<a href="#" class="user"> <strong>(20200001)관리자</strong>
					</a>
				</div>
				<div>
					<a href="#" class="icon logout" id="logoutBtn">로그아웃</a>
				</div>
			</div>
		</header>
		<script type="text/javascript">

var user = {
		id : 'admin',
		name : '관리자',
		emplNo : '20200001',
};

var menuAutoHide = false;

$(function() {
	var cw = document.body.clientWidth;
    if ( cw < 1730 ) {
    	menuAutoHide = true;
    }	
});


/*
// 화면 왼쪽에 마우스올리면 메뉴창 뜨고 마우스 떄면 사라지는 기능
 $(document).on('mouseover', '.btn-snb-toggle-wrap', function() {
	if ( menuAutoHide == true ) {
	    	$('.lnb-wrap').css('display','block');
	}
}); 


$(document).on('mouseleave', '.lnb-wrap', function() {
    if ( menuAutoHide == true ) {
    	$('.lnb-wrap').css('display','NONE');
    }

}); 
*/

 
window.focus();

themesOptions = { 
            selection: {    background: 'blue',     border: '#004082'  },
            scrollbar: {    background: '#f5f5f5',  thumb: '#d9d9d9',  active: '#c1c1c1'    },
            row: {    
                hover: {    background: '#ccc'  }
            },
            cell: {  
                normal: {   background: '#fbfbfb',  border: '#e0e0e0',  showVerticalBorder: true    },
                header: {   background: '#eee',     border: '#ccc',     showVerticalBorder: true    },
                rowHeader: {    border: '#eee',     showVerticalBorder: true    }, 
                editable: { background: '#fbfbfb' },
                selectedHeader: { background: '#eee' }, 
                disabled: { text: '#b0b0b0' }
            }
};
        

 
</script>

		<div class="container">



			<!-- <div class="btn-snb-toggle-wrap" > -->
			<div class="lnb-wrap" style="z-index: 99;">
				<button type="button" style="display: block;"
					class="btn-snb-toggle close" onclick="myFunction()">왼쪽메뉴
					접기</button>
				<div class="logowrap">
					<!-- <a href="#" onclick='javascript:goMainpage();' ></a> -->
					<h1 style="color: white; text-align: center;">천마 HI-TECH</h1>
				</div>
				<!--left menu -->
				<div class="snb-wrap">
					<ul class="snb" style="height: 750px;">

						<li data-menu_no="1000000" data-chk_url=""><a href="#"
							class="hasChild" data-menu_no="1000000"
							onclick="javascript:goMenuPageEx( this,'1000000')">기준정보관리</a></li>

						<li data-menu_no="2000000" data-chk_url=""><a href="#"
							class="hasChild on" data-menu_no="2000000"
							onclick="javascript:goMenuPageEx( this,'2000000')">영업관리</a>
							<ul class="active">
								<li data-menu_no="2010000"
									data-chk_url="/bsn/order/CstMrOrder.do"><a href="#"
									onclick="javascript:goMenuPage('2010000')"
									data-menu_no="2010000" class="current">주문관리참조 조회</a></li>
								<li data-menu_no="2020000"
									data-chk_url="/prdctn/unproduced/UnproducedList.do"><a
									href="#" onclick="javascript:goMenuPage('2020000')"
									data-menu_no="2020000">미생산 의뢰 조회</a></li>
								<li data-menu_no="2030000"
									data-chk_url="/bsn/shipmnt/PrductShipmnt.do"><a href="#"
									onclick="javascript:goMenuPage('2030000')"
									data-menu_no="2030000">출고 관리</a></li>
								<li data-menu_no="2040000"
									data-chk_url="/bsn/report/PrdctnDlivySttus.do"><a href="#"
									onclick="javascript:goMenuPage('2040000')"
									data-menu_no="2040000">출고 조회</a></li>
								<li data-menu_no="2050000"
									data-chk_url="/bsn/shipmnt/PrductRtngud.do"><a href="#"
									onclick="javascript:goMenuPage('2050000')"
									data-menu_no="2050000">반품 관리</a></li>
								<li data-menu_no="2060000"
									data-chk_url="/bsn/prductRtngudSttus/prductRtngudSttus.do"><a
									href="#" onclick="javascript:goMenuPage('2060000')"
									data-menu_no="2060000">반품 조회</a></li>
								<li data-menu_no="2070000"
									data-chk_url="/prduct/prductInvnExcclc.do"><a href="#"
									onclick="javascript:goMenuPage('2070000')"
									data-menu_no="2070000">제품 재고 조정 관리</a></li>
								<li data-menu_no="2080000"
									data-chk_url="/prduct/prductInvnExcclcSttus.do"><a
									href="#" onclick="javascript:goMenuPage('2080000')"
									data-menu_no="2080000">제품 재고 조정 조회</a></li>
								<li data-menu_no="2090000"
									data-chk_url="/bsn/report/PeriodDlivySttus.do"><a href="#"
									onclick="javascript:goMenuPage('2090000')"
									data-menu_no="2090000">기간출고 조회</a></li>
							</ul></li>

						<li data-menu_no="3000000" data-chk_url=""><a href="#"
							class="hasChild" data-menu_no="3000000"
							onclick="javascript:goMenuPageEx( this,'3000000')">자재관리</a></li>

						<li data-menu_no="4000000" data-chk_url=""><a href="#"
							class="hasChild" data-menu_no="4000000"
							onclick="javascript:goMenuPageEx( this,'4000000')">생산관리</a></li>

						<li data-menu_no="5000000" data-chk_url=""><a href="#"
							class="hasChild" data-menu_no="5000000"
							onclick="javascript:goMenuPageEx( this,'5000000')">품질관리</a></li>

						<li data-menu_no="6000000" data-chk_url=""><a href="#"
							class="hasChild" data-menu_no="6000000"
							onclick="javascript:goMenuPageEx( this,'6000000')">설비관리</a></li>

						<li data-menu_no="7000000" data-chk_url=""><a href="#"
							class="hasChild" data-menu_no="7000000"
							onclick="javascript:goMenuPageEx( this,'7000000')">성과관리</a></li>

						<li data-menu_no="8000000" data-chk_url=""><a href="#"
							class="hasChild" data-menu_no="8000000"
							onclick="javascript:goMenuPageEx( this,'8000000')">내부서비스관리</a></li>

						<li data-menu_no="10000000" data-chk_url=""><a href="#"
							class="hasChild" data-menu_no="10000000"
							onclick="javascript:goMenuPageEx( this,'10000000')">관리자</a></li>

						<li data-menu_no="9000000" data-chk_url=""><a href="#"
							class="hasChild" data-menu_no="9000000"
							onclick="javascript:goMenuPageEx( this,'9000000')">내부시스템관리</a></li>



					</ul>
				</div>
				<!--//left menu -->
			</div>
			<!-- </div>  -->
			<form name="menuListForm" action="" method="post">
				<input type="hidden" id="baseMenuNo" name="baseMenuNo"
					value="2010000"> <input type="hidden" id="link" name="link"
					value="">
			</form>

			<script type="text/javascript">

var selectedMenuNo = '2010000';

var menuHierarchey = [ 
	
	   2010000,
	
	   2000000,
	
];

var menuR = menuHierarchey.reverse();

var companyName = '';

$(function(){
    $('.snb > li:not(:has(ul))').mouseover(function(event){
        if($(this).children("ul").length <= 0){
            getSubData($(this)); // 현재 객체를 전달해 나중에 그 객체 하위에 추가를 해야지
            return;
        }
    });	
    

    fnMenuOpen();

    var cw = document.body.clientWidth;
    if ( cw < 1730 ) {
    	$('.lnb-wrap').hide();
    } else {
    	$('.lnb-wrap').show();
    }
    
    if( typeof titleFix == "undefined" ){
	    companyName = '천마하이테크'; 
	    var title = $('.snb-wrap a.current').text()
	    
    } else var title = titleFix; 
	$(document).attr("title", title ); 
    //$(document).attr("title",companyName + "-" + title ); 

});

function goMainpage() {
    location.href='/uat/uia/actionMain.do';
} 

function goPage( url ) {
    location.href = url;
}


function fnMenuOpen() {
    menuR.forEach( function(item,index) {
        obj = $('li[data-menu_no="' + item +  '"]'); 
        if ( $(obj).children("ul").length <= 0   ) {
            getSubData($(obj));
        }
        if ( index == 0 ) {
        	$(obj).children("a").addClass('on');
        }
        if ( index != 0 ) {
        	$(obj).parent().addClass('active');
        }
    });
    
    try {
            obj2 = $('li[data-menu_no="' + selectedMenuNo +  '"]'); 
            $(obj2).children('a').addClass('current');
    }catch(e){}
    
}


function getSubData($obj) {
    
    var menuItem = sessionStorage.getItem($obj.data('menu_no') );
    if ( null != menuItem ) {

        jsonData = JSON.parse(menuItem);
        
        setSubTree($obj,jsonData);    
    } else {
        
        jQuery.ajax({
            type:'get',
            asyn:true,
            url:'/mes/submenu.do',
            data: { 'menuNo' : $obj.data('menu_no') },
            dataType:'json',
            contentType:"application/x-www-form-urlencoded;charset=UTF-8",
            success:function(jsonData){
                setSubTree($obj,jsonData);  
                
                
                jsonStr =  JSON.stringify(jsonData);
                
                sessionStorage.setItem( $obj.data('menu_no') , jsonStr  );
                
            },
            error:function(xhr,textStatus) {
                alert(textStatus + "/"+xhr.status);
            },
            complete:function(xhr,textStatus) {
            
            }
        });
        
    }
}


function setSubTree($obj,jsonData){
    if ( jsonData.list_menulist.length > 0 ) {
        $ul = $('<ul></ul>');
        $(jsonData.list_menulist).each(function(){
            if ( $obj.data('menu_no') == this.upperMenuId ) {
                $a = $('<a></a>')
                .text(this.menuNm)
                .attr('href','#')
                //.attr('onclick','javascript:goMenuPage(\'' + this.menuNo + '\')');
                $li =$('<li data-menu_no=\'' + this.menuNo + '\'  data-chk_url=\'' + this.chkURL + '\'  ></li>');
                
                if ( this.chkURL != '/' ) {
                    $a.attr( 'onclick','javascript:goMenuPage(\'' + this.menuNo + '\')' );  
                } else {
                    $a.attr( 'onclick','javascript:goMenuPageEx( this, \'' + this.menuNo + '\')' );  
                }
                $a.attr( 'data-menu_no',this.menuNo );
                
                $li.append($a);
                $ul.append($li);
            }
        });
        if ( $ul.children().length > 0 ) 
            $obj.append($ul);
    }
    //
    gnbReset();
}

function goMenuPageEx( obj,menuNo ) {
    if( $(obj).parent().children("ul").length <= 0){
    	
    	$li = $(obj).parent();
        getSubData( $li ); // 현재 객체를 전달해 나중에 그 객체 하위에 추가를 해야지
        
        return;
   }
}

var windowObjHistorySearch =  { }; //null;

function goMenuPage(baseMenuNo){
    
    $obj = $('[data-menu_no=\"' + baseMenuNo + '\"]');
    url = $obj.data('chk_url');
    document.getElementById("baseMenuNo").value=baseMenuNo;
    document.getElementById("link").value="forward:"+url; //baseMenuNo; // getLastLink(baseMenuNo);
	/*
    document.menuListForm.action = "/EgovPageLink.do";
    document.menuListForm.submit();
    */
/*
    var pop_title = baseMenuNo; 
    window.open("", pop_title,'',false) ;
    var frm = document.menuListForm ;
    frm.target = pop_title ;
    frm.action = "/EgovPageLink.do" ;
    frm.submit() ;
 */
    /*
    mnu = getCookie( baseMenuNo );
    if ( mnu == null ) {
    	console.log( 'cookie null' )
    	setCookie( baseMenuNo , "true", 1);
    } else {

    }
    */
    
    xUrl = "/EgovPageLink.do"+ "?baseMenuNo=" + baseMenuNo +"&link=" +"forward:"+url;
    var pop_title = baseMenuNo; 
    /*
    window.open( xUrl, pop_title) ;
    */
    winObj = eval( 'windowObjHistorySearch.M'+ baseMenuNo);
    try {
        if ( !winObj ) {
            winObj  = window.open( xUrl, pop_title );
        }
        else {
            if ( winObj.closed ) {
                winObj  = window.open( xUrl, pop_title );
            }
        }
        winObj.blur();
        winObj.focus();
        return winObj;
        
        /*
	    if( windowObjHistorySearch == null) {
	        windowObjHistorySearch = window.open( xUrl, pop_title );
	    } else {
	        if(windowObjHistorySearch.closed) {
	            windowObjHistorySearch = window.open(  xUrl, pop_title );
	        }
	    }
	    windowObjHistorySearch.blur();
	    windowObjHistorySearch.focus();
	    return windowObjHistorySearch;
	    */
    } catch(e){
        //window.location.reload();
    }
    	
}
/*
window.onbeforeunload = function() {
	deleteCookie(  selectedMenuNo )
    return "Bye now!";
};
*/

var deleteCookie = function(name) {
	document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
}
	
var setCookie = function(name, value, exp) {
	var date = new Date();
	date.setTime(date.getTime() + exp*24*60*60*1000);
	document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
};
	
var getCookie = function(name) {
    var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return value? value[2] : null;
};



function guid() {
    function s4() {
      return ((1 + Math.random()) * 0x10000 | 0).toString(16).substring(1);
    }
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
  }

$(document).on( 'click','.snb>li>a', function() {

    // 해당메뉴 열기
    if($(this).hasClass('on')){
        $(this).removeClass('on');
        $(this).parent().children('ul').removeClass('active');
    }else{
        $(this).addClass('on');
        $(this).parent().children('ul').addClass('active');
    }
    
    //다른 sub 메뉴 닫기
    $(this).parent().siblings().children('a').removeClass('on');   
    $(this).parent().siblings().children('ul').removeClass('active');   
    return false;
});


$(document).on( 'click','.snb>li>ul>li>a', function() {

    // 해당메뉴 열기
    if($(this).hasClass('on')){
        $(this).removeClass('on');
        $(this).parent().children('ul').removeClass('active');
    }else{
        $(this).addClass('on');
        $(this).parent().children('ul').addClass('active');
    }
    
    //다른 sub 메뉴 닫기
    $(this).parent().siblings().children('a').removeClass('on');   
    $(this).parent().siblings().children('ul').removeClass('active');   
    return false;
});

function myFunction() {

    var x = document.getElementsByClassName("lnb-wrap")[0];
    if (x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }
}


</script>
			<!-- //left -->
			<!-- contents -->
			<main class="content" id="content">

				<div class="container">
					<h2 class="title">
						주문관리참조 조회
						<div class="navi_current">
							<span class="navi_current_home">홈</span> <span>영업관리</span> <span>주문관리참조
								조회</span>
						</div>
					</h2>

					<input type="hidden" id="mouseX"> <input type="hidden"
						id="mouseY"> <input type="hidden" id="metaList"> <input
						type="hidden" id="lengthDiv"> <input type="hidden"
						id="spanId"> <input type="hidden" id="itemPosition">

					<!-- search area -->


					<form autocomplete="off" id="dataForm" name="dataForm"
						method="post">
						<div class="search-area search-area-border ">
							<ul>
								<li>
									<div class="form-group ta-l ml-1">
										<label class="mr-1 w80">자료구분</label>
										<div class="form-group border ml-1 w260">
											<label for="radio-1"> <input
												class="form-radio-input-small" type="radio" name="cdiv"
												value="1" id="radio-1" style="margin: 1px 5px; opacity: 1;"
												checked="checked" tabindex="1"
												onkeyup="javascript:tab(this, event);"> <span
												style="margin: 3px 30px;">접수일자</span></label> <label for="radio-2">
												<input class="form-radio-input-small" type="radio"
												name="cdiv" value="2" id="radio-2"
												style="margin: 1px 5px; opacity: 1;" tabindex="2"
												onkeyup="javascript:tab(this, event);"> <span
												style="margin: 3px 30px;">납기일자</span>
											</label>
										</div>
										<label class="mr-1 w80">진행 구분</label>
										<div class="form-group border ml-1 w600">
											<label for="radio-3"> <input
												class="form-radio-input-small" type="radio" name="cprogdiv"
												value="1" id="radio-3" style="margin: 1px 5px; opacity: 1;"
												checked="checked" tabindex="3"
												onkeyup="javascript:tab(this, event);"> <span
												style="margin: 3px 30px;">진행</span></label> <label for="radio-4">
												<input class="form-radio-input-small" type="radio"
												name="cprogdiv" value="2" id="radio-4"
												style="margin: 1px 5px; opacity: 1;" tabindex="4"
												onkeyup="javascript:tab(this, event);"> <span
												style="margin: 3px 30px;">완료</span>
											</label> <label for="radio-5"> <input
												class="form-radio-input-small" type="radio" name="cprogdiv"
												value="3" id="radio-5" style="margin: 1px 5px; opacity: 1;"
												tabindex="5" onkeyup="javascript:tab(this, event);">
												<span style="margin: 3px 30px;">전체</span></label>
										</div>
									</div>
								</li>
								<li>
									<div class="col-8 ta-l ml-1">
										<label class="headtxt">해당일자</label>
										<div
											class="tui-datepicker-input tui-datetime-input tui-has-focus"
											style="width: 120px;">
											<input id="searchDate1" name="searchDate1" type="text"
												aria-label="Date-Time" tabindex="6"
												onkeyup="javascript:tab(this, event);"> <span
												class="tui-ico-date"></span>
											<div id="searchDate1-wrapper" style="margin-left: -1px;">
												<div class="tui-datepicker tui-rangepicker"
													style="display: none;">
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
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected"
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
																				class="tui-calendar-date tui-calendar-today tui-is-selectable"
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
											</div>
											<input type="hidden" id="year" name="year">
										</div>
										<label class="ml-1 mr-1">~</label>
										<div
											class="tui-datepicker-input tui-datetime-input tui-has-focus"
											style="width: 120px;">
											<input id="searchDate2" name="searchDate2" type="text"
												aria-label="Date-Time" tabindex="7"
												onkeyup="javascript:tab(this, event);"> <span
												class="tui-ico-date"></span>
											<div id="searchDate2-wrapper" style="margin-left: -1px;">
												<div class="tui-datepicker tui-rangepicker"
													style="display: none;">
													<div class="tui-datepicker-body tui-datepicker-type-date">
														<div class="tui-calendar">
															<div class="tui-calendar-header">
																<div class="tui-calendar-header-inner">
																	<a href="#" class="tui-calendar-btn-prev-month"
																		style="display: none;">Prev month</a> <em
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
																				class="tui-calendar-date tui-calendar-prev-month tui-calendar-sun tui-is-blocked"
																				data-timestamp="1622300400000">30</td>
																			<td
																				class="tui-calendar-date tui-calendar-prev-month tui-is-blocked"
																				data-timestamp="1622386800000">31</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1622473200000">1</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1622559600000">2</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1622646000000">3</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1622732400000">4</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-blocked"
																				data-timestamp="1622818800000">5</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-blocked"
																				data-timestamp="1622905200000">6</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1622991600000">7</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1623078000000">8</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1623164400000">9</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1623250800000">10</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1623337200000">11</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-blocked"
																				data-timestamp="1623423600000">12</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-blocked"
																				data-timestamp="1623510000000">13</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1623596400000">14</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1623682800000">15</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1623769200000">16</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1623855600000">17</td>
																			<td class="tui-calendar-date tui-is-blocked"
																				data-timestamp="1623942000000">18</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-blocked"
																				data-timestamp="1624028400000">19</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-blocked"
																				data-timestamp="1624114800000">20</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range tui-is-selected"
																				data-timestamp="1624201200000">21</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1624287600000">22</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1624374000000">23</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1624460400000">24</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1624546800000">25</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1624633200000">26</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1624719600000">27</td>
																			<td
																				class="tui-calendar-date tui-calendar-today tui-is-selectable tui-is-selected tui-is-selected-range"
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
											</div>
										</div>

									</div>
								</li>



								<li>
									<div class="col-9 ta-l ml-1">
										<label class="headtxt">고객사</label> <input
											class="form-control ta-l w150" type="text"
											id="searchKeywordFrom" name="searchKeywordFrom"
											maxlength="20" tabindex="8"
											onkeyup="javascript:tab(this, event);">
										<button type="button" id="entrpsPopBtn1"
											class="btn-top btn-find-small">찾아보기</button>
										<input class="form-control w200" type="text"
											id="searchKeywordFromNm" name="searchKeywordFromNm"
											maxlength="20" readonly="true"> <label
											class="ml-1 mr-1">~</label> <input
											class="form-control ta-l w150" type="text"
											id="searchKeywordTo" name="searchKeywordTo" maxlength="20"
											tabindex="9" onkeyup="javascript:tab(this, event);">
										<button type="button" id="entrpsPopBtn2"
											class="btn-top btn-find-small">찾아보기</button>
										<input class="form-control w200" type="text"
											id="searchKeywordToNm" name="searchKeywordToNm"
											maxlength="20" readonly="true">
									</div>
								</li>
								<li>
									<div class="col-9 ta-l ml-1">
										<label class="headtxt">제품코드</label> <input
											class="form-control ta-l w150" type="text" id="prductCd"
											name="prductCd" maxlength="20" tabindex="10"
											onkeyup="javascript:tab(this, event);">
										<button type="button" id="prductPopBtn"
											class="btn-top btn-find-small">찾아보기</button>
										<input class="form-control ta-l w200" type="text"
											id="prductNm" name="prductNm" maxlength="20" readonly="true">
									</div>
								</li>
							</ul>
							<div class="grid-option-area">
								<div class="col-6"></div>
								<div class="col-6 ta-r mr-1">
									<button type="button" class="btn btn-reset" id="resetBtn">새자료</button>
									<button type="button" class="btn btn-search" id="searchBtn">조회</button>
									<button type="button" class="btn btn-exel" id="excelBtn">Excel</button>
									<button type="button" class="btn btn-print" id="printBtn">인쇄</button>
								</div>
							</div>
						</div>
					</form>
				</div>


				<!-- //search area-->
				<!-- result tabs -->
				<!-- //result tabs -->

				<!-- grid-option-area -->
				<div class="grid-option-area">
					<div style="margin-left: 8px">

						<label> <b class="mr-1">출력일자 :</b>2021-06-28 10:45:21
						</label>
					</div>
					<div>
						<label><b>[ 천마하이테크 ]</b></label>
					</div>
				</div>
				<!-- //grid-option-area -->
				<!-- grid-area -->

				<div class="flex row mt-1">
					<div class="col-10f">
						<div id="grid">
							<div data-grid-id="1" class="tui-grid-container"
								style="width: 100%;">
								<div class="tui-grid-content-area tui-grid-has-summary-bottom">
									<div class="tui-grid-lside-area"
										style="width: 0px; display: block;">
										<div class="tui-grid-header-area" style="height: 40px;">
											<table class="tui-grid-table">
												<colgroup></colgroup>
												<tbody>
													<tr style="height: 40px;"></tr>
												</tbody>
											</table>
											<div class="tui-grid-column-resize-container"
												style="display: block; margin-top: -35px; height: 35px;"></div>
										</div>
										<div class="tui-grid-body-area"
											style="overflow: scroll; height: 330px;">
											<div class="tui-grid-body-container" style="height: 1px;">
												<div class="tui-grid-table-container"
													style="top: 0px; left: 0px; overflow: visible;">
													<table class="tui-grid-table">
														<colgroup></colgroup>
														<tbody></tbody>
													</table>
												</div>
												<div></div>
											</div>
										</div>
										<div class="tui-grid-summary-area">
											<table class="tui-grid-table" style="height: 40px;">
												<colgroup></colgroup>
												<tbody>
													<tr></tr>
												</tbody>
											</table>
										</div>
										<div class="tui-grid-scrollbar-left-bottom"></div>
									</div>
									<div class="tui-grid-rside-area"
										style="display: block; margin-left: 0px; width: 1460px;">
										<div class="tui-grid-header-area" style="height: 40px;">
											<table class="tui-grid-table">
												<colgroup>
													<col data-column-name="2010000" style="width: 60px;">
													<col data-column-name="2010000" style="width: 80px;">
													<col data-column-name="2010000" style="width: 120px;">
													<col data-column-name="2010000" style="width: 80px;">
													<col data-column-name="2010000" style="width: 120px;">
													<col data-column-name="2010000" style="width: 60px;">
													<col data-column-name="2010000" style="width: 60px;">
													<col data-column-name="2010000" style="width: 100px;">
													<col data-column-name="2010000" style="width: 100px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 173px;">
												</colgroup>
												<tbody>
													<tr style="height: 40px;">
														<th data-column-name="expireYn"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">진행구분</th>
														<th data-column-name="companyNm"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">고객사명</th>
														<th data-column-name="clientOrderNo"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">주문번호</th>
														<th data-column-name="prductCd"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">제품코드</th>
														<th data-column-name="prductNm"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">제품명</th>
														<th data-column-name="prductSize"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">규격</th>
														<th data-column-name="manageUnit"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">단위</th>
														<th data-column-name="soDt"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">접수일자</th>
														<th data-column-name="prductDedt"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">납기일자</th>
														<th data-column-name="orderRceptQy"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">주문량</th>
														<th data-column-name="dayCnt"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">지시량</th>
														<th data-column-name="qty"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">출고량</th>
														<th data-column-name="unPaid"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">미납품량</th>
														<th data-column-name="procdInvn"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">공정재고</th>
														<th data-column-name="edctsInvc"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">완제품재고</th>
														<th data-column-name="invntryQy"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">재고량</th>
														<th data-column-name="remark"
															class="tui-grid-cell tui-grid-cell-header"
															style="text-align: center; vertical-align: middle;">비
															고</th>
													</tr>
												</tbody>
											</table>
											<div class="tui-grid-column-resize-container"
												style="display: block; margin-top: -35px; height: 35px;">
												<div class="tui-grid-column-resize-handle" title="expireYn"
													data-column-index="0" data-column-name="expireYn"
													style="height: 40px; width: 7px; left: 57px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="companyNm"
													data-column-index="1" data-column-name="companyNm"
													style="height: 40px; width: 7px; left: 137px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle"
													title="clientOrderNo" data-column-index="2"
													data-column-name="clientOrderNo"
													style="height: 40px; width: 7px; left: 257px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="prductCd"
													data-column-index="3" data-column-name="prductCd"
													style="height: 40px; width: 7px; left: 337px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="prductNm"
													data-column-index="4" data-column-name="prductNm"
													style="height: 40px; width: 7px; left: 457px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle"
													title="prductSize" data-column-index="5"
													data-column-name="prductSize"
													style="height: 40px; width: 7px; left: 517px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle"
													title="manageUnit" data-column-index="6"
													data-column-name="manageUnit"
													style="height: 40px; width: 7px; left: 577px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="soDt"
													data-column-index="7" data-column-name="soDt"
													style="height: 40px; width: 7px; left: 677px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle"
													title="prductDedt" data-column-index="8"
													data-column-name="prductDedt"
													style="height: 40px; width: 7px; left: 777px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle"
													title="orderRceptQy" data-column-index="9"
													data-column-name="orderRceptQy"
													style="height: 40px; width: 7px; left: 847px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="dayCnt"
													data-column-index="10" data-column-name="dayCnt"
													style="height: 40px; width: 7px; left: 917px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="qty"
													data-column-index="11" data-column-name="qty"
													style="height: 40px; width: 7px; left: 987px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="unPaid"
													data-column-index="12" data-column-name="unPaid"
													style="height: 40px; width: 7px; left: 1057px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="procdInvn"
													data-column-index="13" data-column-name="procdInvn"
													style="height: 40px; width: 7px; left: 1127px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="edctsInvc"
													data-column-index="14" data-column-name="edctsInvc"
													style="height: 40px; width: 7px; left: 1197px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="invntryQy"
													data-column-index="15" data-column-name="invntryQy"
													style="height: 40px; width: 7px; left: 1267px; bottom: 0px;"></div>
												<div class="tui-grid-column-resize-handle" title="remark"
													data-column-index="16" data-column-name="remark"
													style="height: 40px; width: 7px; left: 1440px; bottom: 0px;"></div>
											</div>
										</div>
										<div class="tui-grid-body-area"
											style="overflow: scroll; height: 330px;">
											<div class="tui-grid-body-container"
												style="width: 1442px; height: 1px;">
												<div class="tui-grid-table-container"
													style="top: 0px; left: 0px; overflow: visible;">
													<table class="tui-grid-table">
														<colgroup>
															<col data-column-name="2010000" style="width: 60px;">
															<col data-column-name="2010000" style="width: 80px;">
															<col data-column-name="2010000" style="width: 120px;">
															<col data-column-name="2010000" style="width: 80px;">
															<col data-column-name="2010000" style="width: 120px;">
															<col data-column-name="2010000" style="width: 60px;">
															<col data-column-name="2010000" style="width: 60px;">
															<col data-column-name="2010000" style="width: 100px;">
															<col data-column-name="2010000" style="width: 100px;">
															<col data-column-name="2010000" style="width: 70px;">
															<col data-column-name="2010000" style="width: 70px;">
															<col data-column-name="2010000" style="width: 70px;">
															<col data-column-name="2010000" style="width: 70px;">
															<col data-column-name="2010000" style="width: 70px;">
															<col data-column-name="2010000" style="width: 70px;">
															<col data-column-name="2010000" style="width: 70px;">
															<col data-column-name="2010000" style="width: 173px;">
														</colgroup>
														<tbody></tbody>
													</table>
												</div>
												<div></div>
											</div>
										</div>
										<div class="tui-grid-summary-area">
											<table class="tui-grid-table" style="height: 40px;">
												<colgroup>
													<col data-column-name="2010000" style="width: 60px;">
													<col data-column-name="2010000" style="width: 80px;">
													<col data-column-name="2010000" style="width: 120px;">
													<col data-column-name="2010000" style="width: 80px;">
													<col data-column-name="2010000" style="width: 120px;">
													<col data-column-name="2010000" style="width: 60px;">
													<col data-column-name="2010000" style="width: 60px;">
													<col data-column-name="2010000" style="width: 100px;">
													<col data-column-name="2010000" style="width: 100px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 70px;">
													<col data-column-name="2010000" style="width: 173px;">
												</colgroup>
												<tbody>
													<tr>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="expireYn"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="companyNm">합계</td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="clientOrderNo"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="prductCd"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="prductNm"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="prductSize"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="manageUnit"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="soDt"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="prductDedt"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="orderRceptQy">0</td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="dayCnt">0</td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="qty">0</td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="unPaid">0</td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="procdInvn"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="edctsInvc"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="invntryQy"></td>
														<td class="tui-grid-cell tui-grid-cell-summary"
															data-column-name="remark"></td>
													</tr>
												</tbody>
											</table>
										</div>
										<div class="tui-grid-scrollbar-y-inner-border"
											style="top: 40px; height: 313px;"></div>
										<div class="tui-grid-scrollbar-y-outer-border"></div>
										<div class="tui-grid-scrollbar-right-top"
											style="height: 40px;"></div>
										<div class="tui-grid-scrollbar-right-bottom"
											style="height: 57px;"></div>
										<div class="tui-grid-scrollbar-frozen-border"
											style="height: 17px; width: 0px; margin-left: -1px;"></div>
										<div class="tui-grid-frozen-border"
											style="margin-left: 0px; width: 0px;"></div>
									</div>
									<div class="tui-grid-border-line tui-grid-border-line-top"></div>
									<div class="tui-grid-border-line tui-grid-border-line-left"></div>
									<div class="tui-grid-border-line tui-grid-border-line-right"></div>
									<div class="tui-grid-border-line tui-grid-border-line-bottom"
										style="bottom: 17px;"></div>
								</div>
								<div class="tui-grid-layer-state"
									style="display: block; top: 41px; height: 312px; left: 0px; right: 18px;">
									<div class="tui-grid-layer-state-content">
										<p>No data.</p>
									</div>
								</div>
								<div class="tui-grid-clipboard" contenteditable="true"></div>
							</div>
						</div>
					</div>
				</div>
				<!-- //grid-area -->
				<!-- 정보 안내 영역 -->
				<!-- //정보 안내 영역 -->
			</main>
		</div>

		<!-- //contents -->

	</div>


	<!-- footer -->
	<footer class="footer" style="height: 60px; z-index: 98;">
		<div class="container">
			<!--  logo/ -->
			<div class="logo">
				<img src="/nxn/images/noimg.png" alt="MES 로고">
			</div>
			<div class="info">
				<address class="address"></address>
				<p class="copyright">COPYRIGHT ⓒ 2020 이젠솔루션 ALL RIGHTS RESERVED.</p>
			</div>
		</div>
	</footer>


	<script type="text/javaScript" language="javascript">

$(function() {
    resizeSnb();
});
    
function resizeSnb() {
    var winH = window.innerHeight;
    var winW = window.innerWidth;
    winH = winH - 60 - $('.logowrap').height() -30;
    $('.snb-wrap>ul.snb').css('height',winH );
    
    if ( winW <= 400 ) {
        $('div.info>p').html( 'ⓒ 2020 이젠솔루션' );
    }
}   

$(window).resize(resizeSnb);

    
</script>
	<!-- //footer -->





	<!-- 
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
<meta name="format-detection" content="telephone=no" />

  -->
	<link rel="stylesheet" type="text/css" href="/tui/tui-grid.css">
	<link rel="stylesheet" type="text/css" href="/tui/tui-time-picker.css">
	<link rel="stylesheet" type="text/css" href="/tui/tui-date-picker.css">
	<link rel="stylesheet" type="text/css"
		href="/tui/toastui-select-box.css">
	<!-- 
toastui-select-box.min.css
toastui-select-box.css
 -->

	<!-- 
<script type="text/javascript" src="/tui/tui-code-snippet.js"></script>
 -->
	<script type="text/javascript" src="/tui/tui-time-picker.js"></script>
	<script type="text/javascript" src="/tui/tui-date-picker.js"></script>
	<script type="text/javascript" src="/tui/tui-grid.js"></script>
	<script type="text/javascript" src="/tui/toastui-select-box.js"></script>

	<!-- 
toastui-select-box.js
toastui-select-box.min.js
 -->
	<script type="text/javascript">

class CustomCheckboxRenderer {
    constructor(props) {
        const { grid, rowKey,columnInfo, value } = props;
        const label = document.createElement('checkbox');
/*         const { disabled } = props.columnInfo.renderer.options; */
        label.className = 'checkbox';
        //label.setAttribute('for', String(rowKey));

        const hiddenInput = document.createElement('input');
        hiddenInput.className = 'hidden-input';
        hiddenInput.id = String(rowKey);

        hiddenInput.setAttribute( 'data-check-val', '0' );
        
        label.appendChild(hiddenInput);

        hiddenInput.type = 'checkbox';
        hiddenInput.addEventListener('change', () => {
            if (hiddenInput.checked) {
                hiddenInput.setAttribute( 'data-check-val', '1' );
                grid.setValue(rowKey, columnInfo.name, "1");
            } else {
                hiddenInput.setAttribute( 'data-check-val', '0' );
                grid.setValue(rowKey, columnInfo.name, "0");
            }
            try {
                fnCustomChkboxChange();
            } catch(e) {
                
            }
            
        });

        this.el = label;

        this.render(props);
    }

    getElement() {
        return this.el;
    }

    render(props) {
    const hiddenInput = this.el.querySelector('.hidden-input');
    const checked = Boolean(props.value == '1');
    hiddenInput.checked = checked;
   const disabled = props.columnInfo.renderer.disabled;
    hiddenInput.disabled = disabled; 
    }
};


class CustomBtnRenderer {
    constructor(props) {
        const { grid, rowKey,columnInfo, value } = props;
        const button = document.createElement('button');
        const txtNode = document.createTextNode( value );
        button.appendChild( txtNode );
        
        //button.className = 'btn-sm btn-find-on-small';
        button.className = 'btn btn-sm';
    
        this.el = button;
        //this.render(props);
    }
    getElement() {
        return this.el;
    }
};


class CustomTextEditor {
    constructor(props) {
      const el = document.createElement('input');
      const { maxLength } = props.columnInfo.editor.options;

      el.type = 'text';
      el.maxLength = maxLength;
      el.value = String(props.value);

      this.el = el;
    }

    getElement() {
      return this.el;
    }

    getValue() {
      return this.el.value;
    }

    mounted() {
      this.el.select();
    }
  };
  
</script>
	<script src="/js/mes/mesComFunc.js?=200507-22"></script>
	<script src="/js/mes/mesComFunc2.js?=200421-1"></script>
	<script src="/js/mes/CstmrOrder.js?=200507-22"></script>
	<script type="text/javaScript" language="javascript">
//그리드 정보
var gridData=[
];

const grid = new tui.Grid({
    el: document.getElementById('grid'),
    data: gridData,
    scrollX: true,
    scrollY: true,
    bodyHeight :330,
    rowHeight: 30,
    //rowHeaders:['checkbox',]
    columns: [
    	{  header:'진행구분' , name:'expireYn', align:'center',width:60},
        {  header:'고객사명' , name:'companyNm', align:'left',width:80},
        {  header:'주문번호' , name:'clientOrderNo', align:'center', width:120},
        {  header:'제품코드' , name:'prductCd',  width : 80, align:'left' },
        {  header:'제품명' , name:'prductNm',  width : 120 ,align:'left'  },
        {  header:'규격' , name:'prductSize',  width : 60 ,align:'center'  },
        {  header:'단위' , name:'manageUnit',  width : 60 ,align:'center'  },
        {  header:'접수일자' , name:'soDt',  width : 100 ,align:'center' },
        {  header:'납기일자' , name:'prductDedt',  width : 100 ,align:'center' },
        {  header:'주문량' , name:'orderRceptQy',  width : 70 ,align:'right',
            formatter: function(value) {
                return value.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }},
        {  header:'지시량' , name:'dayCnt',  width : 70 ,align:'right',
            formatter: function(value) {
                return value.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }},
        {  header:'출고량' , name:'qty',  width : 70 ,align:'right',
            formatter: function(value) {
                return value.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }},
        {  header:'미납품량' , name:'unPaid',  width : 70,align:'right',
            formatter: function(value) {
                return value.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }},
        {  header:'공정재고', name: 'procdInvn', width : 70, align : 'right',
            formatter: function(value) {
                return value.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }},
        {  header:'완제품재고', name: 'edctsInvc', width : 70, align : 'right',
            formatter: function(value) {
                return value.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }},
        {  header:'재고량' , name:'invntryQy',  width : 70, align : 'right',
            formatter: function(value) {
               return value.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }},
        {  header:'비   고' , name:'remark' }
    ],
    summary:{
        height:40,
        position:'bottom',
        columnContent:{
        	companyNm:{
                template(summary) {
                    return '합계';
                } 
            },
            orderRceptQy:{
                template(summary) {
                    return ((summary.sum)/2).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                }
            },
            dayCnt:{
                template(summary) {
                    return ((summary.sum)/2).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                }
            },
            qty:{
                template(summary) {
                    return ((summary.sum)/2).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                }
            },
            unPaid:{
                template(summary) {
                    return ((summary.sum)/2).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                }
            }
        }
    },
    columnOptions: {
        resizable : true
    }

});

grid.on('editingStart', (ev) => {
    ev.stop();
});

//상단 작업일자
var today = new Date();
var picker = tui.DatePicker.createRangePicker({
    startpicker: {
        date: today-(7*24*60*60*1000),
        input: '#searchDate1',
        container: '#searchDate1-wrapper',
    },
    endpicker: {
        date: today,
        input: '#searchDate2',
        container: '#searchDate2-wrapper',
    },
    selectableRanges: [
        [new Date(0), new Date(today.getFullYear() + 1, today.getMonth(), today.getDate())]
    ],
    language: 'ko'
});

$('#searchDate2').on('focusout',function() {
    var obj = $(this);
    setTimeout( function() {
        _datePickerClose( $(obj),  picker._endpicker  );
    },100 );
});

$('#searchDate1').on('focus',function() {
    //picker._startpicker.open();
});
$('#searchDate1').on('focusout',function() {
    var obj = $(this);
    setTimeout( function() {
        _datePickerClose( $(obj),   picker._startpicker );
    },100 );
});
 

 
var cstMrOrderSearchViewURL = '/mes/cstMrOrderSearchView.do';
var entrpsDtaSearchViewURL = '/mes/entrpsSearchView.do';
 
$(function() {
    setFocus( $('#searchDate1'), 100);
});
 
 
 

</script>



</body>
</html>