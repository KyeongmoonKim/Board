package webShop.Sevice;

import java.sql.Timestamp;

public class AppointmentVO {
	private int id;
	private String title;
	private String explanation;
	private Timestamp startDate;
	private Timestamp endDate;
	private String userId;
	
	public AppointmentVO() {		
	}
	public void setId(int a) {
		this.id = a;
	}
	public int getId() {
		return this.id;
	}
	public void setTitle(String a) {
		this.title = a;
	}
	public String getTitle() {
		return this.title;
	}
	public void setExplanation(String a) {
		this.explanation = a;
	}
	public String getExplanation() {
		return this.explanation;
	}
	public void setStartDate(Timestamp a) {
		this.startDate = a;
	}
	public void setStartDate(long a) {
		this.startDate = new Timestamp(a);		
	}
	public Timestamp getStartDate() {
		return this.startDate;
	}
	public void setEndDate(Timestamp a) {
		this.endDate = a;
	}
	public void setEndDate(long a) {
		this.endDate = new Timestamp(a);
	}
	public Timestamp getEndDate() {
		return this.endDate;
	}
	public void setUserId(String a) {
		this.userId = new String(a);
	}
	public String getUserId() {
		return this.userId;
	}
}


/*
 TABLE INFORMATION
 ID INT PRIMARY KEY(AUTO INCREMENT),
 TITLE VARCHAR(40) NOT NULL,
 EXPLANATION VARCHAR(255),
 STARTDATE TIMESTAMP NOT NULL,
 ENDDATE TIMESTAMP NOT NULL,
 USERID VARCHAR(20) FOREIGN KEY REFERENCES USER(USERID)
*/
