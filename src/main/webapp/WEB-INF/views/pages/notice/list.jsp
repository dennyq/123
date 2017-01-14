<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>공지사항</title>
</head>
<body>
<section class="content-header">
  <h1>
    공지사항<c:if test="${isAdmin}"> 관리</c:if>
  </h1>
  <div class="breadcrumb-line"></div>
  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/notice/list"/>">공지사항</a></li>
    <li ><a href="<c:url value="/notice/list"/>">공지사항 조회</a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">
  <div class="paddingInside">
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="bottom-25">
            <form id="searchFrm" action="<c:url value="/notice/search"/>" class="form-horizontal" method="post">
              <div class="box-header-sm">
                <h3 class="box-title">공지사항 조회</h3>
              </div>
              <div class="col-xs-6">
                <c:if test="${isAdmin}">
                <a id="addBtn" class="minus-left pointer" href="<c:url value="/notice/detail"/>" > <img src="/imgs/bt_notice-add.png" alt="공지등록"></a>
                </c:if>
                </div>

              <div class="col-xs-6 bottom-10">

                <div class="input-group input-group-sm">
                  <input type="text" id="sch_text"  name="sch_text" class="form-control md-height padding-left-25" placeholder="검색어를 입력하세요." value="${sch_text}">
                  <span class="icon-search form-control-icon" id="searchClear"></span>
                    <span class="input-group-btn" >
                      <button type="submit" class="btn btn-green btn-flat md-height">검색</button>
                    </span>
                </div>
              </div>


            </form><!-- form end -->
            <!-- form start -->


          </div>
        </div>

        <div class="col-xs-12">
          <div class="box">

            <div class="box-body table-responsive no-padding">
              <table class="table table-hover table-th-grey pointer">
                <colgroup>
                  <col width="8%">
                  <col width="*">
                  <col width="10%">
                  <col width="20%">
                </colgroup>
                <tbody>
                <tr>

                  <th class="text-align-center">번호</th>
                  <th>제목</th>
                  <th class="text-align-center">조회수</th>
                  <th class="text-align-center">등록일</th>
                </tr>
                <c:if test="${not empty rows}">
                  <c:forEach items="${rows}" var="rows" varStatus="idx">
                    <tr class="clickTr" idx="${rows.noticenumber}">
                      <td class="text-align-center">${total-(pageTimes)-idx.count+1}</td>
                      <td>${rows.title}</td>
                      <td class="text-align-center">${rows.hitcount}</td>

                      <td class="text-align-center">${rows.regtime}</td>

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
            <div class="btn_bottom">
              ${paging}
            </div>
          </center>
        </div>


      </div><!-- /.row -->

    </section>

  </div>
</section>
<!-- /.content -->

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
      if(menu=='공지사항'){
        $(this).addClass('active');
        menu = menu+<c:if test="${isAdmin}">' 관리'</c:if>
        $('.content-header>h1').text(menu);
      }
    })

    $('#searchBtn').click(function(){
      $('#searchFrm').submit();
    });

    $('.clickTr').click(function(){
      var idx = $(this).attr('idx');
      location.href = '/notice/detail/' + idx;
    });

    $('#searchClear').click(function(){
       $('#sch_text').val("");
    });

    $('.page').click(function(){
//      console.log(this)
      var page = $(this).attr('page');
      location.href = '/notice/list/' + page;
//      $('#searchFrm').submit();
    });

  });
  <!-- bind end -->

</script>
</body>
</html>
