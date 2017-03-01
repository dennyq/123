<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<%--${data}--%>

<form id="detailFrm" class="form-horizontal" action="<c:url value="/member/excelSave"/>" method="post">
  <div class="form-group">
    <label for="file" class="col-sm-4 ">일괄등록파일</label>
    <div class="col-sm-6">
      <input type="file" name="file" id="file" placeholder="일괄등록파일" class="form-control" >
    </div>
  </div>
</form>
