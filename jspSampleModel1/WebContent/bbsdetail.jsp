<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
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
%> 

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
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
dao.readcount(seq);

BbsDto dto = dao.getBbs(seq);


// System.out.println(dto.toString());
%>
<h2>상세 글 보기</h2>

<div align="center">

<table border="1">
<colgroup>
	<col style="width: 200px">
	<col style="width: 400px">
</colgroup>

<tr>
	<th>작성자</th>
	<td>
		<input type="text" value="<%=dto.getId() %>" readonly="readonly">
	</td>
</tr>
<tr>
	<th>제목</th>
	<td><%=dto.getTitle() %></td>
</tr>
<tr>
	<th>작성일</th>
	<td><%=dto.getWdate() %></td>
</tr>
<tr>
	<th>조회수</th>
	<td><%=dto.getReadcount() %></td>
</tr>
<tr>
	<th>정보</th>
	<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td>
</tr>
<tr>
	<th>내용</th>
	<td>
	<textarea rows="15" cols="90" readonly="readonly"><%=dto.getContent() %></textarea>
	</td>
</tr>
</table>

<br>
<button type="button" onclick="answerBbs(<%=dto.getSeq() %>)">답글</button>
<button type="button" onclick="location.href='bbslist.jsp'">글목록</button>

<%
if(dto.getId().equals(mem.getId())){
%>
<button type="button" onclick="updateBbs(<%=dto.getSeq() %>)">수정</button>
<button type="button" onclick="deleteBbs(<%=dto.getSeq() %>)">삭제</button>
<%
}
%>

</div>

<script type="text/javascript">
function answerBbs( seq ) {
	location.href = "answer.jsp?seq=" + seq;
}
function updateBbs( seq ) {
	location.href = "bbsupdate.jsp?seq=" + seq;
}
function deleteBbs( seq ) {
	location.href = "bbsdelete.jsp?seq=" + seq;
}

</script>


</body>
</html>




