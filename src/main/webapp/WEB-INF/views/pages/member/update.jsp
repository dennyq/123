<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<input type="hidden"  name="isNew" value="N"/>

<div class="col-md-6">
  <div class="form-group">
    <label for="memberid" class="col-sm-4 ">아이디</label>
    <div class="col-sm-6">
      <input name="memberid"  id="memberid" placeholder="아이디" class="form-control" value="${data.memberid}" readonly>
    </div>
  </div>
  <div class="form-group">
    <label for="name" class="col-sm-4 ">회원명</label>
    <div class="col-sm-6">
      <input name="name"  id="name" placeholder="회원명" class="form-control" value="${data.name}">
    </div>
  </div>
  <div class="form-group">
    <label for="address" class="col-sm-4 ">주소</label>
    <div class="col-sm-6">
      <input name="address"  id="address" placeholder="주소" class="form-control" value="${data.address}">
    </div>
  </div>
  <div class="form-group">
    <label for="telephone" class="col-sm-4 ">전화번호</label>
    <div class="col-sm-6">
      <input name="telephone"  id="telephone" placeholder="전화번호" class="form-control" value="${data.telephone}">
    </div>
  </div>
  <div class="form-group">
  <label for="latitude" class="col-sm-4 ">위도</label>
  <div class="col-sm-6">
    <input name="latitude"  id="latitude" placeholder="위도" class="form-control" value="${data.latitude}">
    <input type="hidden" name="oldlatitude"  id="oldlatitude" placeholder="위도" class="form-control" value="${data.latitude}">
  </div>
</div>
  <div class="form-group">
    <label for="usestartdate" class="col-sm-4 ">사용시작일자</label>
    <div class="col-sm-6">
      <input name="usestartdate"  id="usestartdate" placeholder="사용시작일자" class="form-control datepicker" value="${data.usestartdate}">
    </div>
  </div>

</div>

<div class="col-md-6 right">
  <div class="form-group">
    <label for="name" class="col-sm-4 ">구분선택</label>
    <div class="col-sm-6">
      <input type="radio" name="gubun" value="1" <c:if test="${data.gubun==1}">checked</c:if>>약국&nbsp;
      <input type="radio" name="gubun" value="2" <c:if test="${data.gubun==2}">checked</c:if>>병원
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-4 "></label>
    <div class="col-sm-6" style="height: 46px">
      <input type="hidden" >
    </div>
  </div>
  <div class="form-group">
    <label for="address_etc" class="col-sm-4 ">기타 주소입력</label>
    <div class="col-sm-6">
      <input name="address_etc"  id="address_etc" placeholder="기타 주소입력" class="form-control" value="${data.address_etc}">
    </div>
  </div>
  <div class="form-group">
    <label for="handphone" class="col-sm-4 ">휴대폰</label>
    <div class="col-sm-6">
      <input name="handphone"  id="handphone" placeholder="휴대폰" class="form-control" value="${data.handphone}">
    </div>
  </div>
  <div class="form-group">
    <label for="longitude" class="col-sm-4 ">경도</label>
    <div class="col-sm-6">
      <input name="longitude"  id="longitude" placeholder="경도" class="form-control" value="${data.longitude}">
      <input type="hidden" name="oldlongitude"  id="oldlongitude" placeholder="경도" class="form-control" value="${data.longitude}">
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
    <label for="introduce" class="col-sm-2 ">회원기타소개</label>
    <div class="col-sm-9">
      <input name="introduce"  id="introduce" placeholder="회원기타소개" class="form-control" value="${data.introduce}">
    </div>
  </div>
</div>