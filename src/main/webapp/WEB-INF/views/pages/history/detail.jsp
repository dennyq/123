<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
  <title>ifarms 사용이력관리</title>

</head>
<body>
<form enctype="multipart/form-data" method="post" action="/history/write">
  머신아이디<input id="memberid" name="memberid" value="1"><br>
  스캔시간<input id="scantime" name="scantime" value="20150101115533"><br>
  카드종류<input id="cardkind" name="cardkind" value="1"><br>
  신분증 스캔하여 수집한 이름<input id="name" name="name" value="1"><br>
  주민등록번호<input id="juminnumber" name="juminnumber" value="1"><br>
  신분증 발급일자 <input id="issuedate" name="issuedate" value="1"><br>
  신분증 면허번호 <input id="licensenumber" name="licensenumber" value="1"><br>
  신분증 일련번호 <input id="serialnumber" name="serialnumber" value="1"><br>
  신분증 진위여부 <input id="realcardflag" name="realcardflag" value="1"><br>
  신분증 실명인증 정보 진위여부 <input id="realnameflag" name="realnameflag" value="1"><br>
  성인 여부 판별 <input id="adultflag" name="adultflag" value="1"><br>

  일반이미지 파일명 <input id="generalimagefile" name="generalimagefile" type="file" ><br>
  ir이미지 파일명 <input id="irimagefile" name="irimagefile" type="file" ><br>
  sign이미지 파일명<input id="signimagefile" name="signimagefile" type="file" ><br>
  <br>
  <button id="submitBtn" type="submit">저장</button>
</form>
  관리자 id('admin')은 제외<br>
  연월일시분초<br>
  미인식(1), 주민등록증(2), 구형운전면허증(3), 신형운전면허증(4)<br>
  음식점의 손님 이름<br>
  음식점의 손님 주민등록번호 앞 6자리<br>
  운전면허증인 경우만 존재<br>
  운전면허증인 경우만 존재<br>
  진짜('1'), 가짜('2'). Default('2')<br>
  일치(1), 불일치(2), 정보없음(3), 시스템장애(4). Default(3)<br>
  성인('1'), 미성년('2'). Default('2')<br>
  연 + 월 + 일 + memberid<br>
  예) /2015/01/01/C4438FAB77BC/<br>
  memberid + 'G' + 연월일시분초.jpg<br>
  예) C4438FAB77BC_G_20150102010123.jpg<br>
  memberid + 'R' + 연월일시분초.jpg<br>
  예) C4438FAB77BC_R_20150102010123.jpg<br>
  memberid + 'S' + 연월일시분초.jpg<br>
  예) C4438FAB77BC_S_20150102010123.jpg<br>
  본 데이터 등록 시간<br>
