<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<%--<footer class="main-footer">--%>
  <%--<div class="pull-left hidden-xs">--%>
    <%--<b>Version</b> 2.3.6--%>
  <%--</div>--%>
  <%--<strong>Copyright &copy; 2014-2016 <a href="http://almsaeedstudio.com">Almsaeed Studio</a>.</strong> All rights--%>
  <%--reserved.--%>
<%--</footer>--%>
<div class="lower-logo" style="height: 50px">
  Copyright@Pharmacy4u.All Rights Reserved.
</div>
<script>
  $(function(){
    var bodyHeight = $('body').height();
    console.log(bodyHeight)
    var windowHeight = $(window).height();
    console.log(windowHeight)
    var footerHeight = 50;
    var loginHeight = 0;
    var isSmall = bodyHeight<(windowHeight);
    if(isSmall){
      $('.wrapper').css('height',windowHeight-footerHeight-loginHeight+'px');
      $('.lower-logo').css('height',footerHeight+'px');
    }

//    console.log(windowHeight);


  })
</script>
