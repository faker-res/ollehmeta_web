<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--
************************************************************
* Comment : 딕셔너리
* User    : Park
* Date    : 2017-12-13
***********************************************************
--%>

<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/ComHeader.jsp" %>
    <style>
        .sortWrap label {
            cursor: pointer;
        }
    </style>
    <script src="/js/metatag.js"></script>
    <script src="/js/dictionary.js"></script>

</head>
<body>

<%@ include file="/WEB-INF/jsp/common/ComHeaderWrapper.jsp" %>


<div class="contents dictionary">
    <div id="dicType" class="dicInquiry">
        <div class="dicMeta">
            <h2>메타사전</h2>
            <div class="inner">
                <a href="#" value="WHEN" class="current"># 시간적 배경</a>
                <a href="#" value="WHERE"># 공간적 배경</a>
                <a href="#" value="WHO"># 인물/캐릭터</a>
                <a href="#" value="WHAT"># 소재/주제</a>
                <a href="#" value="EMOTION"># 감성/분위기</a>
                <%--<a href="#" value="UNCLASS"># 미분류</a>--%>
            </div>
        </div>
        <div class="dicFilter">
            <h2>필터링사전</h2>
            <div class="inner">
                <a href="#" value="NOTUSE"># 불용 키워드</a>
                <a href="#" value="CHANGE"># 대체 키워드</a>
            </div>
        </div>
    </div>
    <div id="act-tabform" class="act-tabform">
        <div id="mod_vcTab" class="mod_vcTab act-tab">
            <ul>
                <li class="tabNav1 on"><a href="#dic_tab1" onclick="return false;">전체</a></li>
                <li class="tabNav2"><a href="#dic_tab2" onclick="return false;">수정 <span></span></a></li>
                <li class="tabNav3"><a href="#dic_tab3" onclick="return false;">이동 <span></span></a></li>
                <li class="tabNav4"><a href="#dic_tab4" onclick="return false;">추가 <span></span></a></li>
                <li class="tabNav5"><a href="#dic_tab5" onclick="return false;">삭제 <span></span></a></li>
            </ul>
        </div>

        <!-- 전체 -->
        <div id="dic_tab1" class="act-tabCn on">
            <div class="inner">
                <div class="topWrap">
                    <div class="txtTag"><span id="title"># 시간적 배경</span> <span class="total"></span></div>
                    <div class="tagAdd">
                        <input id="tagInsertName" type="text" placeholder="추가하실 태그를 입력하세요">
                        <span class="btnWrap"><button id="tagInsert">추가</button></span>
                    </div>
                    <div class="result_search">
                        <input id="tagSearch" type="text" placeholder="결과 내 검색 및 버튼 사용시 DB 검색">
                        <button id="tagDBSearch">검색</button>
                    </div>
                </div><!-- //.topWrap -->
                <!-- 정렬콤보상자 + CSV 업로드/다운로드 -->
				<div class="btnWrap _csv">
					<select name="cboOrder" id="cboOrder">
						<option value="new">최신순</option>
						<option value="abc">가나다순</option>
					</select>
					<span class="_bar"></span>
					<form id="formFileCsv" enctype="multipart/form-data" method="post">
					<input type="file" id="fileCsv" name="fileCsv" style="width:0px;"/>
					<input type="hidden" name="type" />
					</form>
					<button type="button" class="btnUp">CSV 업로드</button>
					<button type="button" class="btnDown">CSV 다운로드</button>
				</div>
				
                <div class="editwrap"  id="allMetaTag">

                </div><!-- //.editwrap -->
            </div><!-- //.inner -->
            <div class="btnWrap btnBig">
                <div class="btnRight">
                    <button id="dicSave">저장</button>
                </div>
            </div><!-- //.btnWrap -->
            <div class="pagenation">
            </div><!-- //.pagenation -->
        </div>
        <!-- //전체 -->

        <!-- 수정 -->
        <div id="dic_tab2" class="act-tabCn dic_mod">
            <div class="inner">
                <div class="topWrap">
                    <div class="txtTag"># 인물/캐릭터 <!-- <span class="total">123,456</span> --></div>
                    <div class="tagAdd">
                        <input type="text" placeholder="추가하실 태그를 입력하세요" disabled="disabled">
                        <span class="btnWrap"><button disabled="disabled">추가</button></span>
                    </div>
                    <div class="result_search">
                        <input type="text" placeholder="결과 내 검색" disabled="disabled">
                        <button disabled="disabled">검색</button>
                    </div>
                </div><!-- //.topWrap -->
                <div class="editwrap" id="updateMetaTag">

                </div><!-- //.editwrap -->
            </div><!-- //.inner -->
            <div class="btnWrap btnBig">
                <div class="btnRight">
                    <button>저장</button>
                </div>
            </div><!-- //.btnWrap -->
            <div class="pagenation">
            </div><!-- //.pagenation -->
        </div>
        <!-- //수정 -->

        <!-- 이동 -->
        <div id="dic_tab3" class="act-tabCn">
            <div class="inner">
                <div class="topWrap">
                    <div class="txtTag"># 인물/캐릭터 <!-- <span class="total">123,456</span> --></div>
                    <div class="tagAdd">
                        <input type="text" placeholder="추가하실 태그를 입력하세요" disabled="disabled">
                        <span class="btnWrap"><button disabled="disabled">추가</button></span>
                    </div>
                    <div class="result_search">
                        <input type="text" placeholder="결과 내 검색" disabled="disabled">
                        <button disabled="disabled">검색</button>
                    </div>
                </div><!-- //.topWrap -->
                <div class="editwrap" id="moveMetaTag">

                </div><!-- //.editwrap -->
            </div><!-- //.inner -->
            <div class="btnWrap btnBig">
                <div class="btnRight">
                    <button>저장</button>
                </div>
            </div><!-- //.btnWrap -->
            <div class="pagenation">
            </div><!-- //.pagenation -->
        </div>
        <!-- //이동 -->

        <!-- 추가 -->
        <div id="dic_tab4" class="act-tabCn">
            <div class="inner">
                <div class="topWrap">
                    <div class="txtTag"># 인물/캐릭터 <!-- <span class="total">123,456</span> --></div>
                    <div class="tagAdd">
                        <input type="text" placeholder="추가하실 태그를 입력하세요" disabled="disabled">
                        <span class="btnWrap"><button disabled="disabled">추가</button></span>
                    </div>
                    <div class="result_search">
                        <input type="text" placeholder="결과 내 검색" disabled="disabled">
                        <button disabled="disabled">검색</button>
                    </div>
                </div><!-- //.topWrap -->
                <div class="editwrap"  id="addMetaTag">
                </div><!-- //.editwrap -->
            </div><!-- //.inner -->
            <div class="btnWrap btnBig">
                <div class="btnRight">
                    <button>저장</button>
                </div>
            </div><!-- //.btnWrap -->
            <div class="pagenation">
            </div><!-- //.pagenation -->
        </div>
        <!-- //추가 -->

        <!-- 삭제 -->
        <div id="dic_tab5" class="act-tabCn">
            <div class="inner">
                <div class="topWrap">
                    <div class="txtTag"># 인물/캐릭터 <!-- <span class="total">123,456</span> --></div>
                    <div class="tagAdd">
                        <input type="text" placeholder="추가하실 태그를 입력하세요" disabled="disabled">
                        <span class="btnWrap"><button disabled="disabled">추가</button></span>
                    </div>
                    <div class="result_search">
                        <input type="text" placeholder="결과 내 검색" disabled="disabled">
                        <button disabled="disabled">검색</button>
                    </div>
                </div><!-- //.topWrap -->
                <div class="editwrap"  id="delMetaTag">
                </div><!-- //.editwrap -->
            </div><!-- //.inner -->
            <div class="btnWrap btnBig">
                <div class="btnRight">
                    <button>저장</button>
                </div>
            </div><!-- //.btnWrap -->
            <div class="pagenation">

            </div><!-- //.pagenation -->
        </div>
        <!-- //삭제 -->
    </div>
