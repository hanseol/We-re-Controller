<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script language="javascript"
	src="<c:url value='/js/egovframework/com/main.js' />"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/select-box/latest/toastui-select-box.css">
<script
	src="https://uicdn.toast.com/select-box/latest/toastui-select-box.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
<script
	src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
<!-- 그리드 -->
<script type="text/javaScript" language="javascript">
var today = new Date();
/*그리드세팅*/
var gridData = [];
const grid = new tui.Grid({
	el: document.getElementById('grid'),
    data: gridData,
    scrollX: true,
    scrollY: true,  //
    bodyHeight :450,
    rowHeight: 30,
//     rowHeaders: ['checkbox'],
    columns: [
    	{ header: '발주일자', name: 'dOrderDate', width : 120, align : 'center' },
    	{ header: '발주코드', name: 'dOrderCode', width : 120, align : 'center' },
    	{ header: '자재코드', name: 'dMatrCode', width : 120, align : 'left' },
    	{ header: '자재명', name: 'dMatrCodeName', width : 250, align : 'left' },
    	{ header: '납품요청일', name: 'dRequestDate', width : 120, align : 'center' },
    	{ header: '거래처코드', name: 'dCompanyName', width : 120, align : 'center' },
        { header: '발주량', name: 'dOrderQty', width : 100, align : 'right',
            formatter: function({ value }) {
                return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            }},
        { header: '단가', name: 'dOrderPrice',  align : 'left' }
    ],
    summary: {
    	height: 40,
        position: 'bottom', // or 'top'
        columnContent: {
        	dCompanyName: {
        		align : 'center',
                template(summary) {
        			return '합 계';
                } 
            },
            dOrderQty: {
            	align : 'right',
            	template(summary) {
            		var summaryResult = (summary.sum)/2;
            		return summaryResult.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                }
            }
        }
    }
});
</script>
<!-- 버튼설정 -->
<script type="text/javaScript" language="javascript">
tui.Grid.applyTheme('default', themesOptions);
/**버튼설정**/

$(function() {
   setFocus( $('#searchDate1') , 100 ); 
});

//상단 작업일자
 var picker = tui.DatePicker.createRangePicker({
	    startpicker: {
	        date: today-(7*24*60*60*1000),
	        input: '#searchDate1',
	        container: '#searchDate1-wrapper'
	    },
	    endpicker: {
	        date: today,
	        input: '#searchDate2',
	        container: '#searchDate2-wrapper'
	    },
	    language : 'ko',
	    selectableRanges: [
	        [new Date(0), new Date(today.getFullYear() + 1, today.getMonth(), today.getDate())]
	    ]
	});

	$(document).on('keyup', '#searchDate1', function() {
	    if (window.event.keyCode == 13) {
	     picker._startpicker.close();
	     $('#searchDate2').focus();
	     picker._endpicker.open();
	    }
	});

	$(document).on('keyup', '#searchDate2', function() {
	    if (window.event.keyCode == 13) {
	     picker._endpicker.close();
	     // 검색 함수 추가 ↓↓↓↓↓
	    
	    }
	});
	
	//코드입력으로 검색
	$('#searchKeywordFrom').on('keydown',function() {
		fnReduceSp($(this));
	   if ( event.keyCode == 13 && $(this).val() != '') {
	        param = { entrpsCd : $('#searchKeywordFrom').val()};
	        var result = fnGetEntrpsByKey( param )   
	        if ( typeof result != 'undefined' ) {           
	            $('#searchKeywordFrom').val( result.entrpsCd );
	            $('#searchKeywordFromNm').val( result.entrpsNm.replace('&amp;','&') );
	        } else {
	        	
	        	fnEntrpsSearchView();
	        }
	    }
	});
	
	$('#searchKeywordTo').on('keydown',function() {
		fnReduceSp($(this));
	   if ( event.keyCode == 13 && $(this).val() != '' ) {
	        param = { entrpsCd : $('#searchKeywordTo').val()};
	        var result = fnGetEntrpsByKey( param )   
	        if ( typeof result != 'undefined' ) {           
	            $('#searchKeywordTo').val( result.entrpsCd );
	            $('#searchKeywordToNm').val( result.entrpsNm.replace('&amp;','&') );
	        } else {
	        	fnEntrpsSearchView();
	        }
	    }
	});
	
	$('#searchKeywordFrom').on('focus',function() {
		entrpsDta = "main";
    });
	$('#searchKeywordTo').on('focus',function() {
		entrpsDta = "sub";
	});
	
	$('#dItemcode').on('keydown',function() {
			fnReduceSp($(this));
		   if ( event.keyCode == 13 && $(this).val() != '' ) {
		        param = { matrCd : $('#dItemcode').val()};
		        var result = fnGetMatrByKey( param )   
		        if ( typeof result != 'undefined' ) {           
		            $('#dItemcode').val( result.matrCd );
		            $('#dItemcodeNm').val( result.matrNm );
		        } else {
		            fnMatrSearchView();
		        }
		    }
		});
 
