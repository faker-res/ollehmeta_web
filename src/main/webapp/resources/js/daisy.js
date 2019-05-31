
var APIS = {
    AUTH_HASH : { url: "/auth/hash", method: "GET"},
    AUTH_USER_LIST : { url: "/auth/user/list", method: "GET"},
    AUTH_USER_LOGIN : { url: "", method: ""},
    DASH_LIST : { url: "/dash/list", method: "GET"},
    ITEM_LIST : { url: "/item/list", method: "POST"},
    ITEM_UPT_ONE : { url: "/item/upt/one", method: "POST"},
    ITEM_UPT_ARRAY : { url: "/item/upt/array", method: "POST"},
    METAS_MOVIE : { url: "/pop/movie", method: "GET"},
    METAS_META : { url: "/pop/meta", method: "GET"},
    METAS_AWARD : { url: "/pop/award", method: "GET"},
    METAS_C_CUBE : { url: "/pop/c_cube", method: "GET"},
    METAS_CINE21 : { url: "/pop/cine21", method: "GET"},
    METAS_GET_SUBGENRE : { url: "/pop/meta/getsubgenre", method: "POST"},
    METAS_UPT_ARRAY : { url: "/pop/meta/upt/array", method: "POST"},
    METAS_RECOVER : { url: "/pop/meta/restore", method: "POST"},
    METAS_UPSTATS : { url: "/pop/meta/uptstat", method: "POST"},
    METAS_META_UPT : { url: "", method: ""},
    DIC_LIST : { url: "/dic/list", method: "GET"},
    DIC_UPT_ARRAY : { url: "/dic/upt/array", method: "POST"},
    AUTH_USER_ADD : { url: "/auth/user/add", method: "POST"},
    AUTH_USER_MOD : { url: "/auth/user/mod", method: "POST"},
    AUTH_USER_DEL : { url: "/auth/user/del", method: "POST"},
    SOCIAL : { url: "/social", method: "GET"},
    STAT_LIST : { url: "/stat/list", method: "POST"},
    POP_META_DEL_AWARD : { url: "/pop/meta/del/award", method: "POST"}
};

var APIS_RETURN_CODE = {
    "1" :   "성공",
    "-1" :  "일반 오류",
    "-2" :  "트랜젝션 오류",
    "-3" :  "권한 오류",
    "-4" :  "기간 만료",
    "-9999" : "시스템 오류",
};


var OM_ALERT = function(messageText, fnClose) {
    var layid = "ly_pop_01";
    if (typeof messageText == "undefined") {
        messageText = "오류";
    }

    return layerAction(messageText, layid, fnClose );
};

var OM_CONFIRM = function(messageText, fnOk, fnCancel) {
    var layid = "ly_pop_02";
    return layerAction(messageText, layid, function(){}, fnOk, fnCancel );
}

function OM_API_CKECK(response){

    if ( typeof response == "undefined" ) {
        OM_ALERT("서버 응답이 없습니다.(10초 이상 응답 메시지 없습니다)")
        return false;
    }

    if ( response.RT_CODE == 1 ){ return true; }
    else {
        var msg = APIS_RETURN_CODE[response.RT_CODE];
        OM_ALERT(msg)
    }
    return false;
}

function OM_API(apiInfo,apiParam,successCallback,failCallback){

    Loading(true);
    /*apiParam.hash = "hGavIsRSA%2F0YUOXytZeDhfIFh%2B28rCsj6IKLWDkD%2B7g%3D";
    apiParam.custid = "ollehmeta";
    */
    var param = {
        apiUrl   : JSON.stringify(apiInfo),
        apiParam : JSON.stringify(apiParam||{})
    };

    $.ajax({
        url: "/v1/apis",
        timeout: 20000,
        method: "POST",
        data: param,
        dataType: "json",
        success: function(data,textStatus,jqXHR){

            if ( OM_API_CKECK(data) == true ) {
                successCallback(data,textStatus,jqXHR);
            } else {
                Loading(false);
            }
        },
        error: function(jqXHR,textStatus,errorThrown){
            failCallback(jqXHR,textStatus,errorThrown);

            if ( textStatus == "timeout" ) {
                OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 001)");
            } else if (typeof jqXHR.responseText != "undefined" && jqXHR.responseText == "apiSessionError" ) {
                OM_ALERT("세션이 종료 되었습니다. <br>재 로그인 시도 합니다.(에러 : 002)", function() {
                    location.href = "/";
                })
            } else {
                OM_ALERT("API 서버 연결이 종료 되었습니다. <br>F5 시도 후 사용해 주세요.(에러 : 003)<br>" +jqXHR.responseText );
            }

        },
        complete: function() {
            Loading(false);
        }

    });
}

function OM_READY(fnInit){
    fnInit();
}

var OM_DATE_PICKER = function (){

    this.init = function(settings){

        this.domCheckAll = settings.domCheckAll;
        this.bCheckAll = false;

        this.domStartDate = settings.domStartDate;
        this.domEndDate = settings.domEndDate;

        // 초기값 설정은 datepicker 실행 전에 하다.
        $(this.domStartDate).val(settings.initStartDate);
        $(this.domEndDate).val(settings.initEndDate);

        $(this.domStartDate).datepicker({
            onSelect: settings.onSelectStartDate || this.onSelectStartDate
        });
        $(this.domEndDate).datepicker({
            onSelect: settings.onSelectEndDate || this.onSelectEndDate
        });

        var thisObject = this;
        $(this.domCheckAll).click(function(){

            var pickder = thisObject;
            pickder.bCheckAll = !pickder.bCheckAll;
            $(pickder.domStartDate).prop('disabled', pickder.bCheckAll);
            $(pickder.domEndDate).prop('disabled', pickder.bCheckAll);

            // 전체 버튼 (비)활성화
            if ( pickder.bCheckAll == true ){
                $(this).addClass("on");
            } else {
                $(this).removeClass("on");
            }
        });

        return this;
    };

    this.getStartDate = function () {
        // "" 전체
        if ( this.bCheckAll == true ){
            return "";
        } else {
            return $(this.domStartDate).val();
        }
    };

    this.getEndDate = function () {
        // "" 전체
        if ( this.bCheckAll == true ){
            return "";
        } else {
            return $(this.domEndDate).val();
        }
    };

    this.onSelectStartDate = function(dateText){

    };

    this.onSelectEndDate = function(dateText){

    };
};

function guid() {
    function s4() {
        return Math.floor((1 + Math.random()) * 0x10000)
            .toString(16)
            .substring(1);
    }
    return s4() + s4() + s4();
}

var OM_UTIL = {
    currentDate : function() {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();

        if(dd<10) {
            dd = '0'+dd
        }
        if(mm<10) {
            mm = '0'+mm
        }
        today = yyyy + '-' + mm + '-' + dd;
        return today;
    },

    startDate : function(yourDate) {
        var today = new Date();
        var newdate = new Date();
        newdate.setDate(today.getDate()-90);
        var dd = newdate.getDate();
        var mm = newdate.getMonth()+1; //January is 0!
        var yyyy = newdate.getFullYear();

        if(dd<10) {
            dd = '0'+dd
        }
        if(mm<10) {
            mm = '0'+mm
        }
        today = yyyy + '-' + mm + '-' + dd;
        return today;
    }

}