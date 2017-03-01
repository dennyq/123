<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<link rel="stylesheet" href="/dist/css/style.css?vs=170226">
<style>
    /*.btn-box{*/
        /*background-color: #0e83a4 !important;*/
        /*color: #fff!important;*/
        /*padding: 7px 10px 10px 9px!important;*/
    /*}*/
</style>
<form id="detailFrm" class="form-horizontal" action="<c:url value="/member/excelSave"/>" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="excelfile" class="col-sm-4 ">일괄등록파일</label>

        <div class="col-sm-6">
            <input type="file" name="excelfile" id="excelfile" placeholder="일괄등록파일" class="form-control">
        </div>
    </div>

    <div class="btn-box centeringContainer ">
      <span class="centered">
        <a id="saveFileBtn" class="pointer btn btn-blue-green btn-flat md-height" style="cursor:pointer">일괄등록</a>
      </span>
    </div>

</form>
<script src="/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script>
    $(function(){
       $('#saveFileBtn').click(function(){
           console.log('aaa');
           $('#detailFrm').submit();
       })
    });
</script>
