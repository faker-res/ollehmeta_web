

var MetaHistoryManager = {
    metaTagHistory : [],
    add : function (word, target_type, target_word, action) {

        word = word.trim();
        target_word = target_word.trim();

        this.metaTagHistory.push({
            meta: word,
            type: target_type,
            target_meta : target_word,
            action: action
        })
    },
    reset : function() {
        this.metaTagHistory = []
    },
    get : function() {
        return this.metaTagHistory;
    },
    getDictionary : function() {

        var dicTagHistory = [];
        for(var i = 0; i < this.metaTagHistory.length; i++) {
            var dicTag = this.metaTagHistory[i];

            dicTagHistory.push({
                word: dicTag.meta,
                target_type: dicTag.type,
                target_word : dicTag.target_meta,
                action: dicTag.action
            })
        }

        return dicTagHistory;

    }
};

function metaLayerAction(){
    // 히스토리를 삭제 한다.
    MetaHistoryManager.reset();

    var id = "ly_autopop_01";
    var layid = document.getElementById(id),
        dim = $('<div class="mod_dim" />');
    if(layid.style.display == 'none'){
        $('html,body').addClass('bodyHidden');
        $('#'+id).fadeIn(0);
        $(layid).before(dim);
        position_cm($(layid)); // layer positioning
    }
    else{
        $('html,body').removeClass('bodyHidden');
        $('#'+id).fadeOut(0);
        $(layid).prev(dim).remove();
    }
}

/**
 * 메타 테그
 * (new MetaTag()).init({parentDom : "metaWhere", tagName: "서울", tagRatio: 8.9, tagType: "new", }).add()
 * @constructor
 */
