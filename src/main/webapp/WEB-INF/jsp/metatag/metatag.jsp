<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--
************************************************************
* Comment : 매타 태그
* User    : Park
* Date    : 2017-12-13
***********************************************************7
--%>

<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/ComHeader.jsp" %>

    <style>
        .sortWrap label {
            cursor: pointer;
        }
        .metaUpdateInput {
            border: 3px dotted red;
        }
        .editwrap .tag_add input[type="text"]{width: 134px;margin-right: 6px;margin-top: -1px;border-radius: 20px; border: 3px dotted red;}
        
        /* 자동완성 선택창 */
		#autocomplete {
			display: none;
		    width: 135px;
		    position: absolute;
		    z-index: 9;
		    border: 1px solid #474a50;
		    background: #f8f8f8;
		    border-radius: 15px;
		    box-shadow: 0px 1px 0px 1px rgba(0,0,0,0.11);
			font-size: 10pt;
			padding: 10px 15px;
			line-height: 2;
		}
        
    </style>
    <script src="/js/metatag.js"></script>
    
    <link rel="stylesheet" href="/js/plugins/jquery-ui/jquery-ui.css" /><!-- 권재일 수정 08.01 2-1 -->
    <script src="/js/plugins/jquery-ui/jquery-ui.js" async></script><!-- 권재일 수정 08.01 2-1 -->
    
</head>
<body>

<%--Nav--%>
<%@ include file="/WEB-INF/jsp/common/ComHeaderWrapper.jsp" %>


