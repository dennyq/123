<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>ifarms 머신관리</title>
</head>
<body>
<div class="paddingInside">
  <section class="content">
    <div class="row">
      <div class="col-md-12">
        <div class="box box-primary box-bg">
          <div class="box-header-sm">
            <h3 class="box-title">머신관리</h3>
          </div>
          <!-- form start -->
          <form id="searchFrm" action="<c:url value="/machine/search"/>" class="form-horizontal" method="post">

            <div class="box-body border-bottom">
              <div class="col-md-4">
                <div class="form-group">
                  <label for="sch_memberid" class="col-sm-4 control-label">머신아이디</label>
                  <div class="col-sm-8">
                    <input id="sch_memberid" name="sch_memberid" value="${param['sch_memberid']}" class="form-control" placeholder="머신아이디">
                  </div>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-group">
                  <label for="sch_machine_name"  class="col-sm-4 control-label">머신명</label>
                  <div class="col-sm-8">
                    <input id="sch_machine_name" name="sch_machine_name" value="${param['sch_machine_name']}" class="form-control" placeholder="머신명">
                  </div>
                </div>
              </div>

              <div class="col-md-4">
                <div class="form-group">
                  <label for="sch_machine_contactpoint" class="col-sm-4 control-label">머신연락처</label>
                  <div class="col-sm-8">
                    <input id="sch_machine_contactpoint" name="sch_machine_contactpoint" value="${param['sch_machine_contactpoint']}" class="form-control" placeholder="머신연락처">
                  </div>
                </div>
              </div>
            </div>
            <div class="box-body border-bottom">
              <div class="col-md-4">
                <div class="form-group">
                  <label for="sch_member_name" class="col-sm-4 control-label">회원명</label>
                  <div class="col-sm-8">
                    <input id="sch_member_name" name="sch_member_name" value="${param['sch_member_name']}" class="form-control" placeholder="회원명" >
                  </div>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-group">
                  <label for="sch_member_contactpoint" class="col-sm-4 control-label">회원연락처</label>
                  <div class="col-sm-8">
                    <input id="sch_member_contactpoint" name="sch_member_contactpoint" value="${param['sch_member_contactpoint']}" class="form-control" placeholder="회원연락처" >
                  </div>
                </div>
              </div>

            </div>
            <div class="box-body border-bottom">
              <div class="col-md-6">
                <div class="form-group">
                  <label  class="col-sm-22 control-label">가입일자</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input id="joindate" name="joindate" value="${param['joindate']}" type="text" class="form-control pull-right datepicker" >
                      <div class="input-group-addon">
                        <i class="fa fa-times remove-date"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-md-6">
                <div class="form-group">
                  <label  class="col-sm-22 control-label">탈퇴일자</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input id="outdate" name="outdate" value="${param['outdate']}" type="text" class="form-control pull-right datepicker" >
                      <div class="input-group-addon">
                        <i class="fa fa-times remove-date"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="box-body border-bottom-big">
              <div class="col-md-6">
                <div class="form-group">
                  <label  class="col-sm-22 control-label">사용시작일자</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input id="usestartdate" name="usestartdate" value="${param['usestartdate']}" type="text" class="form-control pull-right datepicker" >
                      <div class="input-group-addon">
                        <i class="fa fa-times remove-date"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-md-6">
                <div class="form-group">
                  <label  class="col-sm-22 control-label">사용종료일자</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input id="useenddate" name="useenddate" value="${param['useenddate']}" type="text" class="form-control pull-right datepicker" >
                      <div class="input-group-addon">
                        <i class="fa fa-times remove-date"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="box-footer text-align-center box-bg-foot">
              <a id="searchBtn"><img src="/image/btn_search_off.png"/><%--검색--%></a>
            </div>

          </form><!-- form end -->

        </div>
      </div>

      <div class="col-xs-12">
        <div class="box">
          <div class="box-header">
            <h3 class="box-title"></h3>
            <div class="box-tools">
            </div>
          </div>
          <div class="box-body table-responsive no-padding">
            <table class="table table-hover table-th-grey">
              <tbody>
              <tr>

                <th>No.</th>
                <th>머신아이디</th>
                <th>머신명</th>
                <th>회원명</th>
                <th>가입일자</th>
                <th>탈퇴일자</th>
                <th>사용시작일자</th>
                <th>사용종료일자</th>
                <th>머신연락처</th>
                <th>회원연락처</th>
                <th>비고</th>
              </tr>
              <c:if test="${not empty data}">
                <c:forEach items="${data}" var="rows" varStatus="idx">
                  <tr class="clickTr" idx="${rows.memberid}">
                    <td>${idx.count}</td>
                    <td>${rows.memberid}</td>
                    <td>${rows.machine_name}</td>
                    <td>${rows.member_name}</td>
                    <td>${rows.joindate}</td>
                    <td>${rows.outdate}</td>
                    <td>${rows.usestartdate}</td>
                    <td>${rows.useenddate}</td>
                    <td>${rows.machine_contact}</td>
                    <td>${rows.member_contact}</td>
                    <td>${rows.note}</td>
                  </tr>
                </c:forEach>
              </c:if>
              <c:if test="${empty data}">
                <tr>
                  <td colspan="11">데이터가 없습니다.</td>
                </tr>
              </c:if>
              </tbody>
            </table>
          </div>
          <div class="box-footer clearfix">
          </div>
        </div>
      </div>


    </div><!-- /.row -->

  </section>

