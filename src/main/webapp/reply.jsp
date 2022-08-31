<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<% request.setCharacterEncoding("utf-8"); %>
<% 
System.out.println(request.getParameter("reply"));
System.out.println(request.getParameter("idx"));
%>
<%=request.getParameter("reply")%>


<!-- 책번호 idx, reply 댓글을 bookreply table입력 -->

<%
Class.forName("oracle.jdbc.OracleDriver");

Connection conn
=DriverManager.getConnection
("jdbc:oracle:thin:@localhost:1521:xe", "test", "1111");

String sql="insert into bookreply values(bookreply_seq_idx.nextval,?,?)";

PreparedStatement pstmt
=conn.prepareStatement(sql);

pstmt.setString(1, request.getParameter("reply"));
pstmt.setInt(2,Integer.parseInt(request.getParameter("idx")));

int result=pstmt.executeUpdate();

%>
<%=result%>


