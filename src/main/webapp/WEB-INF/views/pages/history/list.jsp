<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid eq 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
  <title>ifarms 사용이력관리</title>
</head>
<body>
<div class="paddingInside">
  <section id="contents" class="content">
    <div class="row">
      <div class="col-md-12">
        <div class="box box-primary box-bg">
          <div class="box-header-sm">
            <h3 class="box-title">사용이력관리</h3>
          </div>
          <!-- form start -->
          <form id="searchFrm" action="<c:url value="/history/search"/>" class="form-horizontal" method="post">
            <input type="hidden" name="searchFrm" value="Y"/>
<c:if test="${isAdmin}">
            <div class="box-body border-bottom">
              <div class="col-md-3">
                <div class="form-group">
                  <label for="sch_memberid" class="col-sm-5 control-label">머신아이디</label>
                  <div class="col-sm-7">
                    <input id="sch_memberid" name="sch_memberid" value="${param['sch_memberid']}" class="form-control" placeholder="머신아이디"   <c:if test="${!isAdmin}">disabled</c:if>>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <label for="sch_machine_name"  class="col-sm-5 control-label">머신명</label>
                  <div class="col-sm-7">
                    <input id="sch_machine_name" name="sch_machine_name" value="${param['sch_machine_name']}" class="form-control" placeholder="머신명" <c:if test="${!isAdmin}">disabled</c:if>>
                  </div>
                </div>
              </div>

              <div class="col-md-3">
                <div class="form-group">
                  <label for="sch_member_name"  class="col-sm-5 control-label">회원명</label>
                  <div class="col-sm-7">
                    <input id="sch_member_name" name="sch_member_name" value="${param['sch_member_name']}" class="form-control" placeholder="회원명" <c:if test="${!isAdmin}">disabled</c:if>>
                  </div>
                </div>
              </div>

              <div class="col-md-3">
                <div class="form-group">
                  <label for="sch_memberid" class="col-sm-5 control-label">회원아이디</label>
                  <div class="col-sm-7">
                    <input id="sch_memberid" name="sch_memberid" value="${param['sch_memberid']}" class="form-control" placeholder="회원아이디"   <c:if test="${!isAdmin}">disabled</c:if>>
                  </div>
                </div>
              </div>

            </div>
  </c:if>
            <c:if test="${!isAdmin}">
              <div class="box-body border-bottom">
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="info_memberid" class="col-sm-4 control-label">회원아이디</label>
                    <div class="col-sm-8">
                      <input id="info_memberid" name="info_memberid" class="form-control" placeholder="회원아이디" value="${sessionScope.memberid}"  disabled>
                    </div>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <label for="info_machine_name"  class="col-sm-4 control-label">회원명</label>
                    <div class="col-sm-8">
                      <input id="info_machine_name" name="info_machine_name" class="form-control" placeholder="회원명" value="${sessionScope.name}" disabled>
                    </div>
                  </div>
                </div>

                <div class="col-md-4">
                  <div class="form-group">
                    <label for="info_machine_contactpoint" class="col-sm-4 control-label">회원연락처</label>
                    <div class="col-sm-8">
                      <input id="info_machine_contactpoint" name="info_machine_contactpoint" class="form-control" placeholder="회원연락처" value="${sessionScope.contactpoint}" disabled>
                    </div>
                  </div>
                </div>
              </div>
            </c:if>

            <div class="box-body border-bottom">
              <div class="col-md-6">
                <div class="form-group">
                  <label  class="col-sm-22 control-label">검사일자</label>
                  <div class="col-sm-9">
                    <div class="input-group">
                      <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                      </div>
                      <input id="scantime" name="scantime" value="${param['scantime']}" type="text" class="form-control pull-right datepicker" >
                      <div class="input-group-addon">
                        <i class="fa fa-times remove-date"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>


            </div>
            <div class="box-body  border-bottom-big">
              <div class="col-md-4">
                <div class="form-group">
                  <label for="sch_member_name" class="col-sm-4 control-label">이름</label>
                  <div class="col-sm-8">
                    <input id="sch_scanning_name" name="sch_scanning_name" value="${param['sch_scanning_name']}" class="form-control" placeholder="이름">
                  </div>
                </div>
              </div>
              <div class="col-md-8">
                <div class="form-group">
                  <label for="sch_juminnumber" class="col-sm-4 control-label">주민등록번호앞자리(6자)</label>
                  <div class="col-sm-8">
                    <input id="sch_juminnumber" name="sch_juminnumber" value="${param['sch_juminnumber']}" class="form-control" placeholder="주민등록번호앞자리(6자)">
                  </div>
                </div>
              </div>
            </div>



            <div class="box-footer text-align-center box-bg-foot">
              <a id="searchBtn"><img src="/image/btn_search_off.png"/><%--검색--%></a>
            </div>

          </form><!-- form end -->

        </div>
      </div>

      <div class="col-xs-12">
        <div class="box">
          <div class="box-header">
            <h3 class="box-title"></h3>
            <div class="box-tools">
            </div>
          </div>
          <div id="info_table_div" class="box-body table-responsive no-padding" >
            <table class="table table-hover table-th-grey">
              <colgroup>
                <col style="width: 20px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
                <col style="width: 100px;"/>
              </colgroup>
              <thead>
              <tr>
                <th >No.</th>
                <th >시간</th>
                <th >카드<br>종류</th>
                <th >이름</th>
                <th >주민등록번호</th>
                <th >발급일자</th>
                <%--<th >면허번호</th>--%>
                <%--<th >일련번호</th>--%>
                <th >신분증진위여부</th>
                <%--<th >정보진위여부&lt;%&ndash;(일치, 불일치)&ndash;%&gt;</th>--%>
                <th >성인판별여부</th>
                <th >회원명</th>
                <th >회원아이디</th>
                <th >머신명</th>
                <th >머신아이디</th>
                <th >Sign 이미지</th>

              </tr>
              </thead>
              <tbody>

              <c:if test="${not empty data}">
                <c:forEach items="${data}" var="rows" varStatus="idx">
                  <tr class="clickTr"
                      idx="${idx.index}"
                      memberid="${rows.memberid}"
                      scantime="${rows.scantime}"
                      imagefilepath="${rows.imagefilepath}"
                      generalimagefile="${rows.generalimagefile}" irimagefile="${rows.irimagefile}" signimagefile="${rows.signimagefile}"
                      memberid="${rows.memberid}" member_name="${rows.member_name}" member_contactpoint="${rows.member_contactpoint}"
                      >
                    <td>${idx.count}</td>
                    <td>${rows.scantime}</td>
                    <td width="200">${rows.cardkindnm}</td>
                    <td>${rows.name}</td>
                    <td>${rows.juminnumber}</td>
                    <td>${rows.issuedate}</td>
                    <%--<td>${rows.licensenumber}</td>--%>
                    <%--<td>${rows.serialnumber}</td>--%>
                    <td>${rows.realcardflagnm}
                    </td>
                    <%--<td>${rows.realnameflagnm}</td>--%>
                    <td>${rows.adultflagnm}</td>
                    <td>${rows.member_name}</td>
                    <td>${rows.memberid}</td>
                    <td>${rows.machine_name}</td>
                    <td>${rows.memberid}</td>
                    <td><img src="${rows.imagefilepath}${rows.signimagefile}" width="50"></td>

                  </tr>
                </c:forEach>
              </c:if>
              <c:if test="${empty data}">
                <tr>
                  <td colspan="16">데이터가 없습니다.</td>
                </tr>
              </c:if>
              </tbody>
            </table>
          </div>
          <div class="box-footer clearfix">
          </div>
        </div>
      </div>

      <div class="col-xs-12">
        <div class="box">
          <div id="imgContainer"  class="box-body">
            <div id="gDiv" class="col-md-5">
              <div class="box-header-sm">
                <h3 class="box-title-sm"><%--일반이미지--%><img src="/image/txt_general.png"/></h3>
                <div class="box-tools">
                </div>
              </div>
              <div class="box" >
                <img class="gImage" src="" width="356" <%--height="330"--%>>
              </div>
            </div>
            <div id="irDiv" class="col-md-5">
              <div class="box-header-sm">
                <h3 class="box-title-sm"><%--IR이미지--%><img src="/image/txt_ir.png"/></h3>
                <div class="box-tools">
                </div>
              </div>
              <div class="box">
                <img class="irImage" src="" width="356" <%--height="330"--%>>
              </div>
            </div>
            <div class="col-md-2 noprint">
              <div class="v-align-bottom imgHover">
                <span id="idxSpan" style="display:none"></span>
                <a id="excelDn"><img src="/image/bt_save_excel_off.png"/></a>
                <a id="printBtn"><img src="/image/bt_print_off.png"/></a>
                <button id="deleteBtn" class="btn btn-round btn-warning btn-wide"><span>삭제</span></button>
                <button id="deleteTempBtn" class="btn btn-round btn-danger btn-wide"><span>임시파일삭제</span></button>

              </div>
            </div>
          </div>
        </div>
      </div>


    </div><!-- /.row -->