var MetaTag = function() {

    this.init = function(settings){
        this.parentDom  = settings.parentDom;
        this.tagName    = settings.tagName;
        this.tagType    = settings.tagType;

        if ( typeof settings.tagRatio == "number" ){
            this.tagRatio   = settings.tagRatio.toFixed(2);
        }else {
            this.tagRatio   = settings.tagRatio;
        }

        this.enableMenu = settings.enableMenu;
        this.enableRatio  = settings.enableRatio;
        if ( typeof settings.enableDelete == "undefined" ) {
            this.enableDelete = true;
        } else {
            this.enableDelete  = settings.enableDelete;
        }
        this.tagGroup     = settings.tagGroup || "metatag";
        this.tagPosition     = settings.tagPosition || "when";
        this.onClickMenu  = settings.onClickMenu || this.onClickMenu;

        this.onDataChangeEvent   = settings.onDataChangeEvent || function(){};
        this.enableAllEvent = true;
        this.tagId        = guid();
        this.editMode     = false;
        this.tagStatus    = "default";
        if ( typeof settings.enableAllEvent != "undefined" ) {
            this.enableAllEvent = settings.enableAllEvent;
        }

        return this;
    };

    this.add = function() {

        var tagName ="";
        if ( typeof this.enableMenu != "undefined" && this.enableMenu == false ){
            tagName = this.tagName
        } else {
            if (this.tagRatio == 0) {
                tagName = this.tagName + "<em></em>";
            } else {
                tagName = this.tagName + "<em>"+ this.tagRatio+"</em>"
            }
        }
        if ( typeof this.enableRatio != "undefined" && this.enableRatio == false) {
            tagName = this.tagName
        }

        var marker = $("<span id="+this.tagId+" class='tag' tag-posion='"+this.tagPosition+"' ></span>").loadTemplate("#template_meta_tag", {
            tagName : tagName
        });

        var thisObject = this;
        marker.find("input[type=radio]").each(function(){
            $(this).attr("name", thisObject.tagId+"-radio");
            $(this).attr("id", thisObject.tagId+"-radio");
        });

        if ( typeof $("#"+ this.parentDom + " .tag_add")[0] != "undefined") {
            // 메타관리 탭인 경우
            $("#"+ this.parentDom + " .tag_add").before(marker)
        } else if (thisObject.tagGroup == "DIC" && thisObject.tagType == "dic_new" && $("#"+ this.parentDom + " span" ).length > 0  ) {
            //$("#"+ this.parentDom + " span").eq(0).before(marker);
            $("#"+ this.parentDom + " span" ).eq(0).before(marker);
        }else {
            // 미분류 탭인 경우 .tag_add 가 없다.
            $("#"+ this.parentDom).append(marker)
        }

        marker.find("#"+ this.parentDom + "Position").addClass("current");
        marker.find("#"+ this.parentDom + "Position").find("input").prop('checked', true);


        switch( this.tagType ) {
            case "update":      $("#"+this.tagId).addClass("bgc_4"); break;
            case "dup":         $("#"+this.tagId).addClass(""); break;
            case "ext":         $("#"+this.tagId).addClass("bgc_2"); break;
            case "new":         $("#"+this.tagId).addClass("bgc_3"); break;
            case "dic_all":     $("#"+this.tagId).addClass(""); break;
            case "dic_new":     $("#"+this.tagId).addClass("bgc_add"); break;
            case "dic_move":    $("#"+this.tagId).addClass("bgc_move"); break;
            case "dic_update":  $("#"+this.tagId).addClass("bgc_mod"); break;
            case "dic_del":     $("#"+this.tagId).addClass("bgc_del"); break;
            default : break;
        }

        if ( this.enableAllEvent ) {
            this.addEvent();
        }

        this.onDataChangeEvent();
    };

    this.addEvent = function() {

        var thisObject = this;
        // 메뉴 이동 팝업

        if ( typeof this.enableMenu != "undefined" && this.enableMenu == false ) {}
        else {
            $("#"+this.tagId).contextmenu(function(){

                $("#"+ thisObject.parentDom + " span").removeClass("mod");
                $(this).addClass("mod");
                return false;
            });
        }

        $("#"+this.tagId + " #displayTag").dblclick(function(event) {
            $("#"+thisObject.tagId).removeClass("mod");

            $("#"+thisObject.tagId + " #displayTag").hide();
            $("#"+thisObject.tagId + " #updateTag").show();
            $("#"+thisObject.tagId).removeClass("tag");
            $("#"+thisObject.tagId).removeClass("mod");
            $("#"+thisObject.tagId).addClass("tag_add");
            $("#"+thisObject.tagId + " .btn_del").hide();

            $("#"+thisObject.tagId + " #updateTag").val(thisObject.tagName);
            
            $("#"+thisObject.tagId).find("#updateTag").attr("data-id",thisObject.tagId);

            thisObject.editMode = true; // 수정 모드

            function release() {
                var updateKeyword = $("#"+thisObject.tagId + " #updateTag").val() ;
                if (updateKeyword.length > 50 ) {
                    OM_ALERT("입력 글자 수를 50자 이상 넣을 수 없습니다.");
                    return;
                }

                thisObject.editMode = false;

                MetaHistoryManager.add(thisObject.tagName ,
                    thisObject.tagPosition,
                    updateKeyword,
                    "mod");

                if ( thisObject.tagGroup == "DIC") {
                    $("#"+thisObject.tagId).attr("class","tag");
                    if ( thisObject.tagName != $("#"+thisObject.tagId + " #updateTag").val() ){
                        //수정 하지 않았다면 업데이트 하지 않는다.
                        thisObject.tagName = $("#"+thisObject.tagId + " #updateTag").val();
                        thisObject.tagStatus = "update";
                    }
                    if ( thisObject.tagStatus == "update" ) {
                        $("#"+thisObject.tagId).addClass("bgc_mod");
                    }

                    $("#"+thisObject.tagId + " #displayTag").text(thisObject.tagName);
                    $("#"+thisObject.tagId + " #displayTag").show();
                    $("#"+thisObject.tagId + " #updateTag").hide();

                    $("#"+thisObject.tagId + " .btn_del").show();

                    //추가
                    (new MetaTag()).init({
                        parentDom : "updateMetaTag",
                        tagName: thisObject.tagName,
                        tagRatio: thisObject.tagRatio,
                        tagPosition: thisObject.tagPosition,
                        tagType: "dic_mod",
                        tagGroup: "DIC",
                        enableRatio: false,
                        enableMenu: false,
                        enableDelete: false,
                        onDataChangeEvent: thisObject.onDataChangeEvent,
                        enableAllEvent: false
                    }).add();

                } else {
                    if ( thisObject.tagName != $("#"+thisObject.tagId + " #updateTag").val() ){
                        //수정 하지 않았다면 업데이트 하지 않는다.
                        thisObject.tagName = $("#"+thisObject.tagId + " #updateTag").val();
                        
                        //배경색
                        var strTagType = thisObject.parentDom.substring(4).toLowerCase();
                        var addTagType = ($("#list_"+strTagType).find("option[value='"+thisObject.tagName+"']").length>0) ? "bgc_4" : "bgc_3";	//bgc_4:update , bgc_3:new
                        var removeTagType = ($("#list_"+strTagType).find("option[value='"+thisObject.tagName+"']").length>0) ? "bgc_3" : "bgc_4";	//bgc_4:update , bgc_3:new
                        $("#"+thisObject.tagId).removeClass(removeTagType);
                        $("#"+thisObject.tagId).addClass("tag " + addTagType);
                        
                    } else {
                        $("#"+thisObject.tagId).addClass("tag");
                        
                        //자동완성
                        $("#"+thisObject.tagId + " .metaUpdateInput").data("type",thisObject.parentDom.substring(4).toLowerCase());
                        
                        var v1 = document.getElementById(thisObject.tagId);
                        var v2 = v1.getElementsByClassName("metaUpdateInput")[0];
                        
                        document.getElementById(thisObject.tagId).getElementsByClassName("metaUpdateInput")[0].addEventListener("focus",fnAutoCompletePop(document.getElementById(thisObject.tagId).getElementsByClassName("metaUpdateInput")[0]));
                    }
                    $("#"+thisObject.tagId + " #displayTag").text(thisObject.tagName);
                    $("#"+thisObject.tagId + " #displayTag").show();
                    $("#"+thisObject.tagId + " #updateTag").hide();
                    $("#"+thisObject.tagId).removeClass("tag_add");

                    $("#"+thisObject.tagId + " .btn_del").show();
                }

            }
            //$("#"+thisObject.tagId + " #updateTag").mouseleave(function(e) {
            //    release();
            //})

            $("#"+thisObject.tagId + " #updateTag").off();
            $("#"+thisObject.tagId + " #updateTag").keyup(function(e) {
                if (e.keyCode == 13) {
                    // 엔터를 입력 하면 반영한다.
                    release()
                }
            });
            event.preventDefault();
            return false;
        });

        if (  this.enableDelete ) {
            // 삭제 버튼 활성화
            $("#"+this.tagId).hover(function(){

                if ( !thisObject.editMode ) {
                    $("#"+thisObject.tagId + " .btn_del").css("display", "inline-block");
                }
            });
            // 삭제 버튼 숨김
            $("#"+this.tagId).mouseleave(function(){
                if ( !thisObject.editMode ) {
                    $("#" + thisObject.tagId + " .btn_del").css("display", "")
                }
            });
            // 삭제
            $("#"+thisObject.tagId + " .btn_del").click(function(){
                $("#"+thisObject.tagId).hide();

                MetaHistoryManager.add(thisObject.tagName,
                    thisObject.tagPosition,
                    thisObject.tagName,
                    "del");

                if ( thisObject.tagGroup == "DIC" ){
                    (new MetaTag()).init({
                        parentDom : "delMetaTag",
                        tagName: thisObject.tagName,
                        tagRatio: thisObject.tagRatio,
                        tagType: "delete",
                        tagGroup: "DIC",
                        enableRatio: false,
                        enableAllEvent: false
                    }).add()
                    thisObject.onDataChangeEvent();
                }
            });
        }


        // 메뉴 숨김 처리
        $("#"+this.tagId +  " .sortWrap").mouseleave(function(){
            $("#"+thisObject.tagId).removeClass("mod");
        })
        // 메뉴 아이템 클릭
        $("#"+this.tagId +  " .sortWrap label").click(function(){
            thisObject.onClickMenu(this);
        })
    }

    this.onClickMenu = function(dom) {

        var thisObject = this;

        $("#"+thisObject.tagId + " .sortWrap label").removeClass("current");
        $(dom).addClass("current");
        $(dom).find("input").prop('checked', true);

        var gotoPosition = $(dom).attr("id").replace("Position", "")
        if ( gotoPosition != thisObject.parentDom ) {
            // 현재 ELM 삭제 후 추가
            $("#"+thisObject.tagId).hide();

            MetaHistoryManager.add(thisObject.tagName ,
                thisObject.tagPosition,
                thisObject.tagName,
                "del");

            var targetPosition = gotoPosition.replace("meta", "").toLowerCase();
            MetaHistoryManager.add(thisObject.tagName ,
                targetPosition,
                thisObject.tagName,
                "add");

            (new MetaTag()).init({
                parentDom : gotoPosition,
                tagName: thisObject.tagName,
                tagPosition: targetPosition,
                tagRatio: thisObject.tagRatio,
                tagType: "update"
            }).add()
            
            //불용어사전 등록
            if(targetPosition=="notuse"){
            	var strNotuse = $("#txtNotuse").val() + (($("#txtNotuse").val()=="") ? "" : "////") + thisObject.tagName;
            	$("#txtNotuse").val(strNotuse);
            }
        }

    }

    this.setTagPosition = function(pos) {
        // tagType에 따라서 컬러 색을 달리 한다.
        switch( pos ) {
            case "update":      $("#"+this.tagId).addClass("bgc_4"); break;
            case "dup":         $("#"+this.tagId).addClass(""); break;
            case "ext":         $("#"+this.tagId).addClass("bgc_2"); break;
            case "new":         $("#"+this.tagId).addClass("bgc_3"); break;
            case "dic_all":     $("#"+this.tagId).addClass(""); break;
            case "dic_new":     $("#"+this.tagId).addClass("bgc_add"); break;
            case "dic_move":    $("#"+this.tagId).addClass("bgc_move"); break;
            case "dic_update":  $("#"+this.tagId).addClass("bgc_mod"); break;
            case "dic_del":     $("#"+this.tagId).addClass("bgc_del"); break;
            default : break;
        }
        this.onDataChangeEvent();
    }
};

function addMetaKeyword(data, parentTag, fnGetData, bAppend) {
    if ( typeof data == "object") {

        if( typeof bAppend != "undefined" && bAppend == true ) {
        } else {
            $("#"+ parentTag + " .tag").remove();
        }

        data.forEach(function(v, i){
            (new MetaTag()).init(fnGetData(v, parentTag)).add()
        })
    }
}

MetaPopupInstance = null;

