<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	Object obj = session.getAttribute("u_no");
	int u_no = (int)obj;
	if(u_no == -1){
		%>
		<script>
		alert("로그인해주세요.");
		location='login.jsp';
		</script>
		<% return;
	}
	
	ArrayList<String[]> movieList = new ArrayList<String[]>();
	
	try{
		//1. 연결
		conn = DAO.getConnection();
		String sql = "SELECT m_no, m_name, m_grade from movie";
		//2. 명령문보내기
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()){
			String[] movie = new String[11];
			movie[0] = rs.getInt("m_no") + "";
			movie[1] = rs.getString("m_name");
			movieList.add(movie);
		}
		rs.close();
		ps.close();
		conn.close(); 
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화예매</title>
</head>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/tiket.css">

<body>
<%@ include file="topmenu.jsp" %>
<section>
<div align="center">
	<h2>빠른예매_영화선택</h2>
	<table border="1">
		<tr>
			<td rowspan="10" align="center">영화</td>
		<%for(int i = 0; i < movieList.size(); i++) {%>
		<%String[] movie = movieList.get(i); %>	
			<td align="center">
			<a href="ticket_theater.jsp?m_no=<%=movie[0]%>&u_no=<%=u_no%>"><%=movie[1]%></a>
			</td>
		</tr>
		<%} %>

	</table>
</div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>