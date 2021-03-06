<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<head>
  <title>PHARMACY4U</title>
  <style>
    .blue-wide-btn{
      background: #0e85a6;
      padding: 15px 0;
      padding-top: 15px;
      padding-right: 0px;
      padding-bottom: 15px;
      padding-left: 0px;
      border-radius: 0;
      color: white;
      width: 331px;
      border-top: 3px solid #0d7895;
      margin-left: 12px;
    }
  </style>
</head>
<div style="height:40%;"></div>
<div class="login-wrapper">
  <%--<img src="/imgs/bg_logbox.png" style="position: relative;width: 860px"/>--%>
  <div class="login-box" style=" height: 350px; background-color: white; ">
    <div class="left-left">
      <div style="height: 10px;"></div>
      <img src="/imgs/img_m_logo.png"/>
      <div style="height: 30px;"></div>
      <img src="/imgs/img_m_illust.png" style="margin-left: 30px;"/>
      <div style="height: 10px;"></div>
    </div>
    <div class="right-left">
      <div class="login-box-body">
        <form method="post">
          <label for="login-id"><img src="/imgs/img_m_id.png" class="img-margin"/>아이디</label>
          <div class="form-group has-icon non-bottom">
            <input id="login-id" name="login-id" class="form-control" placeholder="UserID">
          </div>
          <div style="height: 10px;"></div>
          <label for="login-pw"><img src="/imgs/img_m_id-04.png" class="img-margin"/>패스워드</label>
          <div class="form-group has-icon">
            <input id="login-pw" name="login-pw" type="password" class="form-control" placeholder="Password">

          </div>
          <div class="row">
              <a id="specialLogin" class="btn "><img src="/imgs/bt_login.png"></a>
          </div>
          <div class="row">
              <a id="specialRegister" class="btn blue-wide-btn">
                회원가입
                <%--<img src="/imgs/bt_login.png">--%>
              </a>
          </div>
        </form>

      </div>
    </div>


      <!-- /.login-box-body -->

    </div>


<!-- /.login-box -->
</div>

<div style="height:30%;"></div>

<script>
  $(function () {

    var windowHeight = $(window).height();
    var footerHeight = 50;
    var loginHeight = -100;
//    console.log(windowHeight);

    $('.upper-logo').css('height',windowHeight-footerHeight-loginHeight+'px');
    $('.lower-logo').css('height',footerHeight+'px');

    $('#specialRegister').click(function(){

        location.href = '/special/membership/contract';
    });

    $('#specialLogin').click(function(){
      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="/special/login"/>', req, function (data) {
//          console.log('data : ');
//          console.log(data);
        if (data.result_message == 'success') {
//          alert('관리자외에 접근할 수 없습니다..');
            location.href = '/special/membership/contract/' + $('#login-id').val();
//        }
//        else  if (data.result_message == 'success_admin') {
//          location.href = '/member/list';
        }else{
          alert('아이디나 비밀번호가 맞지 않습니다.');
        }
      }, function (err) {
        alert(err.result_message);
      });

    });
  });
</script>