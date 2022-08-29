<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%
//주의사항:폴더경로를 복사하고 \는 특수문자이므로 \를 하나 더 추가해야함.
String savePath="C:\\project\\work\\jwork\\test\\src\\main\\webapp\\file";
int fileSize=10*1024*1024;
MultipartRequest multi
=new MultipartRequest
(request,savePath,fileSize,"utf-8",new DefaultFileRenamePolicy());
/*
--------------------------------------------------------
multipartRequest는 전달된 데이터(text)와 file로 구분
-------------------------------------------------------
*/

/*
---------------------------------------------------------
전달된 데이터 처리
--------------------------------------------------------
*/
//type file을 제외하고 넘겨받는 파라메타 리스트
Map<String, String> map=new HashMap<String, String>();
Enumeration params = multi.getParameterNames();
//여러개의 input상자가 Enumeration에 저장되어있음
while(params.hasMoreElements()){
	String name=(String)params.nextElement();
	String value=multi.getParameter(name);
	map.put(name, value);
	//* name은 params에서 가져오지만 value는 multi에서 참조
	//out.print("전달파레미터 이름:"+name+"<br>");
	//out.print("전달파레미터 값:"+value+"<br>");
	//out.print("----------------------------<br>");
	
}

//type이 file인 내용을 넘겨받는 파일 리스트
Enumeration files=multi.getFileNames();
//여러개의 input file상자가 Enumeration에 저장되어있음
while(files.hasMoreElements()){
	//파일의 이름을 nextElement()함수로 가져와
	//multi에서 이름을 참조하여 
	//시스템에 저장된 파일명과 전달된 파일명을 찾음
	String file=(String)files.nextElement();
	String savefilename=multi.getFilesystemName(file);
	map.put(file, savefilename);
	String realfilename=multi.getOriginalFileName(file);
	//out.print("전달파레미터 파일이름:"+file+"<br>");
	//out.print("서버시스템에 저장되는 파일명:"+savefilename+"<br>");
	//out.print("실제파일명:"+realfilename+"<br>");
	//out.print("----------------------------<br>");
}

System.out.println(map.toString());

//위에서 전달받은 데이터를 데이터베이스 접속하여 처리
//Class.forName("oracle.jdbc.driver.OracleDriver");
Class.forName("oracle.jdbc.OracleDriver");

Connection conn
=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "test", "1111");

System.out.println(conn);

String sql="insert into book(idx,author,title,content,price,bookimg,regdate)values(book_seq_idx.NEXTVAL,?,?,?,?,?,?)";

PreparedStatement pstmt
=conn.prepareStatement(sql);

pstmt.setString(1, map.get("author"));
pstmt.setString(2, map.get("title"));
pstmt.setString(3, map.get("content"));
pstmt.setInt(4,Integer.parseInt(map.get("price")));
pstmt.setString(5, map.get("bookimg"));
SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
java.util.Date dt=df.parse(map.get("regdate"));
long t=dt.getTime();
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