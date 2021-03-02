<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="webShop.Sevice.*, java.util.*" pageEncoding="UTF-8"%>
    
<%
	ArrayList<AppointmentVO> AppoList = (ArrayList<AppointmentVO>)request.getAttribute("AppoList");
	int pageNum = Integer.parseInt((String)request.getAttribute("page"));
	System.out.println(AppoList.size());
%>
<!DOCTYPE html>
<html>
<head>
<!-- 여기에 polling부분도 들어가야함 3초마다 한번씩 폴링하게 하자. 폴링은 ajax로 하는게 아니라 그냥 3초마다 form에 현재 날짜 기준으로 그냥 찍어서 보내면 되는거임. usercontroller에 -->
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<ul class="lst_type">
	<li>
		<span style='margin-left:50px'>아이디</span>
		<span>제목</span>
		<span>작성자</span>
		<span>시작날짜</span>
		<span>종료날짜</span>
	</li>
</ul>
</body>
</html>