var MetaPopup = function() {
    this.init = function(settings) {

        this.movieInfo = settings.movieInfo;
        this.data = settings.data;
        this.itemId = settings.itemId;
        this.tagCnt = settings.tagCnt || 0;
        this.tagStat = settings.tagStat;

        // 영화 정보 초기화
        $(".layTop").remove();
        $(".mod_comTab li").removeClass("on");
        $(".act-tabCn").removeClass("on");
        $(".mod_comTab li").eq(0).addClass("on");
        $(".act-tabCn").eq(0).addClass("on");

        MetaPopupInstance = this;
        return this;
    };

    this.isUpdating = function(){
        return $( ".metaUpdateInput:visible" ).length > 0 ? true : false;
    }

    this.render = function() {

        metaLayerAction();

        // 영화 정보 포스터
        // 포스터는 CCUBE 데이터로 가져온다

        OM_API( APIS.METAS_C_CUBE,{
            itemid: MetaPopupInstance.itemId
        },function(response){

            var posterImgUrl = response.RESULT.POSTER_URL;

            // 영화 정보
            $('<div></div>').appendTo("#ly_movieInfo").loadTemplate("#template_meta_movie_info", {
                tagCnt: MetaPopupInstance.tagCnt,
                tagPoster : posterImgUrl,
                movieTitle : MetaPopupInstance.movieInfo.RESULT.TITLE,
                movieOTitle : MetaPopupInstance.movieInfo.RESULT.OTITLE,
                bSeriesYN : MetaPopupInstance.movieInfo.RESULT.SERIESYN,
                movieGenre : MetaPopupInstance.movieInfo.RESULT.GENRE,
                movieDirector : MetaPopupInstance.movieInfo.RESULT.DIRECTOR,
                movieActor : MetaPopupInstance.movieInfo.RESULT.ACTOR,
                moviePlot : MetaPopupInstance.movieInfo.RESULT.PLOT,
            });

            $("#tagRollback").click(function(){

                if ( MetaPopupInstance.isUpdating() ) {
                    OM_ALERT("완료되지 않은 키워드가 있습니다<br> 작업 완료 후 다시 시도 바랍니다.");
                    return ;
                }

                var currentTagCnt = $("#tagNumber").text();
                currentTagCnt = parseInt(currentTagCnt) - 1;

                OM_CONFIRM("현재 태그를 모두 삭제하고<br>승인완료된 이전 차수 태그를 복구합니다.<br>복구하시겠습니까",
                    function () {
                        // OK 버튼을 누를 경우
                        OM_API( APIS.METAS_RECOVER,{
                            itemid: MetaPopupInstance.itemId
                        },function(response){

                            metaLayerAction();
                            OM_ALERT("복구 완료 했습니다.");

                            var pageNo = $(".pagenation .current").attr("value");
                            searchExecute(pageNo);
                            /*


                            OM_API(
                                APIS.METAS_META,
                                {itemid: MetaPopupInstance.itemId},
                                function(data){
                                    OM_API(
                                        APIS.METAS_MOVIE,
                                        {itemid: MetaPopupInstance.itemId},
                                        function(movieInfo){
                                            var metaPopup = new MetaPopup();
                                            metaPopup.init({
                                                movieInfo: movieInfo,
                                                data : data,
                                                tagCnt: MetaPopupInstance.tagCnt,
                                                itemId: MetaPopupInstance.itemId
                                            }).render();
                                        },
                                        function(){
                                            console.log("Error")
                                        });

                                },
                                function(){
                                    console.log("Error")
                                });
                             */
                            //OM_ALERT("복구 완료 했습니다.")

                        },function(){
                            OM_ALERT("복구 실패 했습니다.")
                        });

                    },
                    function () {
                        // Cancel 버튼을 누를 경우
                    })

            });
            if ( MetaPopupInstance.tagCnt == 0 ) {
                $("#tagRollback").attr("disabled","disabled");
            }

        },function(){
            console.log("Ajax ResponseError");
        });



        //$("#ly_movieInfo").appendTo(marker);

        // 태깅이 0이고 상태가 "승인대기" 인경우만 색깔이 나오면 된다.
        if ( this.tagCnt == 0 && this.tagStat == "RT") {
            $(".remarks").show();
            $(".btn_repair").attr("disabled", true);
        }
        // 그 외

        // 장르 체크박스
        function addWordsTag(parantId, data) {
            var html = ""
            data.forEach(function (word, k) {
                var tagId = "subtag_"+parantId+"_"+k;
                html += '<label for="'+tagId+'">\
                    <input type="checkbox" id="'+tagId+'" value="'+word+'">\
                    <span>'+word+'</span>\
                    </label>';
            });
            html += '<button class="btn_add_txt">추가</button>';
            $(parantId).html(html);

            $(parantId + " button").click(function(){
               // 서브 장르 추가 시 "감석/분위기" 로 이동한다.
                $(parantId+' input:checked').each(function() {
                    var tagName = $(this).val();

                    MetaHistoryManager.add(tagName ,
                        "emotion",
                        tagName,
                        "add");

                    (new MetaTag()).init({
                        parentDom : "metaEmotion",
                        tagPosition: "emotion",
                        tagName: tagName,
                        tagRatio: "0",
                        tagType: "new"
                    }).add()
                });
            });
        }
        
        //태그정보 로딩 - 팝업창에서 로드할 때는 없는 정보
        if(this.data.RESULT.WORDS_GENRE != null){
        	addWordsTag("#wordsGenre", this.data.RESULT.WORDS_GENRE);
        }
        if(this.data.RESULT.WORDS_SNS != null){
        	addWordsTag("#wordsSns",   this.data.RESULT.WORDS_SNS);
        }
        if(this.data.RESULT.WORDS_ASSOC != null){
        	addWordsTag("#wordsAssoc", this.data.RESULT.WORDS_ASSOC);
        }

        // 추출 주기 설정
        //태그정보 로딩 - 팝업창에서 로드할 때는 없는 정보
        if(this.data.RESULT.DURATION != null){
        	$("#metaDuation").val(this.data.RESULT.DURATION);
        }
        
        addMetaKeyword(this.data.RESULT.METASWHEN, "metaWhen", function(v, parentTag){
            return {
                parentDom : parentTag,
                tagPosition : "when",
                tagName: v.word,
                tagRatio: v.ratio,
                tagType: v.type };
        });
        addMetaKeyword(this.data.RESULT.METASWHERE, "metaWhere", function(v, parentTag){
            return {
                parentDom : parentTag,
                tagPosition : "where",
                tagName: v.word,
                tagRatio: v.ratio,
                tagType: v.type };
        });
        addMetaKeyword(this.data.RESULT.METASWHAT, "metaWhat", function(v, parentTag){
            return {
                parentDom : parentTag,
                tagPosition : "what",
                tagName: v.word,
                tagRatio: v.ratio,
                tagType: v.type };
        });
        addMetaKeyword(this.data.RESULT.METASWHO, "metaWho", function(v, parentTag){
            return {
                parentDom : parentTag,
                tagName: v.word,
                tagPosition : "who",
                tagRatio: v.ratio,
                tagType: v.type };
        });
        addMetaKeyword(this.data.RESULT.METASEMOTION, "metaEmotion", function(v, parentTag){
            return {
                parentDom : parentTag,
                tagPosition : "emotion",
                tagName: v.word,
                tagRatio: v.ratio,
                tagType: v.type };
        });

        addMetaKeyword(this.data.RESULT.METASCHARACTER, "metaCharacter", function(v, parentTag){
            return {
                parentDom : parentTag,
                tagPosition : "character",
                tagName: v.word,
                tagRatio: v.ratio,
                tagType: v.type };
        });

        addMetaKeyword(this.data.RESULT.LIST_NOT_MAPPED, "metaUnclassified", function(v, parentTag){
            return {
                parentDom : parentTag,
                tagName: v.word,
                tagPosition: "list_not_mapped",
                tagRatio: v.ratio,
                tagType: v.type };
        });
        
        //태그정보 로딩 - 팝업창에서 로드할 때는 없는 정보
        addMetaKeyword(this.data.RESULT.LIST_SUBGENRE, "listSubGenre", function(v, parentTag){
            return {
                parentDom : parentTag, tagName: v.word, tagRatio: 0, tagType: v.type, tagPosition: "listSubGenre", enableMenu: false };
        });

        addMetaKeyword(this.data.RESULT.LIST_SEARCHKEYWORDS, "listSearchKeywords", function(v, parentTag){
            return {
                parentDom : parentTag, tagName: v, tagRatio: 0, tagType: "", tagPosition: "listSearchKeywords",  enableMenu: false };
        });

        addMetaKeyword(this.data.RESULT.LIST_RECO_TARGET, "listRecoTarget", function(v, parentTag){
            return {
                parentDom : parentTag, tagName: v.word, tagRatio: 0, tagType: "", tagPosition: "listRecoTarget",  enableMenu: false };
        });

        addMetaKeyword(this.data.RESULT.METASCHARACTER, "listMetasCharacter", function(v, parentTag){
            return {
                parentDom : parentTag, tagName: v.word, tagRatio: 0, tagType: "", tagPosition: "listMetasCharacter",  enableMenu: false };
        });

        addMetaKeyword(this.data.RESULT.LIST_RECO_SITUATION, "listRecoSituation", function(v, parentTag){
            return {
                parentDom : parentTag, tagName: v.word, tagRatio: 0, tagType: "", tagPosition: "listRecoSituation", enableMenu: false };
        });

        addMetaKeyword(this.data.RESULT.LIST_AWARD, "listAward", function(v, parentTag){
            return {
                parentDom : parentTag, tagName: v, tagRatio: 0, tagType: "", tagPosition: "listAward", enableMenu: false };
        });

        // 미분류, 수상정보탭에 데이터가 있을 경우 * 표시 함
        // 초기화
        $("#undefinedTab").removeClass("existence");
        $("#awardInfoTab").removeClass("existence");
        var notMappedCount = this.data.RESULT.LIST_NOT_MAPPED.length;
        if ( notMappedCount != 0 ) {
            $("#undefinedTab").addClass("existence");
        }

        /*
        수상 정보 탭 삭제
        OM_API( APIS.METAS_AWARD,{
            itemid: MetaPopupInstance.itemId
        },function(response){
            //alert("API 수정 요청")

            if ( typeof response.RESULT.AWARD != "undefined" && response.RESULT.AWARD != "_FAIL") {
               // 데이터가 있을 경우 * 표시 함
                if ( response.RESULT.AWARD.length != 0 ) {
                    $("#awardInfoTab").addClass("existence");
                } else {
                }
            }
        },function(){
            console.log("Ajax ResponseError");
        });
         */

        // 씨네21 데이터 확인
        $("#cine21InfoTab").removeClass("existence");
        OM_API( APIS.METAS_CINE21,{
            itemid: MetaPopupInstance.itemId
        },function(response){

            if ( typeof response.RESULT.WORDS_CINE21 != "undefined") {
                // 데이터가 있을 경우 * 표시 함
                if ( response.RESULT.WORDS_CINE21.length != 0 ) {
                    $("#cine21InfoTab").addClass("existence");
                } else {
                }
            }

        },function(){
            console.log("수상정보")
        });
        
        //태그정보 로딩 - 다 처리 후 검색결과 창 있으면 닫기
        if($("#ly_pop_mcidSearchResult").css("display")=="block"){
        	$("#ly_pop_mcidSearchResult").css("display","none");
        }
        

        this.addEvent();
        return this;
    };

    this.addEvent = function() {

        // 서브 장르 추출

        $("#getSubGenreFromDB").off();
        $("#getSubGenreFromDB").click(function(){

            var metaList = ["metaWhen", "metaWhere", "metaWhat", "metaWho", "metaEmotion"];

            var result = [];
            metaList.forEach(function(metaName){

                $("#" + metaName ).find(".txt").each(function (v, k) {
                    if($(k).parent().css('display') !== 'none') {
                        var keyword = $(k).html().replace(/<em>(.*?)<(\/?)em>/gi,"");
                        result.push({"type" : metaName, "meta" : keyword });
                    };
                });
            });
            console.log(result);

            OM_API( APIS.METAS_GET_SUBGENRE,{
                itemid: MetaPopupInstance.itemId,
                items : JSON.stringify(result)
            },function(response){
                //alert("API 수정 요청")

                if ( response.RESULT.length == 0 ) {
                    OM_ALERT("추출된 서브 장르가 없습니다.");
                    return;
                }

                var bAppend = true;
                addMetaKeyword(response.RESULT, "listSubGenre", function(v, parentTag){

                    MetaHistoryManager.add(v.word ,
                        "listsubgenre",
                        v.word,
                        "add");

                    return {
                        parentDom : parentTag,
                        tagPosition : "emotion",
                        tagName: v.word,
                        tagRatio: v.ratio,
                        tagType: v.type };
                });

            },function(){
                console.log("Ajax ResponseError");
            });

        });

        // 수상정보 삭제 요청
        if (MetaPopupInstance.tagCnt == 0 ) {
            $("#removeAwardInfo").hide();
        } else {
            $("#removeAwardInfo").show();
            $("#removeAwardInfo").off();
            $("#removeAwardInfo").click(function(){
                OM_CONFIRM("현재 수상정보를 삭제 하시겠습니까?",
                    function () {
                        OM_API( APIS.POP_META_DEL_AWARD,{
                            itemid: MetaPopupInstance.itemId,
                        },function(response){
                            OM_ALERT("수상정보 삭제 했습니다.");
                        },function(){
                            console.log("수상정보를 삭제 에러");
                        });
                    },
                    function () {
                        // Cancel 버튼을 누를 경우
                    });
            });
        }


        // 닫기  승인 재수집 추출 처리
        $(".btnBig button").off();
        $(".btnBig button").click(function(e){

            if ( MetaPopupInstance.isUpdating() ) {
                OM_ALERT("완료되지 않은 키워드가 있습니다<br> 작업 완료 후 다시 시도 바랍니다.");
                return ;
            }

            var actionName = $(this).html();
            var durationValue = $( "#metaDuation option:selected" ).val();
            switch (actionName) {
                case "닫기":
                    OM_CONFIRM("메타수정을 취소 하시겠습니까?",
                        function () {
                            metaLayerAction();
                        },
                        function () {
                            // Cancel 버튼을 누를 경우
                        });
                    break;
                case "승인":
                    // 작업중
                    var metaHistory = MetaHistoryManager.get();
                    if( metaHistory.length == 0 ) {
                        // 수정 사항이 없다면 승인하지 않음
                        OM_ALERT("수정 사항이 없습니다.");

                    } else {
                        OM_API( APIS.METAS_UPT_ARRAY,{
                            itemid: MetaPopupInstance.itemId,
                            duration: durationValue,
                            items : JSON.stringify(metaHistory)
                        },function(response){
                        	//불용어사전 등록
                        	var strNotuse = $("#txtNotuse").val();
                        	if(strNotuse!=""){
	                        	var arrStrNotuse = strNotuse.split("////");
	                        	
	                        	var metaHistory = [];
	                        	var itemMetaHistory = {};
	                        	for(var i in arrStrNotuse){
	                        		itemMetaHistory = {
	                            		word:arrStrNotuse[i],
	                            		target_type: "NOTUSE",
	                            		target_word: arrStrNotuse[i],
	                            		action: "add"
	                            	};
	                        		
	                        		metaHistory[i] = itemMetaHistory;
	                        	}
	                        	
	                            OM_API(
	                                APIS.DIC_UPT_ARRAY, {
	                                    items: JSON.stringify(metaHistory)
	                                }, function(data){
	                                    //OM_ALERT("불용어사전에 등록되었습니다.");
	                                }, function(){
	                                    console.log("Error")
	                                }
	                            );
                        	}
                        	
                        	//(승인 기존 로직)
                            //alert("API 수정 요청")
                            metaLayerAction();
                            OM_ALERT("승인 완료 했습니다.");
                            MetaHistoryManager.reset();

                            var pageNo = $(".pagenation .current").attr("value");
                            searchExecute(pageNo);

                        },function(){
                            console.log("Ajax ResponseError");
                        });
                    }

                    break;
                case "즉시배포":
                    // 작업중
                    var metaHistory = MetaHistoryManager.get();
                    if( metaHistory.length == 0 ) {
                        // 수정 사항이 없다면 승인하지 않음
                        OM_ALERT("수정 사항이 없습니다.");

                    } else {
                        OM_API( APIS.METAS_UPT_ARRAY,{
                            itemid: MetaPopupInstance.itemId,
                            duration: durationValue,
                            sendnow: "Y",
                            items : JSON.stringify(metaHistory)
                        },function(response){
                            //alert("API 수정 요청")
                            metaLayerAction();
                            OM_ALERT("즉시 승인 완료 했습니다.");
                            MetaHistoryManager.reset();

                            var pageNo = $(".pagenation .current").attr("value");
                            searchExecute(pageNo);

                        },function(){
                            console.log("Ajax ResponseError");
                        });
                    }

                    break;
                case "재수집":
                    OM_CONFIRM("재수집을 진행 하시겠습니까?",
                        function () {
                            OM_API( APIS.ITEM_UPT_ONE,{
                                itemid: MetaPopupInstance.itemId,
                                target_type: "C"
                            },function(response){
                                metaLayerAction();
                                OM_ALERT("재수집 완료 했습니다.");
                                MetaHistoryManager.reset();

                                var pageNo = $(".pagenation .current").attr("value");
                                searchExecute(pageNo);

                            },function(){
                                //console.log("수상정보")
                            });
                        },
                        function () {
                            // Cancel 버튼을 누를 경우
                        });
                    break;
                case "재추출":

                    OM_CONFIRM("재추출을 진행 하시겠습니까?",
                        function () {
                            OM_API( APIS.ITEM_UPT_ONE,{
                                itemid: MetaPopupInstance.itemId,
                                target_type: "A"
                            },function(response){
                                //alert("API 수정 요청")

                                metaLayerAction();
                                OM_ALERT("재추출을 완료 했습니다.");
                                MetaHistoryManager.reset();

                                var pageNo = $(".pagenation .current").attr("value");
                                searchExecute(pageNo);

                            },function(){
                                console.log("재추출 에러")
                            });
                        },
                        function () {
                            // Cancel 버튼을 누를 경우
                        });
                    break;
                case "불가":

                    OM_CONFIRM("승인불가 진행 하시겠습니까?",
                        function () {
                            OM_API( APIS.ITEM_UPT_ONE,{
                                itemid: MetaPopupInstance.itemId,
                                target_type: "FT"
                            },function(response){
                                metaLayerAction();
                                OM_ALERT("승인불가 완료 했습니다.");
                                MetaHistoryManager.reset();

                                var pageNo = $(".pagenation .current").attr("value");
                                searchExecute(pageNo);

                            },function(){
                                //console.log("수상정보")
                            });
                        },
                        function () {
                            // Cancel 버튼을 누를 경우
                        });
                    break;
            }
        });

        // 탭 이동시 이벤트 처리
        if ( typeof $(".mod_comTab li a").data("init") == "undefined" ) {

            $(".mod_comTab li a").click(function(e) {
                var tabName = $(this).text();
                switch (tabName) {
                    case "메타관리":
                        return false;
                        break;
                    case "미분류":
                        return false;
                        break;
                    case "수상정보":
                        OM_API( APIS.METAS_AWARD,{
                            itemid: MetaPopupInstance.itemId
                        },function(response){
                            //alert("API 수정 요청")

                            if ( response.RESULT.AWARD == "_FAIL"){
                                $("#awardInfo").html("<div> 데이터가 없습니다.</div>");
                            } else if ( typeof response.RESULT.AWARD != "undefined" && response.RESULT.AWARD.length != 0) {

                                var html = response.RESULT.AWARD.substring(1, response.RESULT.AWARD.length);
                                html = html.substring(0, html.length-1);
                                html = html.replace(/\\n/gi, "");
                                html = html.replace(/\\/gi, "");
                                html = html.replace(/\<span class=\"screen_out\"\>현재페이지\<\/span\>/gi, "");
                                html = html.replace(/\<em class=\"link_page\"\>1\<\/em\>/gi, "");

                                if ( html.length > 0 ) {
                                    $("#awardInfo").html(html);
                                } else {
                                    $("#awardInfo").html("<div> 데이터가 없습니다.</div>");
                                }

                            } else {
                                $("#awardInfo").html("<div> 데이터가 없습니다.</div>");
                            };
                        },function(){
                            console.log("Ajax ResponseError");
                        });
                        return false;
                        break;
                    case "씨네21":
                        OM_API( APIS.METAS_CINE21,{
                            itemid: MetaPopupInstance.itemId
                        },function(response){

                            if ( typeof response.RESULT.WORDS_CINE21 != "undefined") {
                                // 데이터가 있을 경우 * 표시 함
                                if ( response.RESULT.WORDS_CINE21.length != 0 ) {
                                    $("#lypop_tab4 .cine21").html("");
                                    response.RESULT.WORDS_CINE21.forEach(function(v, k){
                                        $("#lypop_tab4 .cine21").append("<span>"+v+"</span>");
                                    });
                                } else {
                                    $("#cine21Info").html("<div> 데이터가 없습니다.</div>");
                                }
                            }

                        },function(){
                            console.log("수상정보")
                        });
                        return false;
                        break;
                    case "CCUBE":
                        OM_API( APIS.METAS_C_CUBE,{
                            itemid: MetaPopupInstance.itemId
                        },function(response){

                            $(".lypop_tab5 .ccube").html("");
                            var keys = Object.keys(response.RESULT);
                            keys.forEach(function(key){
                                $("#"+key.toLowerCase()).text(response.RESULT[key]);
                            });

                        },function(){
                            console.log("Ajax ResponseError");
                        });
                        return false;
                        break;
                }
            })
            $(".mod_comTab li a").data("init", true);
        }

        function addMetaAppend(parentTag){
            $("#"+parentTag+" .btn_add").off();
            $("#"+parentTag+" .btn_add").click(function(){
            	//parentTag에서 메타 타입 추출
            	var strTagType = parentTag.substring(4).toLowerCase();
            	console.log("strTagType : " + strTagType);
            	
                var inputTempId = guid();
                //기존
                //$(this).parent().prepend('<input id="'+inputTempId+'" class="metaUpdateInput" type="text" placeholder="입력">');
                //수정 : 함수 추가
                $(this).parent().prepend('<input id="'+inputTempId+'" class="metaUpdateInput" type="text" placeholder="입력" onfocus="fnAutoCompletePop(this)" data-type="'+strTagType+'"> ');	//data-type="'+strTagType+'" : parent.parent에서 가져오기 때문에 불필요(?) & focus -> keydown
                //여기까지 autoComplete
                
                $("#"+inputTempId).focus();
                console.log("updateTempId : " + inputTempId);


                $("#"+inputTempId).off();
                $("#"+inputTempId).keyup(function(e){
                    if (e.keyCode == 13) {
                        var metaKeyword = $(this).val();
                        if (metaKeyword.length > 50 ) {
                            OM_ALERT("입력 글자 수를 50자 이상 넣을 수 없습니다.");
                            return;
                        }

                        // 만약 위치 이동이 불가한 경우 체크를 해서 메뉴를 막는다
                        var tagPosition = parentTag.replace("meta", "").toLowerCase();

                        var enableMenu = true;
                        if ( parentTag.indexOf("list") >= 0 ){
                            enableMenu = false;
                        }
                        
                        //배경색
                        var strTagType = parentTag.substring(4).toLowerCase();
                        var tagType = ($("#list_"+strTagType).find("option[value='"+metaKeyword+"']").length>0) ? "update" : "new";
                        (new MetaTag()).init({
                            parentDom : parentTag,
                            tagName: metaKeyword ,
                            tagPosition: tagPosition,
                            tagRatio: "0",
                            //tagType: "update",	//배경색
                            tagType: tagType,	//배경색
                            enableMenu: enableMenu
                        }).add();
                        MetaHistoryManager.add(metaKeyword ,
                            tagPosition,
                            metaKeyword,
                            "add");

                        // input 창 삭제
                        $("#"+inputTempId).off();
                        $("#"+inputTempId).remove();
                    }
                })
            });

            // 해당 서브 카테고리 일괄 삭제 기능
            $("#"+parentTag+" .removeAll").off();
            $("#"+parentTag+" .removeAll").click(function(){
                //alert("삭제용");
                var $metaElm = $(this).parent().parent().find(".tag")
                $metaElm.each(function() {

                    if($(this).css('display') !== 'none') {
                        var metaName   = $(this).find("#displayTag").html().replace(/<em>(.*?)<(\/?)em>/gi,"");
                        var metaPosition = $(this).attr("tag-posion");

                        $(this).hide();
                        MetaHistoryManager.add(metaName,
                            metaPosition,
                            metaName,
                            "del");
                    }
                })
            });
        }

        addMetaAppend("metaWhen");
        addMetaAppend("metaWhere");
        addMetaAppend("metaWhat");
        addMetaAppend("metaWho");
        addMetaAppend("metaEmotion");
        addMetaAppend("metaCharacter");

        addMetaAppend("listSubGenre");
        addMetaAppend("listSearchKeywords");
        addMetaAppend("listRecoTarget");
        addMetaAppend("listRecoSituation");
        addMetaAppend("listAward");

        return this;
    };
};

var MetaTable = function() {

    this.init = function (settings) {
        this.data = settings.data;
        this.domId = settings.domId;
        $(this.domId + " tbody").html("");

        return this;
    };

    this.render = function () {
        var data = this.data;

        // 총 x 편중
        var countsSearch = data.RESULT.COUNTS_SEARCH;
        $(".inquiryResult .total strong").text($.number(countsSearch.COUNT_ALL));
        $(".inquiryResult .inner dd strong").eq(0).text($.number(countsSearch.COUNT_FAIL_COLLECT));
        $(".inquiryResult .inner dd strong").eq(1).text($.number(countsSearch.COUNT_FAIL_ANALYZE));
        $(".inquiryResult .inner dd strong").eq(2).text($.number(countsSearch.COUNT_READY_TAG));
        $(".inquiryResult .inner dd strong").eq(3).text($.number(countsSearch.COUNT_TAGGED));

        data.RESULT.LIST_ITEMS.forEach(function (item, k) {

            //테스트 코드
            //item.ITEMID = 10410;

            var html = "<tr>\
                        <td class='dv'><input type='checkbox' value=" + item.ITEMID + "></td>\
                        <td class='left'>" + item.TITLE + "</td>\
                        <td>" + item.CID + "</td>\
                        <td class='dv'>" + SEARCH_TYPE[item.TYPE] + "</td>\
                        <td>" + item.CNT_TAG + "</td>\
                        <td>" + item.REGID + "</td>\
                        <td>" + item.REGDATE.substr(2, 8) + "</td>\
                        <td>" + item.PROCDATE.substr(2, 14) + "</td>\
                        <td  id='searchStat' class='dv' value="+item.STAT+">" + SEARCH_STAT[item.STAT]+"</td>";


            switch(item.STAT) {
                case "FC":
                    html += "\
                        <td><button class='btn_white' value=" + item.ITEMID + ">수집</button></td>\
                        <td></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + ">대기</button></td>\
                        <td></td>\
                    </tr>";
                    break;
                case "FR":
                    html += "\
                        <td><button class='btn_white' value=" + item.ITEMID + ">수집</button></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + ">추출</button></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + ">대기</button></td>\
                        <td></td>\
                    </tr>";
                    break;
                case "FA":
                    html += "\
                        <td><button class='btn_white' value=" + item.ITEMID + ">수집</button></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + ">추출</button></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + ">대기</button></td>\
                        <td></td>\
                    </tr>";
                    break;
                case "RT":
                    html += "\
                        <td><button class='btn_white' value=" + item.ITEMID + ">수집</button></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + ">추출</button></td>\
                        <td></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + " data-stat="+item.STAT+" data-tagcnt="+item.CNT_TAG+">조회</button></td>\
                    </tr>";
                    break;
                case "ST":
                    html += "\
                        <td><button class='btn_white' value=" + item.ITEMID + ">수집</button></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + ">추출</button></td>\
                        <td></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + " data-stat="+item.STAT+" data-tagcnt="+item.CNT_TAG+">조회</button></td>\
                    </tr>";
                    break;
                default:
                    html += "\
                        <td><button class='btn_white' value=" + item.ITEMID + ">수집</button></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + ">추출</button></td>\
                        <td></td>\
                        <td><button class='btn_white' value=" + item.ITEMID + " data-stat="+item.STAT+" data-tagcnt="+item.CNT_TAG+">조회</button></td>\
                    </tr>";
                    break;
            }
            $("tbody").append(html);
        });

        this.paging();
        this.addEvent();
        this.addPagingEvent();
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

            if ( index == 0 || index == 11) {
                return;
            }

            if (thisObject.data.RESULT.LIST_PAGING_ACTIVE[index] == "active") {
                pagingHtml += "<a href='#' class='current' value="+pageNo+">"+pageNo+"</a>";
            } else {
                pagingHtml += "<a href='#' value="+pageNo+">"+pageNo+"</a>";
            }

            /*
            if ( thisObject.data.RESULT.PAGENO == pageNo ) {
                pagingHtml += "<a href='#' class='current' value="+pageNo+">"+pageNo+"</a>";
            } else {
                pagingHtml += "<a href='#' value="+pageNo+">"+pageNo+"</a>";
            }
            */
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
            searchExecute(nextPageNo);

        });
    };

    this.enableAction = function() {

        $("#multipleAction button").addClass("disabled");
        var itemList = [];
        $.each($(" tbody .dv input:checked"), function () {
          //  var searchStat = $(this).parent().parent().find("#searchStat").attr("value");
            var isC = $(this).parent().parent().find("td").eq(8).find("button").length == 1;
            var isA = $(this).parent().parent().find("td").eq(9).find("button").length == 1;
            var isS = $(this).parent().parent().find("td").eq(10).find("button").length == 1;

            if ( isC ) { itemList.push("C") };
            if ( isA ) { itemList.push("A") };
            if ( isS ) { itemList.push("S") };

       /*
            switch(searchStat) {
                case "FC":
                    itemList.push("C");
                    itemList.push("S");
                    break;
                case "FA":
                    itemList.push("C");
                    itemList.push("A");
                    itemList.push("S");
                    break;
                case "RT":
                    itemList.push("C");
                    itemList.push("A");
                    break;
                case "ST":
                    itemList.push("C");
                    itemList.push("A");
                    break;
                default:
                    break;
            }
            */
        });

        var checkedCount = $(" tbody .dv input:checked").length;
        if ( checkedCount > 0 ) {
            if ( itemList.filter(function(x){return x== "C"}).length ==  checkedCount ){
                $("#multipleAction button").eq(0).removeClass("disabled")
            }
            if ( itemList.filter(function(x){return x== "A"}).length ==  checkedCount ){
                $("#multipleAction button").eq(1).removeClass("disabled")
            }
            if ( itemList.filter(function(x){return x== "S"}).length ==  checkedCount ){
                $("#multipleAction button").eq(2).removeClass("disabled")
            }
        } else {
            $("#multipleAction button").addClass("disabled")
        }

    }


    this.addEvent = function () {

        // 전체 클릭
        var thisObject = this;
        $(this.domId + " thead .dv input").click(function () {
            if ($(this).is(":checked")) {
                $(" tbody .dv input").prop("checked", "checked");
            } else {
                $(" tbody .dv input").removeProp("checked");
            }

            thisObject.enableAction();
        });

        // 개별 항목 선택
        $(this.domId + " tbody .dv input").click(function () {
            thisObject.enableAction();
        });

        $(this.domId + " tbody button").off();
        $(this.domId + " tbody button").click(function () {

           /* var $tr = $(this).parent().parent();
            var $tbody = $(this).parent().parent().parent()
            $tbody.find("tr").each(function() {
                // 백그라운드 해제
                $(this).css("background-color", "");
            });
            $tr.css("background-color", "#fbf6f6");
            */

            var text = $(this).text();
            var itemId = $(this).val();
            var tagCnt = parseInt($(this).data("tagcnt"));
            var tagStat = $(this).data("stat");
            //if ( tagCnt != 0 ) {
            //    tagCnt = tagCnt -1;
            //}

            var target_type = "";
            switch (text) {
                case "수집":
                    target_type = "C";
                    break;
                case "추출":
                    target_type = "A";
                    break;
                case "승인":
                    target_type = "S";
                    break;
                case "대기":
                    target_type = "RT";
                    break;
                case "조회":

                    OM_API(
                        APIS.METAS_META,
                        {itemid: itemId},
                        function(data){
                            OM_API(
                                APIS.METAS_MOVIE,
                                {itemid: itemId},
                                function(movieInfo){
                                    var metaPopup = new MetaPopup();
                                    metaPopup.init({
                                        movieInfo: movieInfo,
                                        data : data,
                                        tagCnt: tagCnt,
                                        tagStat: tagStat,
                                        itemId: itemId
                                    }).render();
                                },
                                function(){
                                    console.log("Error")
                                });

                        },
                        function(){
                            console.log("Error")
                        });
                   // var sampleData = {"RT_CODE":1,"RT_MSG":"SUCCESS","RESULT":{"DURATION":"6m","METASWHEN":[{"word":"20세기","type":"new","ratio":7.3},{"word":"2차세계대전","type":"dup","ratio":6.3}],"METASWHERE":[{"word":"노르망디","type":"new","ratio":7.3}],"METASWHAT":[{"word":"전쟁","type":"dup","ratio":7.3},{"word":"실화","type":"new","ratio":6.5}],"METASWHO":[{"word":"병사","type":"new","ratio":6.5}],"METASEMOTION":[{"word":"감동적인","type":"new","ratio":6.7}],"LIST_NOT_MAPPED":[{"word":"상륙작전","type":"new","ratio":3.7},{"word":"공수부대","type":"new","ratio":3.2}],"WORDS_GENRE":["감동적인","극적인"],"WORDS_SNS":["압권","명작","강추"],"WORDS_ASSOC":["감명적"],"LIST_SUBGENRE":["전쟁드라마"],"LIST_SEARCHKEYWORDS":["노르망디","2차세계대전","전쟁"],"LIST_RECO_TARGET":["다시 군대가는 꿈을 꾼 당신에게"],"LIST_RECO_SITUATION":[]}}
                   // var movieInfo = {"RT_CODE":1,"RT_MSG":"SUCCESS","RESULT":{"TITLE":"라이언 일병 구하기","OTITLE":"Saving Private Ryan","SERIESYN":"N","YEAR":"1998-09-12","DIRECTOR":"스티븐 스필버그","ACTOR":"톰 행크스","GENRE":"드라마","PLOT":"1944년 6월 6일 노르망디 상륙 작전. 병사들은 죽을 고비를 넘기고 임무를 완수하지만, 실종된 유일한 생존자 막내 라이언 일병을 구하는 임무를 맡는다. 그들은 과연 라이언 일병 한 명의 생명이 그들 여덟 명의 생명보다 더 가치가 있는 것인지 혼란에 빠진다."}};

                    break;
                default:
                    break;
            }

            if (target_type.length > 0 ) {
                OM_API(APIS.ITEM_UPT_ONE, {
                        itemid: itemId,
                        target_type: target_type
                    },
                    function (data) {

                        OM_ALERT("페이지를 업데이트 합니다");
                        var pageNo = $(".pagenation .current").attr("value");
                        searchExecute(pageNo);

                    },
                    function () {

                    });
            }

        })
        // 테이블
        $("#multipleAction button").off();
        $("#multipleAction button").click(function () {
            if ($(this).hasClass("disabled")) return;
            var itemList = [];
            $(" tbody .dv input:checked").each(function () {
                itemList.push($(this).val());
            });

            if (itemList.length < 1) {
                OM_ALERT("아이템을 선택 해 주세요");
                return;
            }

            var target_type = "";
            switch ($(this).text()) {
                case "수집":
                    target_type = "C";
                    break;
                case "추출":
                    target_type = "A";
                    break;
                case "승인":
                    target_type = "S";
                    break;
                case "대기":
                    target_type = "RT";
                    break;
                default:
                    break;
            }
            OM_API(APIS.ITEM_UPT_ARRAY, {
                    items: itemList.join(),
                    target_type: target_type
                },
                function (data) {
                    OM_ALERT("페이지를 업데이트 합니다");
                    var pageNo = $(".pagenation .current").attr("value");
                    searchExecute(pageNo);
                },
                function () {

                });

        })
    }
}

