<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

System.out.println("id:"+ id);
System.out.println("title:"+ title);
System.out.println("content:"+ content);

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbswriteAf.jsp</title>
</head>
<body>

<%
BbsDao dao = BbsDao.getInstance();

boolean isS = dao.writeBbs(new BbsDto(id, title, content));
if(isS){
%>
	<script type="text/javascript">
	alert('글쓰기 성공');
	location.href = "bbslist.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert('다시 작성해 주십시오');
	location.href = "bbswrite.jsp";
	</script>
<%
}
%>

</body>
</html>