</div>
<script>
  <!--//bind start -->
  $(function() {

    setClickedMenuBold(1);

    $('#searchBtn').click(function(){
      $('#searchFrm').submit();
    });

    $('.clickTr').dblclick(function(){
      var idx = $(this).attr('idx');
      location.href = '/machine/detail/' + idx;
    });

    $('.remove-date').click(function(){
      var el_id = $(this).parent().siblings('input').attr('id');
      $('#'+el_id+'.datepicker').daterangepicker({
        locale: {
          format: 'YYYY.MM.DD'
        },
        "startDate": "",
        "endDate": ""
      });
    });

    $('#joindate.datepicker').daterangepicker({
      locale: {
        format: 'YYYY.MM.DD'
      },
      <c:if test="${param['joindate_low'] != null and param['joindate_low'] != '' }">
      "startDate":"${param['joindate_low']}",
      "endDate":"${param['joindate_high']}"
      </c:if>
      <c:if test="${param['joindate_low'] == null or param['joindate_low'] == '' }">
      "startDate":"",
      "endDate":""
      </c:if>
    });

    $('#outdate.datepicker').daterangepicker({
      locale: {
        format: 'YYYY.MM.DD'
      },
      <c:if test="${param['outdate_low'] != null and param['outdate_low'] != '' }">
      "startDate":"${param['outdate_low']}",
      "endDate":"${param['outdate_high']}"
      </c:if>
      <c:if test="${param['outdate_low'] == null or param['outdate_low'] == '' }">
      "startDate":"",
      "endDate":""
      </c:if>
    });

    $('#usestartdate.datepicker').daterangepicker({
      locale: {
        format: 'YYYY.MM.DD'
      },
      <c:if test="${param['usestartdate_low'] != null and param['usestartdate_low'] != '' }">
      "startDate":"${param['usestartdate_low']}",
      "endDate":"${param['usestartdate_high']}"
      </c:if>
      <c:if test="${param['usestartdate_low'] == null or param['usestartdate_low'] == '' }">
      "startDate":"",
      "endDate":""
      </c:if>
    });

    $('#useenddate.datepicker').daterangepicker({
      locale: {
        format: 'YYYY.MM.DD'
      },
      <c:if test="${param['useenddate_low'] != null and param['useenddate_low'] != '' }">
      "startDate":"${param['useenddate_low']}",
      "endDate":"${param['useenddate_high']}"
      </c:if>
      <c:if test="${param['useenddate_low'] == null or param['useenddate_low'] == '' }">
      "startDate":"",
      "endDate":""
      </c:if>
    });



  });
  <!-- bind end -->

</script>
</body>
</html>
