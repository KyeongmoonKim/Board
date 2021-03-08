<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="webShop.Sevice.*, java.util.*" pageEncoding="UTF-8"%>
<!-- 일정 수정. windowAppo에서 post로 전송받은 데이터를 폼형식 안에 넣을거임 폼형식은 똑같음 makeAppo랑 -->
<%
	request.setCharacterEncoding("utf-8");  //굉장히 굉장히 중요
	String id = (String)request.getParameter("id");
	String title = (String)request.getParameter("title");
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
            max-width: 450px;
        }

    </style>
        
<script src="./coco/jquery3.3.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	//document.getElementById("title").value = "";
	$("#title").attr("value", "<%=title%>");
	$("#btn_0").click(function(){
	    var frmLogin=document.frmLogin;
	    var obj0 = document.createElement('input');
		obj0.setAttribute('type', 'hidden');
		obj0.setAttribute('name', 'id');
		obj0.setAttribute('value', '<%=id%>'); //글 id 저장
		frmLogin.appendChild(obj0);
	    var title=frmLogin.title.value;
	    var startDate=frmLogin.startDate.value;
	    var endDate=frmLogin.endDate.value;
	    var explanation=frmLogin.explanation.value;	    
	    var obj1 = document.createElement('input');
		obj1.setAttribute('type', 'hidden');
		obj1.setAttribute('name', 'userId');
		obj1.setAttribute('value', '<%=userId%>'); //글 id 저장
		frmLogin.appendChild(obj1);
	    if((title.length==0 ||title=="") ||(startDate.length==0 ||startDate=="")||(endDate.length==0 ||endDate=="")){
			alert("제목과 날짜는 꼭 입력하셔야 합니다.");
	    } else{
			frmLogin.method="post";
			frmLogin.action="/webShop/user/updateAppo"; //directory 경로
			frmLogin.submit();
		}
	});
});

</script>

</head>
<body>
	<div class="ui middle aligned center aligned grid">
        <div class="column">
            <h2 class="ui teal image header">
                일정 수정하기
            </h2>
            <form class="ui large form" name="frmLogin" id="frmRevise">
                <div class="ui stacked segment">
                    <div class="field" id="field1">
                        <input type="text" id="title" name="title" >
                    </div>
                    <div class="field">
                    	<input type="text" id="startDate" name="startDate" value="<%=startDate%>">
                    </div>
                    <div class="field">
                    	<input type="text" id="endDate" name="endDate" value="<%=endDate%>">
                    </div>
                    <div class="field">
                        <div class="ui left icon input">
                            <textarea style="resize: vertical;" id="explanation" name="explanation" rows="8"><%=explanation %></textarea>
                        </div>
                    </div>
                    <div class="ui fluid large teal submit button" id="btn_0">일정 수정하기</div>
                </div>

            </form>

            <a href="/webShop/todayAppoView2.jsp"><button class="ui fluid large teal submit button">홈으로 돌아가기</button></a>
        </div>
    </div>
    

</body>
</html>