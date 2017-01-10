<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <title><decorator:title/></title>

  <page:applyDecorator name="headLib"/>

  <decorator:head/>
</head>
<body class="hold-transition login-page">
<div class="m-upper-logo">
  <div class="login-wrapper">
    <div class="main_logo-fago">
      <%--<img src="/imgs/main_logo-fago.png" alt="main_logo-fago" style="width: 40%;">--%>
    </div>
    <div class="m-login-logo">
      <center>
        <img src="/imgs/main_logo.png" alt="main_logo" style="width: 60%;">
      </center>
      <div class="margin-top-15-p">
        <center>
          <img src="/imgs/img_bg_main_1.png" alt="img_bg_main_1" style="width: 95%;">
        </center>
      </div>

    </div>
  </div>
</div>
<div class="lower-logo">
  <page:applyDecorator name="lib"/>
  <decorator:body/>
</div>


</body>
</html>


