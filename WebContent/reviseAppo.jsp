<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="webShop.Sevice.*, java.util.*" pageEncoding="UTF-8"%>
<!-- 일정 수정. windowAppo에서 post로 전송받은 데이터를 폼형식 안에 넣을거임 폼형식은 똑같음 makeAppo랑 -->
<%
	request.setCharacterEncoding("utf-8");  //굉장히 굉장히 중요
	String id = (String)request.getParameter("id");
	System.out.println(id);
	String title = (String)request.getParameter("title");
	System.out.println(title);
	String explanation = (String)request.getParameter("explanation");
	String startDate = (String)request.getParameter("startDate");
	String endDate = (String)request.getParameter("endDate");
	String userId = (String)session.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%=id %><br>
	<%=title %><br>
	<%=explanation %><br>
	<%=startDate%><br>
	<%=endDate %><br>
	<%=userId %>
</body>
</html>