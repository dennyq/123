<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
</head>
<body style="min-height: 600px;">
<%--${result_code}<br>--%>
<%--${result_message}<br>--%>
<%--${url}<br>--%>
<%--${idx}<br>--%>


<script type="text/javascript">
    var result_code = '${result_code}';
    var message = '${result_message}';
    var returnUrl = '${url}';
    var idx = '${idx}';
    if (message == 'password_not_match') {
        message = '비밀번호가 일치하지 않습니다.';
    } else if (message == 'id_exist') {
        message = '존재하는 아이디입니다.';
    } else if (message == 'already_exist') {
        message = idx+'번째 행은 존재하는 데이터입니다.';
    } else if (message == 'need_login') {
        message = '로그인이 필요한 페이지입니다.';
    } else if (message == 'no_data') {
        message = '데이터가 없습니다.';
    }

    alert(message);
//    console.log(result_code);
//    console.log(message);
//
//    console.log(returnUrl);
//
//    console.log(idx);

    if (returnUrl != '' && returnUrl != 'null') {

        document.location.href = returnUrl;

    } else if (idx != '' && idx != 'null' && result_code=='9010') {
        document.location.href = returnUrl;


    } else if (idx != '' && idx != 'null' && result_code=='9011' && result_code=='9011') {
        document.location.href = returnUrl;


    } else {


        document.location.href = '<c:url value="/"/> ';
    }



</script>

</body></html>