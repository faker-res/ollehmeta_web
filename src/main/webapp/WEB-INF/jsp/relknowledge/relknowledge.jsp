<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
************************************************************
* Comment : 연관 지식
* User    : 권재일
* Date    : 2019-08-30
***********************************************************7
--%>

<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/ComHeader.jsp" %>

    <style>
        .sortWrap label {
            cursor: pointer;
        }
        .metaUpdateInput {
            border: 3px dotted red;
        }
        .editwrap .tag_add input[type="text"]{width: 134px;margin-right: 6px;margin-top: -1px;border-radius: 20px; border: 3px dotted red;}
    </style>
    <script src="/js/metatag.js"></script>
    
    <link rel="stylesheet" href="/js/plugins/jquery-ui/jquery-ui.css" /><!-- 권재일 수정 08.01 2-1 -->
    <script src="/js/plugins/jquery-ui/jquery-ui.js" async></script><!-- 권재일 수정 08.01 2-1 -->
    
    <script src="/js/relknowledge.js"></script>
</head>
<body>

<%--Nav--%>
<%@ include file="/WEB-INF/jsp/common/ComHeaderWrapper.jsp" %>

<div class="contents relatedKnowledge">

	<div class="updownCond">
		<div class="upload">
			<form id="formRelFileCsv" enctype="multipart/form-data" method="post">
				<h2><span>업로드</span></h2>
				<div class="inner">
					<dl class="selCategory">
						<dt>카테고리 선택</dt>
						<dd>
							<select name="type">
								<option value="">선택된 카테고리가 없습니다.</option>
								<option value="cook">요리</option>
								<option value="curr">정치/시사</option>
								<option value="docu">다큐/교양</option>
								<option value="heal">건강/질병</option>
								<option value="hist">역사</option>
								<option value="tour">여행</option>
							</select>
						</dd>
					</dl>
					<dl class="selFile">
						<dt>파일선택</dt>
						<dd>
							<div class="filebox">
								<input type="text" class="upload_name" value="선택된 파일이 없습니다." readonly>
								<label for="ex_filename">파일선택</label><!-- 아래 ex_filename 아이디를 변경할 경우 for="변경된 아이디"로 반드시 변경해야 함 -->
								<input type="file" id="ex_filename" name="ex_filename" class="upload_hidden">
							</div>
							<button id="btnUp" class="btn_ok">OK</button>
						</dd>
					</dl>
				</div>
			</form>
		</div>

		<div class="download">
			<h2><span>다운로드</span></h2>
			<div class="inner">
				<dl class="selCategory">
					<dt>카테고리 선택</dt>
					<dd>
						<select>
							<option value="">선택된 카테고리가 없습니다.</option>
							<option value="cook">요리</option>
							<option value="curr">정치/시사</option>
							<option value="docu">다큐/교양</option>
							<option value="heal">건강/질병</option>
							<option value="hist">역사</option>
							<option value="tour">여행</option>
						</select>
					</dd>
				</dl>
				<dl class="selFile">
					<dt>파일선택</dt>
					<dd>
						<select>
							<option>선택된 파일이 없습니다.</option>
						</select>
						<button id="btnDown" class="btn_ok">OK12</button>
					</dd>
				</dl>
			</div>
		</div>
	</div>

</div><!-- //contents -->

<script>

