<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<head>
  <title>PHARMACY4U</title>
</head>
<div style="height:40%;"></div>
<div class="login-wrapper">
  <%--<img src="/imgs/bg_logbox.png" style="position: relative;width: 860px"/>--%>
  <div class="login-box">
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
          <div style="margin-left: 0px;margin-top: 25px;">
            <a href="/pc/listSearchRegion"> <img src="/imgs/bt_selec_local.png" style="margin-left: 0px;" onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');"/></a>
          </div>
          <div style="margin-left: 0px;margin-top: 25px;">
            <a href="/pc/listSearchName"> <img src="/imgs/bt_selec_name.png" style="margin-left: 0px;" onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');"/></a>
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

    $('#famersLogin').click(function(){
      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="/login"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('관리자외에 접근할 수 없습니다..');
        }else  if (data.result_message == 'success_admin') {
          location.href = '/member/list';
        }else{
          alert('아이디나 비밀번호가 맞지 않습니다.');
        }
      }, function (err) {
        alert(err.result_message);
      });

    });
  });
</script>