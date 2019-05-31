<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--
************************************************************
* Comment : 어드민 페이지
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
<div class="contents management">
    <div class="modHeader">
        <h2>권한관리</h2>
    </div>
    <div class="tbl_bs">
        <table>
            <colgroup>
                <col width="45px">
                <col width="265px">
                <col width="265px">
                <col width="100px">
                <col width="120px">
                <col width="120px">
                <col width="px">
                <col width="65px">
                <col width="65px">
            </colgroup>
            <thead>
                <th>No</th>
                <th>이름</th>
                <th>아이디</th>
                <th>암호</th>
                <th>소속</th>
                <th>권한</th>
                <th>등록일</th>
                <th>수정</th>
                <th>삭제</th>
            </thead>
            <tbody>

            </tbody>
            <!--
            <tr>
                <td>1</td>
                <td>홍길동</td>
                <td>asdfasdf@asdf.com</td>
                <td>kth</td>
                <td>관리자</td>
                <td>2017/12/06</td>
                <td><button class="btn_white">수정</button></td>
                <td><button class="btn_white">삭제</button></td>
            </tr>
            <tr>
                <td>1</td>
                <td>홍길동</td>
                <td><input type="text" value="asdfasdf@asdf.com"></td>
                <td>
                    <select>
                        <option value="">선택</option>
                        <option value="">kt</option>
                        <option value="">kth</option>
                    </select>
                </td>
                <td>
                    <select>
                        <option value="">선택</option>
                        <option value="">운영자</option>
                        <option value="">관리자</option>
                    </select>
            </td>
                <td>2017/12/06</td>
                <td><button class="btn_white">저장</button></td>
                <td><button class="btn_white">삭제</button></td>
            </tr>
            <tr>
                <td>1</td>
                <td><input type="text" value="" placeholder="입력"></td>
                <td><input type="text" value="" placeholder="입력"></td>
                <td>
                    <select>
                        <option value="">선택</option>
                        <option value="">kt</option>
                        <option value="">kth</option>
                    </select>
                </td>
                <td>
                    <select>
                        <option value="">선택</option>
                        <option value="">운영자</option>
                        <option value="">관리자</option>
                    </select>
                </td>
                <td>2017/12/06</td>
                <td><button class="btn_white">저장</button></td>
                <td><button class="btn_white">삭제</button></td>
            </tr>
            -->
        </table>
        <div class="btnWrap">
            <div class="btnRight">
                <button>신규등록</button>
            </div>
        </div>
        <!--
        <div class="pagenation">
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
        </div>
        -->
    </div>
</div>

<!-- //contents ends-->


<%--footer section begins --%>
<%@ include file="/WEB-INF/jsp/common/ComFooter.jsp" %>
<%--footer section ends --%>
</body>
</html>
<script src="/js/admin.js"></script>
<script>

    var adminUserTable = new AdminUserTable();
    $(document).ready(function() {

        OM_API(APIS.AUTH_USER_LIST, {
        }, function(data){

            adminUserTable.init({
                data : data,
                domId : ".tbl_bs"
            }).render();

        }, function(){
            console.log("Error")
        });

    });
</script>