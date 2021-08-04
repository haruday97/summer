package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CalendarDto;

public class CalendarDao {

	private static CalendarDao dao = new CalendarDao();
	
	private CalendarDao() {
	}
	
	public static CalendarDao getInstance() {
		return dao;
	}
	
	public List<CalendarDto> getCalendarList(String id, String yyyyMM) {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+ "    FROM (SELECT ROW_NUMBER()OVER(PARTITION BY SUBSTR(RDATE, 1, 8) ORDER BY RDATE ASC) AS RNUM, "
				+ "			 SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+ "	  		 FROM CALENDAR "
				+ "	         WHERE ID=? AND SUBSTR(RDATE, 1, 6)=? ) "
				+ "    WHERE RNUM BETWEEN 1 AND 5 ";
		
		Connection conn = null;			
		PreparedStatement psmt = null;	
		ResultSet rs = null;		

		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getCalendarList success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyyMM);
			System.out.println("2/4 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getCalendarList success");
			
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(	rs.getInt(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++));
				list.add(dto);
			}
			System.out.println("4/4 getCalendarList success");
			
		} catch (SQLException e) {
			System.out.println("getCalendarList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
	
	public boolean addCalendar(CalendarDto cal) {
		
		String sql = " INSERT INTO CALENDAR(SEQ, ID, TITLE, CONTENT, RDATE, WDATE) "
				   + " VALUES(SEQ_CAL.NEXTVAL, ?, ?, ?, ?, SYSDATE) ";
		
		Connection conn = null;			
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addCalendar success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, cal.getId());
			psmt.setString(2, cal.getTitle());
			psmt.setString(3, cal.getContent());
			psmt.setString(4, cal.getRdate());
			System.out.println("2/3 addCalendar success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addCalendar success");
			
		} catch (SQLException e) {
			System.out.println("addCalendar fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
	
	public CalendarDto getDay(int seq) {
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+ " FROM CALENDAR "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		CalendarDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getDay success");	
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/4 getDay success");	
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getDay success");	
			
			if(rs.next()){
				dto = new CalendarDto();
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRdate(rs.getString(5));
				dto.setWdate(rs.getString(6));						
			}	
			System.out.println("4/4 S getDay success");			
						
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(conn, psmt, rs);					
		}		
		
		return dto;
	}
	
	public boolean updateCalendar(CalendarDto dto) {
		
		String sql = " UPDATE CALENDAR SET "
				+ " TITLE=?, CONTENT=?, RDATE=?, WDATE=SYSDATE "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S updateCalendar");	
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getRdate());
			psmt.setInt(4, dto.getSeq());
			System.out.println("2/3 S updateCalendar");	
			
			count = psmt.executeUpdate();
			System.out.println("3/3 S updateCalendar");	
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(conn, psmt, null);				
		}
		
		return count>0?true:false;
	}
	
	public boolean deleteCalendar(int seq) {
		
		String sql = " DELETE FROM CALENDAR"
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 S deleteCalendar");	
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 S deleteCalendar");	
			
			count = psmt.executeUpdate();
			System.out.println("3/3 S deleteCalendar");				
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally{
			DBClose.close(conn, psmt, null);	
		}
		
		return count>0?true:false;
	}
	
	public List<CalendarDto> getDayList(String id, String yyyymmdd) {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				   + " FROM CALENDAR "
				   + " WHERE ID=? AND SUBSTR(RDATE, 1, 8)=? "
				   + " ORDER BY RDATE ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 S getDayList");	
		
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyymmdd);
			System.out.println("2/4 S getDayList");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 S getDayList");
			
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(	rs.getInt(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++));
				list.add(dto);
			}	
			System.out.println("4/4 S getDayList");
			
		} catch (SQLException e) {
			System.out.println("getDayList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}
	
}










