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
                                <th>일정</th>
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
         success: function(ret) { // check if available
           //success
           /*$( '#tav_list').empty();
           for(var i in ret) {
        	  var tr1 = $("<tr></tr>").appendTo("#tav_list");
        	  $("<td></td>").text(ret[i]['id']).appendTo(tr);
        	  //var temp1 = $("<a></a>").attr("href", "/webShop/windowAppo.jsp?id="+ret[i]['id']);
        	  //var temp2 = $("<td></td>").appendTo(tr);
        	  $("<a></a>").attr("href", "/webShop/windowAppo.jsp?id="+ret[i]['id']).text(ret[i]['title']).appendTo($("<td></td>").appendTo(tr));
        	  //$("<td></td>").text(ret[i]['title']).appendTo(tr);
        	  $("<td></td>").text(ret[i]['userId']).appendTo(tr);
        	  $("<td></td>").text(ret[i]['startDate']).appendTo(tr);
        	  $("<td></td>").text(ret[i]['endDate']).appendTo(tr);
           }*/
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