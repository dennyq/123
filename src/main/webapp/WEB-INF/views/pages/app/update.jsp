<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<input type="hidden"  name="isNew" value="N"/>
<input type="hidden"  name="memberid" id="memberid" value="${data.memberid}"/>
<input type="hidden" id="setmystore" name="setmystore" value="${data.memberid}" size="30">


<div class="col-md-6">
  <div class="form-group">
    <label for="name" class="col-sm-4 ">이름</label>
    <div class="col-sm-6">
      <input name="name"  id="name" placeholder="이름" class="form-control" value="${data.name}" readonly>
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
  <div class="form-group" style="display: none">
    <label for="latitude" class="col-sm-4 ">위도</label>
    <div class="col-sm-6">
      <input type="hidden" name="latitude"  id="latitude" placeholder="위도" class="form-control" value="${data.latitude}">
    </div>
  </div>

</div>

<div class="col-md-6 right">
  <div class="form-group">
    <label class="col-sm-4 "></label>
    <div class="col-sm-6" style="height: 34px">
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
    <label for="handphone" class="col-sm-4 ">폰번호</label>
    <div class="col-sm-6">
      <input name="handphone"  id="handphone" placeholder="휴대폰" class="form-control" value="${data.handphone}">
    </div>
  </div>
  <div class="form-group" style="display: none">
    <label for="longitude" class="col-sm-4 ">경도</label>
    <div class="col-sm-6">
      <input type="hidden" name="longitude"  id="longitude" placeholder="경도" class="form-control" value="${data.longitude}">
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