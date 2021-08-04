<%@page import="dto.MemberDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int seq = Integer.parseInt( request.getParameter("seq") );

BbsDto bbs = BbsDao.getInstance().getBbs(seq);
System.out.println(bbs);
%> 
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>부모글</h2>

<div align="center">

<table border="2">
<col width="200"><col width="500">

<tr>
	<td>작성자</td>
	<td><%=bbs.getId() %></td>
</tr>

<tr>
	<td>제목</td>
	<td><%=bbs.getTitle() %></td>
</tr>

<tr>
	<td>작성일</td>
	<td><%=bbs.getWdate() %></td>
</tr>

<tr>
	<td>내용</td>
	<td>
		<textarea rows="10" cols="50" readonly="readonly"><%=bbs.getContent() %></textarea>
	</td>
</tr>

</table>

</div>

<h2>답글</h2>

<%
MemberDto mem = (MemberDto)session.getAttribute("login");
%>
<div align="center">
<form action="answerAf.jsp" method="post">
<input type="hidden" name="seq" value="<%=bbs.getSeq() %>">

<table border="1">
<col width="200"><col width="500">

<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="id" size="50px" value="<%=mem.getId() %>" readonly>
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="50px">
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="50px" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="글쓰기">
	</td>
</tr>

</table>

</form>
</div>


</body>
</html>








