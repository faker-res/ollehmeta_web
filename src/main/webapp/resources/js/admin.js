
var AUTH_TYPE = {
    "STAT" : "운영자",
    "ADMIN" : "관리자"
}
var AdminUserTable = function() {
    this.init = function(settings) {
        this.data = settings.data;
        this.domId = settings.domId;
        $(this.domId + " tbody").html("");
        return this;
    };

    this.render = function () {
        var thisObject = this;
        var data = this.data;

        $(data.RESULT).each(function(key,item) {

            if ( item.STAT != "D") {
                var html = '<tr>\
                <td>'+(key+1)+'</td>\
                <td>'+item.NAME+'</td>\
                <td>'+item.USERID+'</td>\
                <td data='+item.PASSWORD+'>*****</td>\
            <td>'+item.COMPANY+'</td>\
            <td value='+item.GRANT+'>'+AUTH_TYPE[item.GRANT]+'</td>\
            <td>'+thisObject.getFormatDate(new Date(item.REGDATE))+'</td>\
            <td><button class="btn_white btn_update">수정</button></td>\
            <td><button class="btn_white btn_delete">삭제</button></td>\
            </tr>';
                $(thisObject.domId +" tbody").append(html);
            }
        });

        this.addEvent();
        //this.paging();
        //this.addPagingEvent();
    };
    
    this.addEvent = function () {

        var thisObject = this;

        $(".btn_update").off();
        $(".btn_update").click(function(){
            var $nameUpdate = $(this).parent().parent().find("td").eq(2);
            var $passwordUpdate = $(this).parent().parent().find("td").eq(3);
            var $companyUpdate = $(this).parent().parent().find("td").eq(4);
            var $authUpdate = $(this).parent().parent().find("td").eq(5);
            var $button = $(this).parent();

            $passwordUpdate.html('<input type="text"  value='+atob($passwordUpdate.attr("data"))+'>');

            var company = $companyUpdate.html();
            $companyUpdate.html('<select>\
                <option value="">선택</option>\
                <option value="KT">kt</option>\
                <option value="KTH">kth</option>\
                <option value="ETC">기타</option>\
                </select>');
            var auth = $authUpdate.attr("value");
            $authUpdate.html('<select>\
                <option value="">선택</option>\
                <option value="STAT">운영자</option>\
                <option value="ADMIN">관리자</option>\
                </select>');

            $companyUpdate.find("select").val(company.toUpperCase());
            $authUpdate.find("select").val(auth.toUpperCase());

            $button.html('<button class="btn_white btn_save">저장</button>');

            $(".btn_save").click(function(){
                var $nameUpdate = $(this).parent().parent().find("td").eq(1);
                var $idUpdate = $(this).parent().parent().find("td").eq(2);
                var $passwordUpdate = $(this).parent().parent().find("td").eq(3);
                var $companyUpdate = $(this).parent().parent().find("td").eq(4);
                var $authUpdate = $(this).parent().parent().find("td").eq(5);
                var $button = $(this).parent();


                if ( $idUpdate.html().length == 0 ) {
                    OM_ALERT("아이디를 입력 해 주세요");
                    return;
                }  else if ($authUpdate.find("select option:selected").val().length == 0 ) {
                    OM_ALERT("권한을 선택 해 주세요");
                    return;
                } else if ($companyUpdate.find("select option:selected").val().length == 0) {
                    OM_ALERT("소속회사를 선택 해 주세요");
                    return;
                } else {
                    var password = btoa($passwordUpdate.find("input").val());

                    var company = $companyUpdate.find("select option:selected").val();

                    $passwordUpdate.html('*****');
                    $companyUpdate.html(company);
                    $authUpdate.html(AUTH_TYPE[$authUpdate.find("select option:selected").val()]);

                    $button.html('<button class="btn_white btn_update">수정</button>');

                    thisObject.addEvent();

                    OM_API(APIS.AUTH_USER_MOD, {
                        target_userid: $idUpdate.html(),
                        target_grant: AUTH_TYPE[$authUpdate.find("select option:selected").val()],
                        target_name: $nameUpdate.html(),
                        target_password : password,
                        target_company : company
                    }, function(data){
                        OM_ALERT("저장 되었습니다");
                    }, function(){
                        console.log("Error")
                    });
                }



            });
        });

        $(".btn_delete").off();
        $(".btn_delete").click(function(){

            var $idUpdate = $(this).parent().parent().find("td").eq(2);
            var $tr = $(this).parent().parent();
            var thisObject = this;

            // 만약 저장되기 전 삭제라면
            if ( $tr.hasClass("new-user") ) {
                $tr.remove();
            } else {
                OM_CONFIRM("선택한 사용자를 삭제 하시겠습니까?",
                    function () {

                        OM_API(APIS.AUTH_USER_DEL, {
                            target_userid: $idUpdate.html(),
                        }, function(data){
                            $(thisObject).parent().parent().remove();
                            OM_ALERT("삭제 되었습니다");
                        }, function(){
                            console.log("Error")
                        });


                    },
                    function () {
                        // Cancel 버튼을 누를 경우
                    });

            }


        });
        $(".btn_save").off();
        $(".btn_save").click(function(){

            var $tr = $(this).parent().parent();
            var $nameUpdate = $(this).parent().parent().find("td").eq(1);
            var $idUpdate = $(this).parent().parent().find("td").eq(2);
            var $passwordUpdate = $(this).parent().parent().find("td").eq(3);
            var $companyUpdate = $(this).parent().parent().find("td").eq(4);
            var $authUpdate = $(this).parent().parent().find("td").eq(5);
            var $button = $(this).parent();


            if ( $idUpdate.find("input").val().length == 0 ) {
                OM_ALERT("아이디를 입력 해 주세요");
                return;
            }  else if ($authUpdate.find("select option:selected").val().length == 0 ) {
                OM_ALERT("권한을 선택 해 주세요");
                return;
            } else if ($companyUpdate.find("select option:selected").val().length == 0) {
                OM_ALERT("소속회사를 선택 해 주세요");
                return;
            } else {
                var password = btoa($passwordUpdate.find("input").val());

                var company = $companyUpdate.find("select option:selected").val();
                var userName = $nameUpdate.find("input").val();
                var authType=  $authUpdate.find("select option:selected").val();

                $passwordUpdate.html('*****');
                $idUpdate.html($idUpdate.find("input").val());
                $companyUpdate.html(company);


                $authUpdate.html(AUTH_TYPE[$authUpdate.find("select option:selected").val()]);
                $nameUpdate.html($nameUpdate.find("input").val());

                $button.html('<button class="btn_white btn_update">수정</button>');

                thisObject.addEvent();

                OM_API(APIS.AUTH_USER_ADD, {
                    target_userid: $idUpdate.html(),
                    target_grant: authType,
                    target_name: userName,
                    target_password : password,
                    target_company : company
                }, function(data){
                    OM_ALERT("저장 되었습니다");
                }, function(){
                    // 현재 추가한 내용을 삭제한다.
                    $tr.remove();
                });
            }


            thisObject.addEvent();
        });

        // 신규 등록
        $(".btnRight").off();
        $(".btnRight").click(function(){

            var currentIndex = $(thisObject.domId +" tbody tr").length + 1;

            var html = '<tr class="new-user">\
                <td>'+currentIndex+'</td>\
                <td><input type="text"/></td>\
                <td><input type="text"/></td>\
                <td><input type="text"/></td>\
            <td><select>\
                <option value="">선택</option>\
                <option value="KT">kt</option>\
                <option value="KTH">kth</option>\
                <option value="ETC">기타</option>\
                </select></td>\
            <td><select>\
                <option value="">선택</option>\
                <option value="STAT">운영자</option>\
                <option value="ADMIN">관리자</option>\
                </select></td>\
            <td>'+thisObject.getFormatDate(new Date())+'</td>\
            <td><button class="btn_white btn_save">저장</button></td>\
            <td><button class="btn_white btn_delete">삭제</button></td>\
            </tr>';
            $(thisObject.domId +" tbody").append(html);

            thisObject.addEvent();
        });



    };

    this.paging = function() {
//
        var pagingHtml = "";
        $(".pagenation").html("");

        pagingHtml = "<a href='#' class='btn btn_first' value='first'>처음으로</a>\
            <a href='#' class='btn btn_prev' value='prev'>이전페이지</a>";

        var thisObject = this;
        this.data.RESULT.LIST_PAGING.forEach(function(pageNo, k){

            if ( thisObject.data.RESULT.PAGENO == pageNo ) {
                pagingHtml += "<a href='#' class='current' value="+pageNo+">"+pageNo+"</a>";
            } else {
                pagingHtml += "<a href='#' value="+pageNo+">"+pageNo+"</a>";
            }

        });
        pagingHtml += "<a href='#' class='btn btn_next' value='next'>다음페이지</a>\
            <a href='#' class='btn btn_last' value='last'>마지막페이지</a>";

        $(".pagenation").html(pagingHtml);
    };

    this.addPagingEvent = function () {

        var thisObject = this;
        $(".pagenation a").click(function () {

            var selectedPageNo = $(this).attr("value");
            var currentPageNo = thisObject.data.RESULT.PAGENO;
            var lastPageNo =  thisObject.data.RESULT.LIST_PAGING[thisObject.data.RESULT.LIST_PAGING.length-1];
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
                    nextPageNo = currentPageNo -1;
                    break;
                case "next":
                    nextPageNo = currentPageNo +1;
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
    };

    this.getFormatDate = function(date){
        var year = date.getFullYear();
        var month = (1 + date.getMonth());
        month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
        var day = date.getDate();
        day = day >= 10 ? day : '0' + day;
        return  year + '/' + month + '/' + day;
    }
}