<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>데이터 관리</title>
</head>
<body>
<form id="searchFrm" action="<c:url value="/outerData/search"/>" class="form-horizontal" method="post">
<section class="content-header">
  <h1>
    데이터 관리
  </h1>
  <div class="breadcrumb-line"></div>
  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/outerData/list"/>">데이터 관리</a></li>
    <li ><a href="<c:url value="/outerData/list"/>">데이터 관리</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="paddingInside">
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <div class="box-header-sm">
              <h3 class="box-title"><img src="/imgs/h3_bullet.png"/>데이터 관리</h3>
            </div>

            <!-- tab start -->
            <div class="custom-tab-parent">
              <div >내부 센서데이터 보기</div>
              <div>내부 센서그래프 보기</div>
              <div class="active">외부 센서데이터 보기</div>
              <div>외부 센서그래프 보기</div>
              <div>영농일지</div>
            </div>
            <!--// tab end -->

            <!-- searchform  -->
            <div class="box-body bg-gray">
              <div class="col-md-6">


                <div class="form-group">
                  <label for="sch_usestartdate" class="col-sm-4 ">시작일</label>

                  <div class="col-sm-6">
                    <input name="sch_usestartdate" id="sch_usestartdate" placeholder="시작일" class="form-control"
                           value="${sch_usestartdate}">
                  </div>

                </div>
              </div>
              <div class="col-md-6 right">
                <div class="form-group">
                  <label for="sch_useenddate" class="col-sm-4 ">종료일</label>

                  <div class="col-sm-6">
                    <input name="sch_useenddate" id="sch_useenddate" placeholder="종료일" class="form-control"
                           value="${sch_useenddate}">
                  </div>

                </div>
              </div>

              <div class="col-md-12 text-align-center">

                <button type="submit" class="btn"><img src="/imgs/bt_lookup.png"
                                                       alt="조회"></button>
                <a id="saveExcel" class="btn"><img src="/imgs/bt_save-xls.png" alt="엑셀저장"></a>

              </div>

            </div>
            <!--// searchform  -->

            <div class="custom-tab-bottom">
            </div>

            <div class="box-header-sm">
              <h3 class="box-title margin0"><img src="/imgs/h3_bullet.png"/>조회 결과</h3>
            </div>

            <%--<div class="box-body ">--%>

              <%--<div class="col-xs-12">--%>
                <%--<div class="">--%>

                  <div class="box-body table-responsive no-padding">

                    <table class="table table-hover pointer">
                      <thead class="bg-grey">
                      <tr>
                        <th class="tg-yw4l" rowspan="2">날짜</th>
                        <th class="tg-yw4l" rowspan="2">시간</th>
                        <%--<th class="tg-yw4l" rowspan="2">강우</th>--%>
                        <%--<th class="tg-yw4l" rowspan="2">풍향</th>--%>
                        <%--<th class="tg-yw4l" rowspan="2">풍속</th>--%>
                        <%--<th class="tg-yw4l" rowspan="2">일사량</th>--%>
                        <th class="tg-yw4l" colspan="6">기상센서노드</th>
                      </tr>
                      <tr>
                        <td class="tg-yw4l">온도</td>
                        <td class="tg-yw4l">습도</td>
                        <td class="tg-yw4l">감우</td>
                        <td class="tg-yw4l">일사량</td>
                        <td class="tg-yw4l">풍향</td>
                        <td class="tg-yw4l">풍속</td>
                      </tr>
                      </thead>
                      <tbody>
                      <c:if test="${not empty rows}">
                        <c:forEach items="${rows}" var="rows" varStatus="idx">
                          <input type="hidden" id="isClicked"/>
                          <tr>
                            <td>${rows.date}</td>
                            <td>${rows.time}</td>
                            <%--<td>${rows.rainstate}</td>--%>
                            <%--<td>${rows.winddirection}</td>--%>

                            <%--<td>${rows.windspeed}</td>--%>
                            <%--<td>${rows.wm2}</td>--%>
                            <td>${rows.node_temperature}</td>
                            <td>${rows.node_humidity}</td>
                            <td>
                              <c:if test="${rows.node_rainstate eq 1}">감우</c:if>
                              <c:if test="${rows.node_rainstate eq 0}">비감우</c:if>
                            </td>
                            <td>${rows.node_winddirection}</td>
                            <td>${rows.node_windspeed}</td>
                            <td>${rows.node_wm2}</td>


                          </tr>
                        </c:forEach>
                      </c:if>
                      <c:if test="${empty rows}">
                        <tr>
                          <td colspan="20" class="text-align-center">데이터가 없습니다.</td>
                        </tr>
                      </c:if>
                      </tbody>
                    </table>

                  </div>
                  <div class="box-footer clearfix"></div>
                <%--</div>--%>
                <center>
                  <div class="btn_bottom" style="margin-top: -20px;">
                    ${paging}
                  </div>
                </center>
              <%--</div>--%>
            <%--</div>--%>
            <!--// result  -->

          <%--</div>--%>
          <!-- //bottom-25 end-->

            </div>   <!-- //bottom-25 parent end-->




      </div><!-- /.row -->

    </section>

  </div>
</section>
<!-- /.content -->
<center>
  <div class="col-xs-12 bottom-20">
    <%--<a id="addBtn" class="pointer btn btn-green btn-flat md-height" href="<c:url value="/outerData/detail"/>">등록</a>--%>
    <%--<a id="selectBtn" class="pointer btn btn-default btn-flat md-height" > 데이터 선택</a>--%>
  </div>
</center>
</form>
<script>
  <!--//bind start -->
  var fn_go_page = function(page){
    //alert(11);
    //var page = $(this).attr('page');
    console.log(page)
    //alert(page)
    $("#page").val(page);
    fn_search();
  };
  function fn_search(){
    $('#searchFrm').submit();
  }

  $('#saveExcel').click(function(){
    var url = '';
    var req = $('#searchFrm').serialize();
    if($('#idxSpan').text()!='' || $('#idxSpan').text()!=null){
      url = '/data/excel_transform_controller/'+$('#idxSpan').text();
    }else{
      url = '/data/excel_transform_controller';
    }
    $('#searchFrm').attr('action',url);
    $('#searchFrm').submit();
  });
  $(function() {

    setClickedMenuBold(1);

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active')
//      console.log(this);
      var menu = $(this).attr('menu');

      if(menu=='데이터관리'){
        $(this).addClass('active');
        $('.content-header>h1').text(menu);
      }
    })

    $('#searchBtn').click(function(){
      $('#searchFrm').attr('action','/outerData/search');
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



      location.href = '/outerData/detail/' + idx;
    });


    $('#selectBtn').click(function(){
      var idx = $('#isClicked').val();
//      location.href = '/outerData/detail/' + idx;
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
//      console.log(this)
      var page = $(this).attr('page');
      location.href = '/outerData/list/' + page;
//      $('#searchFrm').submit();
    });

    $('.custom-tab-parent div').click(function(){

      var index = $(this).index();
      console.log(index);
      var url = '/data/list';
      switch (index){
        case 0:
          url = '/data/list';break;
        case 1:
          url = '/data/graph';break;
        case 2:
          url = '/outerData/list';break;
        case 3:
          url = '/outerData/graph';break;
        case 4:
          url = '/daily/';break;
        default :
          url = '/data/list';break;
      }
//      console.log(url);
      location.href=url;

    });

  });
  <!-- bind end -->

</script>

</body>
</html>
