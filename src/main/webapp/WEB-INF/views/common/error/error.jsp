<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <%--<meta charset="UTF-8">--%>
        <title>PHARMACY4U</title>
        <style type="text/css">
            .erobox { width:522px; margin:0 auto; padding:64px 0 64px 0; }
            /*.erobox .erotext_area { height:335px; background:url(/images/ero_bg.png) left top no-repeat; }*/
            .erobox .erotext_area p { padding:84px 0 0 64px; font-size:14px; font-weight:bold; color:#0078ce; line-height:22px; }
            .erobox .err { overflow:hidden; padding:16px 0 0 0; }
            .erobox .err p { float:left; width:260px; padding:0 32px 0 32px; font-size:16px; font-weight:bold; }
            .erobox a { display:inline-block; float:left; min-width:80px; padding:12px 30px; font-weight:bold; font-family:NanumGothic; color:#ffffff; font-size:16px; text-align:center; border-radius:6px; background-color: #ff6000; }
        </style>
        <script>
            $(function(){
                setTimeout(function(){
                    <%--location.href= '<c:url value="/"/>';--%>
                },3000);
            })
        </script>
    </head>
    <body>
    <div id ="content">
        <div class="main"></div>
        <div class="container">
            <div class="erobox">
                <div class="erotext_area">
                    <p> ${result_message}<br />
                        에러코드 : ${result_code}<br />
                        이용에 불편을 드려서 죄송합니다. <br />잠시 후 다시 시도해 주십시오.<br />
                        올바른 경로로 접속하였는지 <br />다시 한번 확인해 주시기 바랍니다.
                    </p>
                </div>
                <div class="err">
                    <p>내부 시스템에 오류가 발생했습니다.<br />
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