</div><!-- //contents -->
<script id="template_meta_tag" type="text/html">
    <a id="displayTag" href="javascript:;" class="txt" data-content="tagName">
    </a>
    <input id="updateTag" type="text" placeholder="입력" style="display: none">
    <a href="#" class="btn_del">삭제</a>
    <div class="sortWrap">
        <ul>
            <li>
                <label for="ra_sort_1-1" id="metaWhenPosition" value="when">
                    시간적 배경
                    <div class="radiobtn">
                        <input type="radio" id="ra_sort_1-1" name="ra_sort_1" checked>
                        <span></span>
                    </div>
                </label>
            </li>
            <li>
                <label for="ra_sort_1-2" id="metaWherePosition" value="where">
                    공간적 배경
                    <div class="radiobtn">
                        <input type="radio" id="ra_sort_1-2" name="ra_sort_1">
                        <span></span>
                    </div>
                </label>
            </li>
            <li>
                <label for="ra_sort_1-3" id="metaWhatPosition" value="what">
                    주제/소재
                    <div class="radiobtn">
                        <input type="radio" id="ra_sort_1-3" name="ra_sort_1">
                        <span></span>
                    </div>
                </label>
            </li>
            <li>
                <label for="ra_sort_1-4" id="metaWhoPosition" value="who">
                    인물/캐릭터
                    <div class="radiobtn">
                        <input type="radio" id="ra_sort_1-4" name="ra_sort_1">
                        <span></span>
                    </div>
                </label>
            </li>
            <li>
                <label for="ra_sort_1-5" id="metaEmotionPosition" value="emotion">
                    감성/분위기
                    <div class="radiobtn">
                        <input type="radio" id="ra_sort_1-5" name="ra_sort_1">
                        <span></span>
                    </div>
                </label>
                <label for="ra_sort_1-6" id="metaNotusePosition" value="notuse">
                    불용 키워드
                    <div class="radiobtn">
                        <input type="radio" id="ra_sort_1-6" name="ra_sort_1">
                        <span></span>
                    </div>
                </label>
            </li>
        </ul>
    </div><!-- //.sortWrap -->

