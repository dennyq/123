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
<body class="hold-transition base-page">
<div class="m-upper-logo">
  <div class="login-wrapper">
    <div class="m_nav_logo-fago">
      <div class="m-nav-title">
        <i class="fa fa-fw fa-caret-left m-font-nav"></i>
        <span class="m-nav-text">
          iFarmers
        </span>

      </div>

    </div>
    <div class="m-login-logo">
      <center>
        <img src="/imgs/main_logo.png" alt="main_logo" style="width: 60%;">
      </center>
      <div class="margin-top-15-p">
        <center>
          <img src="/imgs/img_bg_main_2.png" alt="img_bg_main_1" style="width: 95%;">
        </center>
      </div>

    </div>
  </div>
</div>
<%--<div class="lower-logo">--%>
  <page:applyDecorator name="lib"/>
  <decorator:body/>
<%--</div>--%>


</body>
</html>


