<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>모니터링</title>
</head>
<body>
<section class="content-header">
  <h1>
    모니터링<c:if test="${isAdmin}"> 관리</c:if>
  </h1>
  <div class="breadcrumb-line"></div>
  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/monitor/"/>">모니터링</a></li>
    <li ><a href="<c:url value="/monitor/"/>">모니터링 조회</a></li>
  </ol>
</section>


<!-- Main content -->
<section class="content">
  <div class="paddingInside">
    <section class="content">
      <!-- row 통신상태-->
      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <%--<form id="searchFrm" action="<c:url value="/monitor/search"/>" class="form-horizontal" method="post">--%>
              <div class="box-header-sm">
                <h3 class="box-title">통신상태</h3>
              </div>


            <%--</form>--%>
              <!-- form end -->
          </div>
        </div>
        <!-- box-boxing -->
        <div class="box-boxing col-md-12">
          <div class="box " style="height: 93px">
            <div class=" no-padding">
              <div class="box-body table-responsive no-padding">
                <table class="table table-hover table-th-grey pointer text-align-center">
                  <colgroup>
                    <col width="25%"/>
                    <col width="25%"/>
                    <col width="25%"/>
                    <col width="20%"/>
                  </colgroup>
                  <tbody>
                  <tr>
                    <th class="text-align-center">통신 경보</th>
                    <th class="text-align-center">내부유무선센서 경보</th>
                    <th class="text-align-center">외부유무선센서 경보</th>
                    <th rowspan="2" class="blue-square-box"><div class="blue-square">경보확인</div></th>

                  </tr>


                    <tr class="height-middle" >
                      <td
                              <c:if test="${notConnected ne 'notConnected'}">class="bg-green"</c:if>
                              <c:if test="${notConnected eq 'notConnected'}">class="bg-red"</c:if>
                              >
                      <c:if test="${notConnected ne 'notConnected'}"><span >정상</span></c:if>
                      <c:if test="${notConnected eq 'notConnected'}"><span >경보</span></c:if>
                      </td>

                      <td
                              <c:if test="${not empty innersensorstate.temperature1 && not empty innersensorstate.temperature }">class="bg-green"</c:if>
                              <c:if test="${empty innersensorstate.temperature1 || empty innersensorstate.temperature }">class="bg-red"</c:if>
                              >
                        <c:if test="${not empty innersensorstate.temperature1 && not empty innersensorstate.temperature}"><span >정상</span></c:if>
                        <c:if test="${empty innersensorstate.temperature1 || empty innersensorstate.temperature }"><span >경보</span></c:if>

                      </td>
                      <td
                              <c:if test="${not empty outersensorstate }">class="bg-green"</c:if>
                              <c:if test="${empty outersensorstate}">class="bg-red"</c:if>
                              >
                        <c:if test="${not empty outersensorstate}"><span >정상</span></c:if>
                        <c:if test="${empty outersensorstate }"><span >경보</span></c:if>



                      </td>



                    </tr>


                  </tbody>
                </table>

              </div>
            </div>

            <%--<div class="col-md-2 blue-square-box">--%>
              <%--<div class="blue-square">경보확인</div>--%>
              <%--&lt;%&ndash;<img src="/imgs/bt_alertcheck.png" style=" margin-top: -20px; "/>&ndash;%&gt;--%>
            <%--</div>--%>

          </div>
          <!-- //box -->

        </div>
        <!-- //box-boxing -->

      </div>
      <!-- /.row 통신상태 -->

      <!-- row 내부 무선센서정보 innersensorstate -->
      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <%--<form id="searchFrm" action="<c:url value="/monitor/search"/>" class="form-horizontal" method="post">--%>
            <div class="box-header-sm">
              <h3 class="box-title">내부 무선센서정보</h3>
            </div>


            <%--</form>--%>
            <!-- form end -->
          </div>
        </div>
        <!-- box-boxing -->
        <div class="box-boxing col-md-12">
          <div class="box">

            <div class="box-body table-responsive no-padding">
              <table class="table table-hover table-th-grey pointer dark-tr">
                <tbody>
                <tr>
                  <th></th>
                  <th>온도 (℃)</th>
                  <th>습도 (%)</th>
                  <th>CO2 (ppm)</th>
                </tr>
                <tr>
                  <td>1번 센서</td>
                  <td><c:if test="${empty innersensorstate.temperature1}">-</c:if>
                  <c:if test="${not empty innersensorstate.temperature1}">${innersensorstate.temperature1}</c:if> ℃</td>
                  <td><c:if test="${empty innersensorstate.humidity1}">-</c:if>
                  <c:if test="${not empty innersensorstate.humidity1}">${innersensorstate.humidity1}</c:if> %</td>
                  <td><c:if test="${empty innersensorstate.carbondioxide1}">-</c:if>
                  <c:if test="${not empty innersensorstate.carbondioxide1}">${innersensorstate.carbondioxide1}</c:if> ppm</td>
                </tr>
                <tr>
                  <td>2번 센서</td>
                  <td><c:if test="${empty innersensorstate.temperature2}">-</c:if>
                  <c:if test="${not empty innersensorstate.temperature2}">${innersensorstate.temperature2}</c:if>  ℃</td>
                  <td><c:if test="${empty innersensorstate.humidity2}">-</c:if>
                  <c:if test="${not empty innersensorstate.humidity2}">${innersensorstate.humidity2}</c:if> %</td>
                  <td><c:if test="${empty innersensorstate.carbondioxide2}">-</c:if>
                  <c:if test="${not empty innersensorstate.carbondioxide2}">${innersensorstate.carbondioxide2}</c:if> ppm</td>
                </tr>
                <tr>
                  <td>3번 센서</td>
                  <td><c:if test="${empty innersensorstate.temperature3}">-</c:if>
                  <c:if test="${not empty innersensorstate.temperature3}">${innersensorstate.temperature3}</c:if>  ℃</td>
                  <td><c:if test="${empty innersensorstate.humidity3}">-</c:if>
                  <c:if test="${not empty innersensorstate.humidity3}">${innersensorstate.humidity3}</c:if> %</td>
                  <td><c:if test="${empty innersensorstate.carbondioxide3}">-</c:if>
                  <c:if test="${not empty innersensorstate.carbondioxide3}">${innersensorstate.carbondioxide3}</c:if> ppm</td>
                </tr>
                <tr>
                  <td>4번 센서</td>
                  <td><c:if test="${empty innersensorstate.temperature4}">-</c:if>
                  <c:if test="${not empty innersensorstate.temperature4}">${innersensorstate.temperature4}</c:if>  ℃</td>
                  <td><c:if test="${empty innersensorstate.humidity4}">-</c:if>
                  <c:if test="${not empty innersensorstate.humidity4}">${innersensorstate.humidity4}</c:if> %</td>
                  <td><c:if test="${empty innersensorstate.carbondioxide4}">-</c:if>
                  <c:if test="${not empty innersensorstate.carbondioxide4}">${innersensorstate.carbondioxide4}</c:if> ppm</td>
                </tr>
                <tr>
                  <td>5번 센서</td>
                  <td><c:if test="${empty innersensorstate.temperature5}">-</c:if>
                  <c:if test="${not empty innersensorstate.temperature5}">${innersensorstate.temperature5}</c:if>  ℃</td>
                  <td><c:if test="${empty innersensorstate.humidity5}">-</c:if>
                  <c:if test="${not empty innersensorstate.humidity5}">${innersensorstate.humidity5}</c:if> %</td>
                  <td><c:if test="${empty innersensorstate.carbondioxide5}">-</c:if>
                  <c:if test="${not empty innersensorstate.carbondioxide5}">${innersensorstate.carbondioxide5}</c:if> ppm</td>
                </tr>
                <tr>
                  <td>6번 센서</td>
                  <td><c:if test="${empty innersensorstate.temperature6}">-</c:if>
                  <c:if test="${not empty innersensorstate.temperature6}">${innersensorstate.temperature6}</c:if>  ℃</td>
                  <td><c:if test="${empty innersensorstate.humidity6}">-</c:if>
                  <c:if test="${not empty innersensorstate.humidity6}">${innersensorstate.humidity6}</c:if> %</td>
                  <td><c:if test="${empty innersensorstate.carbondioxide6}">-</c:if>
                  <c:if test="${not empty innersensorstate.carbondioxide6}">${innersensorstate.carbondioxide6}</c:if> ppm</td>
                </tr>
                <tr>
                  <td>7번 센서</td>
                  <td><c:if test="${empty innersensorstate.temperature7}">-</c:if>
                  <c:if test="${not empty innersensorstate.temperature7}">${innersensorstate.temperature7}</c:if>  ℃</td>
                  <td><c:if test="${empty innersensorstate.humidity7}">-</c:if>
                  <c:if test="${not empty innersensorstate.humidity7}">${innersensorstate.humidity7}</c:if> %</td>
                  <td><c:if test="${empty innersensorstate.carbondioxide7}">-</c:if>
                  <c:if test="${not empty innersensorstate.carbondioxide7}">${innersensorstate.carbondioxide7}</c:if> ppm</td>
                </tr>
                <tr>
                  <td>8번 센서</td>
                  <td><c:if test="${empty innersensorstate.temperature8}">-</c:if>
                  <c:if test="${not empty innersensorstate.temperature8}">${innersensorstate.temperature8}</c:if>  ℃</td>
                  <td><c:if test="${empty innersensorstate.humidity8}">-</c:if>
                  <c:if test="${not empty innersensorstate.humidity8}">${innersensorstate.humidity8}</c:if> %</td>
                  <td><c:if test="${empty innersensorstate.carbondioxide8}">-</c:if>
                  <c:if test="${not empty innersensorstate.carbondioxide8}">${innersensorstate.carbondioxide8}</c:if> ppm</td>
                </tr>

                </tbody>
              </table>

            </div>

          </div>

        </div>
        <!-- //box-boxing -->

      </div>
      <!-- /.row 내부 무선센서정보 -->

      <!-- row 내부 유선센서정보-->
      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <%--<form id="searchFrm" action="<c:url value="/monitor/search"/>" class="form-horizontal" method="post">--%>
            <div class="box-header-sm">
              <h3 class="box-title">내부 유선센서정보</h3>
            </div>


            <%--</form>--%>
            <!-- form end -->
          </div>
        </div>
        <!-- box-boxing -->
        <div class="box-boxing col-md-12">
          <div class="box">

            <div class="box-body table-responsive no-padding">
              <table class="table table-hover table-th-grey pointer">
                <tbody>
                <tr class="text-align-center-th">
                  <th>온도</th>

                </tr>
                <tr class="text-align-center-td">
                  <td><c:if test="${empty innersensorstate.temperature}">-</c:if>
                  <c:if test="${not empty innersensorstate.temperature}">${innersensorstate.temperature}</c:if>  ℃</td>

                </tr>
                </tbody>
              </table>

            </div>

          </div>

        </div>
        <!-- //box-boxing -->

      </div>
      <!-- /.row 내부 유선센서정보 -->

      <!-- row 외부 유무선센서정보-->
      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <%--<form id="searchFrm" action="<c:url value="/monitor/search"/>" class="form-horizontal" method="post">--%>
            <div class="box-header-sm">
              <h3 class="box-title">기상센서노드 정보</h3>
            </div>


            <%--</form>--%>
            <!-- form end -->
          </div>
        </div>
        <!-- box-boxing -->
        <div class="box-boxing col-md-12">
          <!-- box 외부유무선센서정보1 -->
          <%--<div class="box">--%>

            <%--<div class="box-body table-responsive no-padding">--%>
              <%--<table class="table table-hover table-th-grey pointer">--%>
                <%--<colgroup>--%>
                  <%--<col width="25%"/>--%>
                  <%--<col width="25%"/>--%>
                  <%--<col width="25%"/>--%>
                  <%--<col width="25%"/>--%>
                <%--</colgroup>--%>
                <%--<tbody>--%>
                <%--<tr class="text-align-center-th">--%>
                  <%--<th>감우</th>--%>
                  <%--<th>풍향</th>--%>
                  <%--<th>풍속</th>--%>
                  <%--<th>일사량</th>--%>
                <%--</tr>--%>
                <%--<tr class="text-align-center-td">--%>
                  <%--<td <c:if test="${outersensorstate.rainstateCode eq 0}">class="bg-default"</c:if>--%>
                            <%--<c:if test="${outersensorstate.rainstateCode eq 1}">class="bg-normal"</c:if>--%>
                            <%--<c:if test="${outersensorstate.rainstateCode eq 2}">class="bg-abnormal"</c:if> >--%>
                  <%--<c:if test="${empty outersensorstate.rainstate}">-</c:if>--%>
                  <%--<c:if test="${not empty outersensorstate.rainstate}">${outersensorstate.rainstate}</c:if> </td>--%>
                <%--<td><c:if test="${empty outersensorstate.winddirection}">-</c:if>--%>
                  <%--<c:if test="${not empty outersensorstate.winddirection}">${outersensorstate.winddirection}</c:if> </td>--%>
                <%--<td><c:if test="${empty outersensorstate.windspeed}">-</c:if>--%>
                  <%--<c:if test="${not empty outersensorstate.windspeed}">${outersensorstate.windspeed}</c:if> </td>--%>
                <%--<td><c:if test="${empty outersensorstate.wm2}">-</c:if>--%>
                  <%--<c:if test="${not empty outersensorstate.wm2}">${outersensorstate.wm2}</c:if> </td>--%>
                <%--</tr>--%>
                <%--</tbody>--%>
              <%--</table>--%>

            <%--</div>--%>

          <%--</div>--%>
          <!-- //box 외부유무선센서정보1 -->

          <!-- box 기상센서노드 -->
          <div class="box">

            <%--<div class="box-header-sm">--%>
              <%--<h3 class="box-title">기상센서노드</h3>--%>
            <%--</div>--%>

            <div class="box-body table-responsive no-padding">
              <table class="table table-hover table-th-grey pointer">
                <colgroup>
                  <col width="16.6%"/>
                  <col width="16.6%"/>
                  <col width="16.6%"/>
                  <col width="16.6%"/>
                  <col width="16.6%"/>
                  <col width="*"/>
                </colgroup>
                <tbody>
                <tr class="text-align-center-th">
                  <th>온도</th>
                  <th>습도</th>
                  <th>감우</th>
                  <th>풍향</th>
                  <th>풍속</th>
                  <th>일사량</th>
                </tr>
                <tr class="text-align-center-td">
                  <td><c:if test="${empty outersensorstate.node_temperature}">-</c:if>
                  <c:if test="${not empty outersensorstate.node_temperature}">${outersensorstate.node_temperature}</c:if> </td>
                  <td><c:if test="${empty outersensorstate.node_humidity}">-</c:if>
                  <c:if test="${not empty outersensorstate.node_humidity}">${outersensorstate.node_humidity}</c:if> </td>
                  <td <c:if test="${outersensorstate.node_rainstateCode eq 0}">class="bg-default"</c:if>
                      <c:if test="${outersensorstate.node_rainstateCode eq 1}">class="bg-normal"</c:if>
                      <c:if test="${outersensorstate.node_rainstateCode eq 2}">class="bg-abnormal"</c:if> >


                          <c:if test="${empty outersensorstate.node_rainstate}">-</c:if>
                  <c:if test="${not empty outersensorstate.node_rainstate}">${outersensorstate.node_rainstate}</c:if> </td>
                  <td><c:if test="${empty outersensorstate.node_winddirection}">-</c:if>
                  <c:if test="${not empty outersensorstate.node_winddirection}">${outersensorstate.node_winddirection}</c:if> </td>
                  <td><c:if test="${empty outersensorstate.node_windspeed}">-</c:if>
                  <c:if test="${not empty outersensorstate.node_windspeed}">${outersensorstate.node_windspeed}</c:if> </td>
                  <td><c:if test="${empty outersensorstate.node_wm2}">-</c:if>
                  <c:if test="${not empty outersensorstate.node_wm2}">${outersensorstate.node_wm2}</c:if> </td>
                </tr>
                </tbody>
              </table>

            </div>

          </div>
          <!-- //box 기상센서노드 -->

        </div>
        <!-- //box-boxing -->

      </div>
      <!-- /.row 외부 유무선센서정보 -->

      <!-- row 정역 채널 상태정보-->
      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <%--<form id="searchFrm" action="<c:url value="/monitor/search"/>" class="form-horizontal" method="post">--%>
            <div class="box-header-sm">
              <h3 class="box-title">정역 채널 상태정보</h3>
            </div>


            <%--</form>--%>
            <!-- form end -->
          </div>
        </div>
        <!-- box-boxing -->
        <div class="box-boxing col-md-12">
          <!-- box 정역채널상태정보1 -->
          <div class="box">

            <div class="box-body table-responsive no-padding">
              <table class="table table-hover table-th-grey pointer">
                <tbody>
                <tr class="text-align-center-th">
                  <th>1채널  <%--<span class="font-red">0.00%</span>--%></th>
                  <th>2채널  <%--<span class="font-red">0.00%</span>--%></th>
                  <th>3채널  <%--<span class="font-red">0.00%</span>--%></th>
                  <th>4채널  <%--<span class="font-red">0.00%</span>--%></th>
                  <th>5채널  <%--<span class="font-red">0.00%</span>--%></th>
                </tr>

                <tr class="height-middle text-align-center-td" >
                  <td class="">
                    <c:if test="${laborStates.channel1 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel1 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel1 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel1 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel1 eq '4'}">정지</c:if>
                  </td>
                  <td class="">
                    <c:if test="${laborStates.channel2 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel2 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel2 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel2 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel2 eq '4'}">정지</c:if>
                  </td>
                  <td class="">
                    <c:if test="${laborStates.channel3 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel3 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel3 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel3 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel3 eq '4'}">정지</c:if>
                  </td>
                  <td class="">
                    <c:if test="${laborStates.channel4 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel4 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel4 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel4 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel4 eq '4'}">정지</c:if>
                  </td>
                  <td class="">
                    <c:if test="${laborStates.channel5 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel5 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel5 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel5 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel5 eq '4'}">정지</c:if>
                  </td>
                </tr>
                <tr class="text-align-center-th">
                  <th>6채널  <%--<span class="font-red">0.00%</span>--%></th>
                  <th>7채널  <%--<span class="font-red">0.00%</span>--%></th>
                  <th>8채널  <%--<span class="font-red">0.00%</span>--%></th>
                  <th>9채널  <%--<span class="font-red">0.00%</span>--%></th>
                  <th>10채널  <%--<span class="font-red">0.00%</span>--%></th>
                </tr>

                <tr class="height-middle text-align-center-td" style="min-height: 59px">
                  <td class="">
                    <c:if test="${laborStates.channel6 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel6 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel6 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel6 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel6 eq '4'}">정지</c:if>
                  </td>
                  <td class="">
                    <c:if test="${laborStates.channel7 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel7 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel7 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel7 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel7 eq '4'}">정지</c:if>
                  </td>
                  <td class="">
                    <c:if test="${laborStates.channel8 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel8 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel8 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel8 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel8 eq '4'}">정지</c:if>
                  </td>
                  <td class="">
                    <c:if test="${laborStates.channel9 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel9 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel9 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel9 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel9 eq '4'}">정지</c:if>
                  </td>
                  <td class="">
                    <c:if test="${laborStates.channel10 eq '0'}"></c:if>
                    <c:if test="${laborStates.channel10 eq '1'}">자동</c:if>
                    <c:if test="${laborStates.channel10 eq '2'}">열림</c:if>
                    <c:if test="${laborStates.channel10 eq '3'}">닫힘</c:if>
                    <c:if test="${laborStates.channel10 eq '4'}">정지</c:if>
                  </td>
                </tr>
                </tbody>
              </table>

            </div>

          </div>
          <!-- //box 정역채널상태정보1 -->


          <!-- box 정역채널상태정보2 -->
          <div class="box">

            <div class="box-body table-responsive no-padding">
              <table class="table table-hover table-th-grey pointer">
                <colgroup>
                  <col width="20%"/>
                  <col width="20%"/>
                  <col width="20%"/>
                  <col width="20%"/>
                  <col width="20%"/>

                </colgroup>
                <tbody>
                <tr class="text-align-center-th">
                  <th colspan="3">열회수형 환풍기 상태정보</th>
                  <th colspan="2">공기유동팬 상태정보</th>
                </tr>
                <tr class="text-align-center-th">
                  <th>온도</th>
                  <th>습도</th>
                  <th>토출온도</th>
                  <th>각도</th>
                  <th>온도</th>
                </tr>

                <tr class="text-align-center-td">
                  <td  <c:if test="${heatrecoverystate.temperature < 0}">class="bg-abnormal " </c:if>
                          ><c:if test="${empty heatrecoverystate.temperature}">-</c:if>
                  <c:if test="${not empty heatrecoverystate.temperature}">${heatrecoverystate.temperature}</c:if>  ℃</td>
                  <td <c:if test="${heatrecoverystate.humidity < 0}">class="bg-abnormal" </c:if>
                          ><c:if test="${empty heatrecoverystate.humidity}">-</c:if>
                  <c:if test="${not empty heatrecoverystate.humidity}">${heatrecoverystate.humidity}</c:if> %</td>
                  <td <c:if test="${heatrecoverystate.discharge < 0}">class="bg-abnormal" </c:if>
                          ><c:if test="${empty heatrecoverystate.discharge}">-</c:if>
                    <c:if test="${not empty heatrecoverystate.discharge}">${heatrecoverystate.discharge}</c:if> %</td>
                  <td class="bg-darkgrey" <c:if test="${heatrecoverystate.temperature < 0}">class="bg-abnormal" </c:if>><c:if test="${empty airfanstate.angle}">-</c:if>
                  <c:if test="${not empty airfanstate.angle}">${airfanstate.angle}</c:if> </td>
                  <td <c:if test="${heatrecoverystate.temperature < 0}">class="bg-abnormal" </c:if>><c:if test="${empty airfanstate.temperature}">-</c:if>
                    <c:if test="${not empty airfanstate.temperature}">${airfanstate.temperature}</c:if> </td>

                </tr>
                </tbody>
              </table>

            </div>

          </div>
          <!-- //box 정역채널상태정보2 -->

        </div>
        <!-- //box-boxing -->

      </div>
      <!-- /.row 정역 채널 상태정보 -->

      <!-- row ON-OFF 채널 상태정보-->
      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <%--<form id="searchFrm" action="<c:url value="/monitor/search"/>" class="form-horizontal" method="post">--%>
            <div class="box-header-sm">
              <h3 class="box-title">ON-OFF 채널 상태 정보</h3>
            </div>


            <%--</form>--%>
            <!-- form end -->
          </div>
        </div>
        <!-- box-boxing -->
        <div class="box-boxing col-md-12">
          <div class="box">

            <div class="box-body table-responsive no-padding">
              <table class="table table-hover table-th-grey pointer">
                <tbody>
                <tr class="text-align-center-th">
                  <th>1채널</th>
                  <th>2채널</th>
                  <th>3채널</th>
                  <th>4채널</th>
                  <th>5채널</th>
                </tr>
                <%--<tr class="text-align-center-td">--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel1}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel1}">${initsetting.onoffchannel1}</c:if> </td>--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel2}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel2}">${initsetting.onoffchannel2}</c:if> </td>--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel3}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel3}">${initsetting.onoffchannel3}</c:if> </td>--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel4}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel4}">${initsetting.onoffchannel4}</c:if> </td>--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel5}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel5}">${initsetting.onoffchannel5}</c:if> </td>--%>
                <%--</tr>
                --%>
                <tr class="height-middle text-align-center-td" >
                  <td class="">
                    <c:if test="${onOffStates.channel1 eq '0'}"></c:if>
                    <c:if test="${onOffStates.channel1 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel1 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel1 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel1 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel1 eq '5'}">작동</c:if>
                  </td>
                  <td class="">
                    <c:if test="${onOffStates.channel2 eq '0'}"></c:if>
                    <c:if test="${onOffStates.channel2 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel2 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel2 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel2 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel2 eq '5'}">작동</c:if>
                  </td>
                  <td class="">
                    <c:if test="${onOffStates.channel3 eq '0'}"></c:if>
                    <c:if test="${onOffStates.channel3 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel3 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel3 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel3 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel3 eq '5'}">작동</c:if>
                  </td>
                  <td class="">
                    <c:if test="${onOffStates.channel4 eq '0'}"></c:if>
                    <c:if test="${onOffStates.channel4 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel4 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel4 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel4 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel4 eq '5'}">작동</c:if>
                  </td>
                  <td class="">
                    <c:if test="${onOffStates.channel5 eq '0'}"></c:if>
                    <c:if test="${onOffStates.channel5 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel5 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel5 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel5 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel5 eq '5'}">작동</c:if>
                  </td>
                </tr>
                <tr class="text-align-center-th">
                  <th>6채널</th>
                  <th>7채널</th>
                  <th>8채널</th>
                  <th>9채널</th>
                  <th>10채널</th>
                </tr>
                <%--<tr class="text-align-center-td">--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel6}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel6}">${initsetting.onoffchannel6}</c:if> </td>--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel7}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel7}">${initsetting.onoffchannel7}</c:if> </td>--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel8}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel8}">${initsetting.onoffchannel8}</c:if> </td>--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel9}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel9}">${initsetting.onoffchannel9}</c:if> </td>--%>
                  <%--<td><c:if test="${empty initsetting.onoffchannel10}">-</c:if>--%>
                  <%--<c:if test="${not empty initsetting.onoffchannel10}">${initsetting.onoffchannel10}</c:if> </td>--%>
                <%--</tr>--%>
                <tr class="height-middle text-align-center-td" style="min-height: 59px;">
                  <td class="">
                    <c:if test="${onOffStates.channel6 eq '0'}">   </c:if>
                    <c:if test="${onOffStates.channel6 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel6 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel6 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel6 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel6 eq '5'}">작동</c:if>
                  </td>
                  <td class="">
                    <c:if test="${onOffStates.channel7 eq '0'}">   </c:if>
                    <c:if test="${onOffStates.channel7 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel7 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel7 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel7 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel7 eq '5'}">작동</c:if>
                  </td>
                  <td class="">
                    <c:if test="${onOffStates.channel8 eq '0'}">   </c:if>
                    <c:if test="${onOffStates.channel8 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel8 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel8 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel8 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel8 eq '5'}">작동</c:if>
                  </td>
                  <td class="">
                    <c:if test="${onOffStates.channel9 eq '0'}">   </c:if>
                    <c:if test="${onOffStates.channel9 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel9 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel9 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel9 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel9 eq '5'}">작동</c:if>
                  </td>
                  <td class="">
                    <c:if test="${onOffStates.channel10 eq '0'}">   </c:if>
                    <c:if test="${onOffStates.channel10 eq '1'}">자동</c:if>
                    <c:if test="${onOffStates.channel10 eq '2'}">열림</c:if>
                    <c:if test="${onOffStates.channel10 eq '3'}">닫힘</c:if>
                    <c:if test="${onOffStates.channel10 eq '4'}">정지</c:if>
                    <c:if test="${onOffStates.channel10 eq '5'}">작동</c:if>
                  </td>
                </tr>
                </tbody>
              </table>

            </div>

          </div>

        </div>
        <!-- //box-boxing -->

      </div>
      <!-- /.row ON-OFF 채널 상태정보 -->


      <!-- row 양액정보-->
      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <%--<form id="searchFrm" action="<c:url value="/monitor/search"/>" class="form-horizontal" method="post">--%>
            <div class="box-header-sm">
              <h3 class="box-title">양액정보</h3>
            </div>
            <%--</form>--%>
            <!-- form end -->
          </div>
        </div>
        <!-- box-boxing -->
        <div class="box-boxing col-md-12">
          <div class="box">

            <div class="box-body table-responsive no-padding">
              <table class="table table-hover table-th-grey pointer dark-tr-6">
                <tbody>
                <colgroup>
                  <col width="16.6%"/>
                  <col width="16.6%"/>
                  <col width="16.6%"/>
                  <col width="16.6%"/>
                  <col width="16.6%"/>
                  <col width="*"/>
                </colgroup>
                <tbody>
                <tr class="text-align-center-th">
                  <th>EC(mS)</th>
                  <th>PH(ph)</th>
                  <th>일사량(w/m2)</th>
                  <th>공급횟수(회)</th>
                  <th>양액공급기</th>
                  <th>운전방식</th>
                </tr>
                <tr class="text-align-center-td">
                  <td><c:if test="${empty nutrientstate.ec}">-</c:if>
                  <c:if test="${not empty nutrientstate.ec}">${nutrientstate.ec}</c:if> </td>
                  <td><c:if test="${empty nutrientstate.ph}">-</c:if>
                  <c:if test="${not empty nutrientstate.ph}">${nutrientstate.ph}</c:if> </td>
                  <td><c:if test="${empty nutrientstate.wm2}">-</c:if>
                  <c:if test="${not empty nutrientstate.wm2}">${nutrientstate.wm2}</c:if> </td>
                  <td><c:if test="${empty nutrientstate.supplycount}">-</c:if>
                  <c:if test="${not empty nutrientstate.supplycount}">${nutrientstate.supplycount}</c:if> </td>
                  <td><c:if test="${empty nutrientstate.workstate}">-</c:if>
                  <c:if test="${not empty nutrientstate.workstate}">${nutrientstate.workstate}</c:if> </td>
                  <td><c:if test="${empty nutrientstate.workmethod}">-</c:if>
                  <c:if test="${not empty nutrientstate.workmethod}">${nutrientstate.workmethod}</c:if> </td>
                </tr>
                </tbody>
              </table>

            </div>

          </div>

        </div>
        <!-- //box-boxing -->

      </div>
      <!-- /.row 양액정보 -->
    </section>

  </div>
</section>
<!-- /.content -->
<%--<img src="/imgs/01_sub_모니터링_161012.jpg"/>--%>
<script>
  <!--//bind start -->
  var fn_go_page = function(page){
    //alert(11);
    //var page = $(this).attr('page');
    console.log(page)
    //alert(page)
    $("#page").val(page);
    fn_search();
  };
  function fn_search(){
    $('#searchFrm').submit();
  }
  $(function() {

    setClickedMenuBold(1);
    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active')
//      console.log(this);
      var menu = $(this).attr('menu');
      if(menu=='모니터링'){
        $(this).addClass('active');
        $('.content-header>h1').text(menu);
      }
    })

    $('#searchBtn').click(function(){
      $('#searchFrm').submit();
    });

    $('.clickTr').click(function(){
      var idx = $(this).attr('idx');
      location.href = '/monitor/detail/' + idx;
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
//      console.log(this)
      var page = $(this).attr('page');
      location.href = '/monitor/' + page;
//      $('#searchFrm').submit();
    });

   monitorSetTimeOut = setInterval(function(){
      location.href = '/monitor/';
    },20000);
//    },2000);

  });
  <!-- bind end -->

</script>
</body>
</html>