//mcid로 동일 컨텐츠 검색
function btnMcidSearch(){
	
	console.log("MetaPopupInstance = ");
	console.log(MetaPopupInstance);
	console.log("MetaPopupInstance.itemId = " + MetaPopupInstance.itemId);
	
    OM_API( {url:"/pop/meta/mcidlist", method: "GET"},{
        itemid: MetaPopupInstance.itemId,
        target_type: "FT"	//?
    },function(response){
    	console.log("response.RESULT");
    	console.log(response.RESULT);
    	
        if ( response.RESULT.length == 0 ) {
        	alert("해당 작품 없음");
        }else{
        	$("#tblMcidSearchResult > tbody").empty();
        	
        	var strHtml = "";
        	var listItems = response.RESULT.LIST_ITEMS;
        	for(var idx in response.RESULT.LIST_ITEMS){
        		//태그정보 로딩 getTagsFromMcidSearchResult
        		strHtml += 	'<tr onclick="getTagsFromMcidSearchResult('+listItems[idx].ITEMID+',\''+listItems[idx].STAT+'\','+listItems[idx].CNT_TAG+')" style="cursor:pointer">'+
							'	<td>'+listItems[idx].CID+'</td>'+
							//'	<td>'+listItems[idx].TITLE+'/' + listItems[idx].STAT + '/' + listItems[idx].CNT_TAG + '</td>'+	//for Test
							'	<td>'+listItems[idx].TITLE+'</td>'+
							'</tr>';
        	}
        	$("#tblMcidSearchResult > tbody").append(strHtml);
        	
        	layerAction(
        		"",
        		'ly_pop_mcidSearchResult'
        	);
        	
        	$("#ly_pop_mcidSearchResult").css("display","block");	//이게 있어야 하나 위의 함수에서 있어야 하는거 아닌가
        
        }
    },function(){
        OM_ALERT("error");
    });
}

