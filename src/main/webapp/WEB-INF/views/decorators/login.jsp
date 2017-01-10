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
<body class="hold-transition login-page bg-farm">
<div class="upper-logo">
  <div class="login-wrapper">
    <div class="main_logo-fago">
      <img src="/imgs/main_logo-fago.png" alt="main_logo-fago">
    </div>
    <div class="login-logo">
      <img src="/imgs/main_logo.png" alt="main_logo">
    </div>
  </div>
</div>
<div class="lower-logo" >


  <page:applyDecorator name="lib"/>
  <decorator:body/>

</div>


</body>
</html>