<div class="contents metaTagging">

    <div class="searchCond">
        <h2>검색조건</h2>
        <div class="inner">
            <dl class="sort">
                <dt>분류</dt>
                <dd>

                    <select id="search_type">
                        <option value="ALL">전체</option>
                        <option value="OTH">해외영화</option>
                        <option value="KOR">한국영화</option>
                        <option value="SER">시리즈</option>
                    </select>

                </dd>
            </dl>
            <dl class="stat">
                <dt>상태</dt>
                <dd>
                    <select id="search_stat">
                        <option value="ALL">전체</option>
                        <option value="FC" <c:if test="${searcyType eq 'FC'}">selected</c:if>>수집실패</option>
                        <option value="FA" <c:if test="${searcyType eq 'FA'}">selected</c:if>>추출실패</option>
                        <option value="RT" <c:if test="${searcyType eq 'RT'}">selected</c:if>>승인대기</option>
                        <option value="FT" <c:if test="${searcyType eq 'FT'}">selected</c:if>>승인불가</option>
                        <option value="ST" <c:if test="${searcyType eq 'ST'}">selected</c:if>>승인완료</option>
                    </select>
                </dd>
            </dl>
            <dl class="getDate">
                <dt>입수일</dt>
                <dd>
                    <button class="btn_allday">전체</button>
                    <input type="text" id="startDate">
                    ~
                    <input type="text" id="endDate">
                </dd>
            </dl>
            <dl class="keyword">
                <dt>키워드</dt>
                <dd><input type="text" placeholder="입력" value=""></dd>
            </dl>
            <div id="searchParts" class="check">
                <label for="chk_001">
                    <input type="checkbox" id="chk_001" value="title" checked>
                    <span class="ic"></span>
                    <span class="txt">제목</span>
                </label>
                <label for="chk_002">
                    <input type="checkbox" id="chk_002" value="genre" >
                    <span class="ic"></span>
                    <span class="txt">장르</span>
                </label>
                <label for="chk_003">
                    <input type="checkbox" id="chk_003" value="director" >
                    <span class="ic"></span>
                    <span class="txt">감독</span>
                </label>
                <label for="chk_004">
                    <input type="checkbox" id="chk_004" value="actor" >
                    <span class="ic"></span>
                    <span class="txt">주연</span>
                </label>
                <label for="chk_005">
                    <input type="checkbox" id="chk_005" value="plot" >
                    <span class="ic"></span>
                    <span class="txt">줄거리</span>
                </label>
                <label for="chk_006">
                    <input type="checkbox" id="chk_006" value="when" >
                    <span class="ic"></span>
                    <span class="txt">시간적배경</span>
                </label>
                <label for="chk_007">
                    <input type="checkbox" id="chk_007" value="where" >
                    <span class="ic"></span>
                    <span class="txt">공간적배경</span>
                </label>
                <label for="chk_008">
                    <input type="checkbox" id="chk_008" value="what" >
                    <span class="ic"></span>
                    <span class="txt">주제/소재</span>
                </label>
                <label for="chk_009">
                    <input type="checkbox" id="chk_009" value="who" >
                    <span class="ic"></span>
                    <span class="txt">인물/캐릭터</span>
                </label>
                <label for="chk_010">
                    <input type="checkbox" id="chk_010" value="emotion" >
                    <span class="ic"></span>
                    <span class="txt">감성/분위기</span>
                </label>
                <label for="chk_011">
                    <input type="checkbox" id="chk_011" value="award" >
                    <span class="ic"></span>
                    <span class="txt">수상정보</span>
                </label>
                <label for="chk_012">
                    <input type="checkbox" id="chk_012" value="keyword" >
                    <span class="ic"></span>
                    <span class="txt">검색키워드</span>
                </label>
                <label for="chk_013">
                    <input type="checkbox" id="chk_013" value="subgenre" >
                    <span class="ic"></span>
                    <span class="txt">서브장르</span>
                </label>
                <label for="chk_014">
                    <input type="checkbox" id="chk_014" value="recotarget" >
                    <span class="ic"></span>
                    <span class="txt">추천표현</span><%--<span class="txt">추천대상</span>--%>
                </label>
                <label for="chk_015">
                    <input type="checkbox" id="chk_015" value="recositu" >
                    <span class="ic"></span>
                    <span class="txt">추천상황</span>
                </label>
                <label for="chk_016">
                    <input type="checkbox" id="chk_016" value="character" >
                    <span class="ic"></span>
                    <span class="txt">캐릭터명</span>
                </label>
            </div>
        </div>
        <button class="btn_result">결과조회</button>
    </div><!-- //searchCond -->

    <div class="inquiryResult">
        <h3>조회 결과</h3>
        <div class="total">총 <strong>80</strong> 편 중</div>
        <div class="inner">
            <dl>
                <dt>수집실패</dt>
                <dd>
                    <strong>0</strong>건
                    <button class="btn_view" value="수집실패">보기</button>
                </dd>
            </dl>
            <dl>
                <dt>추출실패</dt>
                <dd>
                    <strong>0</strong>건
                    <button class="btn_view" value="추출실패">보기</button>
                </dd>
            </dl>
            <dl>
                <dt>승인대기</dt>
                <dd>
                    <strong>0</strong>건
                    <button class="btn_view" value="승인대기">보기</button>
                </dd>
            </dl>
            <dl>
                <dt>승인완료</dt>
                <dd>
                    <strong>0</strong>건
                    <button class="btn_view" value="승인완료">보기</button>
                </dd>
            </dl>
        </div>
    </div><!-- //inquiryResult -->

    <div class="tbl_bs">
        <table>
            <colgroup>
                <col width="45px">
                <col width="">
                <col width="135px">
                <col width="62px">
                <col width="62px">
                <col width="120px">
                <col width="68px">
                <col width="106px">
                <col width="62px">
                <col width="62px">
                <col width="62px">
                <col width="62px">
            </colgroup>
            <thead>
                <th class="dv"><input type="checkbox"></th>
                <th>제목</th>
                <th>MCID&SID</th>
                <th class="dv">분류</th>
                <th>태깅차수</th>
                <th>태거ID</th>
                <th>입수일자</th>
                <th>처리일시</th>
                <th class="dv">처리상태</th>
                <th class="bg1">재수집</th>
                <th class="bg1">재추출</th>
                <th class="bg1">승인대기</th>
                <th class="bg1">상세조회</th>
            </thead>
            <tbody>

            </tbody>

        </table>
        <div class="btnWrap">
            <div class="btnLeft" id="multipleAction">
                <button class="disabled">수집</button>
                <button class="disabled">추출</button>
                <button class="disabled">대기</button>
            </div>
        </div>
        <div class="pagenation">
            <!--
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
            -->
        </div>
    </div>
</div><!-- //contents -->

