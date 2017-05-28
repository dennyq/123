<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>

<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>공지사항 관리</title>
</head>
<body>
  <section class="content-header">
    <h1>
      공지사항 관리
    </h1>
    <div class="breadcrumb-line"></div>
    <ol class="breadcrumb">
      <li><a href="<c:url value="/"/>">HOME</a></li>
      <li ><a href="<c:url value="${thisPath}/list"/>">공지사항 정보</a></li>
      <li ><a href="<c:url value="${thisPath}/list"/>">공지사항 정보 조회</a></li>
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
            <h3 class="box-title">공지사항 조회</h3>
          </div>
          <!-- form start -->
          <form id="searchFrm" action="<c:url value="${thisPath}/search"/>" class="form-horizontal" method="post">
            <!-- box-body start -->
            <div class="box-body bg-gray">
              <!-- left col-md-6 start -->
              <div class="col-md-12">
                <div class="form-group">
                  <label for="sch_noticetitle" class="col-sm-2 ">공지사항 제목</label>
                  <div class="col-sm-10">
                    <input name="sch_noticetitle" id="sch_noticetitle" placeholder="공지사항 제목" class="form-control"
                           value="${sch_noticetitle}">
                  </div>
                </div>
              </div>

              <div class="col-md-6">
                <div class="form-group">
                  <label for="sch_usestartdate" class="col-sm-4 ">등록시작일자</label>
                  <div class="col-sm-8">
                    <input name="sch_usestartdate" id="sch_usestartdate" placeholder="등록시작일자"
                           class="form-control datepicker" value="${sch_usestartdate}">
                  </div>
                </div>

              </div>
              <!-- //left col-md-6 end -->
              <!-- right col-md-6 start -->
              <div class="col-md-6 right">


                <div class="form-group">
                  <label for="sch_useenddate" class="col-sm-4 ">등록종료일자</label>
                  <div class="col-sm-8">
                    <input name="sch_useenddate" id="sch_useenddate" placeholder="등록종료일자"
                           class="form-control datepicker" value="${sch_useenddate}">
                  </div>
                </div>

              </div>
              <!--// right col-md-6 end-->
            </div>
            <!--// box-body end -->
            <div class="btn-box centeringContainer ">
              <span class="centered ">
                  <a id="searchBtn" class="pointer btn btn-blue-green btn-flat md-height">조회</a>
              </span>
            </div>
          </form>
          <!--// form end-->
        </div>
      </div>

      <div class="col-md-12">
        <div class="">
          <div class="box-header-sm">
            <h3 class="box-title">공지사항 조회 결과</h3>
          </div>
          <div class="box-body table-responsive no-padding">
            <table class="table table-hover pointer">
              <colgroup>
                <col width="1%"/><%--번호--%>
                <col width="*"/><%--공지사항제목--%>
                <col width="10%"/><%--등록자--%>
                <col width="10%"/><%--조회수--%>
                <col width="10%"/><%--등록시간--%>
              </colgroup>
              <thead>
              <tr class="bg-gray text-align-center">
                <td>번호</td>
                <td>공지사항제목</td>
                <td>등록자</td>
                <td>조회수</td>
                <td>등록시간</td>
              </tr>
              </thead>
              <tbody>
              <c:if test="${not empty rows}">
                <c:forEach items="${rows}" var="items" varStatus="idx">
                  <input type="hidden" id="isClicked"/>
                  <tr class="clickTr" idx="${items.noticeindex}">
                    <td>${total-(pageTimes)-idx.count+1}</td>
                    <td>${items.noticetitle }</td>
                    <td>${items.regid}</td>
                    <td>${items.searchcount}</td>
                    <td>${items.regtime}</td>
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
    <a id="addBtn" class="pointer btn btn-blue-green btn-flat md-height" href="<c:url value="${thisPath}/detail"/>">등록</a>
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
      if(menu=='공지사항관리'){
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
      location.href = '${thisPath}/detail/' + idx;
    });


    $('#selectBtn').click(function(){
      var idx = $('#isClicked').val();
      console.log('idx : '+idx);
      location.href = '${thisPath}/detail/' + idx;

      <%--var change_uid = $('#isClicked').val();--%>
      <%--location.href = '<c:url value="/member/change/"/>'+change_uid;--%>
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
      var page = $(this).attr('page');
      location.href = '${thisPath}/list/' + page;
    });

  });
  <!-- bind end -->

</script>
</body>
</html>
