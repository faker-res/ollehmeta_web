<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--
************************************************************
* Comment : 소셜 분석
* User    : Park
* Date    : 2017-12-13
***********************************************************
--%>

<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/ComHeader.jsp" %>
</head>
<body>
<%--nav begins--%>
<%@ include file="/WEB-INF/jsp/common/ComHeaderWrapper.jsp" %>
<%--nav ends--%>
<!-- //contents begins-->
<div class="contents socialAnalysis">
    <div class="modHeader">
        <h2>영화 소셜 키워드 TOP 10</h2>
        <span class="today">today : 2017-12-06</span>
    </div>
    <div class="socialWrap">
        <h3><img src="/img/social_instagram.png" alt="인스타그램"></h3>
        <div class="inner">
            <div class="top10_list">
                <ol id="instaList">

                </ol>
            </div>
            <div class="graphWrap">
                <div class="inner">
                    <%--<div class="top10_title">버킷리스트:죽기전에 꼭 하고 싶은 것들</div>--%>
                    <div id="instaGraph" alt="" style="width: 858px;height: 358px;"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="socialWrap">
        <h3><img src="/img/social_twitter.png" alt="트위터"></h3>
        <div class="inner">
            <div class="top10_list">
                <ol id="twitterList">

                </ol>
            </div>
            <div class="graphWrap">
                <div class="inner">
                    <%--<div class="top10_title">범죄도시</div>--%>
                    <div id="twitterGraph"  alt="" style="width: 858px;height: 358px;"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //contents ends-->

<%--footer section begins --%>
<%@ include file="/WEB-INF/jsp/common/ComFooter.jsp" %>
<%--footer section ends --%>
</body>
</html>
<script>

    function zeroFill( number, width )
    {
        width -= number.toString().length;
        if ( width > 0 ){
            return new Array( width + (/\./.test( number ) ? 2 : 1) ).join( '0' ) + number;
        }
        return number + ""; // always return a string
    }

    $(document).ready(function() {

        OM_READY(function(){
            // set today
            var dt = new Date();
            var month = dt.getMonth()+1;
            var day = dt.getDate();
            var year = dt.getFullYear();
            var date = + year+"-"+ zeroFill(month, 2) + '-' + zeroFill(day, 2);
            $(".today").html("today : "+ date);

            OM_API(
                APIS.SOCIAL, {},
                    function(response){

                        var instaList = response.RESULT.WORDS_INSTAGRAM;
                        var twitterList = response.RESULT.WORDS_TWITTER;
                        addList("#instaList", instaList);
                        addList("#twitterList", twitterList);

                        addGraph("instaGraph",
                                response.RESULT.GRAPH_INSTAGRAM.CAPTIONS,
                                response.RESULT.WORDS_INSTAGRAM,
                                response.RESULT.GRAPH_INSTAGRAM
                        );
                        addGraph("twitterGraph",
                                response.RESULT.GRAPH_TWITTER.CAPTIONS,
                                response.RESULT.WORDS_TWITTER,
                                response.RESULT.GRAPH_TWITTER
                        );

                }, function(){
                    console.log("Error")
            });
        });
    });


    function addList(elem, list) {
        var $list = $(elem);

        for ( var i = 0; i < list.length ; i ++) {
            var item = list[i];
            $list.append(' <li>\
                    <span class="num">'+(i+1)+'</span>\
                    <a href="#">'+item+'</a> \
                    </li>');
        }
    }

    function addGraph(elem, CAPTIONS, WORDS, GRAPH) {
        var provider = [];

        $(CAPTIONS).each(function(k, v){

            var item = {
                "processType": v,
            };
            $(WORDS).each(function(i,v){
                item["v"+i] = GRAPH["ITEM" + zeroFill(i+1, 2)][k]
            });
            provider.push(item)
        });

        var graphs = [];
        $(WORDS).each(function(i,v){

            var graph = {
                "title": v,
                "balloonText": "[[title]]: <b>[[value]]</b>",
                "bullet": "round",
                "bulletSize": 10,
                "bulletBorderColor": "#ffffff",
                "bulletBorderAlpha": 1,
                "bulletBorderThickness": 2,
                "valueField": "v"+i
            };
            graphs.push(graph);

        });
        /**
         * Define a plugin that replaces zeros in data with null
         */
        AmCharts.addInitHandler(function(chart) {

            // iterate through data
            for(var i = 0; i < chart.dataProvider.length; i++) {
                var dp = chart.dataProvider[i];
                for(var x in dp) {
                    if (dp.hasOwnProperty(x) && !isNaN(dp[x]) && dp[x] == 0)
                        dp[x] = null;
                }
            }

        }, ["serial"]);

        var chart = AmCharts.makeChart( elem , {
            "type": "serial",
            "theme": "light",
            "fontSize": 12,
            "hideCredits":true,
            "dataProvider": provider,
            "valueAxes": [ {
                "minimum": 1,
                "maximum": 10,
                "reversed": true,
                "autoGridCount": false,
                "gridCount": 10,
                "axisAlpha": 0,
                "dashLength": 5
            }],
            "startDuration": 0,
            "columnWidth": 0.4,
            "gridAboveGraphs": true,
            "graphs": graphs,
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
                "gridAlpha": 0,
                "position": "top",
                "step":1
            },
            "legend": {
                "position": "right",
            }

        } );
    }

</script>