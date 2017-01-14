<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>원격제어</title>
</head>
<body>
<div class='backLayer' style='' > </div>
<section class="content-header">
    <h1> 원격제어 </h1>
    <div class="breadcrumb-line"></div>
    <ol class="breadcrumb">
        <li><a href="<c:url value="/"/>">HOME</a></li>
        <li><a href="<c:url value="/remote/"/>">원격제어</a></li>
        <li><a href="<c:url value="/remote/"/>">원격제어 조회</a></li>
    </ol>
</section>


<!-- Main content -->
<section class="content">
    <div class="paddingInside">
        <section class="content">
            <c:if test="${needSetting eq 'Y'}"><div class="font-red">* 사용자설정에서 ipaddress와 listenport를 설정하세요.</div></c:if>
            <!-- row 정역 채널 상태 정보-->
            <div class="row">
                <div class="col-md-12">
                    <div class="bottom-25">
                        <div class="box-header-sm">
                            <h3 class="box-title">정역 채널 상태 정보</h3>
                        </div>
                    </div>
                </div>
                <!-- box-boxing -->
                <%--<c:if test="${notConnected eq 'connected'}">--%>

                    <div class="box-boxing col-md-12">
                        <div class="box">
                            <div class="no-padding">
                                <div class="box-body table-responsive no-padding">
                                    <table class="table table-hover table-th-grey pointer text-align-center">
                                        <colgroup>
                                            <col width="20%"/>
                                            <col width="20%"/>
                                            <col width="20%"/>
                                            <col width="20%"/>
                                            <col width="20%"/>
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th class="text-align-center">1채널</th>
                                            <th class="text-align-center">2채널</th>
                                            <th class="text-align-center">3채널</th>
                                            <th class="text-align-center">4채널</th>
                                            <th class="text-align-center">5채널</th>
                                        </tr>
                                        <c:if test="${laborStates eq 'notConnected'}">
                                            <tr>
                                                <td colspan="5">${laborStates}</td>
                                            </tr>
                                        </c:if>

                                        <c:if test="${laborStates ne 'notConnected' }">
                                            <tr class="height-middle">
                                                <td class="">
                                                    <span id="laborStatesText1">
                                                    <c:if test="${laborStates.channel1 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel1 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel1 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel1 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel1 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                                <td class="">
                                                    <span id="laborStatesText2">
                                                    <c:if test="${laborStates.channel2 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel2 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel2 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel2 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel2 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                                <td class="">
                                                    <span id="laborStatesText3">
                                                    <c:if test="${laborStates.channel3 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel3 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel3 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel3 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel3 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                                <td class="">
                                                    <span id="laborStatesText4">
                                                    <c:if test="${laborStates.channel4 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel4 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel4 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel4 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel4 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                                <td class="">
                                                    <span id="laborStatesText5">
                                                    <c:if test="${laborStates.channel5 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel5 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel5 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel5 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel5 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                            </tr>
                                            <tr class="height-middle">
                                                <td class="">
                                                    <a id="setOneLaborState12" onclick="setOneLaborState(1,2);"
                                                       <c:if test="${laborStates.channel1 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel1 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState14" onclick="setOneLaborState(1,4);"
                                                       <c:if test="${laborStates.channel1 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel1 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState13" onclick="setOneLaborState(1,3);"
                                                       <c:if test="${laborStates.channel1 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel1 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState11" onclick="setOneLaborState(1,1);"
                                                       <c:if test="${laborStates.channel1 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel1 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>
                                                <td class="">
                                                    <a id="setOneLaborState22" onclick="setOneLaborState(2,2);"
                                                       <c:if test="${laborStates.channel2 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel2 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState24" onclick="setOneLaborState(2,4);"
                                                       <c:if test="${laborStates.channel2 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel2 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState23" onclick="setOneLaborState(2,3);"
                                                       <c:if test="${laborStates.channel2 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel2 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState21" onclick="setOneLaborState(2,1);"
                                                       <c:if test="${laborStates.channel2 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel2 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>
                                                <td class="">
                                                    <a id="setOneLaborState32" onclick="setOneLaborState(3,2);"
                                                       <c:if test="${laborStates.channel3 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel3 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState34" onclick="setOneLaborState(3,4);"
                                                       <c:if test="${laborStates.channel3 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel3 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState33" onclick="setOneLaborState(3,3);"
                                                       <c:if test="${laborStates.channel3 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel3 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState31" onclick="setOneLaborState(3,1);"
                                                       <c:if test="${laborStates.channel3 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel3 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>
                                                <td class="">
                                                    <a id="setOneLaborState42" onclick="setOneLaborState(4,2);"
                                                       <c:if test="${laborStates.channel4 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel4 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState44" onclick="setOneLaborState(4,4);"
                                                       <c:if test="${laborStates.channel4 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel4 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState43" onclick="setOneLaborState(4,3);"
                                                       <c:if test="${laborStates.channel4 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel4 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState41" onclick="setOneLaborState(4,1);"
                                                       <c:if test="${laborStates.channel4 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel4 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>
                                                <td class="">
                                                    <a id="setOneLaborState52" onclick="setOneLaborState(5,2);"
                                                       <c:if test="${laborStates.channel5 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel5 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState54" onclick="setOneLaborState(5,4);"
                                                       <c:if test="${laborStates.channel5 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel5 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState53" onclick="setOneLaborState(5,3);"
                                                       <c:if test="${laborStates.channel5 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel5 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState51" onclick="setOneLaborState(5,1);"
                                                       <c:if test="${laborStates.channel5 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel5 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>

                                            </tr>
                                        </c:if>
                                        <tr>
                                            <th class="text-align-center">6채널</th>
                                            <th class="text-align-center">7채널</th>
                                            <th class="text-align-center">8채널</th>
                                            <th class="text-align-center">9채널</th>
                                            <th class="text-align-center">10채널</th>
                                        </tr>

                                        <c:if test="${laborStates eq 'notConnected'}">
                                            <tr>
                                                <td colspan="5">${laborStates}</td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${laborStates ne 'notConnected'}">
                                            <tr class="height-middle">
                                                <td class="">
                                                    <span id="laborStatesText6">
                                                    <c:if test="${laborStates.channel6 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel6 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel6 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel6 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel6 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                                <td class="">
                                                    <span id="laborStatesText7">
                                                    <c:if test="${laborStates.channel7 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel7 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel7 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel7 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel7 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                                <td class="">
                                                    <span id="laborStatesText8">
                                                    <c:if test="${laborStates.channel8 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel8 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel8 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel8 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel8 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                                <td class="">
                                                    <span id="laborStatesText9">
                                                    <c:if test="${laborStates.channel9 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel9 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel9 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel9 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel9 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                                <td class="">
                                                    <span id="laborStatesText10">
                                                    <c:if test="${laborStates.channel10 eq '0'}"></c:if>
                                                    <c:if test="${laborStates.channel10 eq '1'}">자동</c:if>
                                                    <c:if test="${laborStates.channel10 eq '2'}">열림</c:if>
                                                    <c:if test="${laborStates.channel10 eq '3'}">닫힘</c:if>
                                                    <c:if test="${laborStates.channel10 eq '4'}">정지</c:if>
                                                        </span>
                                                </td>
                                            </tr>

                                            <tr class="height-middle">
                                                <td class="">
                                                    <a id="setOneLaborState62" onclick="setOneLaborState(6,2);"
                                                       <c:if test="${laborStates.channel6 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel6 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState64" onclick="setOneLaborState(6,4);"
                                                       <c:if test="${laborStates.channel6 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel6 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState63" onclick="setOneLaborState(6,3);"
                                                       <c:if test="${laborStates.channel6 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel6 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState61" onclick="setOneLaborState(6,1);"
                                                       <c:if test="${laborStates.channel6 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel6 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>
                                                <td class="">
                                                    <a id="setOneLaborState72" onclick="setOneLaborState(7,2);"
                                                       <c:if test="${laborStates.channel7 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel7 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState74" onclick="setOneLaborState(7,4);"
                                                       <c:if test="${laborStates.channel7 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel7 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState73" onclick="setOneLaborState(7,3);"
                                                       <c:if test="${laborStates.channel7 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel7 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState71" onclick="setOneLaborState(7,1);"
                                                       <c:if test="${laborStates.channel7 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel7 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>
                                                <td class="">
                                                    <a id="setOneLaborState82" onclick="setOneLaborState(8,2);"
                                                       <c:if test="${laborStates.channel8 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel8 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState84" onclick="setOneLaborState(8,4);"
                                                       <c:if test="${laborStates.channel8 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel8 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState83" onclick="setOneLaborState(8,3);"
                                                       <c:if test="${laborStates.channel8 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel8 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState81" onclick="setOneLaborState(8,1);"
                                                       <c:if test="${laborStates.channel8 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel8 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>
                                                <td class="">
                                                    <a id="setOneLaborState92" onclick="setOneLaborState(9,2);"
                                                       <c:if test="${laborStates.channel9 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel9 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState94" onclick="setOneLaborState(9,4);"
                                                       <c:if test="${laborStates.channel9 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel9 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState93" onclick="setOneLaborState(9,3);"
                                                       <c:if test="${laborStates.channel9 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel9 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState91" onclick="setOneLaborState(9,1);"
                                                       <c:if test="${laborStates.channel9 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel9 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>
                                                <td class="">
                                                    <a id="setOneLaborState102" onclick="setOneLaborState(10,2);"
                                                       <c:if test="${laborStates.channel10 eq '2'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel10 ne '2'}">class="square-btn-default"</c:if>
                                                            >열림</a>
                                                    <a id="setOneLaborState104" onclick="setOneLaborState(10,4);"
                                                       <c:if test="${laborStates.channel10 eq '4'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel10 ne '4'}">class="square-btn-default"</c:if>
                                                            >정지</a><br>
                                                    <a id="setOneLaborState103" onclick="setOneLaborState(10,3);"
                                                       <c:if test="${laborStates.channel10 eq '3'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel10 ne '3'}">class="square-btn-default"</c:if>
                                                            >닫힘</a>
                                                    <a id="setOneLaborState101" onclick="setOneLaborState(10,1);"
                                                       <c:if test="${laborStates.channel10 eq '1'}">class="square-btn-red"</c:if>
                                                       <c:if test="${laborStates.channel10 ne '1'}">class="square-btn-default"</c:if>
                                                            >자동</a>
                                                </td>

                                            </tr>
                                        </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- //box-boxing -->
                <%--</c:if>--%>
            </div>
            <!-- /.row 정역 채널 상태 정보 -->

            <!-- row ON-OFF 채널 상태 정보-->
            <div class="row">
                <div class="col-md-12">
                    <div class="bottom-25">
                        <div class="box-header-sm">
                            <h3 class="box-title">ON-OFF 채널 상태 정보</h3>
                        </div>
                    </div>
                </div>

                <div class="box-boxing col-md-12">
                    <div class="box">
                        <div class="no-padding">
                            <div class="box-body table-responsive no-padding">
                                <table class="table table-hover table-th-grey pointer text-align-center">
                                    <colgroup>
                                        <col width="20%"/>
                                        <col width="20%"/>
                                        <col width="20%"/>
                                        <col width="20%"/>
                                        <col width="20%"/>
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th class="text-align-center">1채널</th>
                                        <th class="text-align-center">2채널</th>
                                        <th class="text-align-center">3채널</th>
                                        <th class="text-align-center">4채널</th>
                                        <th class="text-align-center">5채널</th>
                                    </tr>
                                    <c:if test="${onOffStates eq 'notConnected'}">
                                        <tr>
                                            <td colspan="5">${onOffStates}</td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${onOffStates ne 'notConnected' }">
                                        <tr class="height-middle">
                                            <td class="">
                                                <span id="onOffStatesText1">
                                                <c:if test="${onOffStates.channel1 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel1 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel1 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel1 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel1 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel1 eq '5'}">작동</c:if>
                                                </span>
                                            </td>
                                            <td class="">
                                                <span id="onOffStatesText2">
                                                <c:if test="${onOffStates.channel2 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel2 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel2 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel2 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel2 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel2 eq '5'}">작동</c:if>
                                                </span>
                                            </td>
                                            <td class="">
                                                <span id="onOffStatesText3">
                                                <c:if test="${onOffStates.channel3 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel3 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel3 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel3 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel3 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel3 eq '5'}">작동</c:if>
                                                    </span>
                                            </td>
                                            <td class="">
                                                <span id="onOffStatesText4">
                                                <c:if test="${onOffStates.channel4 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel4 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel4 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel4 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel4 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel4 eq '5'}">작동</c:if>
                                                    </span>
                                            </td>
                                            <td class="">
                                                  <span id="onOffStatesText5">
                                                <c:if test="${onOffStates.channel5 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel5 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel5 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel5 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel5 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel5 eq '5'}">작동</c:if>
                                                      </span>
                                            </td>
                                        </tr>
                                        <tr class="height-middle">
                                            <td class="">
                                                <a id="setOneOnOffState15" onclick="setOneOnOffState(1,5);"
                                                   <c:if test="${onOffStates.channel1 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel1 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState14" onclick="setOneOnOffState(1,4);"
                                                   <c:if test="${onOffStates.channel1 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel1 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState11" onclick="setOneOnOffState(1,1);"
                                                   <c:if test="${onOffStates.channel1 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel1 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>
                                            <td class="">
                                                <a id="setOneOnOffState25" onclick="setOneOnOffState(2,5);"
                                                   <c:if test="${onOffStates.channel2 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel2 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState24" onclick="setOneOnOffState(2,4);"
                                                   <c:if test="${onOffStates.channel2 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel2 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState21" onclick="setOneOnOffState(2,1);"
                                                   <c:if test="${onOffStates.channel2 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel2 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>
                                            <td class="">
                                                <a id="setOneOnOffState35" onclick="setOneOnOffState(3,5);"
                                                   <c:if test="${onOffStates.channel3 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel3 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState34" onclick="setOneOnOffState(3,4);"
                                                   <c:if test="${onOffStates.channel3 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel3 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState31" onclick="setOneOnOffState(3,1);"
                                                   <c:if test="${onOffStates.channel3 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel3 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>
                                            <td class="">
                                                <a id="setOneOnOffState45" onclick="setOneOnOffState(4,5);"
                                                   <c:if test="${onOffStates.channel4 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel4 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState44" onclick="setOneOnOffState(4,4);"
                                                   <c:if test="${onOffStates.channel4 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel4 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState41" onclick="setOneOnOffState(4,1);"
                                                   <c:if test="${onOffStates.channel4 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel4 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>
                                            <td class="">
                                                <a id="setOneOnOffState55" onclick="setOneOnOffState(5,5);"
                                                   <c:if test="${onOffStates.channel5 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel5 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState54" onclick="setOneOnOffState(5,4);"
                                                   <c:if test="${onOffStates.channel5 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel5 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState51" onclick="setOneOnOffState(5,1);"
                                                   <c:if test="${onOffStates.channel5 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel5 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>

                                        </tr>
                                    </c:if>
                                    <tr>
                                        <th class="text-align-center">6채널</th>
                                        <th class="text-align-center">7채널</th>
                                        <th class="text-align-center">8채널</th>
                                        <th class="text-align-center">9채널</th>
                                        <th class="text-align-center">10채널</th>
                                    </tr>
                                    <c:if test="${onOffStates eq 'notConnected'}">
                                        <tr>
                                            <td colspan="5">${onOffStates}</td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${onOffStates ne 'notConnected'}">
                                        <tr class="height-middle">
                                            <td class="">
                                                <span id="onOffStatesText6">
                                                <c:if test="${onOffStates.channel6 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel6 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel6 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel6 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel6 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel6 eq '5'}">작동</c:if>
                                                    </span>
                                            </td>
                                            <td class="">
                                                <span id="onOffStatesText7">
                                                <c:if test="${onOffStates.channel7 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel7 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel7 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel7 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel7 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel7 eq '5'}">작동</c:if>
                                                    </span>
                                            </td>
                                            <td class="">
                                                <span id="onOffStatesText8">
                                                <c:if test="${onOffStates.channel8 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel8 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel8 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel8 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel8 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel8 eq '5'}">작동</c:if>
                                                    </span>
                                            </td>
                                            <td class="">
                                                <span id="onOffStatesText9">
                                                <c:if test="${onOffStates.channel9 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel9 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel9 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel9 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel9 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel9 eq '5'}">작동</c:if>
                                                    </span>
                                            </td>
                                            <td class="">
                                                <span id="onOffStatesText10">
                                                <c:if test="${onOffStates.channel10 eq '0'}"></c:if>
                                                <c:if test="${onOffStates.channel10 eq '1'}">자동</c:if>
                                                <c:if test="${onOffStates.channel10 eq '2'}">열림</c:if>
                                                <c:if test="${onOffStates.channel10 eq '3'}">닫힘</c:if>
                                                <c:if test="${onOffStates.channel10 eq '4'}">정지</c:if>
                                                <c:if test="${onOffStates.channel10 eq '5'}">작동</c:if>
                                                    </span>
                                            </td>
                                        </tr>

                                        <tr class="height-middle">
                                            <td class="">
                                                <a id="setOneOnOffState65" onclick="setOneOnOffState(6,5);"
                                                   <c:if test="${onOffStates.channel6 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel6 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState64" onclick="setOneOnOffState(6,4);"
                                                   <c:if test="${onOffStates.channel6 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel6 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState61" onclick="setOneOnOffState(6,1);"
                                                   <c:if test="${onOffStates.channel6 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel6 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>
                                            <td class="">
                                                <a id="setOneOnOffState75" onclick="setOneOnOffState(7,5);"
                                                   <c:if test="${onOffStates.channel7 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel7 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState74" onclick="setOneOnOffState(7,4);"
                                                   <c:if test="${onOffStates.channel7 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel7 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState71" onclick="setOneOnOffState(7,1);"
                                                   <c:if test="${onOffStates.channel7 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel7 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>
                                            <td class="">
                                                <a id="setOneOnOffState85" onclick="setOneOnOffState(8,5);"
                                                   <c:if test="${onOffStates.channel8 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel8 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState84" onclick="setOneOnOffState(8,4);"
                                                   <c:if test="${onOffStates.channel8 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel8 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState81" onclick="setOneOnOffState(8,1);"
                                                   <c:if test="${onOffStates.channel8 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel8 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>
                                            <td class="">
                                                <a id="setOneOnOffState95" onclick="setOneOnOffState(9,5);"
                                                   <c:if test="${onOffStates.channel9 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel9 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState94" onclick="setOneOnOffState(9,4);"
                                                   <c:if test="${onOffStates.channel9 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel9 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState91" onclick="setOneOnOffState(9,1);"
                                                   <c:if test="${onOffStates.channel9 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel9 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>
                                            <td class="">
                                                <a id="setOneOnOffState105" onclick="setOneOnOffState(10,5);"
                                                   <c:if test="${onOffStates.channel10 eq '5'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel10 ne '5'}">class="square-btn-default"</c:if>
                                                        >작동</a>
                                                <a id="setOneOnOffState104" onclick="setOneOnOffState(10,4);"
                                                   <c:if test="${onOffStates.channel10 eq '4'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel10 ne '4'}">class="square-btn-default"</c:if>
                                                        >정지</a><br>
                                                <a id="setOneOnOffState101" onclick="setOneOnOffState(10,1);"
                                                   <c:if test="${onOffStates.channel10 eq '1'}">class="square-btn-red"</c:if>
                                                   <c:if test="${onOffStates.channel10 ne '1'}">class="square-btn-default"</c:if>
                                                        >자동</a>
                                            </td>

                                        </tr>

                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="overlay" style=" display: none; ">
                        <i class="fa fa-refresh fa-spin"></i>
                    </div>
                </div>

                <!-- //box-boxing -->
            </div>
            <!-- /.row ON-OFF 채널 상태 정보 -->

            <!-- row 열회수형환풍기-->
            <div class="row">
                <div class="col-md-12">
                    <div class="bottom-25">
                        <%--<form id="searchFrm" action="<c:url value="/monitor/search"/>" class="form-horizontal" method="post">--%>
                        <div class="box-header-sm">
                            <div class="col-md-6"><h3 class="box-title">열회수형환풍기</h3></div>
                            <div class="col-md-6"><h3 class="box-title">공기유동팬상태정보</h3></div>
                        </div>

                        <%--${heatrecoverystate}bb--%>
                        <%--${airfanstate}cc--%>
                        <%--</form>--%>
                        <!-- form end -->
                    </div>
                </div>
                <!-- box-boxing -->
                <div class="col-md-12">
                    <div class="box">
                        <div class="box-body table-responsive no-padding">
                            <form method="post">
                                <table class="table table-hover table-th-grey pointer">
                                    <colgroup>
                                        <col width="15%"/>
                                        <col width="15%"/>
                                        <col width="15%"/>
                                        <col width="*"/>
                                        <col width="15%"/>
                                    </colgroup>

                                    <tr class="text-align-center-th">
                                        <th>온도</th>
                                        <th>습도</th>
                                        <th>토출온도</th>
                                        <th>각도</th>
                                        <th>온도</th>
                                    </tr>

                                    <tr class="text-align-center-td">
                                        <td><input name="temperature" id="temperature" placeholder="온도"
                                                   class="form-control"
                                                   <c:if test="${  heatrecoverystate ne 'notConnected'}">value="${heatrecoverystate.temperature}"></c:if>
                                        </td>
                                        <td><input name="humidity" id="humidity" placeholder="습도" class="form-control"
                                                   <c:if test="${  heatrecoverystate ne 'notConnected'}">value="${heatrecoverystate.humidity}"></c:if>
                                        </td>
                                        <td><input name="discharge" id="discharge" placeholder="토출온도"
                                                   class="form-control"
                                                   <c:if test="${  heatrecoverystate ne 'notConnected'}">value="${heatrecoverystate.discharge}"></c:if>
                                        </td>
                                        <td>
                                            <c:if test="${  airfanstate ne 'notConnected'}">

                                                <select name="angle" id="angle" class="form-control">
                                                    <c:set var="airfanstateAngle" value="${airfanstate.angle}"/>


                                                    <c:forEach items="${angleList}" var="items" varStatus="idx">

                                                        <option value="${items.code}"

                                                                <c:if test="${items.code == airfanstateAngle}">selected</c:if>>
                                                                ${items.angleStr}</option>
                                                    </c:forEach>

                                                    <c:if test="${  airfanstate eq 'notConnected'}">
                                                        <option value="">연결안됨</option>
                                                    </c:if>
                                                </select>
                                            </c:if>
                                            <c:if test="${  airfanstate eq 'notConnected'}">연결안됨</c:if>
                                        </td>
                                        <td><input name="temperature2" id="temperature2" placeholder="온도"
                                                   class="form-control"
                                                   <c:if test="${  airfanstate ne 'notConnected'}">value="${airfanstate.temperature}"></c:if>
                                        </td>
                                    </tr>
                                    </tbody>
                                    <tfoot>
                                    <tr class="text-align-center-th">
                                        <th colspan="3"><a id="setHeatrecoverystate" class="square-btn-green">설정</a>
                                        </th>
                                        <th colspan="2"><a id="setAirfanstate" class="square-btn-green">설정</a></th>
                                    </tr>
                                    </tfoot>
                                </table>
                            </form>
                        </div>

                    </div>

                </div>
                <!-- //box-boxing -->

            </div>

            <!-- /.row 열회수형환풍기 -->


        </section>


    </div>
