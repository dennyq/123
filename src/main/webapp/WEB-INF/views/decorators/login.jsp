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
  <img src="/imgs/bg_main.png" style="position: absolute;top:0;left:0;width: 100%;z-index: -1;"/>
  <page:applyDecorator name="lib"/>
  <decorator:body/>
</div>
<div class="lower-logo" >
  Copyright@Pharmacy4u.All Rights Reserved.
</div>
</body>
</html>


