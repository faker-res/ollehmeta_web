$(document).ready(function(){

	//gnb
	$(".gnb nav ul li").mouseenter(function(event) {
		$(this).find("div").parent().children("a").css("color", "#fff");
		$(this).find("div").slideDown(1);
	}).mouseleave(function() {
		$(this).find("div:visible").slideUp(1, function() {
			// #menubar-menus li:hover 처리를 하지 않을 경우 아래 라인 활성,
			$(this).parent().children("a").css("color", "#b0b7c2");
		});
	});

	// 셀렉트박스
	$('.selbox').click(function(){
		$(this).toggleClass("on");
	});

	// 날짜선택
	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear: true,
		yearSuffix: '년'
	});

	$(function() {
		$("#datepicker1, #datepicker2").datepicker();
	});

	// tab + tab content
	$('.act-tabform .act-tab a').on('click',function(){
		var ids = $(this).attr('href');

		if($(ids).size() == 0){
			$(this).parent().siblings('li').removeClass('on');
			$(this).parent().addClass('on');
		} else {
			$(this).parent().siblings('li').removeClass('on');
			$(this).parent().parent().parent().siblings('.act-tabCn').removeClass('on');
			$(this).parent().addClass('on');
			$(ids).addClass('on');
		}
	});

	// 토글 - 이전태그복구
	$('.btn_repair').click(function(){
		$(this).toggleClass("disabled");
	});

	// 메타관리

	/*
	$('.editwrap .tag').click(function(){
		$(this).toggleClass("mod");
	});
	$(".sortWrap label").click(function(){
		$(".sortWrap label").removeClass("current");
		$(this).addClass("current");
	});

	$('.editwrap .tag_add .btn_add').click(function(){
		$(this).parent().prepend('<input type="text" placeholder="입력">');
	});
	*/

});

// 레이어 팝업
function position_cm(obj){
	var windowHeight = $(window).height();
	var $obj = $(obj).find('.layInner');
	var objHeight = $obj.height();

	if(windowHeight > objHeight){
		$obj.css({top:(windowHeight/2)-(objHeight/2)});
		// $obj.css({top:(windowHeight/2)-(objHeight/2),bottom:'auto'});
	} else {
		$obj.css({top:0});
	}
}

function layerAction(messageText, id, fnClose, fnOk, fnCancel){

	$("#popupClose").off();
	$("#popupOk").off();
	$("#popupCancel").off();

	var layid = document.getElementById(id),
	dim = $('<div class="mod_dim" />');
	if(layid.style.display == 'none'){

		// add Message

		$("#"+id+ " #popupMessage").html(messageText);

		$('html,body').addClass('bodyHidden');
		$('#'+id).fadeIn(0);
		$(layid).before(dim);
		position_cm($(layid)); // layer positioning

		if ( id == "ly_pop_02" ) {
			// 이벤트 추가
			$("#popupOk").click(function(){
				if( typeof fnOk == "function") fnOk();
				layerAction("", id);
			});
			$("#popupCancel").click(function(){
				if( typeof fnCancel == "function") fnCancel();
				layerAction("", id);
			});

		} else {
			$("#popupClose").click(function(){
				if( typeof fnClose == "function") fnClose();
				layerAction("", id);
			});
		}
	}
	else{
		$('html,body').removeClass('bodyHidden');
		$('#'+id).fadeOut(0);
		$(layid).prev(dim).remove();
	}
}


function Loading(bEnable){

	var bShow = bEnable;
	var loader = $("div.loader");

	if ( bShow ) {
		loader.css("display","");
	} else {
		loader.css("display","none");
	}


}