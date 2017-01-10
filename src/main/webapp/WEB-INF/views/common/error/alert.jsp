<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
</head>
<body style="min-height: 600px;">
<script type="text/javascript">
    var message = '${result_message}';
    var returnUrl = '${url}';
    if(message=='password_not_match'){
        message='비밀번호가 일치하지 않습니다.';
    }else if(message=='id_exist'){
        message='존재하는 아이디입니다.';
    }else if(message=='need_login'){
        message='로그인이 필요한 페이지입니다.';
    }else if(message=='no_data'){
        message='데이터가 없습니다.';
    }
    alert(message);
    if(returnUrl != '' && returnUrl != null){
        document.location.href = returnUrl;
    }else{
        document.location.href = '<c:url value="/"/> ';
    }



</script>

</body></html>