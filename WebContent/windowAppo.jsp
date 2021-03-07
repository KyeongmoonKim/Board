<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="webShop.Sevice.*, java.util.*" pageEncoding="UTF-8"%>
<!-- 특정 id 일정 상세 보기, 수정은 링크로 넘기고 삭제는 그냥 바로 컨트롤러로 보냄. 이 때, 작성자 id가 일치하는지 체크해야함. 현재 session의 로그인아이디가 -->
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
                	<button class="ui fluid large teal submit button" id="btn_0">일정 삭제</button><br>
                    <button class="ui fluid large teal submit button" id="btn_1">일정 수정</button>
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
            <a href="/webShop/todayAppoView2.jsp"><button class="ui fluid large teal submit button">뒤로가기</button></a>
        </div>
    </div>
</body>

<script src="/webShop/coco/jquery3.3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var dataJson = {
        currId : "<%=currId%>"
	};
	var param1;
	var param2;
	var param3;
	var param4;
	var param5;
	var param6;
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
        	$("<td></td>").attr("colspan", 2).attr("text-align", "left").text(ret['startDate']+'~'+ret['endDate']).appendTo(tr2);
        	var tr3 = $("<tr></tr>").attr('height', '250px').appendTo("#tav_list"); //내용
        	$("<td></td>").attr("colspan", 2).text(ret['explanation']).appendTo(tr3); 
        	//변수저장
        	param1 = ret['id'];
        	param2 = ret['title'];
        	param3 = ret['startDate'];
        	param4 = ret['endDate'];
        	param5 = ret['explanation'];
        	param6 = ret['userId'];
         },
         error: function() { // error logging
           console.log('Error!');
         }
       });
 	}

	$("#btn_0").click(function(){ //일정 삭제 버튼
		$.ajax({
			url: '/webShop/user/checkId',
			dataType: 'text',
			data: {reqValue : param6 },
			type: 'get',
			success: function(ret) {
				if(ret=="true") {
					var form0 = document.createElement('form');
					var obj0 = document.createElement('input');
					obj0.setAttribute('type', 'hidden');
					obj0.setAttribute('name', 'id');
					obj0.setAttribute('value', param1); //글 id 저장
					form0.appendChild(obj0);
					form0.setAttribute('method', 'post');
					form0.setAttribute('action', "/webShop/user/deleteAppo");
					document.body.appendChild(form0);
					form0.submit();
				} else {
					alert("이 일정의 작성자가 아닙니다!")
				}
			},
	        error: function() { // error logging
	             console.log('Error!');
	        }
		});
		
	});
	
	$("#btn_1").click(function(){ //일정 수정 버튼
		$.ajax({
			url: '/webShop/user/checkId',
			dataType: 'text',
			data: {reqValue : param6 },
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type: 'get',
			success: function(ret) {
				if(ret=="true") {
					var form = document.createElement('form');
					form.acceptCharset="UTF-8";
					var form_input1, form_input2, form_input3, form_input4, form_input5, form_input6
					form_input1 = document.createElement('input');
					form_input2 = document.createElement('input');
					form_input3 = document.createElement('input');
					form_input4 = document.createElement('input');
					form_input5 = document.createElement('input');
					form_input6 = document.createElement('input');
					
					form_input1.setAttribute('type', 'hidden');
					form_input1.setAttribute('name', 'id');
					form_input1.setAttribute('value',  param1);
					form_input2.setAttribute('type', 'hidden');
					form_input2.setAttribute('name', 'title')
					form_input2.setAttribute('value',  param2);
					form_input3.setAttribute('type', 'hidden');
					form_input3.setAttribute('name', 'startDate');
					form_input3.setAttribute('value',  param3);
					form_input4.setAttribute('type', 'hidden');
					form_input4.setAttribute('name', 'endDate');
					form_input4.setAttribute('value',  param4);
					form_input5.setAttribute('type', 'hidden');
					form_input5.setAttribute('name', 'explanation');
					form_input5.setAttribute('value',  param5);
					form_input6.setAttribute('type', 'hidden');
					form_input6.setAttribute('name', 'userId');
					form_input6.setAttribute('value',  param6);
					
					form.appendChild(form_input1);
					form.appendChild(form_input2);
					form.appendChild(form_input3);
					form.appendChild(form_input4);
					form.appendChild(form_input5);
					form.appendChild(form_input6);
					form.setAttribute('method', 'post');
					form.setAttribute('action', "/webShop/reviseAppo.jsp");
					document.body.appendChild(form);
					form.submit();
				} else {
					alert("이 일정의 작성자가 아닙니다!")
				}
			},
	        error: function() { // error logging
	             console.log('Error!');
	        }
		});
	});
	
 	get_Appointment();
 });
 </script>
</html>