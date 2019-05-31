<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--
************************************************************
* Comment : 공통 헤더.
* User    : Park
* Date    : 2017-12-13
*********************************************************** */
--%>

<title>올레 메타</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" href="/css/jquery-ui.css"/>
<link rel="stylesheet" href="/css/meta_tag_enhancer.css"/>
<script src="/js/lib/jquery-1.11.1.min.js"></script>
<script src="/js/lib/jquery-ui.min.js"></script>
<script src="/js/common.js"></script>
<script src="/js/daisy.js"></script>
<script src="/js/plugins/jquery/jquery.number.min.js"></script>
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>

<script src="/js/plugins/jquery/jquery.loadTemplate.min.js"></script>
<style>
    .loader {
        position: absolute;
        left: 50%;
        top: 50%;
        z-index: 1;
        width: 150px;
        height: 150px;
        margin: -75px 0 0 -75px;
        border: 12px solid #f3f3f3;
        border-radius: 50%;
        border-top: 12px solid #3498db;
        width: 120px;
        height: 120px;
        -webkit-animation: spin 2s linear infinite;
        animation: spin 2s linear infinite;
        z-index: 99999;
    }


    @-webkit-keyframes spin {
        0% { -webkit-transform: rotate(0deg); }
        100% { -webkit-transform: rotate(360deg); }
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>