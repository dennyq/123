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
    <c:if test="${empty data && changePwd ne 'Y'}">
      광고등록
    </c:if>
    <c:if test="${not empty data && changePwd ne 'Y'}">
      광고상세
    </c:if>
    <c:if test="${changePwd eq 'Y'}">
      비밀번호변경
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
    <a id="saveBtn" class="btn btn-blue-green btn-flat md-height">가입하기</a>
    <a href="<c:url value="/adinfo/list"/>" class="btn btn-blue-green btn-flat md-height">목록</a>
  </center>

</c:if>
<c:if test="${not empty data && changePwd ne 'Y'}">
  <center>
    <a id="saveBtn" class="btn btn-blue-green btn-flat md-height">저장</a>
    <a id="delBtn" class="btn btn-green btn-flat md-height showEditor">삭제</a>
    <a id="changePagePwdBtn" class="btn btn-blue-green btn-flat md-height">비밀번호 변경</a>
  </center>
</c:if>
  <c:if test="${not empty data && changePwd eq 'Y'}">
    <center>
      <a id="changePwdBtn" class="btn btn-blue-green btn-flat md-height">저장</a>
    </center>
  </c:if>
</form>

<script>
  var searchAddressAndSave = function(){
   var address = $('#address').val();
    if (address != null && address != ''){
      $.ajax({
        url: "https://apis.daum.net/local/geo/addr2coord?apikey=3449b8f92183a8efbf5dafe9ceb3c430&q="+encodeURIComponent(address)+"&output=json",
        dataType: 'jsonp',
        jsonpCallback: "myCallback",
        success: function(data) {
          console.log('성공 - ', data);
          if(data){
            if(data.channel){
              if(data.channel.item.length>=1){
                if(data.channel.item[0].lat){
                  var lat = data.channel.item[0].lat;
                  console.log('lat - ', lat);
                  $('#latitude').val(lat);
                }
                if(data.channel.item[0].lng){
                  var lng = data.channel.item[0].lng;

                  console.log('lng - ', lng);

                  $('#longitude').val(lng);
                }


              }

            }

          }

          saveFunction();
        },
        error: function(xhr) {
          console.log('실패 - ', xhr);
        }
      });
    }else{
      saveFunction();
    }

  }
  var searchAddress = function(){
    var address = $('#address').val();
    if (address != null && address != '') {
      $.ajax({
        url: "https://apis.daum.net/local/geo/addr2coord?apikey=3449b8f92183a8efbf5dafe9ceb3c430&q="+encodeURIComponent(address)+"&output=json",
        dataType: 'jsonp',
        jsonpCallback: "myCallback",
        success: function (data) {
          console.log('성공 - ', data);
          if (data) {
            if (data.channel) {
              if (data.channel.item.length >= 1) {
                console.log(data.channel.item.length );
                if (data.channel.item[0].lat) {
                  var lat = data.channel.item[0].lat;
                  console.log('lat - ', lat);
                  $('#latitude').val(lat);
                }
                if (data.channel.item[0].lng) {
                  var lng = data.channel.item[0].lng;

                  console.log('lng - ', lng);

                  $('#longitude').val(lng);
                }


              }

            }

          }

//        saveFunction();
        },
        error: function (xhr) {
          console.log('실패 - ', xhr);
        }
      });
    }

  }
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

    $('#address').keydown(function (key) {
      if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        searchAddress();
      }
    });
    $('#address').focusout(function (key) {
        searchAddress();
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


      var latitude = $('#latitude').val();
      var oldlatitude = $('#oldlatitude').val();
      var longitude = $('#longitude').val();
      var oldlongitude = $('#oldlongitude').val();
      var address = $('#address').val();
//      console.log(latitude);
//      console.log(oldlatitude);
      if ((latitude != oldlatitude || longitude != oldlongitude )){
        saveFunction();
      }else{
        searchAddressAndSave();
      }


    });

    $('#id_check').click(function(){
      if($('#memberid').val() ==''){
        alert('아이디를 입력해주세요');
        $('#memberid').focus();
        return false;
      }
      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="/adinfo/idCheck"/>', req, function (data) {
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
