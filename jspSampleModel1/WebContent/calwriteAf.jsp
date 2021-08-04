<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String hour = request.getParameter("hour");
String min = request.getParameter("min");

System.out.println(id + " " + title + " " + content);
System.out.println(year + " " + month + " " + day + " " + hour + " " + min);
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
// rdate	202106211108
String rdate = year + CalUtil.two(month) + CalUtil.two(day) + CalUtil.two(hour) + CalUtil.two(min);

CalendarDao dao = CalendarDao.getInstance();

boolean isS = dao.addCalendar(new CalendarDto(id, title, content, rdate));
if(isS){
	%>
	<script type="text/javascript">
	alert('일정이 추가되었습니다');
	location.href = "calendar.jsp";
	</script>	
	<%
}else{
	%>
	<script type="text/javascript">
	alert('일정이 추가되지 않았습니다');
	location.href = "calendar.jsp";
	</script>
	<%
}
%>


</body>
</html>








