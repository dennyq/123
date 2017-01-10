<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<head>
  <title>IFARMERS</title>
</head>
<div class="login-wrapper">
  <div class="login-box">

      <!-- /.login-logo -->
      <div class="login-box-body">

        <form method="post">
          <div class="form-group has-icon non-bottom">
            <input id="famers-id" name="famersId" class="form-control" placeholder="UserID">
            <span class="icon-user form-control-icon"></span>
          </div>
          <div class="form-group has-icon">
            <input id="famers-pw" name="famersPw" type="password" class="form-control" placeholder="Password">
            <span class="icon-password form-control-icon"></span>
          </div>
          <div class="row">

            <div class="col-xs-12">
              <a id="famersLogin" class="btn btn-light-green btn-block btn-flat">로그인</a>
            </div>
            <!-- /.col -->
          </div>
        </form>


        <%--<a href="#">I forgot my password</a><br>--%>
        <%--<a href="register.html" class="text-center">Register a new membership</a>--%>

      </div>
      <!-- /.login-box-body -->

    </div>


<!-- /.login-box -->
</div>



<script>
  $(function () {

    $('#famersLogin').click(function(){
      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="/login"/>', req, function (data) {
        if (data.result_message == 'success') {
          location.href = '/notice/list';
        }else  if (data.result_message == 'success_admin') {
          location.href = '/notice/list';
        }else{
          alert('아이디나 비밀번호가 맞지 않습니다.');
        }
      }, function (err) {
        alert(err.result_message);
      });

    });
  });
</script>