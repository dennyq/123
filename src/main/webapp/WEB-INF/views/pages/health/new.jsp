<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>

<input type="hidden" name="isNew" value="Y"/>


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

<div>
    //todo: 업로드된 파일 리스트
    healthindex,
    healthtitle,
    regid,
    healthcontent,
    searchcount,
    thumbnailfile,
    regtime
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="health_filename" class="col-sm-1 ">파일</label>
        <div class="col-sm-11">
            <input name="health_filename" id="health_filename" placeholder="사진 파일" class="form-control" type="file">
        </div>
    </div>
</div>

