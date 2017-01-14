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
<form id="searchFrm" action="<c:url value="/daily/search"/>" class="form-horizontal" method="post">
<section class="content-header">
  <h1>
    데이터 관리
  </h1>
  <div class="breadcrumb-line"></div>
  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/daily/list"/>">데이터 관리</a></li>
    <li ><a href="<c:url value="/daily/list"/>">데이터 관리</a></li>
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
              <h3 class="box-title">데이터 관리</h3>
            </div>
            <!-- form start -->




            <div class="nav-tabs-custom">
              <ul class="nav nav-tabs">
                <li class=""><a href="<c:url value="/data/list"/>">내부센서데이터보기</a></li>
                <li class=""><a href="#tab_2" data-toggle="tab" aria-expanded="false">내부센서그래프보기</a></li>
                <li class=""><a href="<c:url value="/outerData/list"/>" >외부센서데이터보기</a></li>
                <li class=""><a href="#tab_4" data-toggle="tab" aria-expanded="false">외부센서그래프보기</a></li>
                <li class="active"><a href="<c:url value="/daily/"/>" >영농일지</a></li>
                <%--<li class="pull-right"><a href="#" class="text-muted"><i class="fa fa-gear"></i></a></li>--%>
              </ul>
              <div class="tab-content">
                <div class="tab-pane " id="tab_1">

                </div><!-- /.tab_1 -->
                <!-- /.tab-pane -->
                <div class="tab-pane" id="tab_2">
                  <b>tab_2</b>

                </div>
                <!-- /.tab-pane -->
                <div class="tab-pane " id="tab_3">



                </div>
                <div class="tab-pane" id="tab_4">
                  <b>tab_4</b>

                </div>
                <div class="tab-pane active" id="tab_5">

                  <div class="box-body bg-gray">
                    <div class="col-md-6">


                      <div class="form-group">
                        <label for="sch_daydate" class="col-sm-4 ">기준일</label>

                        <div class="col-sm-6">
                          <input name="sch_daydate" id="sch_daydate" placeholder="기준일" class="form-control datepicker"
                                 <c:if test="${not empty sch_daydate}">value="${sch_daydate}"</c:if>
                                 <c:if test="${empty sch_daydate}">value="2016.09.14"</c:if>
                                 >
                        </div>

                      </div>
                    </div>
                    <div class="col-md-6 right">
                      <center>

                        <button type="submit" class="btn" style="background-color: white"><img src="/imgs/bt_lookup.png"
                                                                                               alt="조회"></button>
                       <%-- <a id="saveExcel" class="btn" style="background-color: white"><img src="/imgs/bt_save-xls.png"
                                                                                           alt="엑셀저장"></a>--%>
                      </center>
                    </div>

                  </div>
                  <div>

                  </div>
                  <div class="box-header-sm">
                    <h3 class="box-title margin0">조회 결과</h3>
                  </div>
                  <div class="box-body ">

                    <div class="col-xs-12">
                      <div class="">

                        <div class="box-body table-responsive no-padding">

                          <table class="table table-hover pointer">

                            <tbody>
                            <tr><td>재배 품종</td><td ><textarea class="textarea-row"></textarea></td> </tr>
                            <tr><td>작물 재배 상태</td><td ><textarea class="textarea-row"></textarea></td> </tr>
                            <tr><td>수확량</td><td ><textarea class="textarea-row"></textarea></td> </tr>
                            <tr><td>비고</td><td ><textarea class="textarea-row"></textarea></td> </tr>
                            <%--<c:if test="${not empty rows}">
                              <c:forEach items="${rows}" var="rows" varStatus="idx">
                                <input type="hidden" id="isClicked"/>
                                <tr><td>재배 품종</td><td >${rows.date}</td> </tr>
                                <tr><td>작물 재배 상태</td><td >${rows.date}</td> </tr>
                                <tr><td>수확량</td><td >${rows.date}</td> </tr>
                                <tr><td>비고</td><td >${rows.date}</td> </tr>



                              </c:forEach>
                            </c:if>
                            <c:if test="${empty rows}">
                              <tr>
                                <td colspan="11">데이터가 없습니다.</td>
                              </tr>
                            </c:if>--%>
                            </tbody>
                          </table>

                        </div>
                        <div class="box-footer clearfix">

                        </div>
                      </div>

                    </div>
                  </div>

                </div>
                <!-- /.tab-pane -->
              </div>
              <!-- /.tab-content -->
            </div>






          </div>
        </div>



      </div><!-- /.row -->

    </section>

  </div>
</section>
<!-- /.content -->
<center>
  <div class="col-xs-12 bottom-20">
    <a id="addBtn" class="pointer btn btn-green btn-flat md-height" href="<c:url value="/daily/save"/>">저장</a>
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
  $(function() {

    setClickedMenuBold(1);

    $('.datepicker').datepicker({
      format: "yyyy.mm.dd",
//      startDate: '+0d',
//      todayBtn: true
    });

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



      location.href = '/daily/detail/' + idx;
    });


    $('#selectBtn').click(function(){
      var idx = $('#isClicked').val();
//      location.href = '/daily/detail/' + idx;
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
//      console.log(this)
      var page = $(this).attr('page');
      location.href = '/daily/list/' + page;
//      $('#searchFrm').submit();
    });

  });
  <!-- bind end -->

</script>

</body>
</html>
