<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD>

  <TITLE> TEST </TITLE>
  <script language="javascript">


    //// 레지스트리 등록
    function OnRegisterID()
    {
      var userid = uid.value;
      alert(userid);
      var ret = KC7Ax.RegisterID(userid);
      if	( ret == 1 )
      {
        alert('A');
      }
      else if  ( ret == -1 )
      {
        alert('B');
      }
      else if  ( ret == 2 )
      {
        alert('C');
      }
      else if  ( ret == 3 )
      {
        alert('D');
      }
      else if  ( ret == 4 )
      {
        alert('E');
      }
    }


    function OnGetRegID()
    {
      getid.value = "";
      var userid = KC7Ax.GetRegID();
      getid.value = userid;
    }

  </script>


</HEAD>


<BODY bgcolor = #AAAAAA>
<font color="yellow">
  <H1>TEST</H1>
</font>

<OBJECT ID="KC7Ax" CLASSID="CLSID:DBFC0953-8254-46A8-A034-0E674E74D932" STYLE="WIDTH:0px; HEIGHT:0px; ">
</OBJECT>
<p>
<H5>TEST</H5>
<br>
<input type="hidden" name="uid" value="D00000113" size="10">
<input type="button" onclick="OnRegisterID();" value="TEST">
<br>

<br>
<input type="text" name="getid" size="20">
<input type="button" onclick="OnGetRegID();" value="TEST">
<br>
</BODY>
</HTML>

