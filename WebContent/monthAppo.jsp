<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="webShop.Sevice.*, java.util.*, webShop.Util.*" pageEncoding="UTF-8"%>
<!-- 월 일정 창 -->

<%
	request.setCharacterEncoding("utf-8");
	MyCalendar cal = new MyCalendar();
	String yearMonth = request.getParameter("Date");
	cal.setCalendar(yearMonth);
	String currDate = cal.currYM();
	String prevDate = cal.prevYM();
	String nextDate = cal.nextYM();
	//int dow = (cal.curr).get(Calendar.DAY_OF_WEEK); //1이 일요일, 7이 토요일
	int maximumDay = (cal.curr).getActualMaximum(Calendar.DAY_OF_MONTH);
	(cal.curr).set(Calendar.DATE, 1);
	int startDW = (cal.curr).get(Calendar.DAY_OF_WEEK);
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
               <%=currDate.substring(0,7)%>
            </h2>
            <div class="ui large form">
                <div class="ui stacked segment">
                	<a href="/webShop/monthAppo.jsp?Date=<%=prevDate%>"><button class="ui fluid large teal submit button">저번달</button></a><br>
                    <a href="/webShop/monthAppo.jsp?Date=<%=nextDate%>"><button class="ui fluid large teal submit button">다음달</button></a>
                    <table class="ui celled table" id="tav_table">
                    	<thead>
                    		<tr>
                    			<th>일</th>
                            	<th>월</th>
                            	<th>화</th>
                            	<th>수</th>
                            	<th>목</th>
                            	<th>금</th>
                            	<th>토</th>
                            </tr>                               
                    	</thead>
                        <tbody>
                        	<%int i=1;
                        	  while(i<startDW) { //i가 시작요일보다 작을때는 그냥 td만 넣음
                        		  if(i==1) {
                        	%>
                        	<tr>
                        	<%
                        		  }
                        	%>
                        	  <td></td>
                        	<%
                        		i++;
                        	}
                        	%>
                        	<%
                        	  int cnt = 1;
                        	  int tempDW = -1;
                        	  for(;cnt<=maximumDay;cnt++) {
                        		  String tempStr = "";
                        		  if(cnt < 10) tempStr = "0"+Integer.toString(cnt);
                        		  else tempStr = Integer.toString(cnt);
                        		  (cal.curr).set(Calendar.DATE, cnt);
                        		  tempDW = (cal.curr).get(Calendar.DAY_OF_WEEK);
                        		  if(tempDW==0) { //<tr>태그넣고 td태그넣어야함
                        	%>
                        	<tr>
                        		<td id="date_<%=tempStr%>"><%=cnt%></td>
                        	<%
                        		  } else if(tempDW==7) { //td넣고 </tr>해줘야함
                        	%>
                        		<td id="date_<%=tempStr%>"><%=cnt%></td>
                        	</tr>
                        	<%
                        		  } else {
                        	%>
                        		<td id="date_<%=tempStr%>"><%=cnt%></td>
                        	<%
                        		  }
                        	%>
                        	<%
                        	  }
                        	  tempDW++;
                        	%>
                        	<%
                        		while(tempDW < 8) {
                        			if(tempDW==7) {
                        	%>
                        		<td></td>
                       		</tr>
                        	<%
                        			} else {
                        	%>
                        	<td></td>
                        	<%
                        			}
                        	%>
                        	<%
                        			tempDW++;
                        		}
                        	%>
                        </tbody>
                    </table>
                </div>

                <div class="ui error message"></div>

            </div>
        </div>
    </div>
</body>
</html>