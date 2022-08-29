<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="insert.jsp" method="post" enctype="multipart/form-data">
저자:<input type="text" name="author" id="author"><br>
책제목:<input type="text" name="title" id="title"><br>
내용:<input type="text" name="content" id="content"><br>
가격:<input type="text" name="price" id="price"><br>
책이미지:<input type="file" name="bookimg" id="bookimg"><br>
등록일:<input type="date" name="regdate" id="regdate"><br>
<input type="submit" value="책정보입력"><br>
</form>
</body>
</html>