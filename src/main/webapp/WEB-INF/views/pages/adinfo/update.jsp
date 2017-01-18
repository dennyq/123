<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<input type="hidden"  name="isNew" value="N"/>

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
      <input name="telephone"  id="telephone" placeholder="회원명" class="form-control" value="${data.telephone}">
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
      <input name="filename"  id="filename" placeholder="광고 파일" class="form-control" value="${data.filename}"  type="file">
    </div>
  </div>
</div>
<div style="height: 200px;"></div>
<!--// right input end -->
