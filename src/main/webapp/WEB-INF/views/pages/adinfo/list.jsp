<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>광고 관리</title>
</head>
<body>
  <section class="content-header">
    <h1>
      광고 관리
    </h1>
    <div class="breadcrumb-line"></div>
    <ol class="breadcrumb">
      <li><a href="<c:url value="/"/>">HOME</a></li>
      <li ><a href="<c:url value="/adinfo/list"/>">광고 정보</a></li>
      <li ><a href="<c:url value="/adinfo/list"/>">광고 정보 조회</a></li>
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
            <h3 class="box-title">광고 조회</h3>
          </div>
          <!-- form start -->
          <form id="searchFrm" action="<c:url value="/adinfo/search"/>" class="form-horizontal" method="post">
            <!-- box-body start -->
            <div class="box-body bg-gray">
              <!-- left col-md-6 start -->
              <div class="col-md-12">
                <div class="form-group">
                  <label for="sch_adtitle" class="col-sm-2 ">광고제목</label>
                  <div class="col-sm-9">
                    <input name="sch_adtitle"  id="sch_adtitle" placeholder="광고제목" class="form-control" value="${sch_adtitle}">
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label for="sch_adowner" class="col-sm-4 ">광고주명</label>
                  <div class="col-sm-6">
                    <input name="sch_adowner"  id="sch_adowner" placeholder="광고주명" class="form-control" value="${sch_adowner}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_usestartdate" class="col-sm-4 ">사용시작일자</label>
                  <div class="col-sm-6">
                    <input name="sch_usestartdate"  id="sch_usestartdate" placeholder="사용시작일자" class="form-control datepicker" value="${sch_usestartdate}">
                  </div>
                </div>
              </div>
              <!-- //left col-md-6 end -->
              <!-- right col-md-6 start -->
              <div class="col-md-6 right">
                <div class="form-group">
                  <label for="sch_telephone" class="col-sm-4 ">광고주연락처</label>
                  <div class="col-sm-6">
                    <input name="sch_telephone"  id="sch_telephone" placeholder="광고주연락처" class="form-control" value="${sch_telephone}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_useenddate" class="col-sm-4 ">사용종료일자</label>
                  <div class="col-sm-6">
                    <input name="sch_useenddate"  id="sch_useenddate" placeholder="사용종료일자" class="form-control datepicker" value="${sch_useenddate}">
                  </div>
                </div>

              </div>
              <!--// right col-md-6 end-->
            </div>
            <!--// box-body end -->
            <div class="btn-box">
              <center>
                  <a id="searchBtn" class="pointer btn btn-blue-green btn-flat md-height" >조회</a>
              </center>
            </div>
          </form>
          <!--// form end-->
        </div>
      </div>

      <div class="col-md-12">
        <div class="">
          <div class="box-header-sm">
            <h3 class="box-title">광고 조회 결과</h3>
          </div>
          <div class="box-body table-responsive no-padding">
            <table class="table table-hover pointer">
              <colgroup>
                <col width="1%"/><%--번호--%>
                <col width="*"/><%--광고제목--%>
                <col width="10%"/><%--광고주명--%>
                <col width="13%"/><%--광고주연락처--%>
                <col width="5%"/><%--사용시작일자--%>
                <col width="5%"/><%--사용종료일자--%>
                <col width="5%"/><%--등록시간--%>
                <col width="8%"/><%--동영상미리보기--%>
                <col width="9%"/><%--플레이순서(위로이동)--%>
                <col width="9%"/><%--플레이순서(위로이동)--%>

              </colgroup>
              <thead>
                <tr class="bg-gray text-align-center">
                  <td>번호</td>
                  <td>광고제목</td>
                  <td>광고주명</td>
                  <td>광고주연락처</td>
                  <td>사용시작일자</td>
                  <td>사용종료일자</td>
                  <td>등록시간</td>
                  <td>동영상<br>미리보기</td>
                  <td>플레이순서<br>(위로)</td>
                  <td>플레이순서<br>(아래로)</td>
                </tr>
              </thead>
              <tbody>
              <c:if test="${not empty rows}">
                <c:forEach items="${rows}" var="items" varStatus="idx">
                  <input type="hidden" id="isClicked"/>
                  <tr class="clickTr" idx="${items.adindex}">
                    <td>${(pageTimes)+idx.count}</td><%--번호--%>
                    <td>${items.adtitle}</td><%--광고제목--%>
                    <td>${items.adowner}</td><%--광고주명--%>
                    <td>${items.telephone}</td><%--광고주연락처--%>
                    <td>${items.usestartdate}</td><%--사용시작일자--%>
                    <td>${items.useenddate}</td><%--사용종료일자--%>
                    <td>${items.regtime}</td><%--등록시간--%>
                    <td><a href="javascript:popupOpen('/adinfo/popup/${items.adindex}',600,500);">미리보기</a></td><%--동영상미리보기--%><%--/adinfo/upPlayOrder/${items.adindex}/${items.playorder}--%>
                    <td><a class="upPlayOrder" adindex="${items.adindex}" playorder="${items.playorder}"><img src="/imgs/bt_up.png" onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');"/></a></td><%--플레이순서(위로이동)--%>
                    <td><a class="downPlayOrder" adindex="${items.adindex}" playorder="${items.playorder}"><img src="/imgs/bt_down.png" onmouseover="swapOverImg(this,'_on');" onmouseout="swapOutImg(this,'_on');"/></a></td><%--플레이순서(위로이동)--%>
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
    <a id="addBtn" class="pointer btn btn-blue-green btn-flat md-height" href="<c:url value="/adinfo/detail"/>">등록</a>
    <a id="selectBtn" class="pointer btn btn-default btn-flat md-height" > 수정</a>
  </div>
