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
              <h3 class="box-title"><img src="/imgs/h3_bullet.png"/>데이터 관리</h3>
            </div>
            <!-- form start -->



              <!-- tab start -->
              <div class="custom-tab-parent">
                  <div >내부 센서데이터 보기</div>
                  <div >내부 센서그래프 보기</div>
                  <div>외부 센서데이터 보기</div>
                  <div>외부 센서그래프 보기</div>
                  <div class="active">영농일지</div>
              </div>
              <!--// tab end -->

              <!-- searchform  -->
              <div class="box-body bg-gray">
                  <div class="col-md-6">


                      <div class="form-group">
                          <label for="sch_daydate" class="col-sm-4 ">기준일</label>

                          <div class="col-sm-6">
                              <input name="sch_daydate" id="sch_daydate" placeholder="기준일" class="form-control datepicker"
                                     <c:if test="${not empty sch_daydate}">value="${sch_daydate}"</c:if>
                                     <c:if test="${empty sch_daydate}">value="${today}"</c:if>
                              <%--<c:if test="${empty sch_daydate}">value="2016.09.14"</c:if>--%>
                                      >
                          </div>

                      </div>
                  </div>
                  <div class="col-md-6 right">
                      <center>

                          <button type="submit" class="btn"><img src="/imgs/bt_lookup.png"
                                                                                                 alt="조회"></button>
                          <%-- <a id="saveExcel" class="btn"><img src="/imgs/bt_save-xls.png"
                                                                                              alt="엑셀저장"></a>--%>
                      </center>
                  </div>

              </div>
              <!-- //searchform  -->
              <div class="custom-tab-bottom"></div>

              <!-- result  -->

                  <div class="box-header-sm">
                    <h3 class="box-title margin0"><img src="/imgs/h3_bullet.png"/>조회 결과</h3>
                  </div>


                        <div class="box-body table-responsive no-padding">

                          <table class="table table-hover pointer">

                            <tbody>
                            <tr><td>재배 품종</td><td ><textarea name="cultivationspecies" class="textarea-row">${data.cultivationspecies}</textarea></td> </tr>
                            <tr><td>작물 재배 상태</td><td ><textarea name="cultivationcropsstate" class="textarea-row">${data.cultivationcropsstate}</textarea></td> </tr>
                            <tr><td>수확량</td><td ><textarea name="yield" class="textarea-row">${data.yield}</textarea></td> </tr>
                            <tr><td>비고</td><td ><textarea name="note" class="textarea-row">${data.note}</textarea></td> </tr>

                            </tbody>
                          </table>

                        </div>
                        <div class="box-footer clearfix">


                  </div>

              <!-- //result  -->





          </div>
        </div>



      </div><!-- /.row -->

    </section>

  </div>
</section>
<!-- /.content -->
<center>
  <div class="col-xs-12 bottom-20">
    <a id="addBtn" class="pointer btn btn-green btn-flat md-height" >저장</a>
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
//        defaultViewDate:'today',
        "setDate": new Date(),

//      startDate: '0',
//      todayBtn: true
    });
      $("#datepicker").datepicker('update');

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


    $('#addBtn').click(function(){
//      var idx = $('#isClicked').val();
//      location.href = '/daily/detail/' + idx;
      var req = {};
      req = $(this).closest('form').serialize();
        console.log(req);
      $als.execute('<c:url value="/daily/save"/>', req, function (data) {
        if (data.result_message == 'success') {
          alert('저장되었습니다.');
//          alert(req.sch_daydate);

            location.href = '<c:url value="/daily/search"/>/'+data.sch_daydate+'/';
        }
      }, function (err) {
        alert(err.result_message);
      });
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
