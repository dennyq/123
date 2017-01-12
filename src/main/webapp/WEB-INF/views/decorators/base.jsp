<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <%--<link href='https://cdn.rawgit.com/theeluwin/NotoSansKR-Hestia/master/stylesheets/NotoSansKR-Hestia.css' rel='stylesheet' type='text/css'>--%>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

  <title><decorator:title/></title>

  <page:applyDecorator name="headLib"/>

  <decorator:head/>
</head>
<body class="skin-white layout-top-nav" style="height: auto;">
<div class="wrapper" style="height: auto;">

  <div class="wrapper">
    <page:applyDecorator name="header"/>

    <!-- Left side column. contains the logo and sidebar -->
    <%--<page:applyDecorator name="left"/>--%>

    <!-- Content Wrapper. Contains page content -->
    <%--<div class="content-wrapper">--%>
      <div class="container">
        <page:applyDecorator name="lib"/>
        <decorator:body/>
        <!-- Content Header (Page header) -->

      </div>
    <%--</div>--%>
    <!-- /.content-wrapper -->




  </div>
  <!-- ./wrapper -->


<script>
//  var monitorSetTimeOut =null;
  $(function(){
    var minH = $('.main-sidebar').outerHeight()-356;
    $('.sidebar-menu').css('minHeight',minH);
    $('.sub-logo').click(function(){
      location.href='/';
    })

  });



  $(function () {
//    $('.sidebar-menu li, .sidebar-menu li a').click(function(){
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

