<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title>ifarms</title>
  <style>
    .error_area{
      height: 500px;
      min-height: 500px;
      display: table-cell;vertical-align: middle;
    }
  </style>
</head>
<body>
<center>
  <div id="container">
    <div class="error_area type1">
      <p><strong>로그인해주세요.</strong></p>
    </div>
  </div>
</center>
<script type="text/javascript" src="<c:url value="/js/lib/jquery-1.8.3.min.js"/>"></script>
<script>

  $(function(){
    var reurl = '${param['reurl']}';

    setTimeout(function(){
      if(reurl == ''){

        <%--document.location.href='<c:url value="/special/"/>';--%>
        document.location.href='/special/';
      }else{
        document.location.href='<c:url value="/"/>?reurl='+'${param['reurl']}';
      }
    },500);
  });
</script>
</body>
</html>