<!-- 레이어 팝업 -->
<div id="ly_autopop_01" class="mod_layer" style="display: none;">
	<!-- 불용키워드에 입력할 항목 임시 저장소 -->
	<input type="hidden" id="txtNotuse" name="txtNotuse" value="" style="width:800px;"/>
	<!-- 로그인 중인 사용자정보 저장 -->
	<input type="hidden" id="userId" name="userId" value="<%=userId%>" style="width:800px;"/>

    <div class="layInner">
        <div id="ly_movieInfo"> </div>

        <div class="layCont">
            <div class="act-tabform">
                <div class="mod_comTab act-tab">
                    <ul>
                        <li class="on"><a href="#lypop_tab1">메타관리</a></li>
                        <li><a href="#lypop_tab2" id="undefinedTab">미분류</a></li> <%--<li><a href="#lypop_tab2" class="existence">미분류</a></li>--%>
                        <%--<li><a href="#lypop_tab3" id="awardInfoTab">수상정보</a></li>--%>
                        <li><a href="#lypop_tab4" id="cine21InfoTab">씨네21</a></li>
                        <li><a href="#lypop_tab5">CCUBE</a></li>
                    </ul>
                </div>

                <div id="lypop_tab1" class="act-tabCn on">
                    <div class="editwrap">
                        <div class="remarks" style="">
                            <div><span class="bgc_1"></span>자동 추출 태그</div>
                            <div><span class="bgc_4"></span>사전 등록 태그</div>
                            <div><span class="bgc_3"></span>신규 등록 태그</div>
                        </div>
                        <dl>
                            <dt>시간적 배경</dt>
                            <dd id="metaWhen">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>공간적 배경</dt>
                            <dd id="metaWhere">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>주제/소재</dt>
                            <dd id="metaWhat">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>인물/캐릭터</dt>
                            <dd id="metaWho">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>캐릭터명</dt>
                            <dd id="metaCharacter">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>감성/분위기</dt>
                            <dd id="metaEmotion">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                                <div class="subtag">
                                    <dl>
                                        <dt>장르감성어</dt>
                                        <dd id="wordsGenre">
                                            <button class="btn_add_txt">추가</button>
                                            <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>SNS감성어</dt>
                                        <dd id="wordsSns">
                                            <label for="subtag_2-1">
                                                <input type="checkbox" id="subtag_2-1">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_2-2">
                                                <input type="checkbox" id="subtag_2-2">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_2-3">
                                                <input type="checkbox" id="subtag_2-3">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_2-4">
                                                <input type="checkbox" id="subtag_2-4">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_2-5">
                                                <input type="checkbox" id="subtag_2-5">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_2-6">
                                                <input type="checkbox" id="subtag_2-6">
                                                <span>감성어</span>
                                            </label>
                                            <button class="btn_add_txt">추가</button>
                                        </dd>
                                    </dl>
                                    <dl>
                                        <dt>감성유의어</dt>
                                        <dd id="wordsAssoc">
                                            <label for="subtag_3-1">
                                                <input type="checkbox" id="subtag_3-1">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_3-2">
                                                <input type="checkbox" id="subtag_3-2">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_3-3">
                                                <input type="checkbox" id="subtag_3-3">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_3-4">
                                                <input type="checkbox" id="subtag_3-4">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_3-5">
                                                <input type="checkbox" id="subtag_3-5">
                                                <span>감성어</span>
                                            </label>
                                            <label for="subtag_3-6">
                                                <input type="checkbox" id="subtag_3-6">
                                                <span>감성어</span>
                                            </label>
                                            <button class="btn_add_txt">추가</button>
                                        </dd>
                                    </dl>
                                </div>
                            </dd>
                        </dl>
                        <!-- 2018-04-19 추가 -->
                        <div class="btnWrap btnMid center extract">
                            <button id="getSubGenreFromDB">서브 장르 추출</button>
                        </div>
                        <!-- //2018-04-19 추가 -->
                        <hr>
                        <dl>
                            <dt>서브 장르</dt>
                            <dd id="listSubGenre">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>검색 키워드</dt>
                            <dd id="listSearchKeywords">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>추천표헌</dt>
                            <dd id="listRecoTarget">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>추천상황</dt>
                            <dd id="listRecoSituation">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <dl>
                            <dt>수상정보</dt>
                            <dd id="listAward">
								<span class="tag_add">
									<a href="#" class="btn_add">추가</a>
                                    <a href="#" class="btn_del removeAll">삭제</a><!-- 2018-04-06 추가 -->
								</span>
                            </dd>
                        </dl>
                        <hr>
                        <dl>
                            <dt>추출주기</dt>
                            <dd>
                                <select id="metaDuation">
                                    <option value="">설정안함</option>
                                    <option value="6m">6개월마다</option>
                                    <option value="1y">1년마다</option>
                                </select>
                            </dd>
                        </dl>
                    </div>
                    <div class="btnWrap btnBig center">
                        <button>닫기</button>
                        <button>승인</button>
                        <button>즉시배포</button>
                        <button>재수집</button>
                        <button>재추출</button>
                        <button>불가</button>
                    </div>
                </div><!-- //메타관리 -->

                <div id="lypop_tab2" class="act-tabCn">
                    <div class="editwrap notSort">
                        <dl>
                            <!-- <dt></dt> -->
                            <dd id="metaUnclassified">
                            </dd>
                        </dl>
                    </div>
                    <div class="btnWrap btnBig center">
                        <button>닫기</button>
                        <button>승인</button>
                        <button>즉시배포</button>
                        <button disabled="disabled">재수집</button>
                        <button disabled="disabled">재추출</button>
                        <button disabled="disabled">불가</button>
                    </div>
                </div><!-- //미분류 -->

                <div id="lypop_tab3" class="act-tabCn">
                    <div class="award_info">
                        <div class="main_detail">

                            <div class="btnWrap">
                                <button id="removeAwardInfo">수상정보 삭제</button>
                            </div>
                            <div class="info_produce" id="awardInfo">
                            </div>
                            <!--
                            <h4 class="tit_movie">
                                <a href="#">18회 올해의 여성영화인상, 2017</a>
                            </h4>
                            <div class="info_produce">
                                <dl class="list_produce">
                                    <dt>수상</dt>
                                    <dd>
										<span class="info_person">
											<a href="#" class="link_person #click">박은경</a>
											(제작자상)
										</span>
                                    </dd>
                                </dl>
                            </div>

                            <h4 class="tit_movie">
                                <a href="#">17회 디렉터스 컷 어워즈, 2017</a>
                            </h4>
                            <div class="info_produce #award">
                                <dl class="list_produce">
                                    <dt>수상</dt>
                                    <dd>
										<span class="info_person">
											<a href="#" class="link_person #click">최귀화</a>
											(올해의 신인남자연기상)
										</span>
										<span class="info_person">
											<a href="#" class="link_person #click">장훈</a>
											(올해의 특별언급)
										</span>
                                    </dd>
                                </dl>
                            </div>

                            <h4 class="tit_movie">
                                <a href="#">38회 청룡영화상, 2017</a>
                            </h4>
                            <div class="info_produce #award">
                                <dl class="list_produce">
                                    <dt>수상</dt>
                                    <dd>
										<span class="info_person">
											<span class="txt_award">최우수작품상</span>
										</span>
										<span class="info_person">
											<a href="/person/main?personId=561" class="link_person #click">송강호</a>
											(남우주연상)
										</span>
										<span class="info_person">
											<a href="/person/main?personId=1237" class="link_person #click">조영욱</a>
											(음악상)
										</span>
										<span class="info_person">
											<span class="txt_award">한국영화최다관객상</span>
										</span>
                                    </dd>
                                </dl>

                                <dl class="list_produce">
                                    <dt>후보</dt>
                                    <dd>
										<span class="info_person">
											<a href="/person/main?personId=80611" class="link_person #click">장훈</a>
											(감독상)
										</span>
										<span class="info_person">
											<a href="/person/main?personId=2686" class="link_person #click">유해진</a>
											(남우조연상)
										</span>
										<span class="info_person">
											<a href="/person/main?personId=405308" class="link_person #click">류준열</a>
											(신인남우상)
										</span>
										<span class="info_person">
											<a href="/person/main?personId=381379" class="link_person #click">엄유나</a>
											(각본상)
										</span>
										<span class="info_person">
											<a href="/person/main?personId=38373" class="link_person #click">조화성</a>
											(미술상)
										</span>
                                    </dd>
                                </dl>
                            </div>
                            -->
                        </div><!-- //.main_detail -->
                    </div><!-- //.award_info -->
                    <div class="btnWrap btnBig center">
                        <button>닫기</button>
                        <button disabled="disabled">승인</button>
                        <button disabled="disabled">즉시배포</button>
                        <button disabled="disabled">재수집</button>
                        <button disabled="disabled">재추출</button>
                        <button disabled="disabled">불가</button>
                    </div>
                </div><!-- //수상정보 -->

                <div id="lypop_tab4" class="act-tabCn">

                    <div class="cine21" id="cine21Info">
                    </div>
                    <div class="btnWrap btnBig center">
                        <button>닫기</button>
                        <button disabled="disabled">승인</button>
                        <button disabled="disabled">재수집</button>
                        <button disabled="disabled">재추출</button>
                        <button disabled="disabled">불가</button>
                    </div>
                </div><!-- //씨네21 -->

                <div id="lypop_tab5" class="act-tabCn">
                    <div class="ccube">
                        <div class="leftWrap">
                            <dl>
                                <dt>시리즈 ID</dt>
                                <dd id="series_id"></dd>
                            </dl>
                            <dl>
                                <dt>콘텐츠 ID</dt>
                                <dd id="content_id"></dd>
                            </dl>
                            <dl>
                                <dt>마스터 ID</dt>
                                <dd id="master_content_id"></dd>
                            </dl>
                            <dl>
                                <dt>영진위 ID</dt>
                                <dd id="kmrb_id"></dd>
                            </dl>
                            <dl>
                                <dt>제작국가</dt>
                                <dd id="country_of_origin"></dd>
                            </dl>
                            <dl>
                                <dt>제작년도</dt>
                                <dd id="year"></dd>
                            </dl>
                            <dl>
                                <dt>국내개봉일</dt>
                                <dd id="domestic_release_date"></dd>
                            </dl>
                            <dl>
                                <dt>KT 시청등급</dt>
                                <dd id="kt_rating"></dd>
                            </dl>
                        </div>
                        <div class="rightWrap">
                            <dl>
                                <dt>수급 카테고리</dt>
                                <dd id="sad_ctgry_nm"></dd>
                            </dl>
                            <dl>
                                <dt>시리즈 수급명</dt>
                                <dd id="series_nm"></dd>
                            </dl>
                            <dl>
                                <dt>콘텐츠 수급명</dt>
                                <dd id="content_title"></dd>
                            </dl>
                            <dl>
                                <dt>콘텐츠 노출제목</dt>
                                <dd id="title_brief"></dd>
                            </dl>
                            <%--<dl>--%>
                                <%--<dt>콘텐츠 줄임제목</dt>--%>
                                <%--<dd id="_"></dd>--%>
                            <%--</dl>--%>
                            <dl>
                                <dt>콘텐츠 영문제목</dt>
                                <dd id="eng_title"></dd>
                            </dl>
                            <dl>
                                <dt>정렬제목</dt>
                                <dd id="purity_title"></dd>
                            </dl>
                            <dl>
                                <dt>감독</dt>
                                <dd id="director"></dd>
                            </dl>
                            <dl>
                                <dt>출연</dt>
                                <dd id="actors_display"></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="btnWrap btnBig center">
                        <button>닫기</button>
                        <button disabled="disabled">승인</button>
                        <button disabled="disabled">즉시배포</button>
                        <button disabled="disabled">재수집</button>
                        <button disabled="disabled">재추출</button>
                    </div>
                </div><!-- //CCUBE -->
            </div>
            <!-- //.act-tabform 탭 -->
        </div><!-- //.layCont -->
        <a href="javascript:PopUpClose()" class="btn_close">닫기</a>
		<div id="autocomplete" class="sortWrap"><!-- style="width: 150px; height: 200px;"-->
		</div>
    </div>
