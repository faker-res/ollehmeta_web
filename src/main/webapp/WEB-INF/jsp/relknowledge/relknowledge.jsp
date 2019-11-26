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
        /*
        .editwrap .tag_add input[type="text"]{width: 134px;margin-right: 6px;margin-top: -1px;border-radius: 20px; border: 3px dotted red;}
        */
    </style>
    <!-- <script src="/js/metatag.js"></script> -->
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
							<select name="type" id="cboTypeUpload">
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
						<select id="cboType">
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
						<select id="cboFile">
							<option selected>다운로드할 카테고리를 선택해 주십시오.</option>
						</select>
						<button id="btnDown" class="btn_ok">OK</button>
					</dd>
				</dl>
			</div>
		</div>
	</div>

</div><!-- //contents -->

<%@ include file="/WEB-INF/jsp/common/ComFooter.jsp" %>
</body>
<script>

//dictionary.jsp 의 $(".btnUp").click(function(){}); → $("#fileCsv").change(function(){}); 참고
$("#btnUp").click(function(event) {
	event.preventDefault();
	
	var form = $('#formRelFileCsv')[0];
	var data = new FormData(form);
	var tmpFileName = $("#ex_filename").val();
	
	if($("#cboTypeUpload > option:selected").val()==""){
		OM_ALERT("업로드할 카테고리를 선택해 주십시오.");
		return;
	}
	
	if($("#ex_filename").val()==""){
		OM_ALERT("선택된 파일이 없습니다.");
		return;
	}
	
	if(tmpFileName.substring(tmpFileName.indexOf(".csv"),tmpFileName.length) != ".csv"){
		OM_ALERT("CSV 파일을 선택해주십시오.");
		return;
	}
	
	//모래시계 추가
	Loading(true);

	$.ajax({
		crossOrigin : true,
		type : "POST",
		enctype : 'multipart/form-data',
		//url : "/relknowledgeCsvFileUpload.do",
		//url : "http://127.0.0.1:8080/relknowledgeCsvFileUpload.do",
		//url : "http://14.63.174.158:8080/relknowledgeCsvFileUpload.do",
		url : "${BASE_URL}/relknowledgeCsvFileUpload.do",
		data : data,
		processData : false, //prevent jQuery from automatically transforming the data into a query string
		contentType : false,
		//cache : false,
		datatype : "json",
		timeout: 6000000,
		success : function(data) {
            //console.log("SUCCESS");
			//OM_ALERT("업로드가 완료되었습니다.");
			if(JSON.parse(data).RT_CODE>0){
	            console.log("SUCCESS");
				OM_ALERT("업로드가 완료되었습니다.");
			}else{
	            console.log("ERROR");
				OM_ALERT("올바른 CSV파일을 선택해주십시오.");
			}
		},
		error : function(e) {
			console.log("ERROR : ", e);
			//OM_ALERT("업로드 도중 오류가 발생하였습니다.");
		},	
		complete: function() {	
			Loading(false);
		}
	});

});

	$("#btnDown").click(function() {
		//$("#fileCsv").click();
		var type = $("#cboType option:selected").val();
//		alert("btnDown - type="+type);
		
		if(type==""){
			OM_ALERT("다운로드할 카테고리를 선택해 주십시오.");
			return;
		}
		debugger;
		Loading(true);
		
		var param = {	
			apiUrl   : JSON.stringify({url : "/relknowledge/download/type",method : "GET"}),
			apiParam : JSON.stringify({type : type}||{})
		};

		$.ajax({
			url: "/v1/apis",
			timeout: 200000,
			method: "POST",
			data: param,
			dataType: "html",
			success: function(data,textStatus,jqXHR){
				//alert("result success");
				OM_ALERT("다운로드가 완료되었습니다.");
				
			    //구버전 : 파일경로 띄우기
			    //window.open(jqXHR.responseText);
				
				//신버전 : 데이터를 그대로 태우기 - 느림
				var responseTextArr = jqXHR.responseText.split("::::");
				var blob = new Blob(["\ufeff"+responseTextArr[1]], {type: "text/csv;charset=utf-8"});
			    objURL = window.URL.createObjectURL(blob);
			    
			    var a = document.createElement('a');
			    a.href = objURL;
			    //a.download = "VOD_RT_" + $("#cboType > option:selected").val().toUpperCase() + ".csv";
			    //a.download = $("#cboFile > option:selected").val();
			    a.download = responseTextArr[0];
			    a.click();				    
			},
			error: function(jqXHR,textStatus,errorThrown){
				//debugger;
				//alert("result error");
				if ( textStatus == "timeout" ) {
					OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 001)");
				} else if (typeof jqXHR.responseText != "undefined" && jqXHR.responseText == "apiSessionError" ) {
					OM_ALERT("세션이 종료 되었습니다. <br>재 로그인 시도 합니다.(에러 : 002)", function() {
						location.href = "/";
					})
				} else {
					//OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 003)<br>textStatus:"+textStatus+"<br><br>----------------<br>" +jqXHR.responseText +"<br>----------------");
					
					//구버전 : 파일경로 띄우기
				    //window.open(jqXHR.responseText);
				    
					//신버전 : 데이터를 그대로 태우기 - 느림
					var blob = new Blob(["\ufeff"+jqXHR.responseText], {type: "text/csv;charset=utf-8"});
				    objURL = window.URL.createObjectURL(blob);
				    
				    var a = document.createElement('a');
				    a.href = objURL;
				    //a.download = "VOD_RT_" + $("#cboType > option:selected").val().toUpperCase() + ".csv";
				    a.download = $("#cboFile > option:selected").val();
				    a.click();
				    
				}
			},	
			complete: function() {	
				Loading(false);
			}	
		});
	});
	
	
	//https://javafactory.tistory.com/1580 yyyymmdd 형태로 포멧팅하여 날짜 반환
	Date.prototype.yyyymmdd = function()
	{
	    var yyyy = this.getFullYear().toString();
	    var mm = (this.getMonth() + 1).toString();
	    var dd = this.getDate().toString();
	 
	    return yyyy + (mm[1] ? mm : '0'+mm[0]) + (dd[1] ? dd : '0'+dd[0]);
	}
	
	$("#ex_filename").change(function(){
	    var strFilePath = this.value
	    
		if(strFilePath.substring(strFilePath.indexOf(".csv"),strFilePath.length) != ".csv"){
			OM_ALERT("CSV 파일을 선택해주십시오.");
			return;
		}
	    
	    $("input.upload_name").val(strFilePath.substring(strFilePath.lastIndexOf("\\")+1,strFilePath.length));
	});
	
	/*
	//카테고리 선택하면
	var yyyymmdd = new Date().yyyymmdd();
	$("#cboFile").html("<option selected>"+ yyyymmdd.substring(0,4)+"년 "+yyyymmdd.substring(4,6)+"월 "+yyyymmdd.substring(6,8)+"일 0시의 데이터</option>");
	*/
	
	$("#cboType").change(function(){
		if(this.value==""){
			$("#cboFile").html("<option selected>다운로드할 카테고리를 선택해 주십시오.</option>");
			return;
		}
		var param = {	
			apiUrl   : JSON.stringify({url : "/relknowledge/getCsvFileName.do",method : "GET"}),
			apiParam : JSON.stringify({type : this.value}||{})
		};

		$.ajax({
			url: "/v1/apis",
			timeout: 200000,
			method: "POST",
			data: param,
			dataType: "json",
			success: function(data,textStatus,jqXHR){
				//alert("result success");
				//$("#cboFile").html("<option selected>"+data.CSV_FILE_NAME+"</option>");
				$("#cboFile").empty();
				
                $.each(data.RESULT.CSV_FILE_NAME,function(index,item){
                	//console.log("when data " + index + " : " + item);
                	//"list_"+tmp
                	//$("#list_"+tmp).append($("<option>").attr("value",item).text(item));
                	//$("#txtList_"+tmp).append(item+",");
                	if(item!=""){
                		$("#cboFile").append($("<option>").attr("value",item).text(item));
                	}
                });
			},
			error: function(jqXHR,textStatus,errorThrown){
				//debugger;
				//alert("result error");
				if ( textStatus == "timeout" ) {
					OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 001)");
				}
			}
		});
	});
</script>