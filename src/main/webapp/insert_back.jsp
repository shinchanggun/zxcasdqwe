<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
Class.forName("oracle.jdbc.OracleDriver");

Connection conn
=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "test", "1111");

System.out.println(conn);
/*
String sql="";

PreparedStatement pstmt
=conn.prepareStatement(sql);

pstmt.setString(1, "");

int result=pstmt.executeUpdate(); //select = executeQuery(); -> 결과처리 Resultset
//delete, update, insert = executeUpdate(); -> 결과처리 int
*/

String sql="insert into book(idx,author,title,content,price,bookimg,regdate)values(book_seq_idx.NEXTVAL,?,?,?,?,?,?)";

PreparedStatement pstmt
=conn.prepareStatement(sql);

pstmt.setString(1, request.getParameter("author"));
System.out.println(request.getParameter("author"));

pstmt.setString(2, request.getParameter("title"));
System.out.println(request.getParameter("title"));

pstmt.setString(3, request.getParameter("content"));
System.out.println(request.getParameter("content"));

pstmt.setInt(4,Integer.parseInt(request.getParameter("price")));
System.out.println(request.getParameter("price"));

pstmt.setString(5, request.getParameter("bookimg"));
System.out.println(request.getParameter("bookimg"));

System.out.println(request.getParameter("regdate"));
SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
java.util.Date dt=df.parse(request.getParameter("regdate"));
long t=dt.getTime();
System.out.println("t:"+t);
System.out.println("sql time:"+new java.sql.Date(t));
System.out.println("dt:"+dt);
pstmt.setDate(6, new java.sql.Date(t));


int result=pstmt.executeUpdate();
if(result>0){
%>
<script>
	alert("데이터베이스 입력이 성공하였습니다.");
</script>
<%
}
%>

<header>header</header>
<section>section</section>
<footer>footer</footer>