<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>ifarms about</title>
  <link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap.min.css"/>"/>
  <link rel="stylesheet" type="text/css" href="<c:url value="/css/modern-business.min.css"/>"/>
  <style>
    .leftSection{
      height: 2161px;
    }
  </style>
  <script>
    $(function () {
      $('#product').addClass('on-color');
      $('#home').removeClass('on-color');
      $('#about').removeClass('on-color');
    });
  </script>

</head>
<body>
<div style="padding: 20px">

  <img src="/image/pro_subvisual.jpg" />
  <img src="/image/sub_product.jpg" />
</div>

<div style="padding: 36px 0 22px 63px;">

  <img src="/image/foot_address.png" />

</div>
</body>
</html>
