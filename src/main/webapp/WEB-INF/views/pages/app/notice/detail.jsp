<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>

<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>공지사항 관리</title>
  <script src="/ckeditor/ckeditor.js"></script>
  <style>
    .content-header > .breadcrumb{display: none}
    section.content-header > h1{display: none}
  </style>
</head>
<body>
<form id="detailFrm" class="form-horizontal" action="<c:url value="${thisPath}/save"/>" method="post" enctype="multipart/form-data" >

  <!-- Main content -->
  <section class="content">
    <div class="paddingInside">
      <div class="row">
        <%--<div class="col-md-12">--%>
          <div id="progressIndicator" style="display: none"></div>

            <!-- input start -->
            <input type="hidden" name="isNew" value="N"/>

            <%--<div class="form-group">--%>
                <%--<div class="row" style="font-weight: bold;padding: 0 15px 0 15px;font-size: 15px;border-bottom: 1px solid #eaeaea">--%>
                <%--${data.noticetitle}--%>
              <%--</div>--%>
            <%--</div>--%>
            <div class="form-group">
              <div class="row" style="padding: 0 15px 0 15px;">

                  ${data.noticecontent}

              </div>
            </div>
          </div>


    </div><!-- //.paddingInside -->
  </section>
  <div id="map" style="width:100%;height:350px;display: none"></div>

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

    $('.deleteFile').click(function(){
      var noticeindex = $(this).attr('noticeindex');
      var sequencenum = $(this).attr('sequencenum');
      var filename = $(this).attr('filename');
      console.log('noticeindex : '+noticeindex);
      console.log('sequencenum : '+sequencenum);
      var req = {};
      req.noticeindex = noticeindex;
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
