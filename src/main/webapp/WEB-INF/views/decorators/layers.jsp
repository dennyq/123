<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/include/taglibs.jspf" %>
<c:set var="isLogin" value="${sessionScope.memberid != null and sessionScope.memberid != ''}"/>
<form id="frm_change_pwd" method="post">
  <div class="modal-dialog" id="change_pwd">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">사용자 비밀번호 변경</h4>
      </div>
      <div class="modal-body">

        <div class="box-primary box-white-bg">
          <div class="box-body">

              <div class="col-md-12 padding5">
                <div class="form-group">
                  <label for="change_pwd_memberid" class="col-sm-4 control-label">
                    <c:if test="${isAdmin}">아이디</c:if>
                    <c:if test="${!isAdmin}">회원아이디</c:if>
                  </label>
                  <div class="col-sm-8">
                    <input id="change_pwd_memberid" name="memberid" value="${sessionScope.memberid}" class="form-control" placeholder="아이디" disabled>
                  </div>
                </div>
              </div>
              <div class="col-md-12 padding5">
                <div class="form-group">
                  <label for="change_pwd_password" class="col-sm-4 control-label">새비밀번호</label>
                  <div class="col-sm-8 padding5">
                    <input id="change_pwd_password" name="password" class="form-control" placeholder="새비밀번호" type="password">
                  </div>
                </div>
              </div>
              <div class="col-md-12 padding5">
                <div class="form-group">
                  <label for="change_pwd_password_cfm" class="col-sm-4 control-label">비밀번호 확인</label>
                  <div class="col-sm-8">
                    <input id="change_pwd_password_cfm" name="password_cfm" class="form-control" placeholder="비밀번호 확인" type="password">
                  </div>
                </div>
              </div>

          </div><!-- /.box-body -->
        </div><!-- /.box box-primary box-bg -->

      </div>
      <div class="modal-footer">
        <button id="change_pwd_cancle" type="button" class="btn btn-default pull-left popup_close" >취소</button>
        <button id="change_pwd_save" type="button" class="btn btn-primary">저장</button>
      </div>
    </div><!-- /.modal-content -->
  </div>
</form>


<form id="frm_change_info" method="post">
  <div class="modal-dialog" id="change_info">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">사용자 정보 변경</h4>
      </div>
      <div class="modal-body">

        <div class="box-primary box-white-bg">
          <div class="box-body">

            <div class="col-md-12 padding5">
              <div class="form-group">
                <label for="change_info_memberid" class="col-sm-4 control-label">회원아이디</label>
                <div class="col-sm-8">
                  <input id="change_info_memberid" name="memberid" class="form-control" placeholder="회원아이디" disabled>
                </div>
              </div>
            </div>

            <div class="col-md-12 padding5">
              <div class="form-group">
                <label for="change_info_name" class="col-sm-4 control-label">회원명</label>
                <div class="col-sm-8">
                  <input id="change_info_name" name="name" class="form-control" placeholder="회원명">
                </div>
              </div>
            </div>

            <div class="col-md-12 padding5">
              <div class="form-group">
                <label for="change_info_contactpoint" class="col-sm-4 control-label">회원연락처</label>
                <div class="col-sm-8">
                  <input id="change_info_contactpoint" name="contactpoint" class="form-control" placeholder="회원연락처">
                </div>
              </div>
            </div>

            <div class="col-md-12 padding5">
              <div class="form-group">
                <label for="change_info_note" class="col-sm-4 control-label">비고</label>
                <div class="col-sm-8">
                  <input id="change_info_note" name="note" class="form-control" placeholder="회원연락처">
                </div>
              </div>
            </div>

          </div><!-- /.box-body -->
        </div><!-- /.box box-primary box-bg -->

      </div>
      <div class="modal-footer">
        <button id="change_info_cancle" type="button" class="btn btn-default pull-left popup_close" >취소</button>
        <button id="change_info_save" type="button" class="btn btn-primary">저장</button>
      </div>
    </div><!-- /.modal-content -->
  </div>
</form>


<script>
  $(function () {

    var req = {};
    $als.execute('<c:url value="/member/info"/>', req, function (data) {
      if (data.result_message == 'success') {
        console.log(data);
        $('#change_info_memberid').val(data.data.memberid);
        $('#change_info_name').val(data.data.name);
        $('#change_info_contactpoint').val(data.data.contactpoint);
        $('#change_info_note').val(data.data.note);
//        alert('변경되었습니다.');
//        $(".modal-dialog , .bg_popup").fadeOut();
      }else{
        alert('실패하였습니다..');
      }
    }, function (err) {
      alert(err.result_message);
    });





    $('#change_pwd_save').click(function(){
      var chk_validate = false;
      var this_obj = $(this);
      var form = this_obj.closest('form');


      var change_pwd_memberid = $('#change_pwd_memberid');
      var change_pwd_password = $('#change_pwd_password');
      var change_pwd_password_cfm = $('#change_pwd_password_cfm');

      chk_validate = validateObjNull('change_pwd_memberid','아이디를') &&  validateObjNull('change_pwd_password','새비밀번호를') &&  validateObjNull('change_pwd_password_cfm','비밀번호 확인을');
      if(chk_validate){
        var req = {};
        req = $('#frm_change_pwd').serialize();
        req.memberid = $('#change_pwd_memberid').val();
        req.password = $('#change_pwd_password').val();
        req.password_cfm = $('#change_pwd_password_cfm').val();

        if(req.password != req.password_cfm){
          alert('비밀번호가 일치하지 않습니다.');
        }



        $als.execute('<c:url value="/member/pwd/modify"/>', req, function (data) {
          if (data.result_message == 'success') {
            alert('변경되었습니다.');
            $(".modal-dialog , .bg_popup").fadeOut();
          }else{
            alert('실패하였습니다..');
          }
        }, function (err) {
          alert(err.result_message);
        });
      }
    });

    $('#change_info_save').click(function(){
      var chk_validate = false;
      var this_obj = $(this);
      var form = this_obj.closest('form');


      var change_info_memberid = $('#change_info_memberid');
      var change_info_password = $('#change_info_password');
      var change_info_password_cfm = $('#change_info_password_cfm');

      chk_validate = validateObjNull('change_info_memberid','회원아이디를')
                  &&  validateObjNull('change_info_name','회원명을')
                  &&  validateObjNull('change_info_contactpoint','회원연락처를')
                  &&  validateObjNull('change_info_note','비고를');
      if(chk_validate){
        var req = {};
        req = $('#frm_change_info').serialize();
//        req.memberid = $('#change_info_memberid').val();
//        req.password = $('#change_info_password').val();
//        req.password_cfm = $('#change_info_password_cfm').val();
//        req.password_cfm = $('#change_info_password_cfm').val();

//        if(req.password != req.password_cfm){
//          alert('비밀번호가 일치하지 않습니다.');
//        }



        $als.execute('<c:url value="/member/info/modify"/>', req, function (data) {
          if (data.result_message == 'success') {
            alert('변경되었습니다.');
            $(".modal-dialog , .bg_popup").fadeOut();
          }else{
            alert('실패하였습니다..');
          }
        }, function (err) {
          alert(err.result_message);
        });
      }
    });
  });

  function validateObjNull(el_id,alert_msg){
    if($('#'+el_id).val()=='' && $('#'+el_id).val()==''){
      alert(alert_msg+' 입력하세요.');
      $('#'+el_id).focus();
      return false;
    }
    return true;
  }
</script>