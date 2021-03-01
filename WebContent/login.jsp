<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	String isLogin = (String)session.getAttribute("isLogin");
	System.out.println("isLogin is ");
	if(isLogin!=null) System.out.println(isLogin);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정</title>
<script type="text/javascript">
function fn_validate(){	
    var frmLogin=document.frmLogin;
    var user_id=frmLogin.user_id.value;
    var user_pw=frmLogin.user_pw.value;

    if((user_id.length==0 ||user_id=="") ||(user_pw.length==0 ||user_pw=="")){
	 alert("아이디와 비밀번호는 필수입니다.");
    }else{
	frmLogin.method="post";
	frmLogin.action="/webShop/user/login"; //directory 경로
	frmLogin.submit();
    }
 }
 function ol_alert() {
	 <%if(isLogin!=null&&isLogin.compareTo("false")==0) {
	 %>
	 alert("회원정보가 일치하지 않습니다!");
	 <%
	 }
	 %>
 }
 window.onload=ol_alert();
</script>
</head>
<body>
    <form name="frmLogin">       
      <h2 class="form-signin-heading">Please login</h2>
      <input type="text" name="user_id" placeholder="ID"/><br><br>
      <input type="password" name="user_pw" placeholder="password"><br>
      <input type="button" onClick="fn_validate()" value="login">   
    </form>
</body>
</html>