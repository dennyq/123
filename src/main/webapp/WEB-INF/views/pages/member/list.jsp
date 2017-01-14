<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>회원 관리</title>
</head>
<body>
  <section class="content-header">
    <h1>
      회원 관리
    </h1>
    <div class="breadcrumb-line"></div>
    <ol class="breadcrumb">
      <li><a href="<c:url value="/"/>">HOME</a></li>
      <li ><a href="<c:url value="/member/list"/>">회원 정보</a></li>
      <li ><a href="<c:url value="/member/list"/>">회원 정보 조회</a></li>
    </ol>
  </section>

  <!-- Main content -->
  <section class="content">
    <!-- row start -->
    <div class="row">
      <!-- col-md-12 start -->
      <div class="col-md-12">
        <!-- bottom-25 start -->
        <div class="bottom-25">
          <div class="box-header-sm">
            <h3 class="box-title">회원 조회</h3>
          </div>
          <!-- form start -->
          <form id="searchFrm" action="<c:url value="/member/search"/>" class="form-horizontal" method="post">
            <!-- box-body start -->
            <div class="box-body bg-gray">
              <!-- left col-md-6 start -->
              <div class="col-md-6">
                <div class="form-group">
                  <label for="sch_memberid" class="col-sm-4 ">아이디</label>
                  <div class="col-sm-6">
                    <input name="sch_memberid"  id="sch_memberid" placeholder="아이디" class="form-control" value="${sch_memberid}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_name" class="col-sm-4 ">회원명</label>
                  <div class="col-sm-6">
                    <input name="sch_name"  id="sch_name" placeholder="회원명" class="form-control" value="${sch_name}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_telephone" class="col-sm-4 ">자택전화</label>
                  <div class="col-sm-6">
                    <input name="sch_telephone"  id="sch_telephone" placeholder="자택전화" class="form-control" value="${sch_telephone}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_handphone" class="col-sm-4 ">휴대폰</label>
                  <div class="col-sm-6">
                    <input name="sch_handphone"  id="sch_handphone" placeholder="휴대폰" class="form-control" value="${sch_handphone}">
                  </div>
                </div>
              </div>
              <!-- //left col-md-6 end -->
              <!-- right col-md-6 start -->
              <div class="col-md-6 right">
                <div class="form-group">
                  <label for="sch_joindate" class="col-sm-4 ">가입일자</label>
                  <div class="col-sm-6">
                    <input name="sch_joindate"  id="sch_joindate" placeholder="가입일자" class="form-control" value="${sch_joindate}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_usestartdate" class="col-sm-4 ">사용시작일자</label>
                  <div class="col-sm-6">
                    <input name="sch_usestartdate"  id="sch_usestartdate" placeholder="사용시작일자" class="form-control" value="${sch_usestartdate}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_useenddate" class="col-sm-4 ">사용종료일자</label>
                  <div class="col-sm-6">
                    <input name="sch_useenddate"  id="sch_useenddate" placeholder="사용종료일자" class="form-control" value="${sch_useenddate}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_introduce" class="col-sm-4 ">소개</label>
                  <div class="col-sm-6">
                    <input name="sch_introduce"  id="sch_introduce" placeholder="소개" class="form-control" value="${sch_introduce}">
                  </div>
                </div>
              </div>
              <!--// right col-md-6 end-->
            </div>
            <!--// box-body end -->
            <div class="btn-box">
              <center>
                  <a id="searchBtn" class="pointer btn btn-blue-green btn-flat md-height" href="<c:url value="/member/detail"/>">조회</a>
              </center>
            </div>
          </form>
          <!--// form end-->
        </div>
      </div>
      <div class="box-header-sm">
        <h3 class="box-title">회원 조회 결과</h3>
      </div>
      <div class="col-xs-12">
        <div class="">

          <div class="box-body table-responsive no-padding">
            <table class="table table-hover pointer">
              <colgroup>
                <col width="8px"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
              </colgroup>
              <thead>
                <tr class="bg-gray text-align-center">
                  <td>번호</td>
                  <td>아이디</td>
                  <td>회원명</td>
                  <td>구분</td>
                  <td>전화번호</td>
                  <td>사용시작일자</td>
                  <td>사용종료일자</td>
                  <td>폰번호</td>
                  <td>소개</td>
                  <td>주소</td>
                </tr>
              </thead>
              <tbody>
              <c:if test="${not empty rows}">
                <c:forEach items="${rows}" var="items" varStatus="idx">
                  <input type="hidden" id="isClicked"/>
                  <tr class="clickTr" idx="${items.memberid}">
                    <td>${total-(pageTimes)-idx.count+1}</td>
                    <td>${items.memberid}</td>
                    <td>${items.name}</td>
                    <td>${items.gubun}</td>
                    <td>${items.telephone}</td>
                    <td>${items.usestartdate}</td>
                    <td>${items.useenddate}</td>
                    <td>${items.handphone}</td>
                    <td>${items.introduce}</td>
                    <td>${items.address}</td>
                  </tr>
                </c:forEach>
              </c:if>
              <c:if test="${empty rows}">
                <tr>
                  <td colspan="10">데이터가 없습니다.</td>
                </tr>
              </c:if>
              </tbody>
            </table>

          </div>
          <div class="box-footer clearfix">

          </div>
        </div>
        <center>
          <div class="btn_bottom" style="margin-top: -20px;">
            ${paging}
          </div>
        </center>
      </div>


    </div><!-- /.row -->
  </section>
  <!-- /.content -->
<center>
  <div class="btn-box">
    <a id="addBtn" class="pointer btn btn-blue-green btn-flat md-height" href="<c:url value="/member/detail"/>">등록</a>
    <a id="selectBtn" class="pointer btn btn-default btn-flat md-height" > 수정</a>
  </div>
</center>
<script>
  <!--//bind start -->
  var fn_go_page = function(page){
    $("#page").val(page);
    fn_search();
  };

  function fn_search(){
    $('#searchFrm').submit();
  }
  $(function() {

    setClickedMenuBold(1);

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active');
      var menu = $(this).attr('menu');
      if(menu=='회원관리'){
        $(this).addClass('active')
      }
    });

    $('#searchBtn').click(function(){
      $('#searchFrm').submit();
    });

    $('.clickTr').on('click',function(){
      var idx = $(this).attr('idx');
      var trid = $('.clickTr').attr('idx');
      $('.clickTr').each(function(index){
        $(this).find('td').removeClass('click-bg');
        $(this).find('th').removeClass('click-bg');
        var trid = $(this).attr('idx');
        if(idx==trid){
          $(this).find('td').addClass('click-bg');
          $(this).find('th').addClass('click-bg');
        }
      });
      $('#isClicked').val(idx);
    });

    $('.clickTr').on('dblclick',function(){
      var idx = $(this).attr('idx');
      location.href = '/member/detail/' + idx;
    });


    $('#selectBtn').click(function(){
      var idx = $('#isClicked').val();
      console.log('idx : '+idx);
      location.href = '/member/detail/' + idx;

      <%--var change_uid = $('#isClicked').val();--%>
      <%--location.href = '<c:url value="/member/change/"/>'+change_uid;--%>
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
      var page = $(this).attr('page');
      location.href = '/member/list/' + page;
    });

  });
  <!-- bind end -->

</script>
</body>
</html>
