package webShop.Servlet;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Locale;

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
				String pwd = request.getParameter("user_pw");
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
					System.out.println(dTime);
					/*request.setAttribute("date", dTime);
					nextPage = nextPage + "/user/todayAppo"; //dispatch는 이렇게(시작이  /webshop에서 시작임)
					forwardCase = 0; //DISPATCH */ //디스패치
					nextPage = nextPage + "/webShop/user/todayAppo?date="+dTime;
					forwardCase = 1;
				} else {//로그인 실패
					session.setAttribute("isLogin", "false");
					nextPage = nextPage + "/webShop/login.jsp"; //redirect는 경로로 (시작이 localhost:8090)임
					forwardCase = 1; //redirect
				}
			} else if(action.compareTo("/webShop/user/todayAppo")==0) {//request의 date의
				AppointmentDAO Adao = new AppointmentDAO();
				String date = request.getParameter("date"); //get 방식
				System.out.println("hi");
				System.out.println(date);
				ArrayList<AppointmentVO> AppoList = Adao.dayAppo(date);
				request.setAttribute("AppoList", AppoList); 
				nextPage = nextPage + "/todayAppoView.jsp"; //dispatch(시작 /webShop);
				forwardCase = 0;
			}
			//System.out.println("getRequestURI: " + request.getRequestURI());
			//System.out.println("getServletPath: " + request.getServletPath());
			//System.out.println("getServletContext: " + request.getServletContext().getContextPath());
			//System.out.println("getServerName: " + request.getServerName());
			//System.out.println("getServerPort: " + request.getServerPort());
			//System.out.println(nextPage);
			if(forwardCase==0) { 
				RequestDispatcher dis = request.getRequestDispatcher(nextPage); //기본경로는 webShop이고 그뒤에 nextPage가붙나봄.
				dis.forward(request, response);
			} else if(forwardCase==1) {
				response.sendRedirect(nextPage);
			} 
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