</center>
<script>
  <!--//bind start -->
  var fn_go_page = function(page){
    $("#page").val(page);
    fn_search();
  };
  <%--/adinfo/upPlayOrder/${items.adindex}/${items.playorder}--%>
  <%--<td><a id="upPlayOrder" adindex="${items.adindex}" playorder="${items.playorder}">--%>
  <%--<td><a id="downPlayOrder" adindex="${items.adindex}" playorder="${items.playorder}">--%>


  function fn_search(){
    $('#searchFrm').submit();
  }
  $(function() {

      $('.upPlayOrder').click(function(){
          var playordermax = '${playordermax}';
          var playordermin = '${playordermin}';

          var adindex = $(this).attr('adindex');
          var playorder = $(this).attr('playorder');

          if (eval(playordermin) == eval(adindex)) {
              alert('위로 이동할수없습니다.');
              return;
          }

          var req = {};
          req = $(this).closest('form').serialize();
          $als.execute('/adinfo/upPlayOrder/'+adindex+'/'+playorder+'/', req, function (data) {
              if (data.result_message == 'success') {
                  alert('순서가 변경되었습니다.');
                  location.href='/adinfo/list';
              }
          }, function (err) {
              alert(err.result_message);
          });
      });
      $('.downPlayOrder').click(function(){
          var playordermax = '${playordermax}';
          var playordermin = '${playordermin}';

          var adindex = $(this).attr('adindex');
          var playorder = $(this).attr('playorder');


          if (eval(playordermax) <= eval(adindex)) {
              alert('아래로 이동할수없습니다.');
              return;
          }
          var req = {};
          req = $(this).closest('form').serialize();
          $als.execute('/adinfo/downPlayOrder/'+adindex+'/'+playorder+'/', req, function (data) {
              if (data.result_message == 'success') {
                  alert('순서가 변경되었습니다..');
                  location.href='/adinfo/list';
              }
          }, function (err) {
              alert(err.result_message);
          });
      });



    $('.datepicker').datepicker({
      format: "yyyy.mm.dd",
//      startDate: '+0d',
      todayBtn: true
    });

    setClickedMenuBold(1);

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active');
      var menu = $(this).attr('menu');
      if(menu=='광고관리'){
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
      location.href = '/adinfo/detail/' + idx;
    });


    $('#selectBtn').click(function(){
      var idx = $('#isClicked').val();
      console.log('idx : '+idx);
      location.href = '/adinfo/detail/' + idx;

      <%--var change_uid = $('#isClicked').val();--%>
      <%--location.href = '<c:url value="/adinfo/change/"/>'+change_uid;--%>
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
      var page = $(this).attr('page');
      location.href = '/adinfo/list/' + page;
    });

  });
  <!-- bind end -->

</script>
</body>
</html>
