<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>caldetail.jsp</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style type="text/css">
th{
	background-color: #00a2e8;
}
</style>

</head>
<body>

<%!
// 날짜를 보기 좋게 출력하는 함수
public String toDates(String mdate){
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
	
	String s = mdate.substring(0, 4) + "-" 	// yyyy
			+ mdate.substring(4, 6) + "-"	// MM
			+ mdate.substring(6, 8) + " " 	// dd
			+ mdate.substring(8, 10) + ":"	// hh
			+ mdate.substring(10, 12) + ":00"; 
	Timestamp d = Timestamp.valueOf(s);
	
	return sdf.format(d);	
}

public String toOne(String msg){	// 08 -> 8
	return msg.charAt(0)=='0'?msg.charAt(1) + "": msg.trim();
}
%>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto = dao.getDay(seq);

%>

<h1>일정 보기</h1>
<hr>

<div align="center">

<table class="table table-bordered" style="width: 65%">
<col width="200"><col width="500">

<tr>
	<th>아이디</th>
	<td><%=dto.getId() %></td>
</tr>

<tr>
	<th>제목</th>
	<td><%=dto.getTitle() %></td>
</tr>

<tr>
	<th>일정</th>
	<td><%=toDates(dto.getRdate()) %></td>	
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="60" readonly="readonly"><%=dto.getContent() %>
		</textarea>
	</td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="button" value="수정" onclick="location.href='calupdate.jsp?seq=<%=dto.getSeq() %>'">
		<input type="button" value="삭제" onclick="location.href='caldel.jsp?seq=<%=dto.getSeq() %>'">
	</td>
</tr>

</table>

</div>



</body>
</html>



