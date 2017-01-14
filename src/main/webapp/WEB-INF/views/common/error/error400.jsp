<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>PHARMACY4U</title>
    <style type="text/css">
        .erobox { width:522px; margin:0 auto; padding:64px 0 64px 0; }
        .erobox .erotext_area { height:335px;/* background:url(/images/ero_bg.png) left top no-repeat; */}
        .erobox .erotext_area p { padding:84px 0 0 64px; font-size:14px; font-weight:bold; color:#0078ce; line-height:22px; }
        .erobox .err { overflow:hidden; padding:16px 0 0 0; }
        .erobox .err p { float:left; width:260px; padding:0 32px 0 32px; font-size:16px; font-weight:bold; }
        .erobox a { display:inline-block; float:left; min-width:80px; padding:12px 30px; font-weight:bold; font-family:NanumGothic; color:#ffffff; font-size:16px; text-align:center; border-radius:6px; background-color: #ff6000; }
        .headerinner {
            width: 1000px;
            height: 97px;
            margin: 0 auto;
            clear: both;
        }
        .logo a {
            display: block;
            width: 208px;
            height: 84px;
            margin: 10px 0px 0px 0px;
            /*background: url(/images/logo.jpg) no-repeat;*/
            text-indent: -9999px;
            overflow: hidden;
        }
    </style>
    <script>
        function goMain() {
            setTimeout(function () {
                location.href = '<c:url value="/"/>';
            }, 3000);
        }
    </script>
</head>

<body onload="goMain()">

<div id ="content">
    <div class="headerinner">
        <h1 class="logo"><a href="/">PHARMACY4U</a></h1>
    </div>

    <div class="main"></div>
    <div class="container">
        <div class="erobox">
            <div class="erotext_area">
                <p> 페이지의 주소가 잘못 입력되었거나<br />
                    주소가 변경 혹은 삭제되어 <br />
                    요청하신 페이지를 찾을수 없습니다.<br/><br/>
                    입력하신 주소가 정확한지 <br />다시 한번 확인해 주시기 바랍니다.
                </p>
            </div>
            <div class="err">
                <p>
                    <%--페이지의 주소가 잘못 입력되었거나 찾을수 없는 페이지입니다.<br />--%>
                    3초후에 메인화면으로 이동합니다.</p>
                <a href="javascript:location.href= '<c:url value="/"/>';">메인으로 가기</a>
            </div>
        </div>
        <!--erobox //-->
    </div>
    <!---->
</div>
</body>
</html>

