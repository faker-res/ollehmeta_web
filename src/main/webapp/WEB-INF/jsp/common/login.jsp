<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
  Created by IntelliJ IDEA.
  User: kth
  Date: 2017-12-13
  Time: 오후 2:00
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/jsp/common/ComHeader.jsp" %>
</head>
<body>

<div class="loginWrap">
  <h1>Meta TAG Enhancer</h1>
  <div class="inner">
    <form>
    <dl>
      <dt>ID</dt>
      <dd><input name="userId" id="userId"  type="text" placeholder="your ID"></dd>
    </dl>
    <dl>
      <dt>PASSWORD</dt>
      <dd><input name="password" id="password"  type="password" placeholder="your password"></dd>
    </dl>
    </form>

    <button type="button" class="btn_login">로그인</button>

    <!-- <div class="error">승인되지 않은 아이디입니다. 관리자에게 권한 승인을 요청해 주세요.</div> -->
  </div>
  <div class="txtWrap">
    <%--<p class="txt_1">권한 승인 및 이용 안내 : <a href="mailto:helpdesk.metatag@kt.com">helpdesk.metatag@kt.com</a></p>--%>
    <p class="txt_2">본 시스템은 kt 임직원 및 운영사 담당 직원에 한하여 사용할 수 있으며, <br>불법적인 접근 및 사용 시도 시 관련 법규에 의거 처벌될 수 있습니다.</p>
    <p class="txt_3">Copyright ⓒ 2018 kt corp. All rights reserved.</p>
  </div>
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

</body>
</html>
<script>

  function goSubmit() {

    if($("#userId").val().length == 0 && $("#password").val().length == 0) {
      OM_ALERT("아이디/패스워드를 입력해 주세요.");
      return false;
    }

    var param = {userId : $("#userId").val(),
      password : encodeURIComponent($("#password").val())
    };

    $.ajax({
      url: "/loginProcess.do",
      data: param,
      cache: false,
      type: "POST",
      dataType:"json",
      //timeout: 3000,
      beforeSend: function(){
      },
      complete : function(){
      },
      success: function(response) {
        var AUTH_GOOD = 200;
        var AUTH_FAIL_SYSTEM = 1001;
        var AUTH_FAIL_LDAP = 1002;

        switch (response) {
          case AUTH_GOOD : location.replace("/dashboard.do"); break;
          case AUTH_FAIL_SYSTEM : OM_ALERT("승인되지 않은 아이디입니다.<br>관리자에게 권한 승인을 요청해 주세요."); break;
          case AUTH_FAIL_LDAP : OM_ALERT("잘못된 비밀번호입니다."); break;
        }
      },
      error: function(xhr) {
        OM_ALERT("등록되지 않은 ID입니다.");
      }
    });
  }
  $(document).ready(function(){

    $(".btn_login").click(function(){
      goSubmit();
    });

    $("#password").keydown(function(key){
      if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        goSubmit();
      }
    });

  })
</script>