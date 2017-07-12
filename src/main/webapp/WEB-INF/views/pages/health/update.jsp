<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<input type="hidden"  name="isNew" value="N"/>
<input type="hidden"  name="healthindex" value="${data.healthindex}"/>
<div class="col-md-12">
    <div class="form-group">
        <label for="healthtitle" class="col-sm-1">제목</label>
        <div class="col-sm-11">
            <input name="healthtitle" id="healthtitle" placeholder="제목" class="form-control" value="${data.healthtitle}">
        </div>

    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <textarea name="healthcontent" id="editor1" rows="10" cols="10">${data.healthcontent}</textarea>
        <script>CKEDITOR.replace('editor1')</script>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="health_filename" class="col-sm-1 ">파일 :</label>
        <div class="col-sm-11">


            <c:if test="${file != null}">
                <c:forEach items="${file}" var="item">
                    <a href="/upload/health/${item.filename}"
                          style="cursor: pointer;text-decoration: underline;color: blue">
                        ${item.filename}
                            </a> <a class="deleteFile" healthindex="${item.healthindex}" sequencenum="${item.sequencenum}"  filename="${item.filename}" style="cursor: pointer;text-decoration: none;color: red">x</a><br>
                </c:forEach>

            </c:if>
            <c:if test="${file == null}">
                <span style="cursor: pointer;text-decoration: underline;color: blue">
                        첨부파일이 없습니다.
                </span>
            </c:if>

            <%--<input name="health_filename" id="health_filename" placeholder="사진 파일" class="form-control" type="file">--%>
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label for="health_filename" class="col-sm-2 ">파일첨부</label>
        <div class="col-sm-10">
            <input name="health_filename" id="health_filename" placeholder="사진 파일" class="form-control" type="file" value="${data.filename}">
        </div>
    </div>
</div>