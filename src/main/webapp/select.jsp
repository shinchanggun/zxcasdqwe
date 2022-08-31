<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
Class.forName("oracle.jdbc.OracleDriver");

Connection conn
=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "test", "1111");

System.out.println(conn);

String sql="select idx, title, content, bookimg from book";
PreparedStatement pstmt
=conn.prepareStatement(sql);


ResultSet rs=pstmt.executeQuery();
String title="";
String content="";
String bookimg="";
int idx=0;


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.book{
width:200px;
height:300px;
border:1px solid gray;
text-align: center;
margin: 10px;
padding: 10px;
}

.book > img{
width:150px;
height:200px;
border:1px solid gray;
}

.book > h3{
text-align: center;
}

.book > p{
text-align: center;
overflow: hidden;
white-space: nowrap;
text-overflow: ellipsis;
}
</style>
</head>
<body>
<%while(rs.next()){
	idx=rs.getInt("idx");
	title=rs.getString("title");
	content=rs.getString("content");
	bookimg=rs.getString("bookimg");
	

%>
<div class="book" style="float: left;">
<img src="/file/<%=bookimg%>">
<h3><a href="/findOne.jsp?idx=<%=idx%>"><%=title%></a></h3>
<p style="overflow:hidden;text-overflow: ellipsis;white-space:nowrap">
<%=content%>
</p>
</div>
<%} %>
]
<%
rs.close();
pstmt.close();
conn.close();
%>
</body>
</html>

