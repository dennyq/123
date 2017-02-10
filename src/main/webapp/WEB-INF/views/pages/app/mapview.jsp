<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>맵뷰</title>
  <style>

  </style>
  <%--<script type="text/javascript" src="/js/lib/handlebars.min.js"></script>--%>
  <%--<script type="text/javascript" src="/js/common_handlerbar.js"></script>--%>
  <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=3449b8f92183a8efbf5dafe9ceb3c430&libraries=services"></script>
</head>
<body>
<center>
  <section class="content-header">
    <h1 class="big-font">
        맵뷰
    </h1>
  </section>
</center>
  <!-- Main content -->
<section class="content">
  <div>${param['gubun']}</div>
  <div>${param['latitude']}</div>
  <div>${param['longitude']}</div>
<br>
  <div>${gubun}</div>
  <div>${latitude}</div>
  <div>${longitude}</div>

</section>

</body>
</html>
