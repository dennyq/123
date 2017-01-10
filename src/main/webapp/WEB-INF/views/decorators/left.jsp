<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isLogin" value="${sessionScope.memberid != null and sessionScope.memberid != ''}"/>
<c:set var="isAdmin" value="${sessionScope.memberid == 'admin'}"/>
<script>
    var monitorSetTimeOut = null;
</script>

<aside class="main-sidebar">
  <!-- sidebar: style can be found in sidebar.less -->
  <section class="sidebar">
      <div class="overlay dark">
      </div>
    <!-- Sidebar user panel -->
    <div class="sub-logo">
      <center>
        <img src="/imgs/sub_logo.png" alt="Sub Logo">
      </center>

    </div>
<c:if test="${isLogin}">
    <div class="user-panel pd-20">

      <div class="pull-left">
        <p>
          <span class="user-name">${sessionScope.name}</span>님<br> 반갑습니다.
    <c:if test="${sessionScope.login_admin eq 'Y'}"><br> <span id="changeed">(${sessionScope.login_uid})</span> 사용자선택</c:if>
        </p>

      </div>
      <div class="pull-right">
        <a href="<c:url value="/logout"/>"><img src="/imgs/bt_log-in.png" alt="LogOut"></a>

      </div>
    </div>
</c:if>

    <!-- sidebar menu: : style can be found in sidebar.less -->
    <ul class="sidebar-menu">
<c:if test="${isAdmin}">
      <li class=" treeview" menu="사용자관리">
        <a gotourl="<c:url value="/member/list"/>">
          <span>사용자 관리</span>
        </a>
      </li>
</c:if>
      <li class=" treeview" menu="사용자정보">
        <a gotourl="<c:url value="/member/info/${sessionScope.memberid}"/>">
          <span>사용자 정보</span>
        </a>
      </li>
      <li class="treeview" menu="모니터링">
        <a gotourl="<c:url value="/monitor/"/>">
          <span>모니터링</span>
        </a>
      </li>
      <li class="treeview" menu="데이터관리">
        <a gotourl="<c:url value="/data/list"/>">
          <span>데이터 관리</span>
        </a>
      </li>
      <li class="treeview" menu="원격제어">
        <a gotourl="<c:url value="/remote/"/>">
          <span>원격 제어</span>
        </a>
      </li>
      <li class="treeview" menu="영상보기">
        <a gotourl="<c:url value="/cctv/list"/>">
          <span>영상 보기</span>
        </a>
      </li>
      <li class="treeview" menu="공지사항">
        <a gotourl="<c:url value="/notice/list"/>">
          <span>공지사항<c:if test="${isAdmin}"> 관리</c:if></span>
        </a>
      </li>

      <%--<page:applyDecorator name="footer"/>--%>
    </ul>

  </section>

  <!-- /.sidebar -->
  <div>
    <center>
      <img src="/imgs/img_copy-logo.png" width="135px" alt="Copyright">
      <p><i class="fa fa-copyright copyright"></i><span class="copyright">FAGO KOREA All Rights reserved.</span></p>

    </center>

  </div>
</aside>
<%--<script>--%>
    <%--$(function () {--%>
<%--//            $('.sidebar-menu li, .sidebar-menu li a').click(function(){--%>
            <%--$('.sidebar-menu li a').click(function(){--%>
                <%--if (monitorSetTimeOut != null) {--%>
                    <%--clearTimeout(monitorSetTimeOut);--%>
                <%--}--%>

                <%--location.href = $(this).attr('gotourl');--%>

            <%--})--%>
    <%--});--%>
<%--</script>--%>