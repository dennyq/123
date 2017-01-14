<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isAdmin" value="${sessionScope.memberid == 'admin'}"/>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>공지사항 관리</title>
</head>
<body>
<form id="detailFrm" class="form-horizontal" action="<c:url value="/notice/save"/>" method="post">
<section class="content-header">
  <h1>
    공지사항 관리
  </h1>
  <div class="breadcrumb-line"></div>

  <ol class="breadcrumb">
    <li><a href="<c:url value="/"/>">HOME</a></li>
    <li ><a href="<c:url value="/notice/list"/>">공지사항</a></li>
    <li ><a href="<c:url value="/notice/detail/${data.noticenumber}"/>">공지사항
<c:if test="${not empty data}">상세</c:if>
<c:if test="${empty data and isAdmin}">등록</c:if>
      </a></li>
  </ol>
</section>

<!-- Main content -->
<section class="content">

  <div class="paddingInside">
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="">
            <div class="box-header-sm">
              <h3 class="box-title">공지사항</h3>
            </div>
            <div id="progressIndicator" style="display: none"></div>

            <!-- form start -->
            <%--<form id="detailFrm" class="form-horizontal" method="post">--%>
              <table class="table table-th-grey bottom-line-grey">
                <tbody>

                <c:if test="${not empty data}">
                  <tr>

                    <th width="10px">No.<span class="bar_grey">|</span><input type="hidden" name="noticenumber" value="${data.noticenumber}"/>${data.noticenumber}</th>
                    <th>
                      <span class="showContent" style="display: block">제목<span class="bar_grey">|</span>${data.title}</span>
                      <span class="showEditor" style="display: none">
                        <input style="width: 95%;" id="title" name="title" placeholder="제목을 입력하세요" value="${data.title}"/>
                      </span>

                      </th>
                    <th width="100px">조회수<span class="bar_grey">|</span>${data.hitcount}</th>
                    <th width="170px">등록일<span class="bar_grey">|</span>${data.regtime}</th>
                  </tr>
                  <tr style="height: 350px;min-height: 350px;">
                    <td colspan="4" >
                      <span class="showContent" style="display: block">${data.content}</span>
                      <span class="showEditor" style="display: none">
                         <textarea id="editor1" name="content" rows="10" cols="80">${data.content}</textarea>
                      </span>

                    </td>
                  </tr>

                </c:if>
                <c:if test="${empty data}">
                  <tr>
                    <th>제목 <input style="    width: 95%;" id="title" name="title" placeholder="제목을 입력하세요"/></th>
                  </tr>
                  <tr style="height: 350px;min-height: 350px;">
                    <td ><%--<textarea id="content" name="content" placeholder="내용을 입력하세요"></textarea>--%>
                       <textarea id="editor1" name="content" rows="10" cols="80"></textarea>
                    </td>
                  </tr>
                </c:if>
                </tbody>
              </table>

            <!-- form end -->
          </div><!-- /.box -->
        </div>
      </div><!-- /.row -->
    </section>

  </div>

</section>


<c:if test="${empty data}">
  <center>
  <c:if test="${isAdmin}">
    <button type="submit" class="btn btn-green btn-flat md-height">저장</button>
  </c:if>

    <a href="<c:url value="/notice/list"/>" class="btn btn-green btn-flat md-height">목록</a>
  </center>

</c:if>
  <c:if test="${not empty data}">
    <center>
    <c:if test="${isAdmin}">
      <a id="modifyBtn" class="btn btn-green btn-flat md-height showContent">수정</a>
      <a id="saveBtn" class="btn btn-green btn-flat md-height showEditor">저장</a>
    </c:if>
      <a href="<c:url value="/notice/list"/>" class="btn btn-green btn-flat md-height">목록</a>
    </center>

  </c:if>
</form>
<%--<img src="/image/PHARMACY4U-01_home.jpg" width="700px"/>--%>
<%--<img src="/image/PHARMACY4U-02_machine_admin.jpg" width="700px"/>--%>
<%--<img src="/image/PHARMACY4U-03_machine_edit.jpg" width="700px"/>--%>
<%--<img src="/image/PHARMACY4U-04_history_admin.jpg" width="700px"/>--%>

<!-- CK Editor -->
<script src="https://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>

<script>
  <!-- //bind start -->
  $(function(){
    $('ul.sidebar-menu li.treeview').each(function(index){
      $(this).removeClass('active')
//      console.log(this);
      var menu = $(this).attr('menu');
      if(menu=='공지사항'){
        $(this).addClass('active')
      }
    })

    CKEDITOR.replace('editor1');
    $('.showContent').show();
    $('.showEditor').hide();

    $('#modifyBtn').click(function(){
      $('.showContent').hide();
      $('.showEditor').show();

    });
    $('#saveBtn').click(function(){
      $('#detailFrm').submit();


    });
  });
  <!-- bind end -->

</script>
</body>
</html>
