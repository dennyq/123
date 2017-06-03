<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<input type="hidden"  name="isNew" value="N"/>

<div class="col-md-6">
    <div class="form-group">
        <label for="specialid" class="col-sm-4 ">아이디</label>
        <div class="col-sm-8">
            <input name="specialid" id="specialid" placeholder="아이디" class="form-control" value="${data.specialid}" readonly>
        </div>
        <input type="hidden" id="idCheck" value="N"/>
    </div>
    <div class="form-group">
        <label for="name" class="col-sm-4 ">이름</label>
        <div class="col-sm-8">
            <input name="name" id="name" placeholder="이름" class="form-control" value="${data.name}">
        </div>
    </div>
    <div class="form-group">
        <label for="telephone" class="col-sm-4 ">전화번호</label>
        <div class="col-sm-8">
            <input name="telephone" id="telephone" placeholder="전화번호" class="form-control" value="${data.telephone}">
        </div>
    </div>

</div>
<!--// left input end -->

<!-- right input start -->

<div class="col-md-6 right">
    <div class="form-group">
        <div class="col-sm-8" style="height: 36px">
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
            <input name="handphone" id="handphone" placeholder="휴대폰" class="form-control" value="${data.handphone}">
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="form-group">
        <label for="picturename" class="col-sm-2 ">사진 파일</label>
        <div class="col-sm-10">
            <input name="picturename" id="picturename" placeholder="사진 파일" class="form-control" type="file">
        </div>
    </div>
</div>
<div style="height: 200px;"></div>
<!--// right input end -->
<div class="col-md-6">

    <div class="form-group">
        <label for="job" class="col-sm-4 ">직업</label>
        <div class="col-sm-8">
            <input name="job" id="job" placeholder="직업" class="form-control" value="${data.job}">
        </div>
    </div>
    <div class="form-group">
        <label for="belongto" class="col-sm-4 ">소속</label>
        <div class="col-sm-8">
            <input name="belongto" id="belongto" placeholder="소속" class="form-control" value="${data.belongto}">
        </div>
    </div>
    <div class="form-group">
        <label for="usestartdate" class="col-sm-4 ">사용시작일자</label>
        <div class="col-sm-8">
            <input name="usestartdate"  id="usestartdate" placeholder="사용시작일자" class="form-control datepicker" value="${data.usestartdate}">
        </div>
    </div>

</div>
<!--// left input end -->

<!-- right input start -->

<div class="col-md-6 right">

    <div class="form-group">
        <label for="specialty" class="col-sm-4 ">전문</label>
        <div class="col-sm-8">
            <input name="specialty" id="specialty" placeholder="전문" class="form-control" value="${data.specialty}">
        </div>
    </div>
    <div class="form-group">
        <label for="career" class="col-sm-4 ">경력</label>
        <div class="col-sm-8">
            <input name="career" id="career" placeholder="경력" class="form-control" value="${data.career}">
        </div>
    </div>
    <div class="form-group">
        <label for="useenddate" class="col-sm-4 ">사용종료일자</label>
        <div class="col-sm-8">
            <input name="useenddate"  id="useenddate" placeholder="사용종료일자" class="form-control datepicker" value="${data.useenddate}">
        </div>
    </div>


</div>
<div class="col-md-12">
    <div class="form-group">
        <label for="regtime" class="col-sm-2 ">등록시간</label>
        <div class="col-sm-10">
            <input name="regtime"  id="regtime" placeholder="등록시간" class="form-control" value="${data.regtime}" readonly>
        </div>
    </div>
</div>