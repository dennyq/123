<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isLogin" value="${sessionScope.memberid != null and sessionScope.memberid != ''}"/>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<header class="main-header">
  <nav class="navbar navbar-static-top">
    <div class="container">
      <div class="navbar-top">
        <div class="collapse navbar-collapse pull-right" >
        <ul class="nav navbar-nav">
          <li><a href="/">HOME </a></li><li><a>/</a></li><li><a href="/logout">Logout</a></li>
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

          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">회원 관리</a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="/member/detail">회원등록</a></li>
              <li><a href="/member/list">회원조회</a></li>
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
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">환경 설정</a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="/member/changePwdPage/">비밀번호 변경</a></li>
            </ul>
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