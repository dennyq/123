<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>회원 관리</title>
</head>
<body>
<form id="detailFrm" class="form-horizontal" action="<c:url value="/member/save"/>" method="post">
<section class="content-header">
  <h1>
    회원 <c:if test="${not empty data}">상세</c:if>
    <c:if test="${empty data}">등록</c:if>
  </h1>
  <div class="breadcrumb-line"></div>

  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/member/list"/>">회원</a></li>
    <li ><a href="<c:url value="/member/detail/${data.memberid}"/>">회원
<c:if test="${not empty data}">상세</c:if>
<c:if test="${empty data}">등록</c:if>
      </a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="paddingInside">
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="">
            <div class="box-header-sm">
              <h3 class="box-title"<img src="/imgs/h3_bullet.png"/>회원</h3>
            </div>
            <div id="progressIndicator" style="display: none"></div>

            <!-- form start -->
            <%--<form id="detailFrm" class="form-horizontal" method="post">--%>
            <div class="box-body bg-gray">
<c:if test="${empty data}">
  <input type="hidden"  name="isNew" value="Y"/>
              <%--<div class="col-md-12">--%>

                <%--</div>--%>

              <div class="col-md-6">

                <div class="form-group">
                  <label for="memberid" class="col-sm-4 ">아이디</label>

                  <div class="col-sm-3">
                    <input name="memberid"  id="memberid" placeholder="아이디" class="form-control">
                  </div>
                  <a id="id_check" class="btn">사용유무검사</a>
                  <input type="hidden" id="idCheck" value="N"/>
                </div>

                <div class="form-group">
                  <label for="password" class="col-sm-4 ">비밀번호</label>

                  <div class="col-sm-6">
                    <input name="password" type="password"  id="password" placeholder="비밀번호" class="form-control">
                  </div>
                </div>

                <div class="form-group">
                  <label for="name" class="col-sm-4 ">회원명</label>

                  <div class="col-sm-6">
                    <input name="name"  id="name" placeholder="회원명" class="form-control">
                  </div>
                </div>

                <div class="form-group">
                  <label for="address" class="col-sm-4 ">주소</label>

                  <div class="col-sm-6">
                    <input name="address"  id="address" placeholder="주소" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label for="telephone" class="col-sm-4 ">전화번호</label>

                  <div class="col-sm-6">
                    <input name="telephone"  id="telephone" placeholder="전화번호" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label for="usestartdate" class="col-sm-4 ">사용시작일자</label>

                  <div class="col-sm-6">
                    <input name="usestartdate"  id="usestartdate" placeholder="사용시작일자" class="form-control datepicker">
                  </div>

                </div>


              </div>

              <div class="col-md-6 right">
                <div class="form-group">
                  <label for="name" class="col-sm-4 ">구분선택</label>

                  <div class="col-sm-6">
                    <input type="radio" name="name"  id="type" placeholder="이름" class="">약국&nbsp;
                    <input type="radio" name="name"  id="type" placeholder="이름" class="">병원
                  </div>
                </div>
                <div class="form-group">
                  <label for="cfrm_password" class="col-sm-4 ">비밀번호확인</label>

                  <div class="col-sm-6">
                    <input name="cfrm_password" id="cfrm_password" placeholder="비밀번호확인" class="form-control" type="password" >
                  </div>

                </div>
                <div class="form-group">
                  <label for="address_etc" class="col-sm-4 ">기타주소입력</label>

                  <div class="col-sm-6">
                    <input name="address_etc"  id="address_etc" placeholder="기타주소입력" class="form-control datepicker">
                  </div>

                </div>
                <div class="form-group">
                  <label for="handphone" class="col-sm-4 ">휴대폰</label>

                  <div class="col-sm-6">
                    <input name="handphone"  id="handphone" placeholder="휴대폰" class="form-control">
                  </div>
                </div>


                <div class="form-group">
                  <label for="useenddate" class="col-sm-4 ">사용종료일자</label>

                  <div class="col-sm-6">
                    <input name="useenddate"  id="useenddate" placeholder="사용종료일자" class="form-control datepicker">
                  </div>

                </div>
                <div class="form-group">
                  <label for="introduce" class="col-sm-4 ">회원기타소개</label>

                  <div class="col-sm-6">
                    <input name="introduce"  id="introduce" placeholder="회원기타소개" class="form-control datepicker" value="${data.introduce}">
                  </div>

                </div>
              </div>

