<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>

<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>건강정보 관리</title>
  <script src="/ckeditor/ckeditor.js"></script>
</head>
<body>
<form id="detailFrm" class="form-horizontal" action="<c:url value="${thisPath}/save"/>" method="post" enctype="multipart/form-data" >
<section class="content-header">
  <h1>
    <c:if test="${empty data && changePwd ne 'Y'}">
      건강정보등록
    </c:if>
    <c:if test="${not empty data && changePwd ne 'Y'}">
      건강정보상세
    </c:if>
    <c:if test="${changePwd eq 'Y'}">
      비밀번호변경
    </c:if>
  </h1>


  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li><a href="<c:url value="${thisPath}/list"/>">건강정보</a></li>
    <li>
      <a href="<c:url value="${thisPath}/detail/${data.healthindex}"/>"><c:if test="${empty data && changePwd ne 'Y'}">건강정보등록</c:if><c:if test="${not empty data && changePwd ne 'Y'}">건강정보상세</c:if><c:if test="${changePwd eq 'Y'}">비밀번호변경</c:if></a>
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


    if($('#thumbnailfile').val() ==''){
      alert('썸네일을 올려주세요');
      $('#thumbnailfile').focus();
      return false;
    }

    $('#detailFrm').submit();

  }
  $(function(){

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active');
      var menu = $(this).attr('menu');
      if(menu=='건강정보관리'){
        $(this).addClass('active')
      }
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
      if($('#healthindex').val() ==''){
        alert('아이디를 입력해주세요');
        $('#healthindex').focus();
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

    $('.deleteFile').click(function(){
        var healthindex = $(this).attr('healthindex');
        var sequencenum = $(this).attr('sequencenum');
        var filename = $(this).attr('filename');
        console.log('healthindex : '+healthindex);
        console.log('sequencenum : '+sequencenum);
        var req = {};
        req.healthindex = healthindex;
        req.sequencenum = sequencenum;
        req.filename = filename;
        $als.execute('<c:url value="${thisPath}/deleteFile"/>', req, function (data) {
            if (data.result_message == 'success') {
                alert('파일이 삭제되었습니다.');
                $(this).remove();

            }else{
                alert('파일이 삭제가 되지 않았습니다.');
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
