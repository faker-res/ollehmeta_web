<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
  Created by IntelliJ IDEA.
  User: kth
  Date: 2017-12-13
  Time: 오후 2:00
  To change this template use File | Settings | File Templates.
--%>
<%
  String errCode = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/common/ComHeader.jsp" %>
</head>
<body>

<div class="loginWrap">
	<h1>Meta TAG Enhancer</h1>
	<h2><%=errCode%> System Error</h2>
</div>
</body>
</html>