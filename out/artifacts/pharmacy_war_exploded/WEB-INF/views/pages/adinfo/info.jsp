<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>사용자 정보 </title>
</head>
<body>
<form id="detailFrm" class="form-horizontal" action="<c:url value="/member/saveInfo"/>" method="post">
<section class="content-header">
  <h1>
    사용자 정보
  </h1>
  <div class="breadcrumb-line"></div>

  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/member/list"/>">사용자 정보</a></li>
    <li ><a href="<c:url value="/member/detail/${data.memberid}"/>">사용자 정보
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
              <h3 class="box-title">사용자 정보</h3>
            </div>
            <div id="progressIndicator" style="display: none"></div>

            <!-- form start -->

              <div class="box-body bg-gray">

                <input type="hidden"  name="isNew" value="N"/>
                <div class="col-md-12">
                  <div class="form-group">
                    <label for="memberid" class="col-sm-2 ">아이디</label>

                    <div class="col-sm-3">
                      <input name="memberid"  id="memberid" placeholder="아이디" class="form-control" value="${data.memberid}" readonly style="background-color: #fafafa;border: none;">
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
                    <label for="telephone" class="col-sm-4 ">전화번호</label>

                    <div class="col-sm-6">
                      <input name="telephone"  id="telephone" placeholder="전화번호" class="form-control" value="${data.telephone}">
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="handphone" class="col-sm-4 ">휴대폰</label>

                    <div class="col-sm-6">
                      <input name="handphone"  id="handphone" placeholder="휴대폰" class="form-control" value="${data.handphone}">
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
                    <label for="joindate" class="col-sm-4 ">가입일자</label>

                    <div class="col-sm-6">
                      <input name="joindate"  id="joindate" placeholder="가입일자" class="form-control datepicker" value="${data.joindate}">
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
                </div>


            </div>






          </div><!-- /.box -->
        </div>

        <div class="col-md-12">
          <div class="">

            <div id="progressIndicator" style="display: none"></div>

            <!-- form start -->

            <div class="box-body bg-gray"  style="border-top: 1px solid #ececec">

              <input type="hidden"  name="isNew" value="N"/>


              <div class="col-md-6">

                <div class="form-group">
                  <label for="cameracount" class="col-sm-4 ">카메라갯수</label>

                  <div class="col-sm-6">
                    <input name="cameracount"  id="cameracount"  placeholder="카메라갯수" class="form-control" value="${data.cameracount}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="camerainfo1" class="col-sm-4 ">1번 카메라정보</label>

                  <div class="col-sm-6">
                    <input name="camerainfo1"  id="camerainfo1" placeholder="1번 카메라정보" class="form-control" value="${data.camerainfo1}">
                  </div>
                </div>

                <div class="form-group">

                  <label for="camerainfo2" class="col-sm-4 ">2번 카메라정보</label>

                  <div class="col-sm-6">
                    <input name="camerainfo2"  id="camerainfo2" placeholder="2번 카메라정보" class="form-control " value="${data.camerainfo2}">
                  </div>

                </div>
                <div class="form-group">
                  <label for="camerainfo4" class="col-sm-4 ">4번 카메라정보</label>

                  <div class="col-sm-6">
                    <input name="camerainfo4"  id="camerainfo4" placeholder="4번 카메라정보" class="form-control " value="${data.camerainfo4}">
                  </div>

                </div>
                <div class="form-group">
                  <label for="camerainfo6" class="col-sm-4 ">6번 카메라정보</label>

                  <div class="col-sm-6">
                    <input name="camerainfo6"  id="camerainfo6" placeholder="6번 카메라정보" class="form-control " value="${data.camerainfo6}">
                  </div>

                </div>
                <div class="form-group">
                  <label for="listenport" class="col-sm-4 ">8번 카메라정보</label>

                  <div class="col-sm-6">
                    <input name="camerainfo8"  id="camerainfo8" placeholder="8번 카메라정보" class="form-control" value="${data.camerainfo8}">
                  </div>
                </div>

              </div>

              <div class="col-md-6 right">
                <div class="form-group">
                  <label for="ipaddress" class="col-sm-4 ">공유기 IP주소</label>

                  <div class="col-sm-6">
                    <input name="ipaddress"  id="ipaddress" placeholder="공유기 IP주소" class="form-control" value="${data.ipaddress}">
                  </div>

                </div>
                <div class="form-group">
                  <label for="listenport" class="col-sm-4 ">리슨포트</label>

                  <div class="col-sm-6">
                    <input name="listenport" id="listenport" placeholder="리슨포트" class="form-control"
                           value="${data.listenport}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="listenport" class="col-sm-4 ">3번 카메라정보</label>

                  <div class="col-sm-6">
                    <input name="camerainfo3"  id="camerainfo3" placeholder="3번 카메라정보" class="form-control" value="${data.camerainfo3}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="listenport" class="col-sm-4 ">5번 카메라정보</label>

                  <div class="col-sm-6">
                    <input name="camerainfo5"  id="camerainfo5" placeholder="5번 카메라정보" class="form-control" value="${data.camerainfo5}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="listenport" class="col-sm-4 ">7번 카메라정보</label>

                  <div class="col-sm-6">
                    <input name="camerainfo7"  id="camerainfo7" placeholder="7번 카메라정보" class="form-control" value="${data.camerainfo7}">
                  </div>
                </div>

              </div>

              <div style="float: right;color:#e08e0b">
                카메라정보 > 카메라포트:접속아이디:패스워드 ex)4520:admin:4321
              </div>
              </div>




          </div><!-- /.box -->
        </div>
      </div><!-- /.row -->
    </section>

  </div>

</section>



  <c:if test="${not empty data}">
    <center>
      <a id="saveBtn" class="btn"><img src="/imgs/bt_save.png" alt="저장"></a>



    </center>

  </c:if>
</form>

<script>
  <!-- //bind start -->
  $(function(){
    $('.datepicker').datepicker({
      format: "yyyy.mm.dd",
      startDate: '+0d',
      todayBtn: true
    });

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active');

      var menu = $(this).attr('menu');
      if(menu=='사용자정보'){
        $(this).addClass('active');
        $('.content-header>h1').text(menu);
      }
    });

    $('#delBtn').click(function(){
      var req = {};
      req = $(this).closest('form').serialize();
      $als.execute('<c:url value="/member/delete"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('삭제되었습니다.');
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
