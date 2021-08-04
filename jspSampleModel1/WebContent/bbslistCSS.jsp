<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
Object ologin = session.getAttribute("login");
MemberDto mem = null;
if(ologin == null){
	%>	
	<script>
	alert('로그인 해 주십시오');
	location.href = "login.jsp";
	</script>	
	<%
}
mem = (MemberDto)ologin;
%>

<%!
// 댓글의 depth와 image를 추가하는 함수	
// depth = 1   ' '->	
// depth = 2   '  '->
public String arrow(int depth){
	String rs = "<img src='./image/arrow.png' width='20px' heiht='20px'/>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";	// 여백
	
	String ts = "";
	for(int i = 0;i < depth; i++){
		ts += nbsp;
	}
	
	return depth==0 ? "":ts + rs;	
}

%>

<%
String choice = request.getParameter("choice");
String search = request.getParameter("search");
if(choice == null){
	choice = "";
}
if(search == null){
	search = "";
}
%>


<%
// dao부터 list
BbsDao dao = BbsDao.getInstance();

String spageNumber = request.getParameter("pageNumber");
int pageNumber = 0;	// 현재 페이지
if(spageNumber != null && !spageNumber.equals("")){	// 페이지를 번호 클릭했을 때
	pageNumber = Integer.parseInt(spageNumber);
}
System.out.println("pageNumber:" + pageNumber);

// List<BbsDto> list = dao.getBbsList();
// List<BbsDto> list = dao.getBbsSearchList(choice, search);
List<BbsDto> list = dao.getBbsPagingList(choice, search, pageNumber);

int len = dao.getAllBbs(choice, search);
System.out.println("총 글의 수:" + len);

int bbsPage = len / 10;		// 23 -> 2
if((len % 10) > 0){
	bbsPage = bbsPage + 1;
}

%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbslist(Bulletin Board System) = 전자 게시판</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	// 검색어 있는 경우
	let search = "<%=search %>";
	if(search == "") return;
	
	// select
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
});
</script>

</head>
<body bgcolor="#e9e9e9">
<h4 align="right" style="background-color: #f0f0f0">환영합니다 <%=mem.getId() %>님</h4>

<h1>게시판</h1>

<div align="center">

<table class="table table-hover" style="width: 1000px">
<thead>
<tr>
	<th>번호</th><th>제목</th><th>작성자</th>
</tr>
</thead>

<tbody>
<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="3">작성된 글이 없습니다</td>
	</tr>
	<%
}else{
	
	for(int i = 0;i < list.size(); i++){
		BbsDto bbs = list.get(i);
		%>
		<tr>
			<th><%=i + 1 %></th>
			<td>
				<%
				if(bbs.getDel() == 0){
					%>
					<%=arrow( bbs.getDepth() ) %>			
					<a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>">
						<%=bbs.getTitle() %>
					</a>	
					<%
				}else{
					%>		
					<font color="#ff0000">********* 이 글은 작성자에 의해서 삭제되었습니다</font> 
					<%
				}
				%>
			</td>
			<td align="center"><%=bbs.getId() %></td>
		</tr>
		<%
	}
}
%>
</tbody>
</table>

</div>

<div align="center">
<!-- 페이징 	[1] 2 [3] -->
<%
for(int i = 0;i < bbsPage; i++){
	if(pageNumber == i){	// 현재 페이지		[1] 2 [3] 
		%>
		<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
			<%=i + 1 %>
		</span>&nbsp;
		<%
	}
	else{
		%>		
		<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
			style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none">
			[<%=i + 1 %>]
		</a>&nbsp;	
		<%
	}	
}
%>
</div>
<br>

<div align="center">

<select id="choice"> 
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="writer">작성자</option>
</select>

<input type="text" id="search" value="<%=search %>">

<button type="button" onclick="searchBbs()">검색</button>

</div>

<div align="center">
<a href="bbswrite.jsp">글쓰기</a>
</div>

<br><br>

<script type="text/javascript">
function searchBbs() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
//	alert(choice);
//	alert(search);
	
	location.href = "bbslistCSS.jsp?choice=" + choice + "&search=" + search;
}

function goPage( pageNum ) {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	
	location.href = "bbslistCSS.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;	
}

</script>

</body>
</html>





