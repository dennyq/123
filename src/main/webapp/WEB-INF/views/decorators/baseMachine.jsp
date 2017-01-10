<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isLogin" value="${sessionScope.memberid != null and sessionScope.memberid != ''}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
  <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>

  <title><decorator:title/></title>

  <page:applyDecorator name="lib"/>

  <decorator:head/>
</head>
<script>
  $(function () {
    leftBoxResize();
    $('#btnLogout').click(function(){
      location.href = '/member/memberLogout';
    });
  });
  function leftBoxResize(){
    var navbar_header = $('.navbar-header').outerHeight();
    var profileCenter = $('.profileCenter').outerHeight();
    var contHeight = eval($('body').outerHeight() - navbar_header - profileCenter);
    $('.section').css({minHeight:contHeight});
  };
</script>
<body>
<page:applyDecorator name="header"/>


<div class="container width1024">
  <ul class="top5colorBorder">
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
  </ul>
  <div class="topSection">
    <c:if test="${isLogin}">
      <div class="profileCenter">
      <span class="imgProfile">
          <img src="/image/ico_welcome.png"/>
      </span>
        <span class="profileTxt">환영합니다!. ${sessionScope.name}</span>
      <span id="btnLogout" class="profileLogout imgHover">
        <img src="/image/bt_logout_off.png" class="bottom-line" style=""/>
      </span>

      </div>
    </c:if>
  </div>
  <div class="section">
    <decorator:body/>
  </div>
</div>

<div class="bg_popup"></div>
<page:applyDecorator name="layers"/>

</body>
</html>

