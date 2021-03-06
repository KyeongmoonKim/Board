package webShop.Servlet;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Locale;
import java.util.stream.Collectors;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.*;
import webShop.Sevice.*;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/user/*")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doHandle(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doHandle(request, response);
	}
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getRequestURI();
		System.out.println(action);
		String nextPage = "";
		int forwardCase = 0;
		try {
			//login case
			HttpSession session = request.getSession();
			/*if(session.getAttribute("isLogin")!=null&&((String)session.getAttribute("isLogin")).compareTo("true")==0) { //로그인 성공했던경우
				nextPage = nextPage + "/webShop/login.jsp"; //redirect는 경로로
				forwardCase = 1; //redirect
			}
			else*/
			if(action.compareTo("/webShop/user/login")==0) { //로그인 요청
				String id = request.getParameter("user_id"); //post 방식
				System.out.println(id);
				String pwd = request.getParameter("user_pw");
				System.out.println(pwd);
				UserVO uvo = new UserVO();
				uvo.setId(id);
				uvo.setPwd(pwd);
				UserDAO udao = new UserDAO();
				if(udao.logIn(uvo)) {
					System.out.println("login success!");
					//session 등록도 해줘야함.
					session.setAttribute("userId", id);
					session.setAttribute("isLogin", "true");
					long systemTime = System.currentTimeMillis();
					// 출력 형태를 위한 formmater 
					//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA); (초까지 출력)
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
					// format에 맞게 출력하기 위한 문자열 변환
					String dTime = formatter.format(systemTime);
					
					//원래코드
					//nextPage = nextPage + "/webShop/user/todayAppo?date="+dTime+"&page=1";
					
					nextPage = nextPage + "/webShop/todayAppoView2.jsp?date="+dTime+"&page=1";
					forwardCase = 1;
				} else {//로그인 실패
					session.setAttribute("isLogin", "false");
					nextPage = nextPage + "/webShop/login.jsp"; //redirect는 경로로 (시작이 localhost:8090)임
					forwardCase = 1; //redirect
				}
			} else if(action.compareTo("/webShop/user/todayAppo")==0) {//date(YYYY-MM-DD)의 일정 호출, 특정 날짜의 모든 일정 조회, 이거 안쓰고 있음.
				AppointmentDAO Adao = new AppointmentDAO();
				String date = request.getParameter("date"); //get 방식이면 이렇게
				String page = request.getParameter("page");
				if(date==null) {//없을 땐 현재 날짜.
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
					long systemTime = System.currentTimeMillis();
					date = formatter.format(systemTime);
				}
				if(page==null) page = "1";
				ArrayList<AppointmentVO> AppoList = Adao.dayAppo(date);
				request.setAttribute("AppoList", AppoList); 
				request.setAttribute("page", page);
				nextPage = nextPage + "/todayAppoView.jsp"; //dispatch(시작 /webShop);
				forwardCase = 0;
			} else if(action.compareTo("/webShop/user/makeAppo")==0) {//일정 등록
				String title = (String)request.getParameter("title");
				String explanation = (String)request.getParameter("explanation"); //없으면 길이 0임
				String startDate = (String)request.getParameter("startDate");
				String endDate = (String)request.getParameter("endDate");
				String userId = (String)session.getAttribute("userId");
				AppointmentDAO Adao = new AppointmentDAO();
				AppointmentVO Avo = new AppointmentVO();
				Avo.setTitle(title);
				Avo.setStartDate(startDate);
				Avo.setEndDate(endDate);
				Avo.setExplanation(explanation);
				Avo.setUserId(userId);
				Adao.makeAppo(Avo);
				nextPage = nextPage + "/webShop/todayAppoView2.jsp?date="+startDate.substring(0,10)+"&page=1";
				forwardCase = 1;
			} else if(action.compareTo("/webShop/user/todayAppoAjax")==0) {//AJAX통신을 통해서 금일 일정 조회
				//parameter 처리
				String requestData = request.getReader().lines().collect(Collectors.joining());
				String[] ParamEqus = requestData.split("&");
				int paraNum = ParamEqus.length;
				String[] Params = new String[paraNum];
				for(int i = 0; i < paraNum; i++) Params[i] = (ParamEqus[i].split("="))[1];
				String date = Params[0];
				String page = Params[1];
				//System.out.println(date);
				//System.out.println(page);
				AppointmentDAO Adao = new AppointmentDAO();
				ArrayList<AppointmentVO> AppoList = Adao.dayAppo(date);
				System.out.println(AppoList.size());
				String ret = "";
				if(AppoList.size()!=0) {
					ret = ret + "{";
					for(int i = 0; i < AppoList.size(); i++) {
						AppointmentVO avo = AppoList.get(i);
						ret = ret + "\""+Integer.toString(i)+ "\" : ";
						ret = ret+"{";
						ret = ret + "\"id\" : ";
						ret = ret + "\"" + Integer.toString(avo.getId())+ "\",";
						ret = ret + "\"title\" : ";
						ret = ret + "\""+avo.getTitle()+ "\",";
						ret = ret + "\"explanation\" : ";
						ret = ret + "\""+avo.getExplanation()+ "\",";
						ret = ret + "\"startDate\" : ";
						ret = ret + "\""+avo.getStartDate()+ "\",";
						ret = ret + "\"endDate\" : ";
						ret = ret + "\""+avo.getEndDate()+ "\",";
						ret = ret + "\"userId\" : ";
						ret = ret + "\""+avo.getUserId()+ "\"";
						ret = ret+"}";
						ret = ret+",";
					}
					ret = ret.substring(0, ret.length()-1); //마지막 쉼표 제거
					ret = ret+"}";
					//System.out.println(ret);
					response.setContentType("application/json");
					response.setCharacterEncoding("utf-8");
					PrintWriter out = response.getWriter();
					out.print(ret);
					//out.flush(); 
				}
				forwardCase = -1; //no forwarding
			} else if(action.compareTo("/webShop/user/getIdAppo")==0) { //ajax 통신을 통해서 특정 id에 해당하는 일정 모든 정보 조회
				String requestData = request.getReader().lines().collect(Collectors.joining());
				System.out.println(requestData);
				String id = (requestData.split("="))[1];
				System.out.println(id);
				AppointmentDAO Adao = new AppointmentDAO();
				AppointmentVO avo = Adao.getAppoWithId(id);
				String ret = "";
				ret = ret+"{";
				ret = ret + "\"id\" : ";
				ret = ret + "\"" + Integer.toString(avo.getId())+ "\",";
				ret = ret + "\"title\" : ";
				ret = ret + "\""+avo.getTitle()+ "\",";
				ret = ret + "\"explanation\" : ";
				ret = ret + "\""+avo.getExplanation()+ "\",";
				ret = ret + "\"startDate\" : ";
				ret = ret + "\""+avo.getStartDate()+ "\",";
				ret = ret + "\"endDate\" : ";
				ret = ret + "\""+avo.getEndDate()+ "\",";
				ret = ret + "\"userId\" : ";
				ret = ret + "\""+avo.getUserId()+ "\"";
				ret = ret+"}";
				//System.out.println(ret);
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				PrintWriter out = response.getWriter();
				out.print(ret);
				forwardCase = -1; //no forwarding
			}
			
			//System.out.println("getRequestURI: " + request.getRequestURI());
			//System.out.println("getServletPath: " + request.getServletPath());
			//System.out.println("getServletContext: " + request.getServletContext().getContextPath());
			//System.out.println("getServerName: " + request.getServerName());
			//System.out.println("getServerPort: " + request.getServerPort());
			//System.out.println(nextPage);
			if(forwardCase==0) { //디스패치
				RequestDispatcher dis = request.getRequestDispatcher(nextPage); //기본경로는 webShop이고 그뒤에 nextPage가붙나봄.
				dis.forward(request, response);
			} else if(forwardCase==1) { //리다이렉트
				response.sendRedirect(nextPage);
			} 
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