<script>
  <!-- //bind start -->
  $(function(){

    <%--$('#submitBtn').click(function(){--%>
      <%--var req= $('#')--%>

      <%--$als.execute('<c:url value="/history/write"/>', req, function (data) {--%>
        <%--var url = "";--%>
        <%--if (data.result_message == 'success_admin') {--%>
          <%--url = '/machine/list';--%>
        <%--}else if (data.result_message == 'success') {--%>
          <%--url = '/history/list';--%>

        <%--} else if (data.result_message == 'login_not_match') {--%>
          <%--alert('아이디 또는 비밀번호 정보가 일치하지 않습니다.');--%>

          <%--url = '<c:url value="/"/>';--%>

        <%--} else if (data.result_message == 'login_del_member') {--%>
          <%--alert('삭제된 회원입니다.');--%>

          <%--url = '<c:url value="/"/>';--%>
        <%--}--%>
        <%--$("#loginForm").attr("action", url);--%>
        <%--$("#loginForm").submit();--%>
      <%--}, function (err) {--%>
        <%--alert(err.result_message);--%>
      <%--});--%>
    <%--});--%>
    <%--<c:if test="${isAdmin}">--%>
    <%--setClickedMenuBold(3);--%>
    <%--</c:if>--%>
    <%--<c:if test="${!isAdmin}">--%>
    <%--setClickedMenuBold(1);--%>
    <%--</c:if>--%>

    <%--$('#joindate.datepickerrange').daterangepicker({--%>
    <%--locale: {--%>
    <%--format: 'YYYY.MM.DD'--%>
    <%--},--%>
    <%--"startDate": "${data.joindate}",--%>
    <%--"endDate": "",--%>
    <%--singleDatePicker: true,--%>
    <%--showDropdowns: true--%>
    <%--});--%>

    <%--$('#outdate.datepickerrange').daterangepicker({--%>
    <%--locale: {--%>
    <%--format: 'YYYY.MM.DD'--%>
    <%--},--%>
    <%--"startDate": "${data.outdate}",--%>
    <%--"endDate": "",--%>
    <%--singleDatePicker: true,--%>
    <%--showDropdowns: true--%>
    <%--});--%>

    <%--$('#usestartdate.datepickerrange').daterangepicker({--%>
    <%--locale: {--%>
    <%--format: 'YYYY.MM.DD'--%>
    <%--},--%>
    <%--"startDate": "${data.usestartdate}",--%>
    <%--"endDate": "",--%>
    <%--singleDatePicker: true,--%>
    <%--showDropdowns: true--%>
    <%--});--%>

    <%--$('#useenddate.datepickerrange').daterangepicker({--%>
    <%--locale: {--%>
    <%--format: 'YYYY.MM.DD'--%>
    <%--},--%>
    <%--"startDate": "${data.useenddate}",--%>
    <%--"endDate": "",--%>
    <%--singleDatePicker: true,--%>
    <%--showDropdowns: true--%>
    <%--});--%>

    <%--$('a#initailBtn').click(function(){--%>
    <%--getAjax('/machine/','/machine/initailizePwd','초기화되었습니다.');--%>
    <%--});--%>

    <%--$('a#saveBtn').click(function(){--%>
    <%--getAjax('/machine/','/machine/modify','저장되었습니다.');--%>
    <%--});--%>

    <%--$('a#deleteBtn').click(function(){--%>
    <%--if (confirm("삭제하시겠습니까?")) {--%>
    <%--getAjax('/machine/', '/machine/delete', '삭제되었습니다.');--%>
    <%--}--%>
    <%--});--%>

  });
  <!-- bind end -->

</script>
</body>
</html>


<%--<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>--%>
<%--<%@ include file="/common/include/taglibs.jspf" %>--%>
<%--<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>--%>
<%--<!doctype html>--%>
<%--<html lang="ko">--%>
<%--<head>--%>
  <%--<meta charset="utf-8">--%>
  <%--<title>ifarms 사용이력관리</title>--%>

