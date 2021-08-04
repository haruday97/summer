<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>    

<%
int seq = Integer.parseInt( request.getParameter("seq") );

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
BbsDao dao = BbsDao.getInstance();

boolean isS = dao.answer(seq, new BbsDto(id, title, content));
if(isS){
%>
	<script type="text/javascript">
	alert('답글입력 성공!');
	location.href = "bbslist.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert('답글입력 실패');
	location.href = "bbslist.jsp";
	</script>
<%
}
%>

</body>
</html>






