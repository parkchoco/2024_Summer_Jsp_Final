package mvc.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import mvc.database.DBConnection;

public class BoardDAO {

	private static BoardDAO instance;
	
	private BoardDAO() {
		
	}

	public static BoardDAO getInstance() {
		if (instance == null)
			instance = new BoardDAO();
		return instance;
	}	

	public int getListCount(String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		String sql;
		
		if (items == null && text == null)
			sql = "select  count(*) from board";
		else
			sql = "SELECT   count(*) FROM board where " + items + " like '%" + text + "%'";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) 
				x = rs.getInt(1);
			
		} catch (Exception ex) {
			System.out.println("getListCount() 예외발생: " + ex);
		} finally {			
			try {				
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();												
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}		
		return x;
	}

	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int total_record = getListCount(items, text );
		int start = (page - 1) * limit;
		int index = start + 1;
		String sql;

		if (items == null && text == null)
			sql = "select * from board ORDER BY num DESC";
		else
			sql = "SELECT  * FROM board where " + items + " like '%" + text + "%' ORDER BY num DESC ";

		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
	
		try {
			conn = DBConnection.getConnection();		
			
			pstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();
			
			while (rs.absolute(index)) {
				BoardDTO board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				
				board.setSubject(rs.getString("subject"));
				
				list.add(board);					
				
				if (index < (start + limit) && index <= total_record)
					index++;
				else break;
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getBoardList() 예외발생: " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}			
		}
		return null;
	}

	public String getLoginNameById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	

		String name=null;
		String sql = "select * from member where id = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) 
				name = rs.getString("name");	
			
			return name;
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 예외발생: " + ex);
		} finally {
			try {				
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return null;
	}


	public void insertBoard(BoardDTO board)  {

		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();		

			String sql = "insert into board values(?, ?)";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			pstmt.setString(2, board.getSubject());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertBoard() 예외발생: " + ex);
		} finally {
			try {									
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}		
	} 

	public void updateHit(int num) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.getConnection();

			String sql = "select hit from board where num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			int hit = 0;

			if (rs.next())
				hit = rs.getInt("hit") + 1;
		

			sql = "update board set hit=? where num=?";
			pstmt = conn.prepareStatement(sql);		
			pstmt.setInt(1, hit);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateHit() 예외발생: " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}			
		}
	}

	public BoardDTO getBoardByNum(int num, int pageNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO board = null;

		updateHit(num);
		String sql = "select * from board where num = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
			}
			
			return board;
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 예외발생: " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return null;
	}

	public void updateBoard(BoardDTO board) {

		Connection conn = null;
		PreparedStatement pstmt = null;
	
		try {
			String sql = "update board set name=?, subject=?, content=? where num=?";

			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			conn.setAutoCommit(false);

			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, board.getNum());

			pstmt.executeUpdate();			
			conn.commit();

		} catch (Exception ex) {
			System.out.println("updateBoard() 예외발생: " + ex);
		} finally {
			try {										
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
	} 

	public void deleteBoard(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;		

		String sql = "delete from board where num=?";	

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteBoard() 예외발생: " + ex);
		} finally {
			try {										
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
	}

	public String getSubjectByNum(int num) {
    String subject = null;
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement("SELECT subject FROM board WHERE num = ?")) {
        pstmt.setInt(1, num);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                subject = rs.getString("subject");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return subject;
}

	public int getUserPoints(String userId) {
	    int points = 0;
	    String query = "SELECT point FROM member WHERE id = ?";
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	         
	        pstmt.setString(1, userId);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                points = rs.getInt("point");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return points;
	}

	  public int getUserLevel(String userId) {
	        int points = getUserPoints(userId);
	        int level = points / 100;
	        return level;
	    }

    public Date getUserPointsDate(String userId) {
        String sql = "SELECT date_added FROM history WHERE user_id = ? ORDER BY date_added DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getTimestamp("date_added");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateUserPoints(String userId, int points) {
        String sql = "UPDATE member SET point = point + ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, points);
            pstmt.setString(2, userId);
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("updateUserPoints: Rows affected: " + rowsAffected);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void savePointsHistory(String userId, int points) {
        String sql = "INSERT INTO history (user_id, points) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, points);
            int rowsInserted = pstmt.executeUpdate();
            System.out.println("savePointsHistory: Rows inserted: " + rowsInserted); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean hasPointsRecordedToday(String userId) {
        String sql = "SELECT COUNT(*) FROM history WHERE user_id = ? AND DATE(date_added) = CURDATE()";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("hasPointsRecordedToday: Count: " + count);
                    return count > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Date> getUserPointsDatesForMonth(String userId, int year, int month) {
        List<Date> dates = new ArrayList<>();
        String sql = "SELECT date_added FROM history WHERE user_id = ? AND YEAR(date_added) = ? AND MONTH(date_added) = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, year);
            pstmt.setInt(3, month + 1); 
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    dates.add(rs.getTimestamp("date_added"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dates;
    }
	
    public List<String> getStoreContentForRange(int startId, int endId) {
        List<String> contents = new ArrayList<>();
        String sql = "SELECT content FROM store WHERE id BETWEEN ? AND ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, startId);
            pstmt.setInt(2, endId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    contents.add(rs.getString("content"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return contents;
    }
    
    
    public void deductUserPoints(String userId, int points) {
        String sql = "UPDATE member SET point = point - ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, points);
            pstmt.setString(2, userId);
            int rowsUpdated = pstmt.executeUpdate();
            System.out.println("deductUserPoints: Rows updated: " + rowsUpdated); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


	
}