<%--</head>--%>
<%--<body>--%>
<%--<div class="paddingInside">--%>
  <%--<section class="content">--%>
    <%--<div class="row">--%>
      <%--<div class="col-md-12">--%>
        <%--<div class="box box-primary box-bg">--%>
          <%--<div class="box-header-sm">--%>
            <%--<h3 class="box-title">사용이력관리</h3>--%>
          <%--</div>--%>
          <%--<div id="progressIndicator" style="display: none"></div>--%>
          <%--<!-- form start -->--%>
          <%--<form id="detailFrm" class="form-horizontal" method="post">--%>
            <%--<div class="box-body border-bottom">--%>
              <%--<div class="col-md-4">--%>
                <%--<div class="form-group">--%>
                  <%--<label for="memberid" class="col-sm-4 control-label">머신아이디</label>--%>
                  <%--<div class="col-sm-8">--%>
                    <%--<input id="memberid" name="memberid" value="${data.memberid}" class="form-control" placeholder="머신아이디" disabled>--%>
                    <%--<input type="hidden" id="machine_id" name="memberid" value="${data.memberid}"/>--%>
                  <%--</div>--%>
                <%--</div>--%>
              <%--</div>--%>
              <%--<div class="col-md-4">--%>
                <%--<div class="form-group">--%>
                  <%--<label for="machine_name"  class="col-sm-4 control-label">머신명</label>--%>
                  <%--<div class="col-sm-8">--%>
                    <%--<input id="machine_name" name="name" value="${data.machine_name}" class="form-control" placeholder="머신명">--%>
                  <%--</div>--%>
                <%--</div>--%>
              <%--</div>--%>

              <%--<div class="col-md-4">--%>
                <%--<div class="form-group">--%>
                  <%--<label for="machine_contact" class="col-sm-4 control-label">머신연락처</label>--%>
                  <%--<div class="col-sm-8">--%>
                    <%--<input id="machine_contact" name="contactpoint" value="${data.machine_contact}" class="form-control" placeholder="머신연락처">--%>
                  <%--</div>--%>
                <%--</div>--%>
              <%--</div>--%>
            <%--</div>--%>
            <%--<div class="box-body border-bottom">--%>
              <%--<div class="col-md-4">--%>
                <%--<div class="form-group">--%>
                  <%--<label for="member_name" class="col-sm-4 control-label">회원명</label>--%>
                  <%--<div class="col-sm-8">--%>
                    <%--<input id="member_name" name="member_name" value="${data.member_name}" class="form-control" placeholder="회원명" disabled>--%>
                  <%--</div>--%>
                <%--</div>--%>
              <%--</div>--%>
              <%--<div class="col-md-4">--%>
                <%--<div class="form-group">--%>
                  <%--<label for="member_contact" class="col-sm-4 control-label">회원연락처</label>--%>
                  <%--<div class="col-sm-8">--%>
                    <%--<input id="member_contact" name="member_contact" value="${data.member_contact}" class="form-control" placeholder="회원연락처" disabled>--%>
                  <%--</div>--%>
                <%--</div>--%>
              <%--</div>--%>
            <%--</div><!-- /.box-body -->--%>
            <%--<div class="box-body border-bottom">--%>
              <%--<div class="col-md-6">--%>
                <%--<div class="form-group">--%>
                  <%--<label  class="col-sm-22 control-label">가입일자</label>--%>
                  <%--<div class="col-sm-9">--%>
                    <%--<div class="input-group">--%>
                      <%--<div class="input-group-addon">--%>
                        <%--<i class="fa fa-calendar"></i>--%>
                      <%--</div>--%>
                      <%--<input id="joindate" value="${data.joindate}" name="joindate" type="text" class="form-control pull-right datepickerrange" >--%>
                    <%--</div>--%>
                  <%--</div>--%>
                <%--</div>--%>
              <%--</div>--%>

              <%--<div class="col-md-6">--%>
                <%--<div class="form-group">--%>
                  <%--<label  class="col-sm-22 control-label">탈퇴일자</label>--%>
                  <%--<div class="col-sm-9">--%>
                    <%--<div class="input-group">--%>
                      <%--<div class="input-group-addon">--%>
                        <%--<i class="fa fa-calendar"></i>--%>
                      <%--</div>--%>
                      <%--<input id="outdate" value="${data.outdate}" name="outdate" type="text" class="form-control pull-right datepickerrange" >--%>
                    <%--</div>--%>
                  <%--</div>--%>
                <%--</div>--%>
              <%--</div>--%>
            <%--</div><!-- /.box-body -->--%>
            <%--<div class="box-body border-bottom-big">--%>
              <%--<div class="col-md-6">--%>
                <%--<div class="form-group">--%>
                  <%--<label  class="col-sm-22 control-label">사용시작일자</label>--%>
                  <%--<div class="col-sm-9">--%>
                    <%--<div class="input-group">--%>
                      <%--<div class="input-group-addon">--%>
                        <%--<i class="fa fa-calendar"></i>--%>
                      <%--</div>--%>
                      <%--<input id="usestartdate" value="${data.usestartdate}" name="usestartdate" type="text" class="form-control pull-right datepickerrange" >--%>
                    <%--</div>--%>
                  <%--</div>--%>
                <%--</div>--%>
              <%--</div>--%>

              <%--<div class="col-md-6">--%>
                <%--<div class="form-group">--%>
                  <%--<label  class="col-sm-22 control-label">사용종료일자</label>--%>
                  <%--<div class="col-sm-9">--%>
                    <%--<div class="input-group">--%>
                      <%--<div class="input-group-addon">--%>
                        <%--<i class="fa fa-calendar"></i>--%>
                      <%--</div>--%>
                      <%--<input id="useenddate" value="${data.useenddate}" name="useenddate" type="text" class="form-control pull-right datepickerrange" >--%>
                    <%--</div>--%>
                  <%--</div>--%>
                <%--</div>--%>
              <%--</div>--%>
            <%--</div><!-- /.box-body -->--%>
            <%--<div class="box-footer text-align-center box-bg-foot">--%>
              <%--<a id="initailBtn"><img src="/image/bt_resetpw_off.png"/>&lt;%&ndash;비밀번호 초기화&ndash;%&gt;</a>--%>
              <%--<a id="saveBtn"><img src="/image/bt_save_off.png"/>&lt;%&ndash;저장&ndash;%&gt;</a>--%>
              <%--<a id="deleteBtn"><img src="/image/bt_delete_off.png"/>&lt;%&ndash;삭제&ndash;%&gt;</a>--%>

            <%--</div>--%>
          <%--</form><!-- form end -->--%>
        <%--</div><!-- /.box -->--%>
      <%--</div>--%>
    <%--</div><!-- /.row -->--%>
  <%--</section>--%>

