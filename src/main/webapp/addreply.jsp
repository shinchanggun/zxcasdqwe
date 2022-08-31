<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int idx=Integer.parseInt(request.getParameter("idx"));
int _page=Integer.parseInt(request.getParameter("page"));

Class.forName("oracle.jdbc.OracleDriver");

Connection conn
=DriverManager.getConnection
("jdbc:oracle:thin:@localhost:1521:xe", "test", "1111");

System.out.println(conn);

String sql="select * from (select rownum r,t.* from (select bookreply.* from bookreply where book_idx=? order by idx desc) t) where r between ? and ?";

PreparedStatement pstmt
=conn.prepareStatement(sql);
pstmt.setInt(1, idx);
pstmt.setInt(2, (_page*5)+1);
pstmt.setInt(3, (_page+1)*5);
ResultSet rs=pstmt.executeQuery();
while(rs.next()){
%>

<img src="/file/my.png" style="width:30px;height:30px;border-radius:10px">
<input type="text" readonly value="<%=rs.getString("reply")%>"><br>

<%
}
rs.close();
pstmt.close();
conn.close();
%>	