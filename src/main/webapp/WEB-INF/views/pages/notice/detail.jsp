<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>

<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>공지사항 관리</title>
  <script src="/ckeditor/ckeditor.js"></script>
</head>
<body>
<form id="detailFrm" class="form-horizontal" action="<c:url value="${thisPath}/save"/>" method="post" enctype="multipart/form-data" >
<section class="content-header">
  <h1>
    <c:if test="${empty data && changePwd ne 'Y'}">
      공지사항등록
    </c:if>
    <c:if test="${not empty data && changePwd ne 'Y'}">
      공지사항상세
    </c:if>
    <c:if test="${changePwd eq 'Y'}">
      비밀번호변경
    </c:if>
  </h1>


  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li><a href="<c:url value="${thisPath}/list"/>">공지사항</a></li>
    <li>
      <a href="<c:url value="${thisPath}/detail/${data.noticeindex}"/>"><c:if test="${empty data && changePwd ne 'Y'}">공지사항등록</c:if><c:if test="${not empty data && changePwd ne 'Y'}">공지사항상세</c:if><c:if test="${changePwd eq 'Y'}">비밀번호변경</c:if></a>
    </li>
  </ol>
</section>
<!-- Main content -->
<section class="content">
  <div class="paddingInside">
      <div class="row">
        <div class="col-md-12">
          <div id="progressIndicator" style="display: none"></div>
          <div class="box-body">
            <!-- input start -->
            <c:if test="${empty data && changePwd ne 'Y'}">
              <%@include file="new.jsp"%>
            </c:if>

            <c:if test="${not empty data && changePwd ne 'Y'}">
              <%@include file="update.jsp"%>
            </c:if>

            <c:if test="${changePwd eq 'Y'}">
              <%@include file="changePwd.jsp"%>
            </c:if>

        </div><!-- //.box -->
      </div><!-- //.col-md-12 -->
        <%--<div class="breadcrumb-line"></div>--%>
    </div><!-- //.row -->
  </div><!-- //.paddingInside -->
</section>
  <div id="map" style="width:100%;height:350px;display: none"></div>
<c:if test="${empty data}">
  <center>
    <a id="saveBtn" class="btn btn-blue-green btn-flat md-height">저장</a>
    <a href="<c:url value="${thisPath}/list"/>" class="btn btn-blue-green btn-flat md-height">목록</a>
  </center>

</c:if>
<c:if test="${not empty data && changePwd ne 'Y'}">
  <center>
    <a id="saveBtn" class="btn btn-blue-green btn-flat md-height">저장</a>
    <a id="delBtn" class="btn btn-green btn-flat md-height showEditor">삭제</a>

  </center>
</c:if>
  <c:if test="${not empty data && changePwd eq 'Y'}">
    <center>
      <a id="changePwdBtn" class="btn btn-blue-green btn-flat md-height">저장</a>
    </center>
  </c:if>
</form>

<script>



  var saveFunction = function(){


    if($('#noticeindex').val() ==''){
      alert('아이디를 입력해주세요');
      $('#noticeindex').focus();
      return false;
    }
    <c:if test="${empty data}">
    if($('#password').val() ==''){
      alert('비밀번호를 입력해주세요');
      $('#password').focus();
      return false;
    }
    if($('#cfrm_password').val() ==''){
      alert('비밀번호확인을 입력해주세요');
      $('#cfrm_password').focus();
      return false;
    }
    </c:if>
    if($('#name').val() ==''){
      alert('이름을 입력해주세요');
      $('#name').focus();
      return false;
    }
    if($('#gubun').val() ==''){
      alert('약국/병원 구분을 입력해주세요');
      $('#gubun').focus();
      return false;
    }

    if($('#usestartdate').val() ==''){
      alert('사용시작일자를 입력해주세요');
      $('#usestartdate').focus();
      return false;
    }
    if($('#useenddate').val() ==''){
      alert('사용종료일자를 입력해주세요');
      $('#useenddate').focus();
      return false;
    }

    <c:if test="${empty data}">

    </c:if>
    <c:if test="${empty data}">

    </c:if>
    $('#detailFrm').submit();

  }
  $(function(){

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active');
      var menu = $(this).attr('menu');
      if(menu=='공지사항관리'){
        $(this).addClass('active')
      }
    });






    $('.datepicker').datepicker({
      format: "yyyy.mm.dd",
//      startDate: '+0d',
      todayBtn: true
    });

    $('#delBtn').click(function(){
      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="${thisPath}/delete"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('삭제되었습니다.');
          location.href='${thisPath}/list';
        }
      }, function (err) {
        alert(err.result_message);
      });

    });

    //저장
    $('#saveBtn').click(function(){


        saveFunction();

    });

    $('#id_check').click(function(){
      if($('#noticeindex').val() ==''){
        alert('아이디를 입력해주세요');
        $('#noticeindex').focus();
        return false;
      }
      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="${thisPath}/idCheck"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('사용할수 있는 아이디입니다.');
          $('#idCheck').val("Y");
        }else{
          alert('이미 존재하는 아이디입니다.');
        }
      }, function (err) {
        alert(err.result_message);
      });



    });


  });
  <!-- bind end -->

</script>
</body>
</html>