//태그정보 로딩
function getTagsFromMcidSearchResult(code,stat,cnttag){
	console.log("getTagsFromMcidSearchResult(code,stat,cnttag) - code = " + code + " , stat = " + stat + " , cnttag = " + cnttag );
	
	OM_API(
            APIS.METAS_META,
            {itemid: code},
            function(data){
            	console.log("METAS_META 결과 데이터 : ");
            	console.log(data);
            	
                addMetaKeyword(data.RESULT.METASWHEN, "metaWhen", function(v, parentTag){
                    return {
                        parentDom : parentTag,
                        tagPosition : "when",
                        tagName: v.word,
                        tagRatio: v.ratio,
                        tagType: v.type };
                });
                addMetaKeyword(data.RESULT.METASWHERE, "metaWhere", function(v, parentTag){
                    return {
                        parentDom : parentTag,
                        tagPosition : "where",
                        tagName: v.word,
                        tagRatio: v.ratio,
                        tagType: v.type };
                });
                addMetaKeyword(data.RESULT.METASWHAT, "metaWhat", function(v, parentTag){
                    return {
                        parentDom : parentTag,
                        tagPosition : "what",
                        tagName: v.word,
                        tagRatio: v.ratio,
                        tagType: v.type };
                });
                addMetaKeyword(data.RESULT.METASWHO, "metaWho", function(v, parentTag){
                    return {
                        parentDom : parentTag,
                        tagName: v.word,
                        tagPosition : "who",
                        tagRatio: v.ratio,
                        tagType: v.type };
                });
                addMetaKeyword(data.RESULT.METASEMOTION, "metaEmotion", function(v, parentTag){
                    return {
                        parentDom : parentTag,
                        tagPosition : "emotion",
                        tagName: v.word,
                        tagRatio: v.ratio,
                        tagType: v.type };
                });

                addMetaKeyword(data.RESULT.METASCHARACTER, "metaCharacter", function(v, parentTag){
                    return {
                        parentDom : parentTag,
                        tagPosition : "character",
                        tagName: v.word,
                        tagRatio: v.ratio,
                        tagType: v.type };
                });
            	
            	//팝업창 숨기기
                $("#ly_pop_mcidSearchResult").css("display","none");
            },
            function(){
                console.log("Error")
            }
    );
}

