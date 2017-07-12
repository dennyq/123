<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<input type="hidden"  name="isNew" value="N"/>
<input type="hidden"  name="noticeindex" value="${data.noticeindex}"/>
<div class="col-md-12">
    <div class="form-group">
        <label for="noticetitle" class="col-sm-1">제목</label>
        <div class="col-sm-11">
            <input name="noticetitle" id="noticetitle" placeholder="제목" class="form-control" value="${data.noticetitle}">
        </div>

    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <textarea name="noticecontent" id="editor1" rows="10" cols="10">${data.noticecontent}</textarea>
        <script>CKEDITOR.replace('editor1')</script>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="notice_filename" class="col-sm-1 ">파일 :</label>
        <div class="col-sm-11">


            <c:if test="${file != null}">
                <c:forEach items="${file}" var="item">
                    <a href="/upload/notice/${item.filename}"
                          style="cursor: pointer;text-decoration: underline;color: blue">
                        ${item.filename}
                            </a> <a class="deleteFile" noticeindex="${item.noticeindex}" sequencenum="${item.sequencenum}"  filename="${item.filename}" style="cursor: pointer;text-decoration: none;color: red">x</a><br>
                </c:forEach>

            </c:if>
            <c:if test="${file == null}">
                <span style="cursor: pointer;text-decoration: underline;color: blue">
                        첨부파일이 없습니다.
                </span>
            </c:if>

            <%--<input name="notice_filename" id="notice_filename" placeholder="사진 파일" class="form-control" type="file">--%>
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label for="notice_filename" class="col-sm-2 ">파일첨부</label>
        <div class="col-sm-10">
            <input name="notice_filename" id="notice_filename" placeholder="사진 파일" class="form-control" type="file" value="${data.filename}">
        </div>
    </div>
</div>