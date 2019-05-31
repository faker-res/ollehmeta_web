


var MetaDictionary = function() {

    this.init = function (settings) {
        this.data = settings.data;
        this.gotoIndex = settings.gotoIndex;
        this.tagPosition = settings.tagPosition;
        this.onDataChangeEvent = settings.onDataChangeEvent || this.onDataChangeEvent;

        //  기존 데이터를 삭제 한다
        $(".editwrap span").remove();
        this.onDataChangeEvent();
        return this;
    };

    this.onDataChangeEvent = function() {
        $(".tabNav2 span").text( $("#dic_tab2 .editwrap .tag").length );
        $(".tabNav3 span").text( $("#dic_tab3 .editwrap .tag").length );
        $(".tabNav4 span").text( $("#dic_tab4 .editwrap .tag").length );
        $(".tabNav5 span").text( $("#dic_tab5 .editwrap .tag").length );
    };

    this.addTag = function(tagName, tagType, enableMenu) {
        var thisObject = this;
        var metaTag = new MetaTag()
        metaTag.init({
            parentDom : "allMetaTag",
            tagName: tagName,
            tagRatio: "0",
            tagType: tagType,
            tagGroup: "DIC",
            enableMenu: enableMenu,
            enableRatio: false,
            tagPosition: thisObject.tagPosition,
            onDataChangeEvent: thisObject.onDataChangeEvent,
            onClickMenu : function(dom) {
                var thisObject = metaTag;

                $("#"+thisObject.tagId + " .sortWrap label").removeClass("current");
                $(dom).addClass("current");
                $(dom).find("input").prop('checked', true);
                var position = $(dom).attr("value");

                if ( position != thisObject.tagPosition ) {

                    // 현재 ELM 삭제 후 추가
                    MetaHistoryManager.add(thisObject.tagName,
                        thisObject.tagPosition,
                        thisObject.tagName,
                        "del");

                       MetaHistoryManager.add(thisObject.tagName,
                           position,
                           thisObject.tagName,
                        "mod");


                    (new MetaTag()).init({
                        parentDom : "moveMetaTag",
                        tagName: thisObject.tagName,
                        tagRatio: thisObject.tagRatio,
                        tagType: "dic_move",
                        tagGroup: "DIC",
                        onDataChangeEvent: thisObject.onDataChangeEvent,
                        enableRatio: false,
                        enableMenu: false,
                        enableDelete: false,
                        enableAllEvent: false
                    }).add();
                    thisObject.setTagPosition("dic_move");
                }
                $("#"+ thisObject.parentDom + " span").removeClass("mod");
                return true;
            }
        }).add()
    };

    this.render = function () {
        var thisObject = this;

        this.data.RESULT.LIST_WORDS.forEach(function(tagName){

            // 불용 키워드 및 대체 키워드는 위치 이동을 하지 않는다.
            var enableMenu = true;
            if ( thisObject.data.RESULT.TYPE == "CHANGE" || thisObject.data.RESULT.TYPE == "NOTUSE" ) {
                enableMenu = false;
            }
            thisObject.addTag(tagName, "dic_all", enableMenu);
        });

        this.paging();
        this.addPagingEvent();
        this.onDataChangeEvent();
        return this;
    };

    this.paging = function() {

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

            if ( index == 0 || index == 21) {
                return;
            }

            if (thisObject.data.RESULT.LIST_ACTIVE[index] == "active") {
                pagingHtml += "<a href='#' class='current' value="+pageNo+">"+pageNo+"</a>";
            } else {
                pagingHtml += "<a href='#' value="+pageNo+">"+pageNo+"</a>";
            }

        });

        if ( typeof this.data.RESULT.LIST_PAGING[11] != "undefined" ) {
            pagingHtml += "<a href='#' class='btn btn_next' value='next' data='"+ this.data.RESULT.LIST_PAGING[21]+"'>다음페이지</a>\
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
            thisObject.gotoIndex(nextPageNo);

        });
    };

    this.addEvent = function () {

    }
}