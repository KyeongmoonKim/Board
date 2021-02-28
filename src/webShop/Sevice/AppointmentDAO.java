package webShop.Sevice;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

public class AppointmentDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private DataSource dataFactory;
}


/*
TABLE INFORMATION
ID INT PRIMARY KEY(AUTO INCREMENT),
TITLE VARCHAR(40) NOT NULL,
EXPLANATION VARCHAR(255),
STARTDATE TIMESTAMP NOT NULL,
ENDDATE TIMESTAMP NOT NULL,
ISDELETED INT,(기본0 삭제시 1)
USERID VARCHAR(20) FOREIGN KEY REFERENCES USER(USERID)
*/