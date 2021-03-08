<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="webShop.Sevice.*, java.util.*, webShop.Util.*" pageEncoding="UTF-8"%>
<!-- 월 일정 창 -->

<%
	request.setCharacterEncoding("utf-8");
	MyCalendar test = new MyCalendar();
	String yearMonth = request.getParameter("Date");
	test.setCalendar(yearMonth);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./coco/semantic.min.css">
<style type="text/css">
        body {
            background-color: #DADADA;
        }

        body>.grid {
            height: 100%;
        }

        .image {
            margin-top: -100px;
        }

        .column {
            max-width: 1000px;
        }

        .view_btn {
            cursor: pointer;
        }

</style>

</head>
<body>
	<div class="ui middle aligned center aligned grid">
        <div class="column">
            <h2 class="ui teal image header">
               일정 페이지
            </h2>
            <div class="ui large form">
                <div class="ui stacked segment">
                	<a href="/webShop/monthAppo.jsp"><button class="ui fluid large teal submit button">다음 달</button></a><br>
                    <a href="/webShop/makeAppo.jsp"><button class="ui fluid large teal submit button">저번 달</button></a>
                    <table class="ui celled table" id="tav_table">
                    	<thead>
                    		<th>일</th>
                            <th>월</th>
                            <th>화</th>
                            <th>수</th>
                            <th>목</th>
                            <th>금</th>
                            <th>토</th>                               
                    	</thead>
                        <tbody id="tav_list">
                        </tbody>
                    </table>
                </div>

                <div class="ui error message"></div>

            </div>
        </div>
    </div>
</body>
</html>