<form id="deleteFrm" method="post">
  <input type="hidden" id="memberid" name="memberid" value="">
  <input type="hidden" id="del_scantime" name="scantime" value="">
  <input type="hidden" id="generalimagefile" name="generalimagefile" value="">
  <input type="hidden" id="irimagefile" name="irimagefile" value="">
  <input type="hidden" id="signimagefile" name="signimagefile" value="">
  <input type="hidden" id="imagefilepath" name="imagefilepath" value="">
</form>
  </section>

</div>
<script>
  <!--//bind start -->
  $(function() {

    $('#deleteBtn').click(function () {
      var memberid = $('#memberid').val();
      var scantime = $('#del_scantime').val();
      var generalimagefile = $('#generalimagefile').val();
      var irimagefile = $('#irimagefile').val();
      var signimagefile = $('#signimagefile').val();
      var imagefilepath = $('#imagefilepath').val();

      if(memberid ==null  || memberid=="" || scantime==null || scantime==""){
        alert('선택해주세요.');
        return;
      }


      if (confirm("삭제하시겠습니까?")) {


        var isGExist =(generalimagefile ==null  || generalimagefile=="" );
        var isRExist =(irimagefile ==null  || irimagefile=="" );
        var isSExist =(signimagefile ==null  || signimagefile=="" );

        var req = {};

        req.memberid = memberid;
        req.scantime = scantime;
        req.generalimagefile = generalimagefile ;
        req.irimagefile = irimagefile ;
        req.signimagefile = signimagefile ;
        req.imagefilepath = imagefilepath ;


        if(isGExist && isRExist && isSExist ){
          if (confirm("해당 존재하는 이미지파일이 없어 선택한 스캔시간의 모든이력이 삭제됩니다. \n 삭제하시겠습니까?")) {

            $als.execute('<c:url value="/history/delete"/>', req, function (data) {
            var url = "";
            if (data.result_message == 'success') {
            alert('삭제되었습니다.');
            url = '/history/list';

            } else {
            alert(data.result_message);

            url = '<c:url value="/"/>';
            }
              location.href=url;
            }, function (err) {
            alert(err.result_message);
            });
          }


        }else{


          $als.execute('<c:url value="/history/delete"/>', req, function (data) {
          var url = "";
          if (data.result_message == 'success') {
          alert('삭제되었습니다.');
          url = '/history/list';

          } else {
          alert(data.result_message);

          url = '<c:url value="/"/>';
          }
        location.href=url;
          }, function (err) {
          alert(err.result_message);
          });
        }

      }
    });

    <c:if test="${isAdmin}">
       setClickedMenuBold(3);
    </c:if>
    <c:if test="${!isAdmin}">
       setClickedMenuBold(1);
    </c:if>

    $('#searchBtn').click(function(){
      $('#searchFrm').attr('action','/history/search');
      $('#searchFrm').submit();
    });

    $('#excelDn').click(function(){
      var url = '';
      var req = $('#searchFrm').serialize();
      if($('#idxSpan').text()!='' || $('#idxSpan').text()!=null){
        url = '/history/excel_transform_controller/'+$('#idxSpan').text();
      }else{
        url = '/history/excel_transform_controller';
      }
      $('#searchFrm').attr('action',url);
      $('#searchFrm').submit();
    });

    $('#printBtn').click(function(){
      var contents = $("#info_table_div").html();
      var imgContainer = $("#imgContainer").html();
      contents = contents + imgContainer;
      var frame1 = $('<iframe />');
      frame1[0].name = "frame1";
      frame1.css({ "position": "absolute", "top": "-1000000px" });
      $("body").append(frame1);
      var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
      frameDoc.document.open();

      frameDoc.document.write('<html><head><title>사용이력</title>');
      frameDoc.document.write('</head><body>');

      frameDoc.document.write('<link href="<c:url value="/css/style.css"/>" rel="stylesheet" type="text/css" />');

      frameDoc.document.write(contents);
      frameDoc.document.write('</body></html>');
      frameDoc.document.close();
      setTimeout(function () {
        window.frames["frame1"].focus();
        window.frames["frame1"].print();
        frame1.remove();
      }, 500);
    });


    $('.clickTr').dblclick(function(){
      $('#info_table_div > table > tbody > tr').removeClass('bg-green');
      $('#info_table_div > table > tbody > tr').removeClass('bg-yellow');
      $(this).addClass('bg-green');

      var idx = $(this).attr('idx');
      var imagefilepath = $(this).attr('imagefilepath');
      var generalimagefile = $(this).attr('generalimagefile');
      var irimagefile = $(this).attr('irimagefile');
      var signimagefile = $(this).attr('signimagefile');

      var memberid = $(this).attr('memberid');
      var member_name = $(this).attr('member_name');
      var member_contactpoint = $(this).attr('member_contactpoint');


      var gImageScr =  imagefilepath + generalimagefile;
      var irImageScr =  imagefilepath + irimagefile;

      $('.gImage').attr('src',gImageScr);
      $('.irImage').attr('src',irImageScr);


      $('#idxSpan').text(idx);
      $('#info_memberid').val(memberid);
      $('#info_machine_name').val(member_name);
      $('#info_machine_contactpoint').val(member_contactpoint);

    });

    $('.clickTr').click(function(){

      $('#info_table_div > table > tbody > tr').removeClass('bg-green');
      $('#info_table_div > table > tbody > tr').removeClass('bg-yellow');
      $(this).addClass('bg-yellow');

      var memberid = $(this).attr('memberid');
      var scantime = $(this).attr('scantime');

      var imagefilepath = $(this).attr('imagefilepath');
      var generalimagefile = $(this).attr('generalimagefile');
      var irimagefile = $(this).attr('irimagefile');
      var signimagefile = $(this).attr('signimagefile');


      $('#memberid').val(memberid);
      $('#del_scantime').val(scantime);
      $('#imagefilepath').val(imagefilepath);
      $('#generalimagefile').val(generalimagefile);
      $('#irimagefile').val(irimagefile);
      $('#signimagefile').val(signimagefile);


    });

    $('.remove-date').click(function(){
      var el_id = $(this).parent().siblings('input').attr('id');
      $('#'+el_id+'.datepicker').daterangepicker({
        locale: {
          format: 'YYYY.MM.DD'
        },
        "startDate": "",
        "endDate": ""
      });
    });

    $('#scantime.datepicker').daterangepicker({
      locale: {
        format: 'YYYY.MM.DD'
      },
      <c:if test="${param['scantime_low'] != null and param['scantime_low'] != '' }">
      "startDate":"${param['scantime_low']}",
      "endDate":"${param['scantime_high']}"
      </c:if>
      <c:if test="${param['scantime'] == null or param['scantime'] == '' }">
      "startDate":moment().subtract(1, 'month').startOf('month'),
      "endDate":moment()
      </c:if>


    });

  });
  <!-- bind end -->

</script>
</body>
</html>
<%--<script type="text/javascript">--%>
  <%--document.write('<img src="images/theImage.gif?t=' + new Date().getTime() + '" alt="" />');--%>
<%--</script>--%>