</div>
<!-- //레이어 팝업 -->

<!-- //레이어 팝업 -->
<%--content ends--%>

<%--ComFooter Section--%>
<%@ include file="/WEB-INF/jsp/common/ComFooter.jsp" %>
</body>
</html>
<script id="template_meta_movie_info" type="text/html">
    <div class="layTop">
        <div class="tag_wrap">
            <span data-content="tagCnt" id="tagNumber" class="num">0</span>
            <button id="tagRollback" class="btn_repair">이전 태그 복구</button>
        </div>
        <div class="thumbnail">
			<img width="180px" height="254pxen" data-src="tagPoster" src="" alt="포스터">
			<%--mcid로 동일 컨텐츠 검색 --%>
			<div class="mcidBox">
				<a href="javascript:btnMcidSearch()" class="btn_mcidSearch">MCID 조회</a><%--a href="javascript:layerAction('ly_pop_mcidSearchResult');" --%>
			</div>			
		</div>
        <div class="inner">
            <h5 data-content="movieTitle">라이언 일병 구하기 <span class="eng" data-content="movieOTitle">Saving Private Ryan, 1998</span></h5>
            <div class="detail_info">
                <dl>
                    <dt>장르</dt>
                    <dd data-content="movieGenre"></dd>
                </dl>
                <dl>
                    <dt>감독</dt>
                    <dd data-content="movieDirector"></dd>
                </dl>
                <dl>
                    <dt>출연</dt>
                    <dd data-content="movieActor"></dd>
                </dl>
                <%--<dl>--%>
                    <%--<dt>시리즈 여부</dt>--%>
                    <%--<dd data-content="bSeriesYN"></dd>--%>
                <%--</dl>--%>
            </div>
            <div class="story" data-content="moviePlot"></div>
        </div>
    </div><!-- //.layTop -->
