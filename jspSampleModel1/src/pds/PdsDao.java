package pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;

public class PdsDao {
	private static PdsDao pd = new PdsDao();
	
	private PdsDao() {
	}
	
	public static PdsDao getInstance() {
		return pd;
	}
	
	public List<PdsDto> getPdsList() {
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, NEWFILENAME, "
				   + "				READCOUNT, DOWNCOUNT, REGDATE "
				   + " FROM PDS ";
		
		Connection conn = null;			// DB 연결
		PreparedStatement psmt = null;	// Query문을 실행
		ResultSet rs = null;			// 결과 취득
		
		List<PdsDto> list = new ArrayList<PdsDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getPdsList success");
				
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getPdsList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getPdsList success");
			
			while(rs.next()) {
				int i = 1;
				PdsDto dto = new PdsDto(rs.getInt(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++), 
										rs.getString(i++),
										rs.getInt(i++), 
										rs.getInt(i++), 
										rs.getString(i++));
				list.add(dto);
			}	
			System.out.println("4/4 getPdsList success");
			
		} catch (SQLException e) {
			System.out.println("getPdsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}
	
	public boolean writePds(PdsDto pds) {
		
		String sql = " INSERT INTO PDS(SEQ, ID, TITLE, CONTENT, FILENAME, NEWFILENAME, "
				   + "                      READCOUNT, DOWNCOUNT, REGDATE) "
				   + " VALUES(SEQ_PDS.NEXTVAL, ?, ?, ?, ?, ?, 0, 0, SYSDATE) ";
	
		Connection conn = null;			// DB 연결
		PreparedStatement psmt = null;	// Query문을 실행
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 writePds success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, pds.getId());
			psmt.setString(2, pds.getTitle());
			psmt.setString(3, pds.getContent());
			psmt.setString(4, pds.getFilename());
			psmt.setString(5, pds.getNewFilename());
			System.out.println("2/3 writePds success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 writePds success");
			
		} catch (SQLException e) {
			System.out.println("writePds fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
	public PdsDto getPds(int seq) {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, "
				+ " FILENAME, NEWFILENAME, READCOUNT, DOWNCOUNT, REGDATE "
				+ " FROM PDS "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PdsDto pds = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/6 getPds Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getPds Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getPds Success");
			
			if(rs.next()) {
				int i = 1;				
				pds = new PdsDto(rs.getInt(i++), 
								rs.getString(i++), 
								rs.getString(i++), 
								rs.getString(i++), 
								rs.getString(i++),
								rs.getString(i++),
								rs.getInt(i++), 
								rs.getInt(i++), 
								rs.getString(i++));				
			}
			System.out.println("4/6 getPds Success");
			
		} catch (Exception e) {		
			System.out.println("getPds Fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
				
		return pds;
	}
		
	public boolean pdsReadCount(int seq) {
		int count=0;
		String sql=" UPDATE PDS SET " +
				" READCOUNT=READCOUNT+1 " +
				" WHERE  SEQ=? ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("2/6 S  pdsReadCount");
			
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, seq );
			System.out.println("3/6 S  pdsReadCount");
			
			count=psmt.executeUpdate();
			System.out.println("4/6 S  pdsReadCount");
			
		} catch (Exception e) {
			System.out.println("F pdsReadCount");
		}finally{
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
}






