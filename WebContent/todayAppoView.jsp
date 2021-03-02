<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="webShop.Sevice.*, java.util.*" pageEncoding="UTF-8"%>
    
<%
	ArrayList<AppointmentVO> AppoList = (ArrayList<AppointmentVO>)request.getAttribute("AppoList");
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
<% for(int i =0; i < AppoList.size(); i++) {%>
<% AppointmentVO temp = AppoList.get(i); %>
id = <%=temp.getId()%><br>
title = <%=temp.getTitle()%><br>
startdate = <%=temp.getStartDate()%><br>
enddate = <%=temp.getEndDate() %><br>
userid = <%=temp.getUserId() %>
<% } %>
</body>
</html>