</section>
<!-- /.content -->

<script>
    <!--//bind start -->
    var fn_go_page = function (page) {
        //alert(11);
        //var page = $(this).attr('page');
        console.log(page)
        //alert(page)
        $("#page").val(page);
        fn_search();
    };
    function fn_search() {
        $('#searchFrm').submit();
    }
    $(function () {

        setClickedMenuBold(1);
        $('ul.sidebar-menu li.treeview').each(function (index) {
            $(this).removeClass('active')
//      console.log(this);
            var menu = $(this).attr('menu');
            if (menu == '원격제어') {
                $(this).addClass('active');
                $('.content-header>h1').text(menu);
            }
        })

        $('#setHeatrecoverystate').click(function () {
            var form = $(this).closest('form');

            var req = {};
            req = form.serialize();
            $als.execute('<c:url value="/remote/setHeatrecoverystate"/>', req, function (data) {
                if (data.result_message == 'success') {
                    //alert('성공');
                    console.log('setHeatrecoverystate');
                    console.log(data);
                } else {
                    alert('저장되지 않았습니다.');
                }
            }, function (err) {
                alert(err.result_message);
            });

        });

        $('#setAirfanstate').click(function () {
            var form = $(this).closest('form');

            var req = {};
            req = form.serialize();
            $als.execute('<c:url value="/remote/setAirfanstate"/>', req, function (data) {
                if (data.result_message == 'success') {
                    //alert('성공');
                    console.log('setAirfanstate');
                    console.log(data);

                } else {
                    alert('저장되지 않았습니다.');
                }
            }, function (err) {
                alert(err.result_message);
            });
        })

        $('#searchBtn').click(function () {
            $('#searchFrm').submit();
        });

        $('.clickTr').click(function () {
            var idx = $(this).attr('idx');
            location.href = '/monitor/detail/' + idx;
        });

        $('#searchClear').click(function () {
            $('#sch_text').val("");
        });

        $('.page').click(function () {
//      console.log(this)
            var page = $(this).attr('page');
            location.href = '/monitor/' + page;
//      $('#searchFrm').submit();
        });

        //esc키 누르면 화면 잠김 해제
        $(document).keydown(function(event){
            if(event.which=='27'){
                $("#loadingDiv").fadeOut(300);
                $(".backLayer").fadeOut(1000);
            }
        });

        //윈도우가 resize될때마다 backLayer를 조정
        $(window).resize(function(){
            var width = $(window).width();
            var height = $(window).height();
            $(".backLayer").width(width).height(height);
        });
    });
    <!-- bind end -->
    function setBackLoading() {
//        var width = $(window).width();
//        var height = $(window).height();
//
//        //화면을 가리는 레이어의 사이즈 조정
//        $(".backLayer").width(width);
//        $(".backLayer").height(height);
//
//        //화면을 가리는 레이어를 보여준다 (0.5초동안 30%의 농도의 투명도)
//        $(".backLayer").fadeTo(500, 0.3);
//
//        //팝업 레이어 보이게
//        var loadingDivObj = $("#loadingDiv");
//        loadingDivObj.css("top", $(document).height() / 2 - 150);
//        loadingDivObj.css("left", $(document).width() / 2 - 150);
//        loadingDivObj.fadeIn(500);
    }
    function setOneLaborState(channel_no, setting_no) {
        setBackLoading();
        var req = {};
//    req = $(this).closest('form').serialize();
        req.channel = channel_no;
        req.state = setting_no;
        $als.execute('<c:url value="/remote/setOneLaborState"/>', req, function (data) {
            if (data.result_message == 'success') {
                //alert('성공');
                console.log(data);
                console.log(data.data.length);
//                if(data.data.length!=10){
//
//                    //로딩바
//                    setTimeout(function(){
//                        location.href= this.location.href;
//
//                    },1000);
//                    return ;
//
//                }
                $('#setOneLaborState'+channel_no+'1').removeClass('square-btn-red').addClass('square-btn-default')
                $('#setOneLaborState'+channel_no+'2').removeClass('square-btn-red').addClass('square-btn-default')
                $('#setOneLaborState'+channel_no+'3').removeClass('square-btn-red').addClass('square-btn-default')
                $('#setOneLaborState'+channel_no+'4').removeClass('square-btn-red').addClass('square-btn-default')
                $('#setOneLaborState'+channel_no+setting_no).removeClass('square-btn-default').addClass('square-btn-red');

                var stateTxt ='';
                if(setting_no==1)stateTxt='자동';
                else if(setting_no==2)stateTxt='열림';
                else if(setting_no==3)stateTxt='닫힘';
                else if(setting_no==4)stateTxt='정지';
                else if(setting_no==5)stateTxt='작동';
                console.log(stateTxt)
                console.log($('#laborStatesText'+channel_no))

                $('#laborStatesText'+channel_no).text(stateTxt);
                console.log($('#laborStatesText'+channel_no).text())
            } else {
                alert('저장되지 않았습니다.');
            }
        }, function (err) {
            alert(err.result_message);
        });
    }
    function setOneOnOffState(channel_no, setting_no) {
        var req = {};
//    req = $(this).closest('form').serialize();
        req.channel = channel_no;
        req.state = setting_no;
        $als.execute('<c:url value="/remote/setOneOnOffState"/>', req, function (data) {
            if (data.result_message == 'success') {
                //alert('성공');
                console.log(data);
                console.log(data.data.length);
//                if(data.data.length!=10){
//
//                    //로딩바
//                    setTimeout(function(){
//                        location.href= this.location.href;
//
//                    },1000);
//                    return ;
//                }

                $('#setOneOnOffState'+channel_no+'1').removeClass('square-btn-red').addClass('square-btn-default')
                $('#setOneOnOffState'+channel_no+'2').removeClass('square-btn-red').addClass('square-btn-default')
                $('#setOneOnOffState'+channel_no+'3').removeClass('square-btn-red').addClass('square-btn-default')
                $('#setOneOnOffState'+channel_no+'4').removeClass('square-btn-red').addClass('square-btn-default')
                $('#setOneOnOffState'+channel_no+'5').removeClass('square-btn-red').addClass('square-btn-default')
                $('#setOneOnOffState'+channel_no+setting_no).removeClass('square-btn-default').addClass('square-btn-red');
                var stateTxt ='';
                if(setting_no==1)stateTxt='자동';
                else if(setting_no==2)stateTxt='열림';
                else if(setting_no==3)stateTxt='닫힘';
                else if(setting_no==4)stateTxt='정지';
                else if(setting_no==5)stateTxt='작동';

                $('#onOffStatesText'+channel_no).text(stateTxt);
            } else {
                alert('저장되지 않았습니다.');
            }
        }, function (err) {
            alert(err.result_message);
        });
    }

</script>
</body>
</html>
