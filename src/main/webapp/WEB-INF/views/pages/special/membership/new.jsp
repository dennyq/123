<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>

<input type="hidden" name="isNew" value="Y"/>
<input type="hidden" name="openflag" value="0"/>
<input type="hidden" name="deleteyn" value="0"/>

<div class="col-md-12">
    <div class="form-group">
        <label for="specialid" class="col-sm-2">아이디</label>
        <div class="col-sm-4">
            <input name="specialid" id="specialid" placeholder="아이디" class="form-control" >
        </div>
        <a id="id_check" class="btn btn-blue-green btn-flat md-height">중복검사</a>
        <input type="hidden" id="idCheck" value="N"/>
    </div>
</div>


<!-- left input start -->
<div class="col-md-6">

    <div class="form-group">
        <label for="password" class="col-sm-4 ">비밀번호</label>
        <div class="col-sm-8">
            <input name="password" type="password" id="password" placeholder="비밀번호" class="form-control" >
        </div>
    </div>
    <div class="form-group">
        <label for="name" class="col-sm-4 ">이름</label>
        <div class="col-sm-8">
            <input name="name" id="name" placeholder="이름" class="form-control" >
        </div>
    </div>
    <div class="form-group">
        <label for="telephone" class="col-sm-4 ">전화번호</label>
        <div class="col-sm-8">
            <input name="telephone" id="telephone" placeholder="전화번호" class="form-control" >
        </div>
    </div>

</div>
<!--// left input end -->

<!-- right input start -->

<div class="col-md-6 right">
    <div class="form-group">
        <label for="cfrm_password" class="col-sm-4 ">비밀번호확인</label>
        <div class="col-sm-8">
            <input name="cfrm_password" id="cfrm_password" placeholder="비밀번호확인" class="form-control" type="password" >
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-4 "></label>
        <div class="col-sm-8" style="height: 34px">
            <input type="hidden">
        </div>
    </div>
    <div class="form-group">
        <label for="handphone" class="col-sm-4 ">휴대폰</label>
        <div class="col-sm-8">
            <input name="handphone" id="handphone" placeholder="휴대폰" class="form-control" >
        </div>
    </div>
</div>

<div style="height: 200px;"></div>

<div class="col-md-12">
    <div class="form-group">
        <label for="picturename" class="col-sm-2 ">사진 파일</label>
        <div class="col-sm-10">
            <input name="picturename" id="picturename" placeholder="사진 파일" class="form-control" type="file">
        </div>
    </div>
</div>
<!--// right input end -->
<div class="col-md-6">

    <div class="form-group">
        <label for="job" class="col-sm-4 ">직업</label>
        <div class="col-sm-8">
            <input name="job" id="job" placeholder="직업" class="form-control" value="1">
        </div>
    </div>
    <div class="form-group">
        <label for="belongto" class="col-sm-4 ">소속</label>
        <div class="col-sm-8">
            <input name="belongto" id="belongto" placeholder="소속" class="form-control" >
        </div>
    </div>

</div>
<!--// left input end -->

<!-- right input start -->

<div class="col-md-6 right">

    <div class="form-group">
        <label for="specialty" class="col-sm-4 ">전문</label>
        <div class="col-sm-8">
            <input name="specialty" id="specialty" placeholder="전문" class="form-control" >
        </div>
    </div>
    <div class="form-group">
        <label for="career" class="col-sm-4 ">경력</label>
        <div class="col-sm-8">
            <input name="career" id="career" placeholder="경력" class="form-control" >
        </div>
    </div>
</div>