</script>
<!-- input에 펑션이나 data-type -->
<script id="template_meta_tag" type="text/html">
    <a id="displayTag" href="#" class="txt" data-content="tagName">
    </a>
    <input id="updateTag" class="metaUpdateInput" type="text" placeholder="입력" style="display: none" onfocus="fnAutoCompletePop(this)" data-id="dataId">
    <a href="#" class="btn_del">삭제</a>
    <div class="sortWrap">
    <ul>
        <li>
            <label for="ra_sort_1-1" id="metaWhenPosition">
                시간적 배경
                <div class="radiobtn">
                    <input type="radio" id="ra_sort_1-1" name="ra_sort_1" checked>
                    <span></span>
                </div>
            </label>
        </li>
        <li>
            <label for="ra_sort_1-2" id="metaWherePosition">
                공간적 배경
                <div class="radiobtn">
                    <input type="radio" id="ra_sort_1-2" name="ra_sort_1">
                    <span></span>
                </div>
            </label>
        </li>
        <li>
            <label for="ra_sort_1-3" id="metaWhatPosition">
                주제/소재
                <div class="radiobtn">
                    <input type="radio" id="ra_sort_1-3" name="ra_sort_1">
                    <span></span>
                </div>
            </label>
        </li>
        <li>
            <label for="ra_sort_1-4" id="metaWhoPosition">
                인물/캐릭터
                <div class="radiobtn">
                    <input type="radio" id="ra_sort_1-4" name="ra_sort_1">
                    <span></span>
                </div>
            </label>
        </li>
        <li>
            <label for="ra_sort_1-5" id="metaEmotionPosition">
                감성/분위기
                <div class="radiobtn">
                    <input type="radio" id="ra_sort_1-5" name="ra_sort_1">
                    <span></span>
                </div>
            </label>
        </li>
        <%-- 불용어 사전 --%>
        <li>
            <label for="ra_sort_1-6" id="metaNotusePosition" value="notuse">
                불용 키워드
                <div class="radiobtn">
                    <input type="radio" id="ra_sort_1-6" name="ra_sort_1">
                    <span></span>
                </div>
            </label>
        </li>
    </ul>
    </div><!-- //.sortWrap -->

