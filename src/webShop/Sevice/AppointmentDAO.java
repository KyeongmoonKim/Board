package webShop.Sevice;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;
import webShop.Sevice.*;

public class AppointmentDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;
	
	public AppointmentDAO(){
		try {
		 Context ctx = new InitialContext(); //Set an Initial path for JNDI
		 Context envContext = (Context)ctx.lookup("java:/comp/env");
		 dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<AppointmentVO> dayAppo(String date) {//date�� YYYY-MM-DD��.
		ArrayList<AppointmentVO> AppoList = new ArrayList<AppointmentVO>();
		try {
			con = dataFactory.getConnection();
			String q = "SELECT ID, TITLE, EXPLANATION, STARTDATE, ENDDATE, USERID FROM MYAPPOINTMENT WHERE STARTDATE LIKE ? AND ISDELETED=0";
			pstmt = con.prepareStatement(q);
			pstmt.setString(1, date+"%");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				AppointmentVO avo = new AppointmentVO();
				avo.setId(rs.getInt("ID"));//���̵� ����
				avo.setTitle(rs.getString("TITLE"));
				avo.setExplanation(rs.getString("EXPLANATION"));
				avo.setStartDate(rs.getString("STARTDATE"));
				avo.setEndDate(rs.getString("ENDDATE"));
				avo.setUserId(rs.getString("USERID"));
				AppoList.add(avo);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return AppoList;
	}
	public void makeAppo(AppointmentVO Avo) {
		try {
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}


/*
 TABLE INFORMATION
 ID INT PRIMARY KEY(AUTO INCREMENT),
 TITLE VARCHAR(40) NOT NULL,
 EXPLANATION VARCHAR(255),
 STARTDATE CHAR(16) NOT NULL, "YYYY-MM-DD-HH-mm" 16�ڸ�
 ENDDATE CHAR(16) NOT NULL,
 ISDELETED INT,(�⺻0 ������ 1)
 USERID VARCHAR(20),
 CONSTRAINT FK_ID FOREIGN KEY(USERID) REFERENCES MYUSER(USERID);
 
 ���� ��, INSERT INTO MYAPPOINTMENT VALUES(EMP_SEQ.NEXTVAL, ...);
*/