//dictionary.jsp 의 $(".btnUp").click(function(){}); → $("#fileCsv").change(function(){}); 참고
$("#btnUp").click(function(event) {
	
	if("1"=="1"){
		return;
	}
	
	event.preventDefault();
	
	//$("#fileCsv").click();
	alert("btnUp");

	var form = $('#formRelFileCsv')[0];
	var data = new FormData(form);

	//모래시계 추가
	Loading(true);

	$.ajax({
		type : "POST",
		enctype : 'multipart/form-data',
		url : "/relknowledgeCsvFileUpload.do",
		data : data,
		processData : false, //prevent jQuery from automatically transforming the data into a query string
		contentType : false,
		cache : false,
		timeout: 6000000,
		success : function(data) {
			//리턴된 json 문자열을 서버로 보냄 → 일괄등록(일단 파싱먼저)
			debugger;
			alert("strResult = " + data.strResult);

			var strResult = data.strResult;
			var strMessage = data.strMessage;
			var strType = data.strType;

			if (strMessage != "") {
				alert(strMessage);
				return false;
			}
			
			
			
			debugger;
			
			
			//2019.10.02~
			//삭제 + 추가
			//Loading(true);
			var param = {
				apiUrl : JSON.stringify({
					url : "/relknowledge/upload/type",	//from /dic/del/type
					method : "POST"
				}),
				apiParam : JSON.stringify({
					type : strType,
					items : strResult
				})
			};

			$.ajax({
				url : "/v1/apis",
				//timeout: 20000,
				method : "POST",
				data : param,
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					alert("ok " + data.rtmsg);

					//모래시계 없애기
					Loading(false);

					//새로고침 로직
				},
				error : function(jqXHR,
						textStatus,
						errorThrown) {
					//failCallback(jqXHR,textStatus,errorThrown);

					if (textStatus == "timeout") {
						OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 001)");
					} else if (typeof jqXHR.responseText != "undefined"
							&& jqXHR.responseText == "apiSessionError") {
						OM_ALERT(
								"세션이 종료 되었습니다. <br>재 로그인 시도 합니다.(에러 : 002)",
								function() {
									location.href = "/";
								})
					} else {
						OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 003)<br>textStatus:"
								+ textStatus
								+ "<br><br>----------------<br>"
								+ jqXHR.responseText
								+ "<br>----------------");
					}

				},
				complete : function() {
					Loading(false);
				}

			});
			
			
			
			
			
			

			//테스트는 여기까지
			if ("1" == "1") {
				alert("테스트는 여기까지 (_ _)..");
				Loading(false);
				return false;
			}

			//삭제 + 추가
			//Loading(true);
			var param = {
				apiUrl : JSON.stringify({
					url : "/relknowledge/upload/type",
					method : "POST"
				}),
				apiParam : JSON.stringify({
					type : strType,
					items : strResult
				})
			};

			$.ajax({
				url : "/v1/apis",
				//timeout: 20000,
				method : "POST",
				data : param,
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					alert("ok " + data.rtmsg);

					//모래시계 없애기
					Loading(false);

					//새로고침 로직
				},
				error : function(jqXHR,
						textStatus,
						errorThrown) {
					//failCallback(jqXHR,textStatus,errorThrown);

					if (textStatus == "timeout") {
						OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 001)");
					} else if (typeof jqXHR.responseText != "undefined"
							&& jqXHR.responseText == "apiSessionError") {
						OM_ALERT(
								"세션이 종료 되었습니다. <br>재 로그인 시도 합니다.(에러 : 002)",
								function() {
									location.href = "/";
								})
					} else {
						OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 003)<br>textStatus:"
								+ textStatus
								+ "<br><br>----------------<br>"
								+ jqXHR.responseText
								+ "<br>----------------");
					}

				},
				complete : function() {
					Loading(false);
				}

			});

			/*
			//아래는 이전로직이므로 여기서 차단
			if("1"=="1"){
				return false;
			}
			
			
			//삭제 후 추가
			//Loading(true);
			var param = {
			    apiUrl   : JSON.stringify({url : "/dic/del/type",method : "POST"}),
			    apiParam : JSON.stringify({type : strType, items : strResult})
			};

			$.ajax({
			    url: "/v1/apis",
			    //timeout: 20000,
			    method: "POST",
			    data: param,
			    dataType: "json",	//혹시 file 인가
			    success: function(data,textStatus,jqXHR){
			        alert("ok " + data.rtmsg);
			        
			        //모래시계 없애기
			        Loading(false);
			        
			        //새로고침 로직
			    },
			    error: function(jqXHR,textStatus,errorThrown){
			        //failCallback(jqXHR,textStatus,errorThrown);

			        if ( textStatus == "timeout" ) {
			            OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 001)");
			        } else if (typeof jqXHR.responseText != "undefined" && jqXHR.responseText == "apiSessionError" ) {
			            OM_ALERT("세션이 종료 되었습니다. <br>재 로그인 시도 합니다.(에러 : 002)", function() {
			                location.href = "/";
			            })
			        } else {
			            OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 003)<br>textStatus:"+textStatus+"<br><br>----------------<br>" +jqXHR.responseText +"<br>----------------");
			        }

			    },
			    complete: function() {
			        Loading(false);
			    }

			});
			 */

		},
		error : function(e) {

			//$("#result").text(e.responseText);
			console.log("ERROR : ", e);
			//$("#btnSubmit").prop("disabled", false);

			Loading(false);

		}
	});

});

	$("#btnDown").click(function() {
		$("#fileCsv").click();
		alert("btnDown");
	});
</script>