</script>
<script>

    function PopUpClose (){

        if ( MetaPopupInstance.isUpdating() ) {
            OM_ALERT("완료되지 않은 키워드가 있습니다<br> 작업 완료 후 다시 시도 바랍니다.");
            return ;
        }
        metaLayerAction();
    }
    var SEARCH_TYPE = {
        "ALL" : "전체",
        "OTH" : "해외영화",
        "KOR" : "한국영화",
        "SER" : "시리즈",
        "yj":"YJ",
        "CcubeContent": "CCUBE"
    };
    var SEARCH_STAT = {
        "ALL" : "전체",
        "RC" : "수집대기",
        "SC" : "수집성공",
        "FC" : "수집실패",
        "RR" : "정제대기",
        "SR" : "정제성공",
        "FR" : "추출실패",
        "RA" : "추출대기",
        "SA" : "추출성공",
        "FA" : "추출실패",
        "FT" : "승인불가",
        "RT" : "승인대기",
        "ST" : "태깅완료"
     }

    var defultOption = {
        "hash": "111",
        "custid": "111",
        "pagesize": "20",
        "pageno": "1",
        "searchstat": "ALL",
        "searchstat": "ALL",
        "searchsdate": "",
        "searchedate": "",
        "saarchkeyword": "",
        "searchparts": ""
    };
    var dateRange = new OM_DATE_PICKER();
    var metaTable = new MetaTable();

    $(document).ready(function(){

        OM_READY(function(){

            dateRange.init({
                domCheckAll: ".btn_allday",
                domStartDate: "#startDate",
                domEndDate:   "#endDate",
                initStartDate: OM_UTIL.startDate(),
                initEndDate: OM_UTIL.currentDate(),
                onSelectStartDate: function(dateText){

                },
                onSelectEndDate: function(dateText){

                }
            });

            // 조회 결과 탭 이벤트
            $(".inquiryResult button").click(function () {

                switch($(this).val()) {
                    case "수집실패": $("#search_stat").val("FC"); break;
                    case "추출실패": $("#search_stat").val("FA"); break;
                    case "승인대기": $("#search_stat").val("RT"); break;
                    case "승인완료": $("#search_stat").val("ST"); break;
                    default:
                        break;
                }
                searchExecute();
            });

            $(".btn_result").click(function () {
                searchExecute();
            });
            $(".keyword").keyup(function (e) {
                if (e.keyCode == 13) {
                    // 엔터를 입력 하면 조회 한다.
                    searchExecute()
                }
            });

        });
        searchExecute();
    });

    var formData = function(){

        var searchpartarray = [];
        var keyword = "";
        $(".check input").each(function(index, value) {
            if ( $(this).is(":checked") ){
                searchpartarray.push($(this).val())
            }
        });

        // 키워드
        keyword = $(".keyword input").val();
        var searchParts = []
        $("#searchParts input").each(function(){
            if ( $(this).prop( "checked" ) ) {
                searchParts.push($(this).val());
            }
        })

        return {
            searchtype: $( "#search_type option:selected" ).val(), // ALL/전체, OTH/해외영화, KOR/한국영화, SER/시리즈
            searchstat: $( "#search_stat option:selected" ).val(), // ALL/전체, FC/수집실패, FA/추출실패, RT/승인대기, ST/승인완료
            searchsdate :  dateRange.getStartDate(),
            searchedate :    dateRange.getEndDate(),
            searchkeyword: keyword,
            searchparts:   searchParts.join(",")
        };

    };
    
    /*
    //to js
    //autokeywordParam
    var autokeywordParam = function(){
        return {
            type : "",
            KEYWORD : "",
            orderby : "abc",
            pagesize : 100000,
            pageno : 1
        };
    };
    */

    var searchExecute = function(searchPageNo){

        var pageNo = searchPageNo || 1;

        // 조회 결과를 가져 오고
        // 테이블을 갱신한다.
        var forParam = formData();
        forParam.pageno = pageNo + "";

        // 키워드 입력 후 카테고리 선택을 안할 경우 검색 되지 않음
        if ( forParam.searchparts.length == 0 && forParam.searchkeyword.length != 0 ) {
            OM_ALERT("키워드 검색인 경우, <br>최소 한개 이상 카테고리를 선택 하세요");
            return;
        }
        // 일괄 액션 초기화
        $("#multipleAction button").eq(0).addClass("disabled"); // 수집
        $("#multipleAction button").eq(1).addClass("disabled"); // 추출
        $("#multipleAction button").eq(2).addClass("disabled"); // 대기

        OM_API(
                APIS.ITEM_LIST,
                forParam,
                function(data){
                    metaTable.init({
                        data : data,
                        domId : ".tbl_bs"
                    }).render();
                },
                function(){
                    console.log("Error")
        });
        
        
        /*
        //테스트 11.05 : 자동완성 조회 안함
        if("1"=="1"){
        	return;
        }
        
        //처음 1회만 조회 - 모든 텍박이 비어 있을때만 조회함
        if($("#txtList_when").val() || $("#txtList_where").val() || $("#txtList_what").val() || 
        	$("#txtList_who").val() || $("#txtList_emotion").val() || $("#txtList_character").val() ){
        	return;
        }
        
        var autokeywordWhenParam = autokeywordParam();
        var autokeywordWhereParam = autokeywordParam();
        var autokeywordWhatParam = autokeywordParam();
        var autokeywordWhoParam = autokeywordParam();
        var autokeywordEmotionParam = autokeywordParam();
        var autokeywordCharacterParam = autokeywordParam();
        
        autokeywordWhenParam.type = "when";
        autokeywordWhereParam.type = "where";
        autokeywordWhatParam.type = "what";
        autokeywordWhoParam.type = "who";
        autokeywordEmotionParam.type = "emotion";
        autokeywordCharacterParam.type = "character";
        
        autokeywordWhenParam.pagesize = "100000";
        autokeywordWhereParam.pagesize = "100000";
        autokeywordWhatParam.pagesize = "100000";
        autokeywordWhoParam.pagesize = "100000";
        autokeywordEmotionParam.pagesize = "100000";
        autokeywordCharacterParam.pagesize = "100000";

        var apiInfo = { url: "/dic/list", method: "GET"}	//아래에도 고정
        
        var paramWhen = {
            apiUrl   : JSON.stringify(apiInfo),
            apiParam : JSON.stringify(autokeywordWhenParam||{})
        };
        var paramWhere = {
            apiUrl   : JSON.stringify(apiInfo),
            apiParam : JSON.stringify(autokeywordWhereParam||{})
        };
        var paramWhat = {
            apiUrl   : JSON.stringify(apiInfo),
            apiParam : JSON.stringify(autokeywordWhatParam||{})
        };
        var paramWho = {
            apiUrl   : JSON.stringify(apiInfo),
            apiParam : JSON.stringify(autokeywordWhoParam||{})
        };
        var paramEmotion = {
            apiUrl   : JSON.stringify(apiInfo),
            apiParam : JSON.stringify(autokeywordEmotionParam||{})
        };
        var paramCharacter = {
            apiUrl   : JSON.stringify(apiInfo),
            apiParam : JSON.stringify(autokeywordCharacterParam||{})
        };
        
        var arrParam = [paramWhen,paramWhere,paramWhat,paramWho,paramEmotion,paramCharacter]
        
        for(var i in arrParam){
            fnLoadDic(arrParam[i].apiParam.split("\"")[3],arrParam[i]);
        }
        */
        
    }
    
    //js로 이동
    /*
    function fnLoadDic(strType,param){
        $.ajax({
            url: "/v1/apis",
            method: "POST",
            data: param,
            dataType: "json",
            success: function(data,textStatus,jqXHR){
                if ( OM_API_CKECK(data) == true ) {
                    $("#list_"+strType).empty();
                    
                    $.each(data.RESULT.LIST_WORDS,function(index,item){
                    	//console.log("when data " + index + " : " + item);
                    	//"list_"+strType
                    	$("#list_"+strType).append($("<option>").attr("value",item).text(item));
                    	$("#txtList_"+strType).append(item+",");
                    });
                    
                    $("#txtList_"+strType).val(data.RESULT.LIST_WORDS);
                } else {
                    Loading(false);
                }
            },
            error: function(jqXHR,textStatus,errorThrown){
                console.log("Error");

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
    */
