<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/include/taglibs.jspf" %>
<head>
  <title>PHARMACY4U</title>
</head>
<form method="post">
<div class="mobile">
  <div class="m-login-box">
    <div><label>User ID</label><input id="famers-id" name="famersId" class="m-form-control" placeholder="UserID"></div>
    <div class="margin-top-40"><label>Password</label><input id="famers-pw" name="famersPw" type="password" class="m-form-control" placeholder="Password"></div>
    <div><a id="famersLogin" class="m-form-button btn btn-light-orange btn-block btn-flat">로그인</a></div>
    <div class="m-font right"><input id="auto_login" name="auto_login" type="checkbox" class="checkbox-style"/><label for="auto_login">자동저장</label></div>

  </div>

</div>
  </form>




<script>
  $(function () {




      $('#famersLogin').click(function () {
          var req = {};
          req = $(this).closest('form').serialize();
          $als.execute('<c:url value="/login"/>', req, function (data) {
              if (data.result_message == 'success') {

                  if ($('#auto_login').prop('checked') == true) {
                      saveLogin($("#famers-id").val());
                  }
                  location.href = '/m_list';
              } else if (data.result_message == 'success_admin') {

                  if ($('#auto_login').prop('checked') == true) {
                      saveLogin($("#famers-id").val());
                  }
                  location.href = '/m_list';
              } else {
                  alert('아이디나 비밀번호가 맞지 않습니다.');
              }
          }, function (err) {
              alert(err.result_message);
          });

      });

      var cookie_user_id = getLogin();
      /**
       * 쿠키값이 존재하면 id에 쿠키에서 가져온 id를 할당한 뒤
       * 체크박스를 체크상태로 변경
       */
      if(cookie_user_id != "") {
          $("#famers-id").val(cookie_user_id);
          $("#auto_login").attr("checked", true);
//          $('#famersLogin').trigger('click');
      }

//      auto_login
  });


  /**
   * saveLogin
   * 로그인 정보 저장
   * @param id
   */
  function saveLogin(id) {
      if(id != "") {
// userid 쿠키에 id 값을 7일간 저장
          setSave("userid", id, 365*3);
      }else{
// userid 쿠키 삭제
          setSave("userid", id, 365*3);
      }
  }

  /**
   * setSave
   * Cookie에 user_id를 저장
   * @param name
   * @param value
   */
  function setSave(name, value, expiredays) {
      var today = new Date();
      today.setDate( today.getDate() + expiredays );
      document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";"
  }

  /**
   * getLogin
   * 쿠키값을 가져온다.
   * @returns {String}
   */
  function getLogin() {
// userid 쿠키에서 id 값을 가져온다.
      var cook = document.cookie + ";";
      var idx = cook.indexOf("userid", 0);
      var val = "";

      if(idx != -1) {
          cook = cook.substring(idx, cook.length);
          begin = cook.indexOf("=", 0) + 1;
          end = cook.indexOf(";", begin);
          val = unescape(cook.substring(begin, end));
      }
      return val;
  }
</script>