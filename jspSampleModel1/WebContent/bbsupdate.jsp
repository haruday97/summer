<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>bbsupdate</title>

</head>
<body>

<a href="logout.jsp">로그아웃</a>

<h1>글 수정</h1>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq.trim());

BbsDao dao = BbsDao.getInstance();
BbsDto bbs = dao.getBbs(seq);
%>

<%
Object ologin = session.getAttribute("login");
MemberDto mem = null;
mem = (MemberDto)ologin;
%>

<div align="center">

<form action="bbsupdateAf.jsp" method="post">
<input type="hidden" name="seq" value="<%=seq %>">
			
<table border="1">
<col width="200"><col width="500"> 

<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="id" readonly="readonly" size="60" 
			value="<%=mem.getId() %>"> 		
	</td>	
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="60" value="<%=bbs.getTitle() %>">		
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="10" cols="60" name="content"><%=bbs.getContent() %></textarea>		
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="글수정">
	</td>
</tr>

</table>

</form>

</div>

<a href="bbslist.jsp">글목록</a>

</body>
</html>