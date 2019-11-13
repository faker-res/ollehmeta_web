<%@ page import="egovframework.daisyinsight.olleh.vo.UserSessionData" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%--
************************************************************
* Comment : 공통 메뉴 헤더.
* User    : Park
* Date    : 2017-12-13
*********************************************************** */
--%>
<%
    String reqURI = "" ;
    if( request.getAttribute( "javax.servlet.forward.request_uri" ) != null ) {
        reqURI = (String)request.getAttribute( "javax.servlet.forward.request_uri" ) ;
    } else {
        // 예외 사항을 찾기 위한 처리.
        System.out.println ( "##### Exception : " + request.getRequestURL() ) ;
    }

    session = request.getSession(true);
    UserSessionData userVO = (UserSessionData)session.getAttribute("userLoginInfo");
    String userName = userVO.getUserName();
    Boolean isAdmin = userVO.isAdmin();
    Boolean isSuperAdmin = false; // 통계 조회 용 사용자 여부
    String userId = userVO.getUserId();

    /*
    특정 사용자만 통계조회 페이지를 노출 한다.
     */
    if ( userId.equals("youlyoung.yi") ||
            userId.equals("seok-won.kim") ||
            userId.equals("penta.kill") ||
            userId.equals("ghkdwo77") ||
            userId.equals("hochul.lee") ||
            userId.equals("jaewoan.park")) {
        isSuperAdmin = true;
    }

%>

<header class="gnb">
    <div class="inner">
        <h1><a href="/">Meta TAG Enhancer</a></h1>
        <nav>
            <ul>
                <li class="<%=( reqURI.indexOf("/dashboard") >-1 ) ? "current" : "" %>"><a href="/dashboard.do">대시보드</a></li>
                <li class="<%=( reqURI.indexOf("/metatag") >-1 ) ? "current" : "" %>"><a href="/metatag.do">메타태깅</a></li>
                <li class="<%=( reqURI.indexOf("/dictionary") >-1 ) ? "current" : "" %>"><a href="/dictionary.do">사전관리</a></li>
                <li class="<%=( reqURI.indexOf("/social") >-1 ) ? "current" : "" %>"><a href="/social.do">소셜분석</a></li>
                <% if ( isAdmin )  { %>
                <li class="<%=( reqURI.indexOf("/admin") >-1 ) ? "current" : "" %>">
                    <a href="/admin/dataview.do">관리기능</a>
                    <% if ( isSuperAdmin )  { %>
                    <div class="submenu">
                        <span class="ic"></span>
                        <a class="<%=( reqURI.indexOf("dataview.do") >-1 ) ? "current" : "" %>" href="/admin/dataview.do">통계조회</a>
                        <%--<a class="<%=( reqURI.indexOf("admin.do") >-1 ) ? "current" : "" %>" href="/admin/admin.do">권한관리</a>--%>
                    </div>
                    <% }%>
                </li>
                <% } %>
                <li class="<%=( reqURI.indexOf("/relknowledge.do") >-1 ) ? "current" : "" %>"><a href="/relknowledge.do">연관지식</a></li>
            </ul>
        </nav>
        <div class="user">

            <% if ( isAdmin )  { %>
                <img src="/img/ic_admin.png" alt="관리자"  title="관리자" class="ic">
            <% } else { %>
                <img src="/img/ic_oper.png" alt="운영자" title="운영자"  class="ic">
            <% } %>
            <strong><%= userName%></strong><span>님</span>
            <button class="btn_logout" onclick="location.href='/logout.do'" >로그아웃</button>
        </div>
    </div>
</header>

