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
            OM_API(
                    APIS.DIC_LIST, {
                        type: type,
                        KEYWORD: searchKeyword,
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