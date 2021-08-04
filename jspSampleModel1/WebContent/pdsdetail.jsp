<%@page import="pds.PdsDao"%>
<%@page import="pds.PdsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

PdsDao dao = PdsDao.getInstance();
// readcount
dao.pdsReadCount(seq);
PdsDto pds = dao.getPds(seq);

request.setAttribute("_pds", pds);
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pdsdetail.jsp</title>

<style type="text/css">
th{
	background-color: #00ff00;
}
</style>
</head>
<body>

<h2>자료 상세 내용</h2>

<div align="center">

<table border="1">
<col width="200"><col width="500">

<tr>
	<th>게시자</th>
	<td><%=pds.getId() %></td>	
</tr>

<tr>
	<th>제목</th>
	<td>${_pds.title }</td>
</tr>

<tr>
	<th>다운로드</th>
	<td>
		<input type="button" name="btnDown" value="파일"
			onclick="javascript:document.location.href='filedown?filename=<%=pds.getFilename() %>&seq=<%=pds.getSeq() %>'"/>  
	</td>
</tr>

<tr>
	<th>조회수</th>
	<td>${_pds.readcount }</td>
</tr>

<tr>
	<th>다운수</th>
	<td><%=pds.getDowncount() %></td>
</tr>

<tr>
	<th>파일명</th>
	<td><%=pds.getFilename() %></td>
</tr>

<tr>
	<th>등록일</th>
	<td><%=pds.getRegdate() %></td>
</tr>

<tr>
	<th>내용</th>
<td>
<textarea rows="20" cols="50" 
readonly="readonly"><%=pds.getContent() %>
</textarea>
</td>
</tr>

</table>
 </div>

<!-- 삭제 -->
<input type="button" name="btnDown" value="삭제"
			 onclick="javascript:document.location.href='pdsdel.jsp?pdsseq=<%=pds.getSeq()%>&pdsid=<%=pds.getId()%>'"/>




</body>
</html>