</c:if>
              <c:if test="${not empty data}">
                <input type="hidden"  name="isNew" value="N"/>
                <div class="col-md-12">
                  <div class="form-group">
                    <label for="memberid" class="col-sm-2 ">아이디</label>

                    <div class="col-sm-3">
                      <input name="memberid"  id="memberid" placeholder="아이디" class="form-control" value="${data.memberid}">
                    </div>

                  </div>
                </div>

                <div class="col-md-6">

                  <div class="form-group">
                    <label for="password" class="col-sm-4 ">비밀번호</label>

                    <div class="col-sm-6">
                      <input name="password"  id="password" type="password" placeholder="비밀번호" class="form-control" >
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="name" class="col-sm-4 ">이름</label>

                    <div class="col-sm-6">
                      <input name="name"  id="name" placeholder="이름" class="form-control" value="${data.name}">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="name" class="col-sm-4 ">주소</label>

                    <div class="col-sm-6">
                      <input name="name"  id="name" placeholder="주소" class="form-control" value="${data.name}">
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="telephone" class="col-sm-4 ">전화번호</label>

                    <div class="col-sm-6">
                      <input name="telephone"  id="telephone" placeholder="전화번호" class="form-control" value="${data.telephone}">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="usestartdate" class="col-sm-4 ">사용시작일자</label>

                    <div class="col-sm-6">
                      <input name="usestartdate"  id="usestartdate" placeholder="사용시작일자" class="form-control datepicker" value="${data.usestartdate}">
                    </div>

                  </div>

                </div>

                <div class="col-md-6 right">
                  <div class="form-group">
                    <label for="cfrm_password" class="col-sm-4 ">비밀번호확인</label>

                    <div class="col-sm-6">
                      <input name="cfrm_password"  id="cfrm_password" type="password" placeholder="비밀번호확인" class="form-control" value="${data.cfrm_password}">
                    </div>

                  </div>

                  <div class="form-group">
                    <label for="joindate" class="col-sm-4 ">기타 주소입력</label>

                    <div class="col-sm-6">
                      <input name="joindate"  id="joindate" placeholder="기타 주소입력" class="form-control datepicker" value="${data.joindate}">
                    </div>

                  </div>

                  <div class="form-group">
                    <label for="handphone" class="col-sm-4 ">휴대폰</label>

                    <div class="col-sm-6">
                      <input name="handphone"  id="handphone" placeholder="휴대폰" class="form-control" value="${data.handphone}">
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="usestartdate" class="col-sm-4 ">사용시작일자</label>

                    <div class="col-sm-6">
                      <input name="usestartdate"  id="usestartdate" placeholder="사용시작일자" class="form-control datepicker" value="${data.usestartdate}">
                    </div>

                  </div>

                  <div class="form-group">
                    <label for="useenddate" class="col-sm-4 ">사용종료일자</label>

                    <div class="col-sm-6">
                      <input name="useenddate"  id="useenddate" placeholder="사용종료일자" class="form-control datepicker" value="${data.useenddate}">
                    </div>

                  </div>

                  <div class="form-group">
                    <label for="useenddate" class="col-sm-4 ">회원기타소개</label>

                    <div class="col-sm-6">
                      <input name="useenddate"  id="useenddate" placeholder="회원기타소개" class="form-control datepicker" value="${data.useenddate}">
                    </div>

                  </div>
                </div>


              </c:if>

            </div>






            <!-- form end -->
          </div><!-- /.box -->


        </div><%--md12--%>

      </div><!-- /.row -->
    </section>

  </div>

</section>


<c:if test="${empty data}">
  <center>
    <a id="saveBtn" class="btn btn-green btn-flat md-height">저장</a>
    <a href="<c:url value="/member/list"/>" class="btn btn-green btn-flat md-height">목록</a>
  </center>

</c:if>
  <c:if test="${not empty data}">
    <center>
      <a id="saveBtn" class="btn"><img src="/imgs/bt_save.png" alt="저장"></a>
      <a id="delBtn" class="btn btn-green btn-flat md-height showEditor">삭제</a>
      <a id="initailizePwdBtn" class="btn "><img src="/imgs/bt_pw-reset.png" alt="비번초기화"></a>


    </center>

  </c:if>
</form>

<script>
  <!-- //bind start -->
  $(function(){

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active')
//      console.log(this);
      var menu = $(this).attr('menu');
      if(menu=='회원관리'){
        $(this).addClass('active')
      }
    })

    $('.datepicker').datepicker({
      format: "yyyy.mm.dd",
      startDate: '+0d',
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

    $('#saveBtn').click(function(){
      if($('#memberid').val() ==''){
        alert('아이디를 입력해주세요');
        $('#memberid').focus();
        return false;
      }
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
      if($('#name').val() ==''){
        alert('이름을 입력해주세요');
        $('#name').focus();
        return false;
      }
      if($('#joindate').val() ==''){
        alert('가입일자를 입력해주세요');
        $('#joindate').focus();
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


      if($('#password').val() != $('#cfrm_password').val()){
        alert('비밀번호가 일치하지 않습니다.');
        $('#password').focus();
        return false;
      }
<c:if test="${empty data}">
            if($('#idCheck').val() != 'Y'){
        alert('아이디 중복검사를 해주세요.');

        return false;
      }
  </c:if>

      $('#detailFrm').submit();


    });

    $('#id_check').click(function(){
      if($('#memberid').val() ==''){
        alert('아이디를 입력해주세요');
        $('#memberid').focus();
        return false;
      }
      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="/member/idCheck"/>', req, function (data) {
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

    $('#initailizePwdBtn').click(function(){

      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="/member/initailizePwd"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('초기화되었습니다.');
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