//키워드 추천
function fnAutoCompletePop(obj){
	//if(obj.value == "") return;
	
	var searchKeyword = obj.parentElement.getElementsByClassName("metaUpdateInput")[0];
	var autocomplete = document.getElementById("autocomplete");
	var keyword ="";
	
	searchKeyword.onkeydown = function(e) {
		searchKeyword.onkeyup(e);
	};
	
	/*
	//요거 하면 창이 계속 뜨고
	searchKeyword.onfocus = function(e) {
		searchKeyword.onkeyup(e);
	};
	*/
	/*
	//요거 하면 추천검색창에서 클릭을 못하고
	searchKeyword.onblur = function(e){
		document.getElementById("autocomplete").style.display = "none";
	}
	*/
	
	searchKeyword.onkeyup = function( e ){
		//if( e.char ) {
			//IE 전용
			keyword = searchKeyword.value;
		//}
		
		//비어있다면 div를 안보여주고,
		if( keyword == ""){
			autocomplete.style.display = "none";
		}else if(e.keyCode==13){
			autocomplete.style.display = "none";
		}else{
			// 안비어있다면 div를 보여준다.
			var inputLeft = obj.offsetLeft+
							obj.parentElement.offsetLeft+
							obj.parentElement.parentElement.parentElement.parentElement.offsetLeft;
			var inputTop  = obj.offsetTop+
							obj.parentElement.offsetTop+
							obj.parentElement.parentElement.parentElement.parentElement.offsetTop;
			var inputHeight = obj.offsetHeight;
			
			autocomplete.style.display = "block";
			autocomplete.style.position = "absolute";
			autocomplete.style.left= inputLeft;
			autocomplete.style.top = inputTop + inputHeight + 2;
			
			fillSearchResult(autocomplete,obj);
		}
	};
}

