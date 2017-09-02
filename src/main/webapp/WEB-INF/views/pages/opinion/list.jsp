<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>의견올리기 관리</title>
</head>
<body>
  <section class="content-header">
    <h1>
      의견올리기 관리
    </h1>
    <div class="breadcrumb-line"></div>
    <ol class="breadcrumb">
      <li><a href="<c:url value="/"/>">HOME</a></li>
      <li ><a href="<c:url value="/opinion/list"/>">의견올리기 정보</a></li>
      <li ><a href="<c:url value="/opinion/list"/>">의견올리기 정보 조회</a></li>
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
            <h3 class="box-title">의견올리기 조회</h3>
          </div>
          <!-- form start -->
          <form id="searchFrm" action="<c:url value="/opinion/search"/>" class="form-horizontal" method="post">
            <!-- box-body start -->
            <div class="box-body bg-gray">
              <!-- left col-md-6 start -->
              <div class="col-md-6">
                <div class="form-group">
                  <label for="sch_opinionkey" class="col-sm-4 ">아이디</label>
                  <div class="col-sm-6">
                    <input name="sch_opinionkey"  id="sch_opinionkey" placeholder="아이디" class="form-control" value="${sch_opinionkey}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_name" class="col-sm-4 ">의견올리기명</label>
                  <div class="col-sm-6">
                    <input name="sch_name"  id="sch_name" placeholder="의견올리기명" class="form-control" value="${sch_name}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_telephone" class="col-sm-4 ">전화번호</label>
                  <div class="col-sm-6">
                    <input name="sch_telephone"  id="sch_telephone" placeholder="전화번호" class="form-control" value="${sch_telephone}">
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
                <%--<div class="form-group">--%>
                  <%--<label for="sch_regtime" class="col-sm-4 ">가입일자</label>--%>
                  <%--<div class="col-sm-6">--%>
                    <%--<input name="sch_regtime"  id="sch_regtime" placeholder="가입일자" class="form-control datepicker" value="${sch_regtime}">--%>
                  <%--</div>--%>
                <%--</div>--%>
                <div class="form-group">
                  <label for="sch_usestartdate" class="col-sm-4 ">사용시작일자</label>
                  <div class="col-sm-6">
                    <input name="sch_usestartdate"  id="sch_usestartdate" placeholder="사용시작일자" class="form-control datepicker" value="${sch_usestartdate}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_useenddate" class="col-sm-4 ">사용종료일자</label>
                  <div class="col-sm-6">
                    <input name="sch_useenddate"  id="sch_useenddate" placeholder="사용종료일자" class="form-control datepicker" value="${sch_useenddate}">
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
            <div class="btn-box centeringContainer " >
              <span class="centered ">
                  <a id="searchBtn" class="pointer btn btn-blue-green btn-flat md-height" >조회</a>
              </span>
              <span class="right inline" >
                <a id="insertFileBtn" class="pointer btn btn-blue-green btn-flat md-height" >일괄등록</a>
              </span>
            </div>
          </form>
          <!--// form end-->
        </div>
      </div>

      <div class="col-md-12">
        <div class="">
          <div class="box-header-sm">
            <h3 class="box-title">의견올리기 조회 결과</h3>

                    번호,구분,이름,전화번호,휴대폰번호,진료과목,근무시간,슬로건,소개,일반의견제목,일반의견내용,작성자이름,등록시간,삭제
          </div>
          <div class="box-body table-responsive no-padding">
            <table class="table table-hover pointer">
              <colgroup>
                <col width="1%"/><%--구분--%>
                <col width="7%"/><%--이름--%>
                <col width="7%"/><%--전화번호--%>
                <col width="5%"/><%--휴대폰번호--%>
                <col width="10%"/><%--진료과목--%>
                <col width="10%"/><%--근무시간--%>
                <col width="10%"/><%--슬로건--%>
                <col width="8%"/><%--소개--%>
                <col width="8%"/><%--일반의견제목--%>
                <col width="13%"/><%--일반의견내용--%>
                <col width="5%"/><%--작성자이름--%>
                <col width="5%"/><%--등록시간--%>
                <col width="8%"/><%--삭제--%>

                <col width="*"/><%----%>
              </colgroup>
              <thead>
                <tr class="bg-gray text-align-center">
                  <td>구분</td>
                  <td>이름</td>
                  <td>전화번호</td>
                  <td>휴대폰번호</td>
                  <td>진료과목</td>
                  <td>근무시간</td>
                  <td>슬로건</td>
                  <td>소개</td>
                  <td>일반의견제목</td>
                  <td>일반의견내용</td>
                  <td>작성자이름</td>
                  <td>등록시간</td>
                  <td>삭제</td>
                </tr>
              </thead>
              <tbody>
              <c:if test="${not empty rows}">
                <c:forEach items="${rows}" var="items" varStatus="idx">
                  <input type="hidden" id="isClicked"/>
                  <tr class="clickTr" idx="${items.opinionkey}">
                    <td>${total-(pageTimes)-idx.count+1}</td>
                    <td>${items.opinionkey}</td>
                    <td>${items.name}</td>
                    <td><c:if test="${items.gubun eq 1}">약국</c:if><c:if test="${items.gubun eq 2}">병원</c:if></td>
                    <td>${items.telephone}</td>
                    <td> ${items.handphone} </td>
                    <td> ${items.longitude} </td>
                    <td>${items.usestartdate}</td>
                    <td>${items.useenddate}</td>
                    <td>${items.handphone}</td>
                    <td>
                      ${fn:substring(items.introduce, 0, 8)}
                      <c:if test="${fn:length(items.introduce)>8}">...</c:if>

                    </td>
                    <td>
                        ${fn:substring(items.address, 0, 8)}
                      <c:if test="${fn:length(items.address)>8}">...</c:if>
                    </td>
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
    <a id="addBtn" class="pointer btn btn-blue-green btn-flat md-height" href="<c:url value="/opinion/detail"/>">등록</a>
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
    $('.datepicker').datepicker({
      format: "yyyy.mm.dd",
//      startDate: '+0d',
      todayBtn: true
    });

    setClickedMenuBold(1);

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active');
      var menu = $(this).attr('menu');
      if(menu=='의견올리기관리'){
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
      location.href = '/opinion/detail/' + idx;
    });


    $('#selectBtn').click(function(){
      var idx = $('#isClicked').val();
      console.log('idx : '+idx);
      location.href = '/opinion/detail/' + idx;

      <%--var change_uid = $('#isClicked').val();--%>
      <%--location.href = '<c:url value="/opinion/change/"/>'+change_uid;--%>
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
      var page = $(this).attr('page');
      location.href = '/opinion/list/' + page;
    });

    $('#insertFileBtn').click(function(){
      popupOpen('/opinion/popup/${items.adindex}',600,500);

    });
  });
  <!-- bind end -->

</script>
</body>
</html>
