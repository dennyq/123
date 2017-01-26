<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

  <title><decorator:title/></title>
  <page:applyDecorator name="headLib"/>
  <page:applyDecorator name="lib"/>
  <decorator:head/>

</head>
<body class="skin-white layout-top-nav" style="height: auto;">
<div class="wrapper" style="height: auto;">
    <page:applyDecorator name="header"/>
      <div class="container">

        <decorator:body/>
      </div>
</div>
<page:applyDecorator name="footer"/>
<script>
  $(function(){
    var minH = $('.main-sidebar').outerHeight()-356;
    $('.sidebar-menu').css('minHeight',minH);
    $('.sub-logo').click(function(){
      location.href='/';
    })
  });
  $(function () {
    $('.sidebar-menu li a').click(function(){
      if(monitorSetTimeOut!=null){
        clearTimeout(monitorSetTimeOut);
      }
      location.href = $(this).attr('gotourl');
    })
  });
</script>
</body>
</html>

