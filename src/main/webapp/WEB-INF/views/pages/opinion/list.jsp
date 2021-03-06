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
                  <label for="sch_gubun" class="col-sm-4 ">구분</label>
                  <div class="col-sm-6">
                    <select name="sch_gubun"  id="sch_gubun" placeholder="아이디" class="form-control" value="${sch_opinionkey}">
                        <option value="1">약국+병원 의견</option>
                        <option value="2">일반 의견</option>

                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_telephone" class="col-sm-4 ">전화번호</label>
                  <div class="col-sm-6">
                    <input name="sch_telephone"  id="sch_telephone" placeholder="아이디" class="form-control" value="${sch_telephone}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="schhospitaldept" class="col-sm-4 ">진료과목</label>
                  <div class="col-sm-6">
                    <input name="schhospitaldept"  id="schhospitaldept" placeholder="의견올리기명" class="form-control" value="${schhospitaldept}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_address" class="col-sm-4 ">주소</label>
                  <div class="col-sm-6">
                    <input name="sch_address"  id="sch_address" placeholder="휴대폰" class="form-control" value="${sch_address}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_slogan" class="col-sm-4 ">슬로건</label>
                  <div class="col-sm-6">
                    <input name="sch_slogan"  id="sch_slogan" placeholder="전화번호" class="form-control" value="${sch_slogan}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_opiniontitle" class="col-sm-4 ">일반의견제목</label>
                  <div class="col-sm-6">
                    <input name="sch_opiniontitle"  id="sch_opiniontitle" placeholder="전화번호" class="form-control" value="${sch_opiniontitle}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_usestartdate" class="col-sm-4 ">등록시작일자</label>
                  <div class="col-sm-6">
                    <input name="sch_usestartdate"  id="sch_usestartdate" placeholder="등록시작일자" class="form-control datepicker" value="${sch_usestartdate}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_writername" class="col-sm-4 ">작성자 이름</label>
                  <div class="col-sm-6">
                    <input name="sch_writername"  id="sch_writername" placeholder="사용시작일자" class="form-control" value="${sch_writername}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_opinioncontent" class="col-sm-4 ">연락처</label>
                  <div class="col-sm-6">
                    <input name="sch_opinioncontent"  id="sch_opinioncontent" placeholder="사용시작일자" class="form-control" value="${sch_opinioncontent}">
                  </div>
                </div>
              </div>
              <!-- //left col-md-6 end -->
              <!-- right col-md-6 start -->
              <div class="col-md-6 right">
                  <div class="form-group">
                      <label for="sch_name" class="col-sm-4 ">이름</label>
                      <div class="col-sm-6">
                          <input name="sch_name"  id="sch_name" placeholder="아이디" class="form-control" value="${sch_name}">
                      </div>
                  </div>
                <div class="form-group">
                  <label for="sch_handphone" class="col-sm-4 ">휴대폰</label>
                  <div class="col-sm-6">
                    <input name="sch_handphone"  id="sch_handphone" placeholder="휴대폰" class="form-control" value="${sch_handphone}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_worktime" class="col-sm-4 ">근무시간</label>
                  <div class="col-sm-6">
                    <input name="sch_worktime"  id="sch_worktime" placeholder="휴대폰" class="form-control" value="${sch_worktime}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_address_etc" class="col-sm-4 ">기타주소</label>
                  <div class="col-sm-6">
                    <input name="sch_address_etc"  id="sch_address_etc" placeholder="휴대폰" class="form-control" value="${sch_address_etc}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_introduce" class="col-sm-4 ">소개</label>
                  <div class="col-sm-6">
                    <input name="sch_introduce"  id="sch_introduce" placeholder="휴대폰" class="form-control" value="${sch_introduce}">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sch_opinioncontent" class="col-sm-4 ">일반의견 내용</label>
                  <div class="col-sm-6">
                    <input name="sch_opinioncontent"  id="sch_opinioncontent" placeholder="휴대폰" class="form-control" value="${sch_opinioncontent}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_useenddate" class="col-sm-4 ">등록종료일자</label>
                  <div class="col-sm-6">
                    <input name="sch_useenddate"  id="sch_useenddate" placeholder="등록종료일자" class="form-control datepicker" value="${sch_useenddate}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_relation" class="col-sm-4 ">관계</label>
                  <div class="col-sm-6">
                    <input name="sch_relation"  id="sch_relation" placeholder="사용종료일자" class="form-control" value="${sch_relation}">
                  </div>
                </div>

                <div class="form-group">
                  <label for="sch_email" class="col-sm-4 ">이메일</label>
                  <div class="col-sm-6">
                    <input name="sch_email"  id="sch_email" placeholder="사용종료일자" class="form-control" value="${sch_email}">
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
            </div>
          </form>
          <!--// form end-->
        </div>
      </div>

      <div class="col-md-12">
        <div class="">
          <div class="box-header-sm">
            <h3 class="box-title">의견올리기 조회 결과</h3>

          </div>
          <div class="box-body table-responsive no-padding">
            <table class="table table-hover pointer">
              <colgroup>
                <col width="1%"/>
                <col width="1%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="5%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="8%"/>
                <col width="8%"/>
                <col width="13%"/>
                <col width="5%"/>
                <col width="5%"/>
                <col width="8%"/>

                <col width="*"/>
              </colgroup>
              <thead>
                <tr class="bg-gray text-align-center">
                  <td>번호</td>
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
                    <td> ${items.hospitaldept} </td>
                    <td>${items.worktime}</td>
                    <td>${items.slogan}</td>
                    <td>${items.introduce}</td>
                    <td>${items.opiniontitle}</td>
                    <td>${items.opinioncontent}</td>
                    <td>${items.writername}</td>
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