</script>

<!-- 미리 읽어와 팝업창의 텍스트상자에 적용 -->
<datalist id="list_character"></datalist>
<datalist id="list_emotion"></datalist>
<datalist id="list_what"></datalist>
<datalist id="list_when"></datalist>
<datalist id="list_where"></datalist>
<datalist id="list_who"></datalist>

<input type="hidden" id="txtList_character"></input>
<input type="hidden" id="txtList_emotion"></input>
<input type="hidden" id="txtList_what"></input>
<input type="hidden" id="txtList_when"></input>
<input type="hidden" id="txtList_where"></input>
<input type="hidden" id="txtList_who"></input>




<!-- mcid로 동일 컨텐츠 검색 레이어 팝업 -->
<div id="ly_pop_mcidSearchResult" class="mod_layer" style="display: none;">
	<div class="layInner _mcid">
		<div class="_thead">
			<table>
				<colgroup>
					<col style="width:152px;" />
					<col style="width:487px;" />
				</colgroup>
				<thead>
					<tr>
						<th>MCID&amp;SID</th>
						<th>제목</th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="mCustomScrollbar scroll_tbodyBox" data-mcs-theme="dark">
			<div class="_tbody scroll_tbody">
				<table id="tblMcidSearchResult">
					<colgroup>
						<!--
						<col style="width:163px;" />
						<col style="width:487px;" />
						-->
						<col style="width:152px;" />
						<col style="width:487px;" />
					</colgroup>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="btn_close01">
			<a href="javascript:layerAction('','ly_pop_mcidSearchResult')" class="btn_del">삭제</a>
		</div>
	</div>
</div>
<!-- 레이어 팝업 -->
