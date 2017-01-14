<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>

<input type="hidden"  name="isNew" value="Y"/>
<input type="hidden"  name="openflag" value="0"/>
<input type="hidden"  name="deleteyn" value="0"/>
<!-- left input start -->
<div class="col-md-6">
  <div class="form-group">
    <label for="memberid" class="col-sm-4 ">아이디</label>
    <div class="col-sm-4">
      <input name="memberid"  id="memberid" placeholder="아이디" class="form-control" style="    width:130px">
    </div>
    <a id="id_check" onmouseover="chageImgSrc(this);"><img src="/imgs/bt_check_id.png" style="margin-left: -25px;"/></a>
    <input type="hidden" id="idCheck" value="N"/>
  </div>
  <div class="form-group">
    <label for="password" class="col-sm-4 ">비밀번호</label>
    <div class="col-sm-6">
      <input name="password" type="password"  id="password" placeholder="비밀번호" class="form-control">
    </div>
  </div>
  <div class="form-group">
    <label for="name" class="col-sm-4 ">회원명</label>
    <div class="col-sm-6">
      <input name="name"  id="name" placeholder="회원명" class="form-control">
    </div>
  </div>

  <div class="form-group">
    <label for="address" class="col-sm-4 ">주소</label>
    <div class="col-sm-6">
      <input name="address"  id="address" placeholder="주소" class="form-control">
    </div>
  </div>
  <div class="form-group">
    <label for="telephone" class="col-sm-4 ">전화번호</label>
    <div class="col-sm-6">
      <input name="telephone"  id="telephone" placeholder="전화번호" class="form-control">
    </div>
  </div>
  <div class="form-group">
    <label for="usestartdate" class="col-sm-4 ">사용시작일자</label>
    <div class="col-sm-6">
      <input name="usestartdate"  id="usestartdate" placeholder="사용시작일자" class="form-control datepicker">
    </div>
  </div>
</div>
<!--// left input end -->

<!-- right input start -->
<div class="col-md-6 right">
  <div class="form-group">
    <label for="name" class="col-sm-4 ">구분선택</label>
    <div class="col-sm-6" style="height: 34px">
      <input type="radio" name="gubun" value="1" checked>약국&nbsp;
      <input type="radio" name="gubun" value="2">병원
    </div>
  </div>
  <div class="form-group">
    <label for="cfrm_password" class="col-sm-4 ">비밀번호확인</label>
    <div class="col-sm-6">
      <input name="cfrm_password" id="cfrm_password" placeholder="비밀번호확인" class="form-control" type="password" >
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-4 "></label>
    <div class="col-sm-6" style="height: 34px">
      <input type="hidden">
    </div>
  </div>
  <div class="form-group">
    <label for="address_etc" class="col-sm-4 ">기타주소입력</label>
    <div class="col-sm-6">
      <input name="address_etc"  id="address_etc" placeholder="기타주소입력" class="form-control">
    </div>
  </div>
  <div class="form-group">
    <label for="handphone" class="col-sm-4 ">휴대폰</label>
    <div class="col-sm-6">
      <input name="handphone"  id="handphone" placeholder="휴대폰" class="form-control">
    </div>
  </div>
  <div class="form-group">
    <label for="useenddate" class="col-sm-4 ">사용종료일자</label>
    <div class="col-sm-6">
      <input name="useenddate"  id="useenddate" placeholder="사용종료일자" class="form-control datepicker">
    </div>
  </div>
  <div class="form-group">
    <label for="introduce" class="col-sm-4 ">회원기타소개</label>
    <div class="col-sm-6">
      <input name="introduce"  id="introduce" placeholder="회원기타소개" class="form-control">
    </div>
  </div>
</div>
<!--// right input end -->
