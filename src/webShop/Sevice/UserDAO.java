
package webShop.Sevice;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;
import webShop.Sevice.UserVO;

public class UserDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;
	
	public UserDAO(){
		try {
		 Context ctx = new InitialContext(); //Set an Initial path for JNDI
		 Context envContext = (Context)ctx.lookup("java:/comp/env");
		 dataFactory = (DataSource)envContext.lookup("jdcb/oracle");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean logIn(UserVO uvo) {
		boolean ret = false;
		//DB CONNECTION
		try {
			con = dataFactory.getConnection();
			String id = uvo.getId();
			String pwd = uvo.getPwd();
			String q = "SELECT COUNT(*) AS cnt FROM MYUSER WHERE USERID=? AND USERPWD=?";
			pstmt = con.prepareStatement(q);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			ResultSet rs = pstmt.executeQuery();
			if(rs.getInt("cnt")==1) ret = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return ret;
	}
}