function fillSearchResult(autocomplete,obj) {
	debugger;
	console.log("value = " + obj.value);
	console.log("class1 = " + obj.getAttribute("data-type"));
	console.log("class2 = " + obj.parentElement.parentElement.getAttribute("id").substring(4).toLowerCase());
	
	var strResult = "";
	var strClass = obj.parentElement.parentElement.getAttribute("id").substring(4).toLowerCase();
	var searchVal = obj.value;
	var objId;
	objId = (obj.id=="updateTag" ? obj.getAttribute("data-id") : obj.id);
	
	var filteredList = document.getElementById("list_"+strClass).querySelectorAll("option[value*='"+searchVal+"']");
	for(var i in filteredList){
		if(isNaN(i)) continue;
		if(i>9) break;
		
		strResult += "<ul><li><label onclick='selectData(this,\""+objId+"\")'>" + filteredList[i].value + "</label></li></ul>";
	}
	autocomplete.innerHTML = strResult;
	
}

function selectData(that,objId) {
	var searchKeyword;
	if(objId=="updateTag"){
		searchKeyword = that.parentElement.parentElement.parentElement.parentElement.getElementsByClassName("metaUpdateInput")[0];
		searchKeyword.value = that.innerText;
	}else{
		var objSearchKeyword = document.getElementById(objId);
		
		if(objSearchKeyword.tagName.toLowerCase()=="span"){
			searchKeyword = document.querySelectorAll("[data-id='"+objId+"']")[0];
		}else{
			searchKeyword = objSearchKeyword;
		}
		searchKeyword.value = that.innerText;
	}
	
	
	var autocomplete = document.getElementById("autocomplete");
	autocomplete.style.display = "none";
}

function getElementsByAttribute(attributeName){
	
}

