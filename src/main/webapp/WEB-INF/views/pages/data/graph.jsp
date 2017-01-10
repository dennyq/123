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
<form id="searchFrm" action="<c:url value="/data/graphSearch"/>" class="form-horizontal" method="post">
<section class="content-header">
  <h1>
    데이터 관리
  </h1>
  <div class="breadcrumb-line"></div>
  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/data/graph"/>">데이터 관리</a></li>
    <li ><a href="<c:url value="/data/graph"/>">데이터 관리</a></li>
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
                <div class="active">내부 센서그래프 보기</div>
                <div>외부 센서데이터 보기</div>
                <div>외부 센서그래프 보기</div>
                <div>영농일지</div>
            </div>
            <!--// tab end -->

            <!-- searchform  -->
            <div class="box-body bg-gray">
              <div class="col-md-8">


                <div class="form-group">
                  <label for="sch_date" class="col-sm-4 ">기준일</label>

                  <div class="col-sm-6">

                    <input name="sch_date" id="sch_date" placeholder="시작일" class="form-control datepicker"
                       <c:if test="${not empty sch_date}">value="${sch_date}"</c:if>
                    <c:if test="${empty sch_date}">value="${today}"</c:if>
                            />
                  </div>


                </div>

              </div>

              <div class="col-md-4 right">
                <button type="submit" class="btn" ><img src="/imgs/bt_lookup.png" alt="조회"></button>
              </div>

              <div class="col-md-12">
                <input id="channel1" name="channel1" type="checkbox"
                       <c:if test="${channel1 eq 'Y'}">checked</c:if>
                       value="Y"/>채널1
                <input id="channel2" name="channel2" type="checkbox"
                       <c:if test="${channel2 eq 'Y'}">checked</c:if>
                       value="Y"/>채널2
                <input id="channel3" name="channel3" type="checkbox"
                       <c:if test="${channel3 eq 'Y'}">checked</c:if>
                       value="Y"/>채널3
                <input id="channel4" name="channel4" type="checkbox"
                       <c:if test="${channel4 eq 'Y'}">checked</c:if>
                       value="Y"/>채널4
                <input id="channel5" name="channel5" type="checkbox"
                       <c:if test="${channel5 eq 'Y'}">checked</c:if>
                       value="Y"/>채널5
                <input id="channel6" name="channel6" type="checkbox"
                       <c:if test="${channel6 eq 'Y'}">checked</c:if>
                       value="Y"/>채널6
                <input id="channel7" name="channel7" type="checkbox"
                       <c:if test="${channel7 eq 'Y'}">checked</c:if>
                       value="Y"/>채널7
                <input id="channel8" name="channel8" type="checkbox"
                       <c:if test="${channel8 eq 'Y'}">checked</c:if>
                       value="Y"/>채널8
               </div>

            </div>
            <!--// searchform  -->



            <div class="custom-tab-bottom">
            </div>
            <div class="box-header-sm">
              <h3 class="box-title margin0"><img src="/imgs/h3_bullet.png"/>조회 결과</h3>
            </div>

            <!-- result  -->
            <div class="box-body ">
              <img width="700" src="${grpPath}"/>

            </div>
            <!--// result  -->
          </div>
          <!-- //bottom-25 end-->
        </div>



      </div><!-- /.row -->

    </section>

  </div>
</section>
<!-- /.content -->
<center>
  <div class="col-xs-12 bottom-20">
    <%--<a id="addBtn" class="pointer btn btn-green btn-flat md-height" href="<c:url value="/data/detail"/>">등록</a>--%>
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

    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active')
//      console.log(this);
      var menu = $(this).attr('menu');

      if(menu=='데이터관리'){
        $(this).addClass('active');
        $('.content-header>h1').text(menu);
      }
    })

    $('.datepicker').datepicker({
      format: "yyyy.mm.dd",
//        defaultViewDate:'today',
      "setDate": new Date(),

//      startDate: '0',
//      todayBtn: true
    });
    $("#datepicker").datepicker('update');



    $('#searchBtn').click(function(){
      $('#searchFrm').attr('action','/data/graphSearch');

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



      location.href = '/data/detail/' + idx;
    });


    $('#selectBtn').click(function(){
      var idx = $('#isClicked').val();
//      location.href = '/data/detail/' + idx;
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
//      console.log(this)
      var page = $(this).attr('page');
      location.href = '/data/list/' + page;
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
