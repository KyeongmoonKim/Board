package webShop.Sevice;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;
import webShop.Sevice.*;
import webShop.Util.*;

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
	
	public ArrayList<AppointmentVO> dayAppo(String date) {//date�� YYYY-MM-DD��. date��¥�� ��� ���� ��ȸ
		ArrayList<AppointmentVO> AppoList = new ArrayList<AppointmentVO>();
		try {
			//db���� �� ���� �ۼ�
			con = dataFactory.getConnection();
			//���� ��Ʈ ��Ȱ��ȭ �� �� �߿� ������.
			String q = "SELECT ID, TITLE, EXPLANATION, STARTDATE, ENDDATE, USERID FROM MYAPPOINTMENT WHERE STARTDATE LIKE ? AND ISDELETED=0";
			pstmt = con.prepareStatement(q);
			pstmt.setString(1, date+"%");
			//���� ���� �� ����
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
			//���� ����
			rs.close();
			pstmt.close();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return AppoList;
	}
	public ArrayList<MyPair> getMonthAppo(String YM) {
		ArrayList<MyPair> ret = new ArrayList<MyPair>();
		try {
			//db ���� �� ���� �ۼ�
			con = dataFactory.getConnection();
			//System.out.println(YM);
			String q = "SELECT DISTINCT(SUBSTR(STARTDATE, 1, 10)) AS MONTHDATE, COUNT(*) AS CNT FROM MYAPPOINTMENT WHERE STARTDATE LIKE ? AND ISDELETED=0 GROUP BY SUBSTR(STARTDATE, 1, 10)";
			pstmt = con.prepareStatement(q);
			pstmt.setString(1, YM+"%");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				MyPair temp = new MyPair();
				temp.key = rs.getString("MONTHDATE");
				temp.value = Integer.toString(rs.getInt("CNT"));
				ret.add(temp);
			}
			rs.close();
			pstmt.close();
			con.close();
		}
			catch(Exception e) {
			e.printStackTrace();
		}
		return ret;
		
	}
	public AppointmentVO getAppoWithId(String id) { //Ư�� id�� ���� ��ȸ
		AppointmentVO avo= new AppointmentVO();
		try {
			//db ���� �� ���� �ۼ�
			con = dataFactory.getConnection();
			int key = Integer.parseInt(id); //id�� �⺻ Ű��
			String q = "SELECT * FROM MYAPPOINTMENT WHERE ID=?";
			pstmt = con.prepareStatement(q);
			pstmt.setInt(1, key);
			
			//���� ���� ��� ����
			ResultSet rs = pstmt.executeQuery();
			int chk = 0;
			while(rs.next()) {
				if(rs.getInt("ISDELETED")==1) chk = 1;
				avo.setId(rs.getInt("ID"));//���̵� ����
				avo.setTitle(rs.getString("TITLE"));
				avo.setExplanation(rs.getString("EXPLANATION"));
				avo.setStartDate(rs.getString("STARTDATE"));
				avo.setEndDate(rs.getString("ENDDATE"));
				avo.setUserId(rs.getString("USERID"));
			}
			rs.close();
			pstmt.close();
			con.close();
			if(chk==1) { //������ �� �� �������� ��������. �߰�����ó�� ���߿� �ؾ��ҵ�(���� �������� ������ �����б⸸ ��������)
				System.out.println("getAppoWithId Error : ������ ���� �󼼺��� �õ�");
				return null;
			}
			//���� ����
		}
			catch(Exception e) {
			e.printStackTrace();
		}
		return avo;
	}
	
	public void makeAppo(AppointmentVO Avo) { //���� ���, �ܼ� 1�� ¥�� �����̶� transaction ��� ������. 
		try {
			con = dataFactory.getConnection();
			String q = "INSERT INTO MYAPPOINTMENT(ID, TITLE, EXPLANATION, STARTDATE, ENDDATE, ISDELETED, USERID) VALUES (EMP_SEQ.NEXTVAL, ?, ?, ?, ?, 0, ?)";
			pstmt = con.prepareStatement(q);
			pstmt.setString(1,  Avo.getTitle()); //����
			if(Avo.getExplanation().length()==0) pstmt.setString(2,  "No Explanation"); //����
			else pstmt.setString(2,  Avo.getExplanation()); //����
			pstmt.setString(3,  Avo.getStartDate()); //������
			pstmt.setString(4,  Avo.getEndDate()); //������
			pstmt.setString(5,  Avo.getUserId());
			pstmt.executeUpdate();
			pstmt.close();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void reviseAppo(AppointmentVO Avo) {
		try {
			con = dataFactory.getConnection();
			String q = "UPDATE MYAPPOINTMENT SET TITLE=?, EXPLANATION=?, STARTDATE=?, ENDDATE=? WHERE ID=?";
			pstmt = con.prepareStatement(q);
			pstmt.setString(1,  Avo.getTitle()); //����
			if(Avo.getExplanation().length()==0) pstmt.setString(2,  "No Explanation"); //����
			else pstmt.setString(2,  Avo.getExplanation()); //����
			pstmt.setString(3,  Avo.getStartDate()); //������
			pstmt.setString(4,  Avo.getEndDate()); //������
			pstmt.setInt(5, Avo.getId());
			pstmt.executeUpdate();
			pstmt.close();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteAppo(String id) {
		try {
			con = dataFactory.getConnection();
			int key = Integer.parseInt(id);
			
			String q = "UPDATE MYAPPOINTMENT SET ISDELETED=1 WHERE ID=?";
			pstmt = con.prepareStatement(q);
			pstmt.setInt(1,  key); //Ű ����
			
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
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