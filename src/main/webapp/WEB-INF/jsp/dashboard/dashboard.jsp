<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--
************************************************************
* Comment : 대쉬 보드
* User    : Park
* Date    : 2017-12-13
***********************************************************
--%>

<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/ComHeader.jsp" %>

    <script>

        var render_dashboard = function($widget, value1, value2, value3){
            $widget.find(".inner dl dd").eq(0).html($.number( value1 ));
            $widget.find(".inner dl dd").eq(1).html($.number( value2 ));
            $widget.find(".stat .number strong").html($.number( value3 ));

        }

       $(document).ready(function(){

           OM_API(APIS.DASH_LIST,{},
                   function(data){

                       render_dashboard($(".progress").eq(0),
                               data.RESULT.LIST_STAT.COUNT_INSERTED,
                               data.RESULT.LIST_STAT.COUNT_INSERT_TAGGED,
                               data.RESULT.LIST_SUMMARY.COUNT_READY);

                       render_dashboard($(".progress").eq(1),
                               data.RESULT.LIST_STAT.COUNT_START_COLLECT,
                               data.RESULT.LIST_STAT.COUNT_COLLECTED,
                               data.RESULT.LIST_SUMMARY.COUNT_FAIL_COLLECT);

                       render_dashboard($(".progress").eq(2),
                               data.RESULT.LIST_STAT.COUNT_START_ANALYZE,
                               data.RESULT.LIST_STAT.COUNT_ANALYZED,
                               data.RESULT.LIST_SUMMARY.COUNT_FAIL_ANALYZE);

                       render_dashboard($(".progress").eq(3),
                               data.RESULT.LIST_STAT.COUNT_START_TAG,
                               data.RESULT.LIST_STAT.COUNT_TAGGED,
                               data.RESULT.LIST_SUMMARY.COUNT_READY_TAG);



                       var chart = AmCharts.makeChart( "rate_chart", {
                           "type": "serial",
                           "theme": "light",
                           "rotate": true,
                           "height" : "600",
                           "autoMarginOffset": 30,
                           "fontSize": 12,
                           "hideCredits":true,
                           "dataProvider": [ {
                               "processType": "태깅",
                               "ratio": data.RESULT.LIST_RATIO.RATIO_ALL_TAG,
                               "color": "#5679e1"
                           }, {
                               "processType": "수집",
                               "ratio": data.RESULT.LIST_RATIO.RATIO_COLLECT,
                               "color": "#f4728a"
                           }, {
                               "processType": "추출",
                               "ratio": data.RESULT.LIST_RATIO.RATIO_ANALYZE,
                               "color": "#85aa43"
                           } ],
                           "valueAxes": [ {
                               "gridColor": "#000000",
                               "gridAlpha": 0.2,
                               "dashLength": 5,
                               "minimum": 0,
                               "maximum": 100,
                           } ],
                           "startDuration": 0.3,
                           "columnWidth": 0.4,
                           "graphs": [ {
                               "balloonText": "[[category]]: <b>[[value]]</b>",
                               "balloonFunction": function(item) {
                                           return item.category + " : <b>" + $.number(item.values.value, 1) + "%</b>";
                               },
                               "fillAlphas": 0.8,
                               "fillColorsField": "color",
                               "lineAlpha": 0.2,
                               "type": "column",
                               "valueField": "ratio",

                           } ],
                           "categoryField": "processType",
                           "categoryAxis": {
                               "gridPosition": "start",
                               "axisAlpha": 0,
                               "fillAlpha": 0.05,
                               "fillColor": "#000000",
                               "gridAlpha": 0
                           }

                       } );

                       var provider = [];
                       data.RESULT.LIST_GRAPH_DAILY.LIST_CAPTION.forEach(function(v,k){

                           provider.push({
                               "processType": v,
                               "v1": data.RESULT.LIST_GRAPH_DAILY.LIST_COUNT_INSERTED[k],
                               "v2": data.RESULT.LIST_GRAPH_DAILY.LIST_COUNT_COLLECTED[k],
                               "v3": data.RESULT.LIST_GRAPH_DAILY.LIST_COUNT_ANALYZED[k],
                               "v4": data.RESULT.LIST_GRAPH_DAILY.LIST_COUNT_TAGGED[k]
                           })
                       })

                       var chart = AmCharts.makeChart( "series_chart", {
                           "type": "serial",
                           "theme": "light",
                           "fontSize": 12,
                           "hideCredits":true,
                           "dataProvider": provider,
                           "valueAxes": [ {
                               "gridColor": "#000000",
                               "gridAlpha": 0.2,
                               "dashLength": 5
                           }],
                           "startDuration": 0,
                           "columnWidth": 0.4,
                           "gridAboveGraphs": true,
                           "graphs": [ {
                               "title": "입수",
                               "balloonText": "[[title]]: <b>[[value]]</b>",
                               "bullet": "round",
                               "bulletSize": 10,
                               "bulletBorderColor": "#ffffff",
                               "bulletBorderAlpha": 1,
                               "bulletBorderThickness": 2,
                               "valueField": "v1"
                           },{
                               "title": "수집",
                               "balloonText": "[[title]]: <b>[[value]]</b>",
                               "bullet": "round",
                               "bulletSize": 10,
                               "bulletBorderColor": "#ffffff",
                               "bulletBorderAlpha": 1,
                               "bulletBorderThickness": 2,
                               "valueField": "v2"
                           }, {
                               "title": "추출",
                               "balloonText": "[[title]]: <b>[[value]]</b>",
                               "bullet": "round",
                               "bulletSize": 10,
                               "bulletBorderColor": "#ffffff",
                               "bulletBorderAlpha": 1,
                               "bulletBorderThickness": 2,
                               "valueField": "v3"
                           }, {
                               "title": "승인",
                               "balloonText": "[[title]]: <b>[[value]]</b>",
                               "bullet": "round",
                               "bulletSize": 10,
                               "bulletBorderColor": "#ffffff",
                               "bulletBorderAlpha": 1,
                               "bulletBorderThickness": 2,
                               "valueField": "v4"
                           }],
                           "chartCursor": {
                               "categoryBalloonEnabled": false,
                               "cursorAlpha": 0,
                               "zoomable": false
                           },
                           "categoryField": "processType",
                           "categoryAxis": {
                               "gridPosition": "start",
                               "axisAlpha": 0,
                               "fillAlpha": 0.05,
                               "fillColor": "#000000",
                               "gridAlpha": 0
                           },
                           "legend": {
                               "position": "right",
                           }

                       } );


                   }, function() {
                       //error
                   }
           );

        })



    </script>
    <style>
        .box {
            width: 598px;
            height: 313px;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/jsp/common/ComHeaderWrapper.jsp" %>


<div class="contents">
    <div class="progressWrap">
        <div class="progress">
            <h2>진행편수</h2>
            <div class="inner">
                <dl>
                    <dt>입수완료</dt>
                    <dd>0</dd>
                </dl>
                <dl>
                    <dt>태깅완료</dt>
                    <dd>0</dd>
                </dl>
            </div>
            <div class="stat">
                <span class="tit">잔여 처리대기:</span>
                <span class="number"><strong>0</strong>건</span>
                <a href="/metatag.do?searchType=WT" class="btn_go">GO</a>
            </div>
        </div>
        <div class="progress">
            <h2>수집건수</h2>
            <div class="inner">
                <dl>
                    <dt>수집시도</dt>
                    <dd>0</dd>
                </dl>
                <dl>
                    <dt>수집완료</dt>
                    <dd>0</dd>
                </dl>
            </div>
            <div class="stat">
                <span class="tit">잔여 수집실패:</span>
                <span class="number"><strong>0</strong>건</span>
                <a href="/metatag.do?searchType=FC" class="btn_go">GO</a>
            </div>
            <span class="next">다음</span>
        </div>
        <div class="progress">
            <h2>추출건수</h2>
            <div class="inner">
                <dl>
                    <dt>추출시도</dt>
                    <dd>0</dd>
                </dl>
                <dl>
                    <dt>추출완료</dt>
                    <dd>0</dd>
                </dl>
            </div>
            <div class="stat">
                <span class="tit">잔여 추출실패:</span>
                <span class="number"><strong>0</strong>건</span>
                <a href="/metatag.do?searchType=FA" class="btn_go">GO</a>
            </div>
            <span class="next">다음</span>
        </div>
        <div class="progress">
            <h2>승인건수</h2>
            <div class="inner">
                <dl>
                    <dt>승인대기</dt>
                    <dd>0</dd>
                </dl>
                <dl>
                    <dt>승인완료</dt>
                    <dd>0</dd>
                </dl>
            </div>
            <div class="stat">
                <span class="tit">잔여 승인대기:</span>
                <span class="number"><strong>0</strong>건</span>
                <a href="/metatag.do?searchType=RT" class="btn_go">GO</a>
            </div>
        </div>
    </div><!-- //progressWrap -->

    <div class="chartWrap">
        <div class="dv2 ratio">
            <h3>처리 비율</h3>
            <div id="rate_chart" class="box"></div>
        </div>
        <div class="dv2 change">
            <h3>진행 추이</h3>
            <div id="series_chart" class="box"></div>
        </div>
    </div><!-- //chartWrap -->
</div><!-- //contents -->

<%@ include file="/WEB-INF/jsp/common/ComFooter.jsp" %>
</body>
</html>
