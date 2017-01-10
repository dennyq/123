<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isLogin" value="${sessionScope.memberid != null and sessionScope.memberid != ''}"/>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>ifarms home</title>
  <%--<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap.min.css"/>"/>--%>
  <%--<link rel="stylesheet" type="text/css" href="<c:url value="/css/modern-business.min.css"/>"/>--%>
  <script>
    <%--$(function () {--%>
      <%--$('#home').addClass('on-color');--%>
      <%--$('#product').removeClass('on-color');--%>
      <%--$('#about').removeClass('on-color');--%>
      <%--$('.btn > a img').hover(function(){--%>
        <%--var src = $(this).attr('src');--%>
        <%--src= src.replace('_off','_on');--%>
        <%--$(this).attr('src',src);--%>
      <%--},function(){--%>
        <%--var src = $(this).attr('src');--%>
        <%--src= src.replace('_on','_off');--%>
        <%--$(this).attr('src',src);--%>
      <%--});--%>
    <%--});--%>


    <%--function login() {--%>
      <%--var req = {};--%>
      <%--req =  $("#loginForm").serialize();--%>
      <%--req.memberid = $('#loginId').val();--%>
      <%--req.password = $('#loginPwd').val();--%>

      <%--if(req.memberid == ''){--%>
        <%--alert('아이디를 입력하세요.');--%>
        <%--$('#loginId').focus();--%>
        <%--return;--%>
      <%--}--%>
      <%--if(req.password ==''){--%>
        <%--alert('패스워드를 입력하세요.');--%>
        <%--$('#loginPwd').focus();--%>
        <%--return;--%>
      <%--}--%>



      <%--$als.execute('<c:url value="/member/memberLogin"/>', req, function (data) {--%>
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
    <%--}--%>
  </script>

</head>
<body>
<c:if test="${!isLogin}">
  <form id="loginForm" name="loginForm" method="POST">
    <div class="body">
      <div class="loginContainer">
        <img src="/image/main_img_bi.png"/>

        <div class="login">
          <div class="idpw">
            <div class="id"><span class="idpwText"><img src="/image/main_txt_id.png"/><%--ID--%></span>
              <input id="loginId" name="memberid" placeholder="USER_ID">
            </div>
            <div class="pw"><span class="idpwText" style=" margin-left: 5px; "><img src="/image/main_txt_pw.png"/><%--PW--%></span>
              <input id="loginPwd" name="password"  type="password" placeholder="USER_PWD">
            </div>
          </div>
          <div class="btn imgHover">
            <a  href="javascript:login()" title="로그인"><img src="/image/main_btn_ok_off.png" width="100"/></a>
          </div>
        </div>
      </div>
    </div>

    <div class="footDiv" style="padding-top: 40px;">

      <img src="/image/foot_address.png" />

    </div>
  </form>
</c:if>
</body>
</html>
