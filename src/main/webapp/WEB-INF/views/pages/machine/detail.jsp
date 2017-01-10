<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
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
          <div id="progressIndicator" style="display: none"></div>
          <!-- form start -->
          <form id="detailFrm" class="form-horizontal" method="post">
            <div class="box-body border-bottom">
              <div class="col-md-4">
                <div class="form-group">
                  <label for="memberid" class="col-sm-4 control-label">머신아이디</label>
                  <div class="col-sm-8">
                    <input id="machine_id" name="machine_id" value="${data.memberid}" class="form-control" placeholder="머신아이디" disabled>
                    <input type="hidden" id="memberid" name="memberid" value="${data.memberid}"/>
                  </div>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-group">
                  <label for="machine_name"  class="col-sm-4 control-label">머신명</label>
                  <div class="col-sm-8">
                    <input id="machine_name" name="name" value="${data.machine_name}" class="form-control" placeholder="머신명">
                  </div>
                </div>
              </div>

              <div class="col-md-4">
                <div class="form-group">
                  <label for="machine_contact" class="col-sm-4 control-label">머신연락처</label>
                  <div class="col-sm-8">
                    <input id="machine_contact" name="contactpoint" value="${data.machine_contact}" class="form-control" placeholder="머신연락처">
                  </div>
                </div>
              </div>
            </div>
            <div class="box-body border-bottom">
              <div class="col-md-4">
                <div class="form-group">
                  <label for="member_name" class="col-sm-4 control-label">회원명</label>
                  <div class="col-sm-8">
                    <input id="member_name" name="member_name" value="${data.member_name}" class="form-control" placeholder="회원명" readonly>
                  </div>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-group">
                  <label for="member_contact" class="col-sm-4 control-label">회원연락처</label>
                  <div class="col-sm-8">
                    <input id="member_contact" name="member_contact" value="${data.member_contact}" class="form-control" placeholder="회원연락처" readonly>
                  </div>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-group">
                  <label for="member_contact" class="col-sm-4 control-label">비고</label>
                  <div class="col-sm-8">
                    <input id="note" name="note" value="${data.note}" class="form-control" placeholder="비고" >
                  </div>
                </div>
              </div>
            </div><!-- /.box-body -->
            <div class="box-body border-bottom">
              <div class="col-md-6">
                <div class="form-group">
                  <label  class="col-sm-22 control-label">가입일자</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input id="joindate" value="${data.joindate}" name="joindate" type="text" class="form-control pull-right datepickerrange" >
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
                      <input id="outdate" value="${data.outdate}" name="outdate" type="text" class="form-control pull-right datepickerrange" >
                    </div>
                  </div>
                </div>
              </div>
            </div><!-- /.box-body -->
            <div class="box-body border-bottom-big">
              <div class="col-md-6">
                <div class="form-group">
                  <label  class="col-sm-22 control-label">사용시작일자</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input id="usestartdate" value="${data.usestartdate}" name="usestartdate" type="text" class="form-control pull-right datepickerrange" >
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
                      <input id="useenddate" value="${data.useenddate}" name="useenddate" type="text" class="form-control pull-right datepickerrange" >
                    </div>
                  </div>
                </div>
              </div>
            </div><!-- /.box-body -->
            <div class="box-footer text-align-center box-bg-foot">
              <a id="initailBtn"><img src="/image/bt_resetpw_off.png"/><%--비밀번호 초기화--%></a>
              <a id="saveBtn"><img src="/image/bt_save_off.png"/><%--저장--%></a>
              <a id="deleteBtn"><img src="/image/bt_delete_off.png"/><%--삭제--%></a>

            </div>
          </form><!-- form end -->
        </div><!-- /.box -->
      </div>
    </div><!-- /.row -->
  </section>

</div>

<%--<img src="/image/IFARMERS-01_home.jpg" width="700px"/>--%>
<%--<img src="/image/IFARMERS-02_machine_admin.jpg" width="700px"/>--%>
<%--<img src="/image/IFARMERS-03_machine_edit.jpg" width="700px"/>--%>
<%--<img src="/image/IFARMERS-04_history_admin.jpg" width="700px"/>--%>



<script>
  <!-- //bind start -->
  $(function(){
    setClickedMenuBold(2);

    $('#joindate.datepickerrange').daterangepicker({
      locale: {
        format: 'YYYY.MM.DD'
      },
      "startDate": "${data.joindate}",
      "endDate": "",
      singleDatePicker: true,
      showDropdowns: true
    });

    $('#outdate.datepickerrange').daterangepicker({
      locale: {
        format: 'YYYY.MM.DD'
      },
      "startDate": "${data.outdate}",
      "endDate": "",
      singleDatePicker: true,
      showDropdowns: true
    });

    $('#usestartdate.datepickerrange').daterangepicker({
      locale: {
        format: 'YYYY.MM.DD'
      },
      "startDate": "${data.usestartdate}",
      "endDate": "",
      singleDatePicker: true,
      showDropdowns: true
    });

    $('#useenddate.datepickerrange').daterangepicker({
      locale: {
        format: 'YYYY.MM.DD'
      },
      "startDate": "${data.useenddate}",
      "endDate": "",
      singleDatePicker: true,
      showDropdowns: true
    });

    $('a#initailBtn').click(function(){
//      getAjax('/machine/','/machine/initailizePwd','초기화되었습니다.');
      var url = '/machine/initailizePwd';
      var rootUrl ='/machine/';
      var alert_msg ='초기화되었습니다.';
      var req = $('#detailFrm').serialize();

      var p = new prog();
      p.startSpinner();
      $als.execute(url, req, function (data) {
        p.stopSpinner();
        var url = "";
        if (data.result_message == 'success') {
          alert(alert_msg);
          url = rootUrl + 'list';
          location.href = url;
        } else {
          alert(data.result_message);
          url = rootUrl + 'list';
          location.href = url;
        }

      }, function (err) {
        p.stopSpinner();
        alert(err.result_message);
      });
    });

    $('a#saveBtn').click(function(){
//      getAjax('/machine/','/machine/modify','저장되었습니다.');
      var url = '/machine/modify';
      var rootUrl ='/machine/';
      var alert_msg ='저장되었습니다.';
      var req = $('#detailFrm').serialize();

      var p = new prog();
      p.startSpinner();
      $als.execute(url, req, function (data) {
        p.stopSpinner();
        var url = "";
        if (data.result_message == 'success') {
          alert(alert_msg);
          url = rootUrl + 'list';
          location.href = url;
        } else {
          alert(data.result_message);
          url = rootUrl + 'list';
          location.href = url;
        }

      }, function (err) {
        p.stopSpinner();
        alert(err.result_message);
      });
    });

    $('a#deleteBtn').click(function(){
      if (confirm("정말로 삭제하시겠습니까?")) {
//        getAjax('/machine/', '/machine/delete', '삭제되었습니다.');
        var url = '/machine/delete';
        var rootUrl ='/machine/';
        var alert_msg ='삭제되었습니다.';
        var req = $('#detailFrm').serialize();

        var p = new prog();
        p.startSpinner();
        $als.execute(url, req, function (data) {
          p.stopSpinner();
          var url = "";
          if (data.result_message == 'success') {
            alert(alert_msg);
            url = rootUrl + 'list';
            location.href = url;
          } else {
            alert(data.result_message);
            url = rootUrl + 'list';
            location.href = url;
          }

        }, function (err) {
          p.stopSpinner();
          alert(err.result_message);
        });
      }
    });

  });
  <!-- bind end -->

</script>
</body>
</html>
