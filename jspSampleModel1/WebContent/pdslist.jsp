<%@page import="pds.PdsDto"%>
<%@page import="java.util.List"%>
<%@page import="pds.PdsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null){
%>  
	<script>
	alert("로그인 해 주십시오");
	location.href = "login.jsp";
	</script>	
<%
}

PdsDao dao = PdsDao.getInstance();
List<PdsDto> list = dao.getPdsList();

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pdslist.jsp</title>
</head>
<body>

<h2>자료실</h2>

<div align="center">

<table border="1">
<col width="50"><col width="100"><col width="400"><col width="50">
<col width="50"><col width="50"><col width="100">

<tr>
	<th>번호</th><th>작성자</th><th>제목</th><th>다운로드</th>
	<th>조회수</th><th>다운수</th><th>작성일</th>
</tr>

<%
for(int i = 0;i < list.size(); i++){
	PdsDto pds = list.get(i);
	
	String bgcolor = "";
	if(i % 2 == 0){
		bgcolor = "#ddeebb";
	}else{
		bgcolor = "#ddddcc";
	}
	%>
	<tr bgcolor="<%=bgcolor %>" align="center" height="5">
		<th><%=i + 1 %></th>
		<td><%=pds.getId() %></td>
		<td align="left">
			<a href="pdsdetail.jsp?seq=<%=pds.getSeq() %>">
				<%=pds.getTitle() %>
			</a>
		</td>
		<td>
			<input type="button" name="btnDown" value="파일"
				onclick="filedownload('<%=pds.getNewFilename() %>', <%=pds.getSeq() %>)">
		</td>
		<td><%=pds.getReadcount() %></td>
		<td><%=pds.getDowncount() %></td>
		<td><%=pds.getRegdate() %></td>
	</tr>
	<%
}
%>
</table>
<br>
<a href="pdswrite.jsp">자료 올리기</a>
</div>

<script type="text/javascript">
function filedownload(newfilename, seq) {
	location.href = 'filedown?newfilename=' + newfilename + '&seq=' + seq;
}

</script>

</body>
</html>