<%--</div>--%>

<%--&lt;%&ndash;<img src="/image/PHARMACY4U-01_home.jpg" width="700px"/>&ndash;%&gt;--%>
<%--&lt;%&ndash;<img src="/image/PHARMACY4U-02_machine_admin.jpg" width="700px"/>&ndash;%&gt;--%>
<%--&lt;%&ndash;<img src="/image/PHARMACY4U-03_machine_edit.jpg" width="700px"/>&ndash;%&gt;--%>
<%--&lt;%&ndash;<img src="/image/PHARMACY4U-04_history_admin.jpg" width="700px"/>&ndash;%&gt;--%>



<%--<script>--%>
  <%--<!-- //bind start -->--%>
  <%--$(function(){--%>
    <%--<c:if test="${isAdmin}">--%>
    <%--setClickedMenuBold(3);--%>
    <%--</c:if>--%>
    <%--<c:if test="${!isAdmin}">--%>
    <%--setClickedMenuBold(1);--%>
    <%--</c:if>--%>

    <%--$('#joindate.datepickerrange').daterangepicker({--%>
      <%--locale: {--%>
        <%--format: 'YYYY.MM.DD'--%>
      <%--},--%>
      <%--"startDate": "${data.joindate}",--%>
      <%--"endDate": "",--%>
      <%--singleDatePicker: true,--%>
      <%--showDropdowns: true--%>
    <%--});--%>

    <%--$('#outdate.datepickerrange').daterangepicker({--%>
      <%--locale: {--%>
        <%--format: 'YYYY.MM.DD'--%>
      <%--},--%>
      <%--"startDate": "${data.outdate}",--%>
      <%--"endDate": "",--%>
      <%--singleDatePicker: true,--%>
      <%--showDropdowns: true--%>
    <%--});--%>

    <%--$('#usestartdate.datepickerrange').daterangepicker({--%>
      <%--locale: {--%>
        <%--format: 'YYYY.MM.DD'--%>
      <%--},--%>
      <%--"startDate": "${data.usestartdate}",--%>
      <%--"endDate": "",--%>
      <%--singleDatePicker: true,--%>
      <%--showDropdowns: true--%>
    <%--});--%>

    <%--$('#useenddate.datepickerrange').daterangepicker({--%>
      <%--locale: {--%>
        <%--format: 'YYYY.MM.DD'--%>
      <%--},--%>
      <%--"startDate": "${data.useenddate}",--%>
      <%--"endDate": "",--%>
      <%--singleDatePicker: true,--%>
      <%--showDropdowns: true--%>
    <%--});--%>

    <%--$('a#initailBtn').click(function(){--%>
      <%--getAjax('/machine/','/machine/initailizePwd','초기화되었습니다.');--%>
    <%--});--%>

    <%--$('a#saveBtn').click(function(){--%>
      <%--getAjax('/machine/','/machine/modify','저장되었습니다.');--%>
    <%--});--%>

    <%--$('a#deleteBtn').click(function(){--%>
      <%--if (confirm("삭제하시겠습니까?")) {--%>
        <%--getAjax('/machine/', '/machine/delete', '삭제되었습니다.');--%>
      <%--}--%>
    <%--});--%>

  <%--});--%>
  <%--<!-- bind end -->--%>

<%--</script>--%>
<%--</body>--%>
<%--</html>--%>
