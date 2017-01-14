<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>

<input type="hidden"  name="isNew" value="N"/>
<div class="col-md-12">
  <div class="form-group">
    <label for="memberid" class="col-sm-2 ">아이디</label>

    <div class="col-sm-3">
      <input name="memberid"  id="memberid" placeholder="아이디" class="form-control" value="${data.memberid}">
    </div>

  </div>
</div>

<div class="col-md-6">

  <div class="form-group">
    <label for="password" class="col-sm-4 ">비밀번호</label>

    <div class="col-sm-6">
      <input name="password"  id="password" type="password" placeholder="비밀번호" class="form-control" >
    </div>
  </div>

  <div class="form-group">
    <label for="name" class="col-sm-4 ">이름</label>

    <div class="col-sm-6">
      <input name="name"  id="name" placeholder="이름" class="form-control" value="${data.name}">
    </div>
  </div>
  <div class="form-group">
    <label for="name" class="col-sm-4 ">주소</label>

    <div class="col-sm-6">
      <input name="name"  id="name" placeholder="주소" class="form-control" value="${data.name}">
    </div>
  </div>

  <div class="form-group">
    <label for="telephone" class="col-sm-4 ">전화번호</label>

    <div class="col-sm-6">
      <input name="telephone"  id="telephone" placeholder="전화번호" class="form-control" value="${data.telephone}">
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
    <label for="cfrm_password" class="col-sm-4 ">비밀번호확인</label>

    <div class="col-sm-6">
      <input name="cfrm_password"  id="cfrm_password" type="password" placeholder="비밀번호확인" class="form-control" value="${data.cfrm_password}">
    </div>

  </div>

  <div class="form-group">
    <label for="joindate" class="col-sm-4 ">기타 주소입력</label>

    <div class="col-sm-6">
      <input name="joindate"  id="joindate" placeholder="기타 주소입력" class="form-control datepicker" value="${data.joindate}">
    </div>

  </div>

  <div class="form-group">
    <label for="handphone" class="col-sm-4 ">휴대폰</label>

    <div class="col-sm-6">
      <input name="handphone"  id="handphone" placeholder="휴대폰" class="form-control" value="${data.handphone}">
    </div>
  </div>

  <div class="form-group">
    <label for="usestartdate" class="col-sm-4 ">사용시작일자</label>

    <div class="col-sm-6">
      <input name="usestartdate"  id="usestartdate" placeholder="사용시작일자" class="form-control datepicker" value="${data.usestartdate}">
    </div>

  </div>

  <div class="form-group">
    <label for="useenddate" class="col-sm-4 ">사용종료일자</label>

    <div class="col-sm-6">
      <input name="useenddate"  id="useenddate" placeholder="사용종료일자" class="form-control datepicker" value="${data.useenddate}">
    </div>

  </div>

  <div class="form-group">
    <label for="useenddate" class="col-sm-4 ">회원기타소개</label>

    <div class="col-sm-6">
      <input name="useenddate"  id="useenddate" placeholder="회원기타소개" class="form-control datepicker" value="${data.useenddate}">
    </div>

  </div>
</div>