</script>

<%@ include file="/WEB-INF/jsp/common/ComFooter.jsp" %>
</body>
</html>
<script>
    var metaDictionary = new MetaDictionary();
    $(document).ready(function(){

        OM_READY(function(){
            // 선택된 메타 사전 정보를 가져 온다
            loadDictionary();
            $("#dicSave").click(function() {

                var metaHistory = MetaHistoryManager.getDictionary();

                if ( metaHistory.length == 0 ) {
                    OM_ALERT("수정할 내용이 없습니다.");
                    return;
                }
                OM_API(
                        APIS.DIC_UPT_ARRAY, {
                            items: JSON.stringify(metaHistory)
                        }, function(data){

                            OM_ALERT("저장되었습니다.");

                            var currentPageNum = $(".pagenation .current").html();

                            loadDictionary(currentPageNum);
                            MetaHistoryManager.reset();
                        }, function(){
                            console.log("Error")
                        });

            });

            $("#dicType a").click(function() {

                $("#dicType a").removeClass("current");
                $(this).addClass("current");
                $("#cboOrder").val("new").prop("selected",true);//최신순 강제 선택
                loadDictionary();
            });


            function addTag(){

                var tagPosion =  $("#dicType .current").attr("value");
                MetaHistoryManager.add($("#tagInsertName").val(),
                        tagPosion,
                        $("#tagInsertName").val(),
                        "add");

                var tagName = $("#tagInsertName").val();
                metaDictionary.addTag(tagName, "dic_new");
                var metaTag = new MetaTag()
                metaTag.init({
                    parentDom : "addMetaTag",
                    tagName: tagName,
                    tagRatio: 0,
                    tagType: "dic_new",
                    tagGroup: "DIC",
                    onDataChangeEvent: metaDictionary.onDataChangeEvent,
                    enableRatio: false,
                    enableMenu: false,
                    enableDelete: false,
                    enableAllEvent: false
                }).add();

                $("#tagInsertName").val("");
            }
            $("#tagInsert").click(function(){
                addTag();
            });
            $("#tagInsertName").keyup(function(e) {
                if (e.keyCode == 13) {
                    addTag();
                }
            });

            // 결과 내 검색
            $("#tagSearch").keyup(function(e) {
                //if (e.keyCode == 13) {}
                var keyword = $(this).val();
                if ( keyword != "" ) {
                    $("#allMetaTag span").hide();
                    $("#allMetaTag span").each(function() {
                        if ( $(this).find("a").text().indexOf(keyword) != -1 ) {
                            $(this).show();
                        }
                    });
                } else {
                    $("#allMetaTag span").show();
                }
            });

            // DB 검색
            $("#tagDBSearch").click(function(){
                var keyword = $("#tagSearch").val();
                if ( keyword != "" ) {
                    loadDictionary(1, keyword);
                } else {
                    loadDictionary(1, "");
                }
            });
            
            //정렬
            $("#cboOrder").change(function(){
                var keyword = $("#tagSearch").val();
                if ( keyword != "" ) {
                    loadDictionary(1, keyword);
                } else {
                    loadDictionary(1, "");
                }
            });
            
            //CSV 다운로드
            $(".btnDown").click(function(){
            	var type = $("#dicType .current").attr("value").toLowerCase();
            	
                var param = {
                    apiUrl   : JSON.stringify({url : "/admin/dic/keywords/download",method : "GET"}),
                    apiParam : JSON.stringify({type : type}||{})
                };

			    //모래시계 추가
			    Loading(true);
			    
                $.ajax({
                    url: "/v1/apis",
                    timeout: 20000,
                    method: "POST",
                    data: param,
                    dataType: "html",
        			success: function(data,textStatus,jqXHR){
        				//alert("result success");
       					
       				    //구버전 : 파일경로 띄우기
       				    //window.open(jqXHR.responseText);
       					
       					//신버전 : 데이터를 그대로 태우기 - 느림
       					var blob = new Blob(["\ufeff"+jqXHR.responseText], {type: "text/csv;charset=utf-8"});
       				    objURL = window.URL.createObjectURL(blob);
       				    
       				    var a = document.createElement('a');
       				    a.href = objURL;
       				    a.download = "VOD_RT_" + $("#dicType .current").attr("value").toUpperCase() + ".csv";
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
        				    a.download = "VOD_RT_" + $("#dicType .current").attr("value").toUpperCase() + ".csv";
        				    a.click();				    
        				    
        				    
        				}
        			},	
        			complete: function() {	
        				Loading(false);
        			}	
                });
            });
			
            //CSV 업로드
            $(".btnUp").click(function(){
            	//1. 파일을 로컬에 업로드(web)
            	//2. 업로드 파일을 json 스트링으로 리턴(web)
            	//3. json스트링을 ctms 서버로 서브밋(web → ctms)
            	//4. 분해하여 (기존거 삭제 후) 업로드~
            	
            	//formFileCsv.fileCsv 창 띄우기
            	$("#fileCsv").click();//?
            });
            
            
            //CSV 업로드
            $("#fileCsv").change(function(){
			    var form = $('#formFileCsv')[0];
			    $(form).find("input[name=type]").val($("#dicType .current").attr("value").toLowerCase());
			    
			    var data = new FormData(form);
			
			    //모래시계 추가
			    Loading(true);
			    
			    $.ajax({
			        type: "POST",
			        enctype: 'multipart/form-data',
			        //url: "/dictionaryCsvFileUpload.do",
			        //url: "http://127.0.0.1:8080/dictionaryCsvFileUpload.do",
			        url: "http://14.63.174.158:8080/dictionaryCsvFileUpload.do",
			        data: data,
			        processData: false, //prevent jQuery from automatically transforming the data into a query string
			        contentType: false,
			        cache: false,
			        datatype : "json",
			        //timeout: 600000,
			        success: function (data) {
			            console.log("SUCCESS");
			        	
					    //Loading(false);
			            OM_ALERT("업로드가 완료되었습니다.");
			        	
			        },
			        error: function (e) {

			            //$("#result").text(e.responseText);
			            console.log("ERROR : ", e);
			            //$("#btnSubmit").prop("disabled", false);
					    //Loading(false);

			        },
        			complete: function() {	
        				Loading(false);
        				//OM_ALERT("업로드가 완료되었습니다.");
        			}	
			    });
            	
            });
            

        });

        function loadDictionary(pageNextNo, searchWord) {

            MetaHistoryManager.reset();

            var pageNo = 1;
            var searchKeyword = "";
            if ( typeof pageNextNo != "undefined" ) {
                pageNo = pageNextNo;
            }
            if ( typeof searchWord != "undefined" ) {
                searchKeyword = searchWord;
            }


            var type = $("#dicType .current").attr("value").toLowerCase();
            var tagPosition = $("#dicType .current").attr("value").toLowerCase();
            var orderby = $("#cboOrder option:selected").val();	//권재일 추가 07.31 5-1
            //alert("orderby = " + orderby);
            OM_API(
                    APIS.DIC_LIST, {
                        type: type,
                        KEYWORD: searchKeyword,
                        orderby:orderby,
                        pagesize: 500,
                        pageno:pageNo
                    }, function(data){
                        metaDictionary.init({
                            data : data,
                            domId : ".tbl_bs",
                            tagPosition : tagPosition,
                            gotoIndex: function( pageNo ) {
                                loadDictionary(pageNo);
                            }
                        }).render();

                        var totalCount = data.RESULT.COUNT_ALL;

                        $(".txtTag .total").html(totalCount);
                        var currentPosision = $(".dicMeta .current").html();
                        $(".txtTag #title").html(currentPosision);


                        // 탭이동
                        $("#mod_vcTab").find("li").removeClass("on");
                        $("#act-tabform").find(".on").removeClass("on");
                        $("#act-tabform").find("#dic_tab1").addClass("on");
                        $("#mod_vcTab").find("li").eq(0).addClass("on");

                        // 탭 이름 변경
                        var currentTabName = $("#dicType .current").html();
                        $("#dic_tab1 #title").html(currentTabName);
                        $("#dic_tab2 .txtTag").html(currentTabName);
                        $("#dic_tab3 .txtTag").html(currentTabName);
                        $("#dic_tab4 .txtTag").html(currentTabName);
                        $("#dic_tab5 .txtTag").html(currentTabName);

                    }, function(){
                        console.log("Error")
            });
        }

    });
</script>