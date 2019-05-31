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

<div class="contents management">
    <div class="modHeader">
        <h2>통계조회</h2>
    </div>

    <div class="searchCond">
        <h2>검색조건</h2>
        <div class="inner">
            <dl class="getDate">
                <dt>일자</dt>
                <dd>
                    <button class="btn_allday">전체</button>
                    <input type="text" id="startDate">
                    ~
                    <input type="text" id="endDate">
                </dd>
            </dl>
        </div>
        <button class="btn_result">결과조회</button>
    </div>


    <div class="tbl_bs2">
        <table>
            <colgroup>
                <col width="25%">
                <col width="25%">
                <col width="25%">
                <col width="25%">
            </colgroup>
            <tr>
                <th>입수건수</th>
                <th>수집건수</th>
                <th>추출건수</th>
                <th>승인건수</th>
            </tr>
            <tr>
                <td>
                    <dl>
                        <dt>완료:</dt>
                        <dd class="number"><strong class="poi_1" id="IN"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="IN">조회</button></dd>
                    </dl>
                </td>
                <td>
                    <dl>
                        <dt>완료:</dt>
                        <dd class="number"><strong class="poi_1" id="SC"></strong> 건</dd>
                        <%--<dd class="btnWrap"><button class="btn" value="SC">조회</button></dd>--%>
                    </dl>
                    <dl>
                        <dt>실패:</dt>
                        <dd class="number"><strong class="poi_1" id="FC"></strong> 건</dd>
                        <%--<dd class="btnWrap"><button class="btn" value="FC">조회</button></dd>--%>
                    </dl>
                </td>
                <td>
                    <dl>
                        <dt>완료:</dt>
                        <dd class="number"><strong class="poi_1" id="SA"></strong> 건</dd>
                        <%--<dd class="btnWrap"><button class="btn" value="SA">조회</button></dd>--%>
                    </dl>
                    <dl>
                        <dt>실패:</dt>
                        <dd class="number"><strong class="poi_1" id="FA"></strong> 건</dd>
                        <%--<dd class="btnWrap"><button class="btn" value="FA">조회</button></dd>--%>
                    </dl>
                </td>
                <td><!-- class="mod3" 삭제 -->
                    <dl>
                        <dt>완료:</dt>
                        <dd class="number"><strong class="poi_1" id="ST"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="ST">조회</button></dd>
                    </dl>
                    <!-- <dl>
                        <dt>잔여:</dt>
                        <dd class="number"><strong class="poi_1">1,345</strong> 건</dd>
                        <dd class="btnWrap"><button class="btn">조회</button></dd>
                    </dl> -->
                    <dl>
                        <dt>불가:</dt>
                        <dd class="number"><strong class="poi_1"  id="FT"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn"  value="FT">조회</button></dd>
                    </dl>
                </td>
            </tr>

            <!--
            <tr>
                <td>
                    <dl>
                        <dt>완료:</dt>
                        <dd class="number"><strong class="poi_1" id="IN"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="IN">조회</button></dd>
                    </dl>
                </td>
                <td>
                    <dl>
                        <dt>완료:</dt>
                        <dd class="number"><strong class="poi_1" id="SC"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="SC">조회</button></dd>
                    </dl>
                    <dl>
                        <dt>실패:</dt>
                        <dd class="number"><strong class="poi_1" id="FC">2,345</strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="FC">조회</button></dd>
                    </dl>
                </td>
                <td>
                    <dl>
                        <dt>완료:</dt>
                        <dd class="number"><strong class="poi_1" id="SA"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="SA">조회</button></dd>
                    </dl>
                    <dl>
                        <dt>실패:</dt>
                        <dd class="number"><strong class="poi_1" id="FA"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="FA">조회</button></dd>
                    </dl>
                </td>
                <td class="mod3">
                    <dl>
                        <dt>완료:</dt>
                        <dd class="number"><strong class="poi_1" id="ST"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="ST">조회</button></dd>
                    </dl>
                    <dl>
                        <dt>잔여:</dt>
                        <dd class="number"><strong class="poi_1" id="RT"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="RT">조회</button></dd>
                    </dl>
                    <dl>
                        <dt>불가:</dt>
                        <dd class="number"><strong class="poi_1" id="FT"></strong> 건</dd>
                        <dd class="btnWrap"><button class="btn" value="FT">조회</button></dd>
                    </dl>
                </td>
            </tr>
            -->
        </table>
    </div><!-- //.tbl_bs2 -->

    <div class="tbl_bs">
        <table>
            <colgroup>
                <col width="">
                <col width="145px">
                <col width="72px">
                <col width="74px">
                <col width="78px">
                <col width="78px">
                <col width="74px">
                <!-- <col width="62px">
                <col width="62px">
                <col width="62px">
                <col width="62px"> -->
            </colgroup>
            <thead>
            <th>제목</th>
            <th>CID&SID</th>
            <th class="dv">분류</th>
            <th>태깅차수</th>
            <th>입수일자</th>
            <th>최종일자</th>
            <th class="dv">현재상태</th>
            <!-- <th class="bg1">입수</th>
            <th class="bg1">수집</th>
            <th class="bg1">추출</th>
            <th class="bg1">승인</th> -->
            </thead>
            <tbody>
            </tbody>

        </table>
        <%--<div class="btn_top_down">--%>
            <%--<div class="inner">--%>
                <%--<a href="javascript:fnMove('1');" class="btn btn_top">맨위로</a>--%>
                <%--<a href="javascript:fnMove('2');" class="btn btn_down">맨아래로</a>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div id="move2" class="pagenation">
            <!--
            <a href="#" class="btn btn_first">처음으로</a>
            <a href="#" class="btn btn_prev">이전페이지</a>
            <a href="#">1</a>
            <a href="#" class="current">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">6</a>
            <a href="#">7</a>
            <a href="#">8</a>
            <a href="#">9</a>
            <a href="#">10</a>
            <a href="#" class="btn btn_next">다음페이지</a>
            <a href="#" class="btn btn_last">마지막페이지</a>
            -->
        </div>
    </div><!-- //.tbl_bs2 -->
