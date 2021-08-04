<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.center{
	margin: auto;
	width: 60%;
	border: 3px solid #0000ff;
	padding: 10px;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

</head>
<body>

<h2>login Page</h2>

<div class="center">

<form action="loginAf.jsp" method="post">

<table border="1">
<tr>
	<th>아이디</th>
	<td>
		<input type="text" id="id" name="id" size="20"><br>
		<input type="checkbox" id="chk_save_id">save id
	</td>
</tr>
<tr>
	<th>패스워드</th>
	<td>
		<input type="password" name="pwd" size="20">
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="로그인">
		<button type="button" onclick="account()">회원가입</button>
	</td>
</tr>
</table>
</form>
</div>


<script type="text/javascript">
let user_id = $.cookie("user_id");
if(user_id != null){
	$("#id").val(user_id);
	$("#chk_save_id").prop("checked", true);
}

$("#chk_save_id").click(function () {
//	alert('click');

	if( $("#chk_save_id").is(":checked") ){	// 첵크가 되었을 때		
		if( $("#id").val().trim() == "" ){
			alert('id를 입력해 주십시오');
			$("#chk_save_id").prop("checked", false);
		}else{
			// id를 쿠키에 저장
			$.cookie("user_id", $("#id").val().trim(), { expires:7, path:'/' });
		}
	}
	else{
		$.removeCookie("user_id", { path:'/' });
	}	
});

function account() {
	location.href = "regi.jsp";
}


</script>


</body>
</html>















