<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<head>
  <title>PHARMACY4U</title>
</head>
<%--<form method="post">--%>
    <div class="mobile">
        <div class="m-box">
            <div class="m-btn m-btn-grey" linkurl="/remote/"><img src="/imgs/img_bt_01.png" alt="main_logo" style="width: 10%;margin-right: 10px"><a href="/remote/">원격제어 관리시스템</a></div>
            <div class="m-btn m-btn-green" linkurl="/monitor/"> <img src="/imgs/img_bt_02.png" alt="main_logo" style="width: 10%;margin-right: 10px"><a href="/monitor/">센서 모니터링</a></div>
            <div class="m-btn m-btn-orange" linkurl="app://iVMS"><img src="/imgs/img_bt_03.png" alt="main_logo" style="width: 10%;margin-right: 10px"><a id="applink" href="app://iVMS">영상보기</a></div>

        </div>

    </div>
<%--</form>--%>




<script>
  $(function () {
$('.m-btn').click(function(){
    location.href = $(this).attr('linkurl');
})

  });
</script>