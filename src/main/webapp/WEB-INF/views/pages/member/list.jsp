<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>사용자 관리</title>
</head>
<body>
<section class="content-header">
  <h1>
    사용자 관리
  </h1>
  <div class="breadcrumb-line"></div>
  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/member/list"/>">사용자 정보</a></li>
    <li ><a href="<c:url value="/member/list"/>">사용자 정보 조회</a></li>
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
              <h3 class="box-title"><img src="/imgs/h3_bullet.png"/>사용자 조회</h3>
            </div>
            <!-- form start -->
            <form id="searchFrm" action="<c:url value="/member/search"/>" class="form-horizontal" method="post">


              <div class="box-body bg-gray">
              <div class="col-md-6">
                <div class="form-group">
                  <label for="sch_memberid" class="col-sm-4 ">아이디</label>

                  <div class="col-sm-6">
                    <input name="sch_memberid"  id="sch_memberid" placeholder="아이디" class="form-control" value="${sch_memberid}">
                  </div>

                </div>
                <div class="form-group">
                  <label for="sch_name" class="col-sm-4 ">이름</label>

                  <div class="col-sm-6">
                    <input name="sch_name"  id="sch_name" placeholder="이름" class="form-control" value="${sch_name}">
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
              </div>

                </div>
              <div>
                <center>

                  <button type="submit" class="btn" style="background-color: white"> <img src="/imgs/bt_lookup.png" alt="조회"></button>
                </center>
              </div>



          </div>
        </div>
        <div class="box-header-sm">
          <h3 class="box-title"><img src="/imgs/h3_bullet.png"/>사용자 조회 결과</h3>
        </div>
        <div class="col-xs-12">
          <div class="">

            <div class="box-body table-responsive no-padding">

              <table class="table table-hover pointer">
                <tbody>
                <c:if test="${not empty rows}">
                  <c:forEach items="${rows}" var="rows" varStatus="idx">
                    <input type="hidden" id="isClicked"/>
                    <tr class="clickTr" idx="${rows.memberid}">
                      <td  rowspan="3">${total-(pageTimes)-idx.count+1}</td>
                      <th class="tg-yw4l">아이디</th>
                      <td colspan="5">${rows.memberid}</td>
                    </tr>
                    <tr class="clickTr" idx="${rows.memberid}">
                      <th class="tg-yw4l">이름</th>
                      <td >${rows.name}</td>
                      <th class="tg-yw4l">자택전화</th>
                      <td >${rows.telephone}</td>
                      <th class="tg-yw4l">휴대폰</th>
                      <td >${rows.handphone}</td>
                    </tr>
                    <tr class="clickTr" idx="${rows.memberid}">
                      <th class="tg-yw4l">가입일자</th>
                      <td >${rows.joindate}</td>
                      <th class="tg-yw4l">사용시작일자</th>
                      <td >${rows.usestartdate}</td>
                      <th class="tg-yw4l">사용종료일자</th>
                      <td >${rows.useenddate}</td>
                    </tr>
                  </c:forEach>
                </c:if>
                <c:if test="${empty rows}">
                  <tr>
                    <td colspan="11">데이터가 없습니다.</td>
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

  </div>
</section>
<!-- /.content -->
<center>
  <div class="col-xs-12 bottom-20">
    <a id="addBtn" class="pointer btn btn-green btn-flat md-height" href="<c:url value="/member/detail"/>">등록</a>
    <a id="selectBtn" class="pointer btn btn-default btn-flat md-height" > 사용자 선택</a>
  </div>
</center>

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
      if(menu=='사용자관리'){
        $(this).addClass('active')
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



      location.href = '/member/detail/' + idx;
    });


    $('#selectBtn').click(function(){
      var idx = $('#isClicked').val();
//      location.href = '/member/detail/' + idx;
//      console.log($('#isClicked').val());
//      var req = {};
      var change_uid = $('#isClicked').val();
      location.href = '<c:url value="/member/change/"/>'+change_uid;
//      console.log(req);
      <%--$als.execute('<c:url value="/member/change"/>', req, function (data) {--%>
        <%--if (data.result_message == 'success') {--%>
          <%--alert('사용자가 선택되었습니다.');--%>
<%--//          alert(req.sch_daydate);--%>
<%--$('#changeed').text(req.change_uid);--%>

          <%--location.href = '<c:url value="/member/list"/>';--%>
        <%--}--%>
      <%--}, function (err) {--%>
        <%--alert(err.result_message);--%>
      <%--});--%>


    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
//      console.log(this)
      var page = $(this).attr('page');
      location.href = '/member/list/' + page;
//      $('#searchFrm').submit();
    });

  });
  <!-- bind end -->

</script>
</body>
</html>
