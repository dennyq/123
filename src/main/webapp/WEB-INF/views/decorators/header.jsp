<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isLogin" value="${sessionScope.memberid != null and sessionScope.memberid != ''}"/>
<c:set var="isSpecialLogin" value="${sessionScope.specialid != null and sessionScope.specialid != ''}"/>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<c:set var="isSpecial" value="${sessionScope.login_type eq 'special'}"/>
<header class="main-header">
  <nav class="navbar navbar-static-top">
    <div class="container">
      <div class="navbar-top">
        <div class="collapse navbar-collapse pull-right" >
        <ul class="nav navbar-nav">
          <li><a href="/">HOME </a></li>
          <li><a>/</a></li>
          <li>
            <c:if test="${isSpecial && isSpecialLogin}">
              <a href="/special/logout">Logout</a>
            </c:if>
            <c:if test="${isSpecial && !isSpecialLogin}">
              <a href="/special/">Login</a>
            </c:if>
            <c:if test="${!isSpecial && !isLogin}">
              <a href="/">Login</a>
            </c:if>
            <c:if test="${!isSpecial && isLogin}">
              <a href="/logout">Logout</a>
            </c:if>


          </li>
          </ul>
          </div>
      </div>
    </div>
    <div class="header-border"></div>
    <div class="container">

      <div class="navbar-header">
        <a href="/" class="navbar-brand"><b><img style="margin-top:-40px;" src="/imgs/img_s_logo.png"/></b></a>
      </div>


      <div class="collapse navbar-collapse pull-right" id="navbar-collapse">
        <ul class="nav navbar-nav">

          <c:if test="${!isSpecial}">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">회원 관리</a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="/member/detail">회원등록</a></li>
              <li><a href="/member/list">회원조회</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">전문가 회원 관리</a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="/special/membership/detail">전문가회원등록</a></li>
              <li><a href="/special/membership/list">전문가회원조회</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">광고 관리</a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="/adinfo/detail">광고등록</a></li>
              <li><a href="/adinfo/list">광고조회</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">공지사항 관리</a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="/notice/detail">공지사항 등록</a></li>
              <li><a href="/notice/list">공지사항 조회</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">건강정보 관리</a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="/health/detail">건강정보 등록</a></li>
              <li><a href="/health/list">건강정보 조회</a></li>
            </ul>
          </li>
          </c:if>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">환경 설정</a>
            <c:if test="${isSpecial}">
              <ul class="dropdown-menu" role="menu">
                <li style="margin-left: -100px;"><a href="/special/membership/detail/${sessionScope.specialid}">회원정보수정</a></li>
                <li><a href="/special/membership/changePwdPage/">비밀번호 변경</a></li>
              </ul>
            </c:if>
            <c:if test="${!isSpecial}">
              <ul class="dropdown-menu" role="menu">
                <li><a href="/member/changePwdPage/">비밀번호 변경</a></li>
              </ul>
            </c:if>


          </li>
        </ul>

      </div>
      <!-- /.navbar-collapse -->

      <!-- /.navbar-custom-menu -->
    </div>
    <div class="container blue-thick-line"></div>
    <!-- /.container-fluid -->
  </nav>
</header>