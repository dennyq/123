<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>

<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>전문가 회원 관리</title>
</head>
<body>
  <section class="content-header">
    <h1>
      전문가 회원 관리
    </h1>
    <div class="breadcrumb-line"></div>
    <ol class="breadcrumb">
      <li><a href="<c:url value="/"/>">HOME</a></li>
      <li ><a href="<c:url value="${thisPath}/list"/>">전문가 회원 정보</a></li>
      <li ><a href="<c:url value="${thisPath}/list"/>">전문가 회원 정보 조회</a></li>
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
            <h3 class="box-title">전문가 회원 조회</h3>
          </div>
          <!-- form start -->
          <form id="searchFrm" action="<c:url value="${thisPath}/search"/>" class="form-horizontal" method="post">
            <!-- box-body start -->
            <div class="box-body bg-gray">
              <!-- left col-md-6 start -->
              <div class="col-md-6">
                <div class="form-group">
                  <label for="sch_specialid" class="col-sm-4 ">아이디</label>
                  <div class="col-sm-6">
                    <input name="sch_specialid" id="sch_specialid" placeholder="아이디" class="form-control"
                           value="${sch_specialid}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_telephone" class="col-sm-4 ">전화번호</label>
                  <div class="col-sm-6">
                    <input name="sch_telephone" id="sch_telephone" placeholder="전화번호" class="form-control"
                           value="${sch_telephone}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_job" class="col-sm-4 ">직업</label>
                  <div class="col-sm-6">
                    <input name="sch_job" id="sch_job" placeholder="직업" class="form-control"
                           value="${sch_job}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_belongto" class="col-sm-4 ">소속</label>
                  <div class="col-sm-6">
                    <input name="sch_belongto" id="sch_belongto" placeholder="소속" class="form-control"
                           value="${sch_belongto}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_usestartdate" class="col-sm-4 ">사용시작일자</label>
                  <div class="col-sm-6">
                    <input name="sch_usestartdate" id="sch_usestartdate" placeholder="사용시작일자"
                           class="form-control datepicker" value="${sch_usestartdate}">
                  </div>
                </div>

              </div>
              <!-- //left col-md-6 end -->
              <!-- right col-md-6 start -->
              <div class="col-md-6 right">
                <div class="form-group">
                  <label for="sch_name" class="col-sm-4 ">이름</label>
                  <div class="col-sm-6">
                    <input name="sch_name" id="sch_name" placeholder="이름" class="form-control" value="${sch_name}">
                  </div>
                </div>


                <div class="form-group">
                  <label for="sch_handphone" class="col-sm-4 ">휴대폰번호</label>
                  <div class="col-sm-6">
                    <input name="sch_handphone" id="sch_handphone" placeholder="휴대폰번호" class="form-control"
                           value="${sch_handphone}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_specialty" class="col-sm-4 ">전문</label>
                  <div class="col-sm-6">
                    <input name="sch_specialty" id="sch_specialty" placeholder="전문" class="form-control"
                           value="${sch_specialty}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_career" class="col-sm-4 ">경력</label>
                  <div class="col-sm-6">
                    <input name="sch_career" id="sch_career" placeholder="경력" class="form-control"
                           value="${sch_career}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_useenddate" class="col-sm-4 ">사용종료일자</label>
                  <div class="col-sm-6">
                    <input name="sch_useenddate" id="sch_useenddate" placeholder="사용종료일자"
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
              <span class="right inline">
                <a id="insertFileBtn" class="pointer btn btn-blue-green btn-flat md-height">일괄등록</a>
              </span>
            </div>
          </form>
          <!--// form end-->
        </div>
      </div>

      <div class="col-md-12">
        <div class="">
          <div class="box-header-sm">
            <h3 class="box-title">전문가 회원 조회 결과</h3>
          </div>
          <div class="box-body table-responsive no-padding">
            <table class="table table-hover pointer">
              <colgroup>
                <col width="1%"/>
                <%--번호--%>
                <col width="7%"/>
                <%--아이디--%>
                <col width="7%"/>
                <%--이름--%>
                <col width="10%"/>
                <%--전화번호--%>
                <col width="10%"/>
                <%--휴대폰번호--%>

                <col width="8%"/>
                <%--사용시작일자--%>
                <col width="8%"/>
                <%--사용종료일자--%>
                <col width="13%"/>
                <%--폰번호--%>
                <col width="5%"/>
                <%--소개--%>
                <col width="*"/>
                <%--등록시간--%>
              </colgroup>
              <thead>
              <tr class="bg-gray text-align-center">
                <td>번호</td>
                <td>아이디</td>
                <td>이름</td>
                <td>전화번호</td>
                <td>휴대폰번호</td>

                <td>사용시작일자</td>
                <td>사용종료일자</td>

                <td>직업</td>
                <td>전문</td>
                <td>소속</td>
                <td>경력</td>

                <td>사진</td>

                <td>등록시간</td>
              </tr>
              </thead>
              <tbody>
              <c:if test="${not empty rows}">
                <c:forEach items="${rows}" var="items" varStatus="idx">
                  <input type="hidden" id="isClicked"/>
                  <tr class="clickTr" idx="${items.specialid }">
                    <td>${total-(pageTimes)-idx.count+1}</td>
                    <td>${items.specialid }</td>
                    <td>${items.name}</td>
                    <td>${items.telephone}</td>
                    <td>${items.handphone}</td>

                    <td>${items.usestartdate}</td>
                    <td>${items.useenddate}</td>

                    <td>${items.job}</td>
                    <td>${items.specialty}</td>
                    <td>${items.belongto}</td>
                    <td>${items.career}</td>

                    <td>${items.picturename}</td>

                    <td>${items.regtime}</td>

                      <%----%>
                      <%--<td>--%>
                      <%--${fn:substring(items.introduce, 0, 8)}--%>
                      <%--<c:if test="${fn:length(items.introduce)>8}">...</c:if>--%>

                      <%--</td>--%>
                      <%--<td>--%>
                      <%--${fn:substring(items.address, 0, 8)}--%>
                      <%--<c:if test="${fn:length(items.regtime)>8}">...</c:if>--%>
                      <%--</td>--%>
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
      if(menu=='전문가 회원관리'){
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
