<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="webShop.Sevice.*, java.util.*" pageEncoding="UTF-8"%>

<!-- 이 페이지는 항상 get방식으로 와야함. date랑  page로 -->
<%
	String currDate = request.getParameter("date");
	String currPage = request.getParameter("page");
%>
<!DOCTYPE html>
<html>
<head>
<!-- 여기에 polling부분도 들어가야함 3초마다 한번씩 폴링하게 하자. 폴링은 ajax로 하는게 아니라 그냥 3초마다 form에 현재 날짜 기준으로 그냥 찍어서 보내면 되는거임. usercontroller에 -->
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
                	<a href="/webShop/monthAppo.jsp"><button class="ui fluid large teal submit button">다른 일정 보기</button></a><br>
                    <a href="/webShop/makeAppo.jsp"><button class="ui fluid large teal submit button">일정 등록하기</button></a>
                    <table class="ui celled table" id="tav_table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>제목</th>
                                <th>등록자</th>
                                <th>시작날짜</th>
                                <th>끝날짜</th>
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

    <div class="ui modal" id='view_modal'>
        <i class="close">x</i>
        <div class="header" id="b_title">
            
        </div>
        <div class="content">
            <div class="description">
            	<p style = "text-align: right" id = "b_review"></p>
            	<div id = 'b_content'></div>
            </div>
        </div>
        <div class="actions">
            <div class="ui black deny button">
                닫기
            </div>
        </div>
    </div>
</body>

<script src="/webShop/coco/jquery3.3.1.min.js"></script>
<script type="text/javascript">
var dataJson = {
        currDate : "<%=currDate%>",
        currPage : "<%=currPage%>"
};
function get_Appointment(){	
	 $.ajax({
         url: '/webShop/user/todayAppoAjax',
         dataType: 'json',
         data: dataJson,
         type: 'post',
         success: function(ret) { // check if available
           //success
           $( '#tav_list').empty();
           for(var i in ret) {
        	  var tr = $("<tr></tr>").appendTo("#tav_list");
        	  $("<td></td>").text(ret[i]['id']).appendTo(tr);
        	  $("<td></td>").text(ret[i]['title']).appendTo(tr);
        	  $("<td></td>").text(ret[i]['userId']).appendTo(tr);
        	  $("<td></td>").text(ret[i]['startDate']).appendTo(tr);
        	  $("<td></td>").text(ret[i]['endDate']).appendTo(tr);
           }
         },
         error: function() { // error logging
           console.log('Error!');
         }
       });
 }
 (function() {
	 var pollinterval = setInterval(function() {
		 get_Appointment();
	 }, 2000);
	 get_Appointment();
 })();
</script>
</html>