<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<input type="hidden"  name="isNew" value="N"/>

<div class="col-md-12">
  <%--<div class="form-group">--%>
    <%--<label for="introduce" class="col-sm-2 ">회원기타소개</label>--%>
    <%--<div class="col-sm-9">--%>
      <%--<input name="introduce"  id="introduce" placeholder="회원기타소개" class="form-control datepicker" value="${data.introduce}">--%>
    <%--</div>--%>
  <%--</div>--%>

  <div class="form-group">
    <label for="healthindex" class="col-sm-4 ">아이디</label>
    <div class="col-sm-6">
      <input name="healthindex"  id="healthindex" placeholder="아이디" class="form-control" value="${data.healthindex}">
    </div>
  </div>
  <div class="form-group">
    <label for="newPassword" class="col-sm-4 ">새비밀번호</label>
    <div class="col-sm-6">
      <input name="newPassword"  id="newPassword" placeholder="새비밀번호" class="form-control" type="password">
    </div>
  </div>
  <div class="form-group">
    <label for="password" class="col-sm-4 ">비밀번호확인</label>
    <div class="col-sm-6">
      <input name="password"  id="password" placeholder="비밀번호확인" class="form-control" type="password">
    </div>
  </div>
</div>