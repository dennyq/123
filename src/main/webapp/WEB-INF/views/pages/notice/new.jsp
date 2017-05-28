<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>

<input type="hidden" name="isNew" value="Y"/>


<div class="col-md-12">
    <div class="form-group">
        <label for="noticetitle" class="col-sm-1">제목</label>
        <div class="col-sm-11">
            <input name="noticetitle" id="noticetitle" placeholder="제목" class="form-control">
        </div>

    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <textarea name="noticecontent" id="editor1" rows="10" cols="10"></textarea>
        <script>CKEDITOR.replace('editor1')</script>
    </div>
</div>

