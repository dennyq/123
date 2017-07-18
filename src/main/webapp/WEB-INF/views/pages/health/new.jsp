<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>


<input type="hidden" name="isNew" value="Y"/>


<!-- Button trigger modal -->
<%@include file="searchModal.jsp"%>

<div class="col-md-12">
    <div class="form-group">
        <label for="regid" class="col-sm-1">아이디</label>
        <div class="col-sm-2">
            <input name="regid" id="regid" placeholder="제목" class="form-control" value="" readonly>
        </div>
        <label for="name" class="col-sm-1">이름</label>
        <div class="col-sm-2">
            <input name="name" id="name" placeholder="제목" class="form-control" value="" readonly>
        </div>
        <label for="telephone" class="col-sm-1">전화번호</label>
        <div class="col-sm-2">
            <input name="telephone" id="telephone" placeholder="제목" class="form-control" value="" readonly>
        </div>
        <label for="handphone" class="col-sm-1">휴대폰번호</label>
        <div class="col-sm-2">
            <input name="handphone" id="handphone" placeholder="제목" class="form-control" value="" readonly>
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="job" class="col-sm-1">직업</label>
        <div class="col-sm-2">
            <input name="job" id="job" placeholder="제목" class="form-control" value="" readonly>
        </div>
        <label for="specialty" class="col-sm-1">전문</label>
        <div class="col-sm-2">
            <input name="specialty" id="specialty" placeholder="제목" class="form-control" value="" readonly>
        </div>
        <label for="belongto" class="col-sm-1">소속</label>
        <div class="col-sm-2">
            <input name="belongto" id="belongto" placeholder="제목" class="form-control" value="" readonly>
        </div>
        <label for="career" class="col-sm-1">경력</label>
        <div class="col-sm-2">
            <input name="career" id="career" placeholder="제목" class="form-control" value="" readonly>
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="healthtitle" class="col-sm-1">제목</label>
        <div class="col-sm-11">
            <input name="healthtitle" id="healthtitle" placeholder="제목" class="form-control">
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <textarea name="healthcontent" id="editor1" rows="10" cols="10"></textarea>
        <script>CKEDITOR.replace('editor1')</script>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="thumbnailfile" class="col-sm-1 ">썸네일파일</label>
        <div class="col-sm-11">
            <input name="thumbnailfile" id="thumbnailfile" placeholder="사진 파일" class="form-control" type="file">
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="fileupload" class="col-sm-1 ">사진파일</label>
        <div class="col-sm-11">
            <%--<input name="thumbnailfile" id="thumbnailfile" placeholder="사진 파일" class="form-control" type="file">--%>
            <input id="fileupload" type="file" name="files" multiple>
        </div>
    </div>
</div>
<%@include file="multiFileUpload.jsp"%>