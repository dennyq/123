<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>광고 관리</title>
</head>
<body>
<form id="detailFrm" class="form-horizontal" action="<c:url value="/adinfo/save"/>" method="post" enctype="multipart/form-data" >
<section class="content-header">
  <h1>
    <c:if test="${empty data}">
      광고등록
    </c:if>
    <c:if test="${not empty data}">
      광고상세
    </c:if>

  </h1>


  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li><a href="<c:url value="/adinfo/list"/>">광고</a></li>
    <li>
      <a href="<c:url value="/adinfo/detail/${data.memberid}"/>"><c:if test="${empty data && changePwd ne 'Y'}">광고등록</c:if><c:if test="${not empty data && changePwd ne 'Y'}">광고상세</c:if><c:if test="${changePwd eq 'Y'}">비밀번호변경</c:if></a>
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
            <c:if test="${empty data}">
              <%@include file="new.jsp"%>
            </c:if>

            <c:if test="${not empty data}">
              <%@include file="update.jsp"%>
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
    <a id="saveBtn" class="btn btn-blue-green btn-flat md-height">등록</a>
    <a href="<c:url value="/adinfo/list"/>" class="btn btn-blue-green btn-flat md-height">목록</a>
  </center>

</c:if>
<c:if test="${not empty data}">
  <center>
    <a id="saveBtn" class="btn btn-blue-green btn-flat md-height">저장</a>
    <a id="delBtn" class="btn btn-green btn-flat md-height showEditor">삭제</a>

  </center>
</c:if>

</form>

<script>

  var saveFunction = function(){


    $('#detailFrm').submit();

  }
  $(function(){

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active');
      var menu = $(this).attr('menu');
      if(menu=='광고관리'){
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
      $als.execute('<c:url value="/adinfo/delete"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('삭제되었습니다.');
          location.href='/adinfo/list';
        }
      }, function (err) {
        alert(err.result_message);
      });

    });

    //저장
    $('#saveBtn').click(function(){

      saveFunction();


    });

    $('#ad_check').click(function(){
      if($('#adtitle').val() ==''){
        alert('광고제목을 입력해주세요');
        $('#adtitle').focus();
        return false;
      }
      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="/adinfo/adCheck"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('사용할수 있는 광고제목입니다.');
          $('#idCheck').val("Y");
        }else{
          alert('이미 존재하는 광고제목입니다.');
        }
      }, function (err) {
        alert(err.result_message);
      });



    });

    $('#changePagePwdBtn').click(function(){
      var id = $('#memberid').val();
      console.log(id);
      location.href='/adinfo/changePwdPage/'+id;

    });

    $('#changePwdBtn').click(function(){

      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="/adinfo/changePwd"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('비밀번호가 변경되었습니다.');
          location.href='/adinfo/list';
        }else if (data.result_message == 'fail') {
          alert('비밀번호가 맞지 않습니다.');
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