var entrpsDtaSearchViewURL = '/mes/entrpsSearchView.do';
var entrpsDtaSearchViewURL2 = '/mes/entrpsSearchView.do';
var MatrSearchPopupURL = '/mes/matrSearchView.do';
</script>

<!-- 여러기능 -->
<script type="text/javascript">

var selectedMenuNo = '3020000';

var menuHierarchey = [ 
	
	   3020000,
	
	   3000000,
	
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
function getAllData(){
	$.ajax({
		type:'get',
		url:'/matInout/selectMatInout.do',
		data:  {
			ERP_MATERIAL_ORDER_CODE : $obj.data('')
		},
		error : function(error) {
			console.log("error");
		},
		success : function(data) {
			console.log("success");

		}
	})
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

</head>
<body class="desktop" style="">
	<div class="wrap">
		<div class="container">
			<main class="content" id="content">
				<div class="container">
					<h2>발주관리 참조</h2>
					<input type="hidden" id="mouseX"> <input type="hidden"
						id="mouseY"> <input type="hidden" id="metaList"> <input
						type="hidden" id="lengthDiv"> <input type="hidden"
						id="spanId"> <input type="hidden" id="itemPosition">

					<!-- 검색(Master) -->
					<form id="dataForm" name="dataForm" method="post"
						onsubmit="return false;" autocomplete="off">
						<div class="search-area search-area-border">
							<ul>
								<li>
									<div class="col-6 ta-l ml-1">
										<label class="mr-1">해당일자</label>
										<div
											class="tui-datepicker-input tui-datetime-input tui-has-focus"
											style="width: 140px;">
											<input id="searchDate1" name="searchDate1" type="text"
												aria-label="Date" tabindex="1"
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
																		class="tui-calendar-title tui-calendar-title-month">2017.01</em>
																	<a href="#" class="tui-calendar-btn-next-month">Next
																		month</a>
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
																				class="tui-calendar-date tui-calendar-sun tui-is-selectable tui-is-selected tui-is-selected-range"
																				data-timestamp="1483196400000">1</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1483282800000">2</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1483369200000">3</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1483455600000">4</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1483542000000">5</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1483628400000">6</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1483714800000">7</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1483801200000">8</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1483887600000">9</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1483974000000">10</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484060400000">11</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484146800000">12</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484233200000">13</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484319600000">14</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484406000000">15</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484492400000">16</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484578800000">17</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484665200000">18</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484751600000">19</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484838000000">20</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1484924400000">21</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485010800000">22</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485097200000">23</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485183600000">24</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485270000000">25</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485356400000">26</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485442800000">27</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485529200000">28</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485615600000">29</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485702000000">30</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485788400000">31</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485874800000">1</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-is-selectable tui-is-selected-range"
																				data-timestamp="1485961200000">2</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-is-selectable tui-is-selected-range"
																				data-timestamp="1486047600000">3</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1486134000000">4</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1486220400000">5</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-is-selectable tui-is-selected-range"
																				data-timestamp="1486306800000">6</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-is-selectable tui-is-selected-range"
																				data-timestamp="1486393200000">7</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-is-selectable tui-is-selected-range"
																				data-timestamp="1486479600000">8</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-is-selectable tui-is-selected-range"
																				data-timestamp="1486566000000">9</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-is-selectable tui-is-selected-range"
																				data-timestamp="1486652400000">10</td>
																			<td
																				class="tui-calendar-date tui-calendar-next-month tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1486738800000">11</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<label class="ml-1 mr-1">~</label>
										<div
											class="tui-datepicker-input tui-datetime-input tui-has-focus"
											style="width: 140px;">
											<input id="searchDate2" name="searchDate2" type="text"
												aria-label="Date" tabindex="2"
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
																		style="display: block;">Prev month</a> <em
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
																				class="tui-calendar-date tui-calendar-prev-month tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1622300400000">30</td>
																			<td
																				class="tui-calendar-date tui-calendar-prev-month tui-is-selectable tui-is-selected-range"
																				data-timestamp="1622386800000">31</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1622473200000">1</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1622559600000">2</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1622646000000">3</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1622732400000">4</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1622818800000">5</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1622905200000">6</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1622991600000">7</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623078000000">8</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623164400000">9</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623250800000">10</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623337200000">11</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623423600000">12</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623510000000">13</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623596400000">14</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623682800000">15</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623769200000">16</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623855600000">17</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
																				data-timestamp="1623942000000">18</td>
																			<td
																				class="tui-calendar-date tui-calendar-sat tui-is-selectable tui-is-selected-range"
																				data-timestamp="1624028400000">19</td>
																		</tr>
																		<tr class="tui-calendar-week">
																			<td
																				class="tui-calendar-date tui-calendar-sun tui-is-selectable tui-is-selected-range"
																				data-timestamp="1624114800000">20</td>
																			<td
																				class="tui-calendar-date tui-is-selectable tui-is-selected-range"
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
									<div class="col-6 ta-l ml-1">
										<label class="mr-1">발주업체</label> <input type="text"
											id="searchKeywordFrom" name="searchKeywordFrom"
											class="form-control ta-l w120" maxlength="20"
											data-input="search" data-fn-name="fnEntrpsSearchView"
											tabindex="3" onkeyup="javascript:tab(this, event);"
											inputmode="search">
										<button type="button" id="entrpsPopBtn"
											class="btn-top btn-find-small">찾아보기</button>
										<input type="text" id="searchKeywordFromNm"
											name="searchKeywordFromNm" class="form-control  w150"
											maxlength="20" readonly="true"> <span
											class="ml-1 mr-1">~</span> <input type="text"
											id="searchKeywordTo" name="searchKeywordTo"
											class="form-control ta-l w120" maxlength="20"
											data-input="search" data-fn-name="fnEntrpsSearchView"
											tabindex="4" onkeyup="javascript:tab(this, event);"
											inputmode="search">
										<button type="button" id="entrpsPopBtn1"
											class="btn-top btn-find-small">찾아보기</button>
										<input type="text" id="searchKeywordToNm"
											name="searchKeywordToNm" class="form-control  w150"
											maxlength="20" readonly="true">
									</div>
								</li>
								<li>
									<div class="col-6 ta-l ml-1">
										<label class="mr-1">자재코드</label> <input type="text"
											id="dItemcode" name="dItemcode"
											class="form-control ta-l w120" maxlength="20"
											data-input="search" data-fn-name="MatrSearchViewPopup"
											tabindex="5" onkeyup="javascript:tab(this, event);"
											inputmode="search">
										<button type="button" id="matrPopBtn"
											class="btn-top btn-find-small">찾아보기</button>
										<label class="mr-1 ml-7">자재명</label> <input type="text"
											id="dItemcodeNm" name="dItemcodeNm" class="form-control w350"
											readonly="readonly">
									</div>
								</li>
								<li>
									<div class="col-6 ta-l ml-1">
										<label class="mr-1 w80">정렬구분</label>
										<div class="form-group border ml-1 w700">
											<label for="radio-5" class="mr-1"> <span>일자</span>
											</label> <input class="form-radio-input-small tuiIgnorian"
												type="radio" name="orderBy" value="dDate" id="radio-5"
												checked="checked" tabindex="6"
												onkeyup="javascript:tab(this, event);"> <label
												for="radio-3" class="mr-1"> <span>업체</span>
											</label> <input class="form-radio-input-small tuiIgnorian"
												type="radio" name="orderBy" value="dCompanyNm" id="radio-3"
												tabindex="7" onkeyup="javascript:tab(this, event);">
											<label for="radio-4" class="mr-1"> <span>자재</span>
											</label> <input class="form-radio-input-small tuiIgnorian"
												type="radio" name="orderBy" value="dItemcode" id="radio-4"
												tabindex="8" onkeyup="javascript:tab(this, event);">
										</div>
									</div>
								</li>
							</ul>
							<div class="grid-option-area">
								<div class="col-6"></div>
								<div class="col-6 ta-r mr-1">
									<button type="button" class="btn btn-search" id="searcnBtn">
										조회</button>
									<button type="button" class="btn btn-new" id="resetBtn">새자료</button>
									<button type="button" class="btn btn-exel" id="excelBtn">Excel</button>
									<button type="button" class="btn btn-print" id="printBtn">인쇄</button>
								</div>
							</div>
						</div>
					</form>
				</div>


				<!-- //search area-->
				<!-- grid area -->
				<div class="grid-area">
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
										style="overflow: scroll; height: 450px;">
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
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 250px;">
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 100px;">
												<col data-column-name="3020000" style="width: 100px;">
												<col data-column-name="3020000" style="width: 100px;">
												<col data-column-name="3020000" style="width: 100px;">
												<col data-column-name="3020000" style="width: 193px;">
											</colgroup>
											<tbody>
												<tr style="height: 40px;">
													<th data-column-name="dOrderDate"
														class="tui-grid-cell tui-grid-cell-header"
														style="text-align: center; vertical-align: middle;">발주일자</th>
													<th data-column-name="dOrderCode"
														class="tui-grid-cell tui-grid-cell-header"
														style="text-align: center; vertical-align: middle;">발주코드</th>
													<th data-column-name="dMatrCode"
														class="tui-grid-cell tui-grid-cell-header"
														style="text-align: center; vertical-align: middle;">자재코드</th>
													<th data-column-name="dMatrCodeName"
														class="tui-grid-cell tui-grid-cell-header"
														style="text-align: center; vertical-align: middle;">자재명</th>
													<th data-column-name="dRequestDate"
														class="tui-grid-cell tui-grid-cell-header"
														style="text-align: center; vertical-align: middle;">납품요청일</th>
													<th data-column-name="dCompanyName"
														class="tui-grid-cell tui-grid-cell-header"
														style="text-align: center; vertical-align: middle;">거래처명</th>
													<th data-column-name="dOrderQty"
														class="tui-grid-cell tui-grid-cell-header"
														style="text-align: center; vertical-align: middle;">발주량</th>
													<th data-column-name="dOrderPrice"
														class="tui-grid-cell tui-grid-cell-header"
														style="text-align: center; vertical-align: middle;">단가</th>
												</tr>
											</tbody>
										</table>
										<div class="tui-grid-column-resize-container"
											style="display: block; margin-top: -35px; height: 35px;"></div>
									</div>
									<div class="tui-grid-body-area"
										style="overflow: scroll; height: 450px;">
										<div class="tui-grid-body-container"
											style="width: 1442px; height: 1px;">
											<div class="tui-grid-table-container"
												style="top: 0px; left: 0px; overflow: visible;">
												<table class="tui-grid-table">
													<colgroup>
														<col data-column-name="3020000" style="width: 120px;">
														<col data-column-name="3020000" style="width: 120px;">
														<col data-column-name="3020000" style="width: 120px;">
														<col data-column-name="3020000" style="width: 250px;">
														<col data-column-name="3020000" style="width: 120px;">
														<col data-column-name="3020000" style="width: 120px;">
														<col data-column-name="3020000" style="width: 100px;">
														<col data-column-name="3020000" style="width: 100px;">
														<col data-column-name="3020000" style="width: 100px;">
														<col data-column-name="3020000" style="width: 100px;">
														<col data-column-name="3020000" style="width: 193px;">
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
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 250px;">
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 120px;">
												<col data-column-name="3020000" style="width: 100px;">
												<col data-column-name="3020000" style="width: 100px;">
												<col data-column-name="3020000" style="width: 100px;">
												<col data-column-name="3020000" style="width: 100px;">
												<col data-column-name="3020000" style="width: 193px;">
											</colgroup>
											<tbody>
												<tr>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="dDate"></td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="dIncode"></td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="dItemcode"></td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="dItemcodeNm"></td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="dIndate"></td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="dCompanyNm">합 계</td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="dQty">0</td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="dInqty">0</td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="unQty">0</td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="dStock"></td>
													<td class="tui-grid-cell tui-grid-cell-summary"
														data-column-name="remark"></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="tui-grid-scrollbar-y-inner-border"
										style="top: 40px; height: 433px;"></div>
									<div class="tui-grid-scrollbar-y-outer-border"></div>
									<div class="tui-grid-scrollbar-right-top" style="height: 40px;"></div>
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
								style="display: block; top: 41px; height: 432px; left: 0px; right: 18px;">
								<div class="tui-grid-layer-state-content">
									<p>No data.</p>
								</div>
							</div>
							<div class="tui-grid-clipboard" contenteditable="true"></div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>