<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<input type="hidden"  name="isNew" value="N"/>
<input type="hidden"  name="healthindex" value="${data.healthindex}"/>
<div class="col-md-12">
    <div class="form-group">
        <label for="regid" class="col-sm-1">아이디</label>
        <div class="col-sm-2">
            <input name="regid" id="regid" placeholder="제목" class="form-control" value="${data.regid}" readonly>
        </div>
        <label for="name" class="col-sm-1">이름</label>
        <div class="col-sm-2">
            <input name="name" id="name" placeholder="제목" class="form-control" value="${data.name}" readonly>
        </div>
        <label for="telephone" class="col-sm-1">전화번호</label>
        <div class="col-sm-2">
            <input name="telephone" id="telephone" placeholder="제목" class="form-control" value="${data.telephone}" readonly>
        </div>
        <label for="handphone" class="col-sm-1">휴대폰번호</label>
        <div class="col-sm-2">
            <input name="handphone" id="handphone" placeholder="제목" class="form-control" value="${data.handphone}" readonly>
        </div>
    </div>
</div>

<div class="col-md-12">
    <div class="form-group">
        <label for="job" class="col-sm-1">직업</label>
        <div class="col-sm-2">
            <input name="job" id="job" placeholder="제목" class="form-control" value="${data.job}" readonly>
        </div>
        <label for="specialty" class="col-sm-1">전문</label>
        <div class="col-sm-2">
            <input name="specialty" id="specialty" placeholder="제목" class="form-control" value="${data.specialty}" readonly>
        </div>
        <label for="belongto" class="col-sm-1">소속</label>
        <div class="col-sm-2">
            <input name="belongto" id="belongto" placeholder="제목" class="form-control" value="${data.belongto}" readonly>
        </div>
        <label for="career" class="col-sm-1">경력</label>
        <div class="col-sm-2">
            <input name="career" id="career" placeholder="제목" class="form-control" value="${data.career}" readonly>
        </div>
    </div>
</div>


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
        <label for="searchcount" class="col-sm-1">조회수</label>

        <div class="col-sm-1">
            <input name="searchcount" id="searchcount" placeholder="조회수" class="form-control" value="${data.searchcount}" readonly style="border: none;background: white">
        </div>
        <label for="specialty" class="col-sm-1">하트수</label>

        <div class="col-sm-1">
            <input name="heartcount" id="heartcount" placeholder="하트수" class="form-control" value="${data.heartcount}" readonly style="border: none;background: white">
        </div>
        <label for="regtime" class="col-sm-3">등록 시간</label>

        <div class="col-sm-4">
            <input name="regtime" id="regtime" placeholder="등록 시간" class="form-control" value="${data.regtime}" readonly style="border: none;background: white">
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
        <label for="thumbnailfile" class="col-sm-2 ">썸네일 : </label>
        <div class="col-sm-10">
            <a href="/upload/healthinfo/thumbnailfile/${data.thumbnailfile}" style="cursor: pointer;text-decoration: underline;color: blue"> ${data.thumbnailfile}</a>
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label for="thumbnailfile" class="col-sm-2 ">썸네일파일수정</label>
        <div class="col-sm-10">
            <input name="thumbnailfile" id="thumbnailfile" placeholder="썸네일파일첨부" class="form-control" type="file" value="${data.thumbnailfile}">
        </div>
    </div>
</div>


-=--
번호 파일명 사진 사진순서 사진순서 삭제