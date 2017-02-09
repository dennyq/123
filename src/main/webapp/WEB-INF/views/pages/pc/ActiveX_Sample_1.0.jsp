<!DOCTYPE html>
<HTML>
<HEAD>

<TITLE> 내 영업소로 지정 Active-X 테스트 </TITLE>
<script language="javascript">
	

//// 레지스트리 등록
function OnRegisterID()
{	
	var userid = uid.value;
	alert(userid);
	var ret = KC7Ax.RegisterID(userid);
	if	( ret == 1 )
	{
		alert('성공');
	}
	else if  ( ret == -1 )
	{
		alert('실패');
	}
	else if  ( ret == 2 )
	{
		alert('아이디가 널값입니다');
	}
	else if  ( ret == 3 )
	{
		alert('아이디가 10자리 이하여야 합니다');
	}
	else if  ( ret == 4 )
	{
		alert('아이디는 영문자와 숫자여야만 합니다');
	}	
}

//// 아이디 얻기
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
<H1>내 영업소로 지정 Active-X 테스트</H1>
</font>

<OBJECT ID="KC7Ax" CLASSID="CLSID:DBFC0953-8254-46A8-A034-0E674E74D932" STYLE="WIDTH:0px; HEIGHT:0px; ">
</OBJECT>
<p>
	<H5>내 영업소로 지정 테스트</H5>
        <br>
	<input type="hidden" name="uid" value="D00000113" size="10">
        <input type="button" onclick="OnRegisterID();" value="내 영업소로 지정">
        <br>
        
        <br>
	<input type="text" name="getid" size="20">
        <input type="button" onclick="OnGetRegID();" value="아이디 얻기">
        <br>
</BODY>
</HTML>