</div><!-- //contents -->


<%@ include file="/WEB-INF/jsp/common/ComFooter.jsp" %>
</body>
</html>

<script src="/js/dataview.js"></script>
<script>

    var dataViewTable = new DataViewTable();

    var dateRange = new OM_DATE_PICKER();
    dateRange.init({
        domCheckAll: ".btn_allday",
        domStartDate: "#startDate",
        domEndDate:   "#endDate",
        initStartDate: OM_UTIL.startDate(),
        initEndDate: OM_UTIL.currentDate(),
        onSelectStartDate: function(dateText){
        },
        onSelectEndDate: function(dateText){
        }
    });

    var searchStatics = function (searchStat) {

        OM_API(APIS.STAT_LIST, {
            searchstat: searchStat,
            searchsdate: dateRange.getStartDate(),
            searchedate: dateRange.getEndDate()
        }, function(data){
            dataViewTable.init({
                searchStat: searchStat,
                data : data,
                domId : ".tbl_bs"
            }).render();

            $.map(data.RESULT.COUNTS_STAT, function(value, key){
                var statCode = key.substr(-2) // "COUNT_FA" --> "FA"
                $("#"+statCode).html($.number(value));
            });

        }, function(){
            console.log("Error")
        });
    }

    $(document).ready(function(){

        $(".btn_result").click(function(){
            searchStatics("ALL");
        });

        $(".btnWrap .btn").click(function(){

            var searchStat = $(this).attr("value");
            searchStatics(searchStat);
        });

        OM_READY(function() {
            searchStatics("ALL");
        });
    });
    function fnMove(seq){
        var offset = $("#move" + seq).offset();
        $('html, body').animate({scrollTop : offset.top}, 400);
    }
</script>