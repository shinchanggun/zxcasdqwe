<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

int idx=Integer.parseInt(request.getParameter("idx"));
String author="";
String title="";
String content="";
String bookimg="";
java.sql.Date regdate=new Date(2022,8,30);

//위에서 전달받은 데이터를 데이터베이스 접속하여 처리
Class.forName("oracle.jdbc.driver.OracleDriver");

Connection conn
=DriverManager.getConnection
("jdbc:oracle:thin:@localhost:1521:xe", "test","1111");
System.out.println(conn);

String sql="select * from book where idx=?";

PreparedStatement pstmt
=conn.prepareStatement(sql);
pstmt.setInt(1, idx);
ResultSet rs=pstmt.executeQuery();

if(rs.next()){
	author=rs.getString("author");
	title=rs.getString("title");
	content=rs.getString("content");
	bookimg=rs.getString("bookimg");
	regdate=rs.getDate("regdate");
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.book{
width:100%;height:400px;
border:1px solid gray;
text-align:center;
}
.book > img {width:150px;height:200px;
border:1px solid gray;
}

.book > h3 {border:1px solid gray; text-align: center}
.book > h4 {border:1px solid gray; text-align: center}
.book > p {border:1px solid gray;text-align: center}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
var page=1;
$(function (){
	
	/* 키보드를 확인하는 코드*/
	/*
	$(document).keyup(function(event) {
	    if (event.which === 13) {
	        alert('Enter is pressed!');
	    }
	});
	*/
	/*
	$(document).keypress(function(e){
		    if(e.keyCode==13) 
			alert('Enter is pressed!');
	});
	*/
	
//alert('test');
$('#btn').click(function(){
	//$('#reply').prepend("a<br>");
	//$('#reply').prepend("<input type='text' readonly value='"+$("#replyin").val()+"'>","<br>");
	var v=$("#replyin").val();
	$('#reply').prepend("<input type='text' readonly value='"+v+"'>","<br>");
	$('#reply').prepend("<img src='/file/my.png' style='width:30px;height:30px;border-radius:10px'>");
	
	//javascript에서는 
	//jsp코드가 동작하지 않으므로 ajax를 이용하여 url처리
	
	$.ajax({
		url:"/reply.jsp",
		data:{idx:'<%=idx%>',reply:$("#replyin").val()},
		success: function(result){
			alert(result);
			//if(result==1){ alert('댓글이 입력되었습니다.!');}
			//else{alert('댓글 입력 실패!');}
		}
	});
	
	$("#replyin").val("");
	
});

$(document).keyup(function(event) {
	
	var v=$("#replyin").val();
	
    if (event.which === 13 && v!="") {
    	
    	$('#reply').prepend("<input type='text' readonly value='"+v+"'>","<br>");
    	$('#reply').prepend("<img src='/file/my.png' style='width:30px;height:30px;border-radius:10px'>");
    
    	$.ajax({
    		url:"/reply.jsp",
    		data:{idx:'<%=idx%>',reply:$("#replyin").val()},
    		success: function(result){
   				
    		}
    	});
    	
    	$("#replyin").val("");
    }
});

//더보기 처리
$("#addreply").click(function(){
	$.ajax({
		url:"/addreply.jsp",
		data:{'idx':'<%=idx%>','page':page},
		success: function(result){
			$("#reply").append(result);
			page++;
		}
	});
});

});

/*
var i=1;
function replyinput(){
	document.querySelector('#reply').innerHTML=i+"<img src='/file/my.gif'>	<input type='text' readonly value='"+document.querySelector('#replyin').value+"'><br>"+document.querySelector('#reply').innerHTML;
	i++;
}
*/
</script>
</head>
<body>

<div class="book">
<img src="/file/<%=bookimg%>">
<h3><%=title%></h3>
<h4><%=author%></h4>
<h4><%=regdate%></h4>
<p><%=content%></p>
</div>

<div id="replyInput">
<img src="/file/reply.gif">
댓글입력:<input type="text" id="replyin">
<input type="button" value="입력"  id="btn" onclick="replyinput()">
</div>

<!-- 
<div id="reply">
<img src="/file/my.gif">
<input type="text" readonly value="댓글테스트"><br>
</div> 
-->
<!-- 책 댓글 불러오기 -->
<%
//sql="select * from bookreply where book_idx=? order by idx desc";
sql="select * from (select rownum r,t.* from (select bookreply.* from bookreply where book_idx=? order by idx desc) t) where r between 1 and 5";
pstmt=conn.prepareStatement(sql);
pstmt.setInt(1, 
Integer.parseInt(request.getParameter("idx")));
rs=pstmt.executeQuery();
%>
<div id="reply">
<%
while(rs.next()){
%>
<img src="/file/my.png" style="width:30px;height:30px;border-radius:10px">
<input type="text" readonly value="<%=rs.getString("reply")%>"><br>
 
<%
}
%>
</div>
<%
rs.close();
pstmt.close();
conn.close();
%>
<input type="button" id="addreply" 
value="더보기" style="width:200px"><br>
</body>
</html>