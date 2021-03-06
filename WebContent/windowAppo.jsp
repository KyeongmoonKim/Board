<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="webShop.Sevice.*, java.util.*" pageEncoding="UTF-8"%>
<!-- 특정 id 일정 상세 보기 -->
<%
	String currId = request.getParameter("id"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/webShop/coco/semantic.min.css">
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
            max-width: 500px;
        }

        .view_btn {
            cursor: pointer;
        }
        th {
        	text-align: center;
        }
        tr {
        	text-align: center;
        }

</style>
</head>
<body>
	<div class="ui middle aligned center aligned grid">
        <div class="column">
            <h2 class="ui teal image header">
               일정 상세 보기
            </h2>
            <div class="ui large form">
                <div class="ui stacked segment">
                	<a href="/webShop/monthAppo.jsp"><button class="ui fluid large teal submit button">일정 삭제</button></a><br>
                    <a href="/webShop/makeAppo.jsp"><button class="ui fluid large teal submit button">일정 수정</button></a>
                    <table class="ui celled table" id="tav_table">
                        <thead>
                            <tr>
                                <th id="th_1">일정</th>
                            </tr>
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

<script src="/webShop/coco/jquery3.3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var dataJson = {
        currId : "<%=currId%>"
	};
	function get_Appointment(){	
		$.ajax({
        url: '/webShop/user/getIdAppo',
        dataType: 'json',
        data: dataJson,
        type: 'post',
        success: function(ret) { // check if available, 결과값 예시 {"id" : "16","title" : "맘터","explnation" : "저녁","startDate" : "2021-03-06-20-20","endDate" : "2021-03-06-20-40","userId" : "kkm8031"}
        	//$("#tav_table").attr('table-layout', 'fixed');
        	$("#th_1").attr("colspan", 2);
        	var tr0 = $("<tr></tr>").appendTo("#tav_list"); // 제목 일정제목
        	$("<td></td>").text('일정명').appendTo(tr0);
        	$("<td></td>").text(ret['title']).appendTo(tr0);
        	var tr1 = $("<tr></tr>").appendTo("#tav_list"); // 작성자 이름(td태그 2개를 가짐)
        	$("<td></td>").text('작성자').appendTo(tr1);
        	$("<td></td>").text(ret['userId']).appendTo(tr1);
        	var tr2 = $("<tr></tr>").appendTo("#tav_list"); // 일정 시작일~일정 종료일
        	$("<td></td>").attr("colspan", 2).text(ret['startDate']+'~'+ret['endDate']).appendTo(tr2);
        	var tr3 = $("<tr></tr>").attr('height', '250px').appendTo("#tav_list"); //내용
        	$("<td></td>").attr("colspan", 2).text(ret['explanation']).appendTo(tr3);
        	
        	
         },
         error: function() { // error logging
           console.log('Error!');
         }
       });
 	}
 	get_Appointment();
 });
 </script>
</html>