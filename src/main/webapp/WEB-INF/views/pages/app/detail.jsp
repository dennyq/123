<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>세부정보</title>
</head>
<body class="margin-padding-none">
<form id="detailFrm" class="form-horizontal margin-padding-none" action="<c:url value="/pc/detail"/>" method="post">
    <input type="hidden" id="setmystore" name="setmystore" value="${param['setmystore']}">
    <center>
        <section class="content-header margin-padding-none" style="margin-top: -37px!important;">
            <h1 class="big-font">
                <span class="marinblue">세부정보</span>보기
            </h1>
        </section>
    </center>
<!-- Main content -->
<section class="content margin-padding-none">
  <div class="paddingInside margin-padding-none">
      <div class="row">
        <div>
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
    <div id="buttons" style="margin-top: 20px"></div>
    <center>
        <%--<OBJECT ID="KC7Ax" CLASSID="CLSID:DBFC0953-8254-46A8-A034-0E674E74D932" STYLE="WIDTH:0px; HEIGHT:0px; ">
        </OBJECT>--%>
        <c:if test="${not empty data.telephone}">
            <a href="tel:${data.telephone}" id="callBtn" class="btn btn-blue-green btn-flat md-height">전화걸기</a>
        </c:if>
        <c:if test="${not empty data.handphone}">
            <a href="sms:${data.handphone}" id="sendMsgBtn" class="btn btn-blue-green btn-flat md-height">메시지보내기</a>
        </c:if>
        <a id="kakaoBtn" class="btn btn-blue-green btn-flat md-height">카톡실행</a>

    </center>
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

    var latitude = $('#latitude').val();
    var longitude = $('#longitude').val();
//    console.log(latitude.split('.')[0].length)
//    console.log(longitude.split('.')[0].length)
    if(latitude.split('.')[0].length>4){
      alert('올바른 위도값이 아닙니다.');
      $('#latitude').focus();
      return false;
    }
    if(longitude.split('.')[0].length>4){
      alert('올바른 경도값이 아닙니다.');
      $('#longitude').focus();
      return false;
    }

    <%--if($('#memberid').val() ==''){--%>
      <%--alert('아이디를 입력해주세요');--%>
      <%--$('#memberid').focus();--%>
      <%--return false;--%>
    <%--}--%>
    <%--<c:if test="${empty data}">--%>
    <%--if($('#password').val() ==''){--%>
      <%--alert('비밀번호를 입력해주세요');--%>
      <%--$('#password').focus();--%>
      <%--return false;--%>
    <%--}--%>
    <%--if($('#cfrm_password').val() ==''){--%>
      <%--alert('비밀번호확인을 입력해주세요');--%>
      <%--$('#cfrm_password').focus();--%>
      <%--return false;--%>
    <%--}--%>
    <%--</c:if>--%>
    <%--if($('#name').val() ==''){--%>
      <%--alert('이름을 입력해주세요');--%>
      <%--$('#name').focus();--%>
      <%--return false;--%>
    <%--}--%>
    <%--if($('#gubun').val() ==''){--%>
      <%--alert('약국/병원 구분을 입력해주세요');--%>
      <%--$('#gubun').focus();--%>
      <%--return false;--%>
    <%--}--%>

    <%--if($('#usestartdate').val() ==''){--%>
      <%--alert('사용시작일자를 입력해주세요');--%>
      <%--$('#usestartdate').focus();--%>
      <%--return false;--%>
    <%--}--%>
    <%--if($('#useenddate').val() ==''){--%>
      <%--alert('사용종료일자를 입력해주세요');--%>
      <%--$('#useenddate').focus();--%>
      <%--return false;--%>
    <%--}--%>

    <%--<c:if test="${empty data}">--%>
    <%--if($('#password').val() != $('#cfrm_password').val()){--%>
      <%--alert('비밀번호가 일치하지 않습니다.');--%>
      <%--$('#password').focus();--%>
      <%--return false;--%>
    <%--}--%>

    <%--if($('#idCheck').val() != 'Y'){--%>
      <%--alert('아이디 중복검사를 해주세요.');--%>

      <%--return false;--%>
    <%--}--%>
    <%--</c:if>--%>
    <%--<c:if test="${empty data}">--%>

    <%--</c:if>--%>
    $('#detailFrm').submit();

  }
  $(function(){

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active');
      var menu = $(this).attr('menu');
      if(menu=='회원관리'){
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
      $als.execute('<c:url value="/member/delete"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('삭제되었습니다.');
          location.href='/member/list';
        }
      }, function (err) {
        alert(err.result_message);
      });

    });

    //저장
    $('#saveBtn').click(function(){

        var frm = $('#detailFrm');
        var getAction = frm.attr('action');
        var memberId = $('#memberid').val();
        //alert(memberId);
        //location.href = getAction+'/'+memberId  + '?setmystore='+memberId;
        $('#setmystore').val(memberId);
        frm.attr('action',getAction+'/'+memberId);
        frm.submit();
//        OnRegisterID()
//
//      var latitude = $('#latitude').val();
//      var oldlatitude = $('#oldlatitude').val();
//      var longitude = $('#longitude').val();
//      var oldlongitude = $('#oldlongitude').val();
//      var address = $('#address').val();
////      console.log(latitude);
////      console.log(oldlatitude);
//      if ((latitude != oldlatitude || longitude != oldlongitude )){
//        saveFunction();
//      }else{
//        searchAddressAndSave();
//      }
//

    });
});


  <!-- bind end -->

</script>
</body>
</html>
