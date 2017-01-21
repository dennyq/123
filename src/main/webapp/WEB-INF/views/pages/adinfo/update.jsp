<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>

<input type="hidden"  name="isNew" value="N"/>
<input id="adindex" name="adindex" type="hidden" value="${data.adindex}">
<!-- left input start -->
<div class="col-md-12">
  <div class="form-group">
    <label for="adtitle" class="col-sm-2 ">광고 제목</label>
    <div class="col-sm-8">
      <input name="adtitle"  id="adtitle" placeholder="광고 제목" class="form-control" value="${data.adtitle}"/>
      <input type="hidden" id="adCheck" value="N"/>
    </div>
    <span class="col-sm-1"><a id="ad_check" class="btn btn-blue-green btn-flat md-height" onmouseover="chageImgSrc(this);" style="width: 100%">검색</a></span>
  </div>
</div>


<div class="col-md-6">

  <div class="form-group">
    <label for="adowner" class="col-sm-4 ">광고주명</label>
    <div class="col-sm-6">
      <input name="adowner"  id="adowner" placeholder="광고주명" class="form-control" value="${data.adowner}">
    </div>
  </div>


  <div class="form-group">
    <label for="usestartdate" class="col-sm-4 ">사용시작일자</label>
    <div class="col-sm-6">
      <input name="usestartdate"  id="usestartdate" placeholder="사용시작일자" class="form-control datepicker" value="${data.usestartdate}">
    </div>
  </div>
</div>
<!--// left input end -->

<!-- right input start -->
<div class="col-md-6 right">
  <div class="form-group">
    <label for="telephone" class="col-sm-4 ">광고주연락처</label>
    <div class="col-sm-6">
      <input name="telephone"  id="telephone" placeholder="광고주연락처" class="form-control" value="${data.telephone}">
    </div>
  </div>

  <div class="form-group">
    <label for="useenddate" class="col-sm-4 ">사용종료일자</label>
    <div class="col-sm-6">
      <input name="useenddate"  id="useenddate" placeholder="사용종료일자" class="form-control datepicker" value="${data.useenddate}">
    </div>
  </div>

</div>
<div class="col-md-12">
  <div class="form-group">
    <label for="filename" class="col-sm-2 ">광고 파일</label>
    <div class="col-sm-9">
      <c:if test="${not data.filename}">${data.filename}</c:if>
      <%--<input name="filename"  id="filename" placeholder="광고 파일" class="form-control" value=""  type="file"/>--%>
      <span class="btn btn-success fileinput-button">
      <i class="glyphicon glyphicon-plus"></i>
      <span>Select files...</span>
      <!-- The file input field used as target for the file upload widget -->
      <input id="filename" type="file" name="filename">
      </span>
      <div id="progress" class="progress">
        <div class="progress-bar progress-bar-success"></div>
      </div>
      <!-- The container for the uploaded files -->
      <div id="files" class="files"></div>
      <%--<div class="progress">--%>
        <%--<div class="bar"></div >--%>
        <%--<div class="percent">0%</div >--%>
      <%--</div>--%>

      <%--<div id="status"></div>--%>
    </div>
  </div>
</div>
<div style="height: 200px;"></div>
<!--// right input end -->
