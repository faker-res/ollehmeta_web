<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--
************************************************************
* Comment : 공통 풋터
* User    : Park
* Date    : 2017-12-13
***********************************************************
--%>

<div class="loader" style="display:none">
</div>

<!-- 레이어 팝업 -->
<div id="ly_pop_01" class="mod_layer" style="display: none;">
    <div class="layInner alret">
        <p id="popupMessage">잠시 후 다시 시도해주세요.</p>
        <div class="btnWrap center btnMid">
            <button id="popupClose">확인</button>
        </div>
    </div>
</div>

<!-- 레이어 팝업 -->
<div id="ly_pop_02" class="mod_layer" style="display: none;">
    <div class="layInner alret" style="width: 340px;">
        <p id="popupMessage">태깅 진행 중인 현재 태그를 모두 삭제하고 승인완료된 이전 차수 태그를 복구합니다. <br>복구하시겠습니까?</p>
        <div class="btnWrap center btnMid">
            <button id="popupOk">확인</button>
            <button id="popupCancel">취소</button>
        </div>
    </div>
</div>


<%--<div id="footer" class="error_foot">--%>
    <%--Copyright ⓒ 2017 KT Hitel All Rights Reserved.--%>
<%--</div>--%>