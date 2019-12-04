

var DataViewTable = function() {
    this.init = function(settings) {
        this.data = settings.data;
        this.domId = settings.domId;
        $(this.domId + " tbody").html("");
        this.searchStat = settings.searchStat;

        return this;
    };

    this.render = function () {
        var thisObject = this;
        var data = this.data;
        var SEARCH_TYPE = {
            "ALL" : "전체",
            "OTH" : "해외영화",
            "KOR" : "한국영화",
            "SER" : "시리즈",
            "yj":"YJ",
            "CcubeContent": "CCUBE"
        };

        var SEARCH_STAT = {
            "ALL" : "전체",
            "RC" : "수집대기",
            "SC" : "수집성공",
            "FC" : "수집실패",
            "RR" : "정제대기",
            "SR" : "정제성공",
            "FR" : "추출실패",
            "RA" : "추출대기",
            "SA" : "추출성공",
            "FA" : "추출실패",
            "FT" : "승인불가",
            "RT" : "승인대기",
            "ST" : "태깅완료",
            "Y"  : "수집대기",	//2019.11.25
            "CT" : "태깅불가",	//2019.12.04
            "MG" : "중복"		//2019.12.04
        };

        $(data.RESULT.LIST_ITEMS).each(function(k,item) {

            var html = ' <tr>\
            <td class="left">'+item.TITLE+'</td>\
            <td>'+item.CID+'</td>\
            <td class="dv">'+SEARCH_TYPE[item.TYPE]+'</td>\
            <td>'+item.CNT_TAG+'</td>\
            <td>'+thisObject.getFormatDate(new Date(item.REGDATE))+'</td>\
            <td>'+thisObject.getFormatDate(new Date(item.PROCDATE))+'</td>\
            <td class="dv">'+SEARCH_STAT[item.STAT]+'</td>\
            </tr>';

            $(thisObject.domId +" tbody").append(html);
        });

        this.paging();
        this.addPagingEvent();
    }

    this.paging = function() {
//
        var pagingHtml = "";
        $(".pagenation").html("");

        if (  this.data.RESULT.LIST_PAGING.length == 0 ) {
            return;
        }

        if ( this.data.RESULT.LIST_PAGING[0] != 0 ) {
            pagingHtml += "<a href='#' class='btn btn_first' value='first'>처음으로</a>\
           <a href='#' class='btn btn_prev' value='prev' data='"+ this.data.RESULT.LIST_PAGING[0]+"'>이전페이지</a>";
        }

        var thisObject = this;
        this.data.RESULT.LIST_PAGING.forEach(function(pageNo, index){

            if ( index == 0 || index == 11) {
                return;
            }

            if (thisObject.data.RESULT.LIST_PAGING_ACTIVE[index] == "active") {
                pagingHtml += "<a href='#' class='current' value="+pageNo+">"+pageNo+"</a>";
            } else {
                pagingHtml += "<a href='#' value="+pageNo+">"+pageNo+"</a>";
            }
        });

        if ( typeof this.data.RESULT.LIST_PAGING[11] != "undefined" ) {
            pagingHtml += "<a href='#' class='btn btn_next' value='next' data='"+ this.data.RESULT.LIST_PAGING[11]+"'>다음페이지</a>\
            <a href='#' class='btn btn_last' value='last'>마지막페이지</a>";
        }

        $(".pagenation").html(pagingHtml);
    };

    this.addPagingEvent = function () {

        if (  this.data.RESULT.LIST_PAGING.length == 0 ) {
            return;
        }

        var thisObject = this;
        $(".pagenation a").click(function () {

            var selectedPageNo = $(this).attr("value");
            var currentPageNo = thisObject.data.RESULT.PAGENO;
            var lastPageNo =  thisObject.data.RESULT.MAXPAGE;
            var nextPageNo = 1;

            if ( thisObject.data.RESULT.PAGENO == selectedPageNo) {
                // 현재 페이지
                return;
            }
            switch(selectedPageNo) {
                case "first":
                    nextPageNo = 1;
                    break;
                case "prev":
                    nextPageNo = $(this).attr("data");
                    break;
                case "next":
                    nextPageNo = $(this).attr("data");
                    break;
                case "last":
                    nextPageNo = lastPageNo;
                    break;
                default:
                    nextPageNo = selectedPageNo;
                    break;
            }
            searchExecute(thisObject, nextPageNo);

        });
    };

    var searchExecute = function(thisObject, searchPageNo){

        var pageNo = searchPageNo || 1;

        // 조회 결과를 가져 오고
        // 테이블을 갱신한다.

        OM_API(APIS.STAT_LIST, {
            searchstat: thisObject.searchStat,
            searchsdate: dateRange.getStartDate(),
            searchedate: dateRange.getEndDate(),
            pageno : searchPageNo
        }, function(data){

            dataViewTable.init({
                searchStat: thisObject.searchStat,
                data : data,
                domId : ".tbl_bs"
            }).render();

            $.map(data.RESULT.COUNTS_STAT, function(value, key){
                var statCode = key.substr(-2) // "COUNT_FA" --> "FA"
                $("#"+statCode).html(value);
            });

        }, function(){
            console.log("Error")
        });
    }

    this.getFormatDate = function(date){
        var year = date.getFullYear().toString().substr(-2);
        var month = (1 + date.getMonth());
        month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
        var day = date.getDate();
        day = day >= 10 ? day : '0' + day;
        return  year + '/' + month + '/' + day;
    }
}