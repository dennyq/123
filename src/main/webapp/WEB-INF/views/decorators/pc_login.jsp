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
<body class="hold-transition login-page bg-farm-dark">
<div class="upper-logo">
  <%--<img src="/imgs/bg_main_foot_1.png" style="position: absolute;top:0;left:0;width: 100%;z-index: -1;"/>--%>
  <page:applyDecorator name="lib"/>
  <decorator:body/>
</div>
<div class="lower-logo-gray" >
  Copyright@Pharmacy4u.All Rights Reserved.
</div>
</body>
</html>


