package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class DisplayDAO {
    private static DisplayDAO instance;

    private DisplayDAO() {}

    public static DisplayDAO getInstance() {
        if (instance == null) {
            instance = new DisplayDAO();
        }
        return instance;
    }

    public void insertDisplay(DisplayDTO display) {
        String sql = "INSERT INTO display (subject, content, created_at) VALUES (?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, display.getSubject());
            pstmt.setString(2, display.getContent());
            pstmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public ArrayList<DisplayDTO> getDisplayList() {
        ArrayList<DisplayDTO> displayList = new ArrayList<>();
        String sql = "SELECT * FROM display ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                DisplayDTO display = new DisplayDTO();
                display.setId(rs.getInt("id"));
                display.setSubject(rs.getString("subject")); 
                display.setContent(rs.getString("content"));
                display.setCreatedAt(rs.getTimestamp("created_at"));
                displayList.add(display);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return displayList;
    }

	public ArrayList<DisplayDTO> getDisplaysBySubject(String subject) {
    ArrayList<DisplayDTO> displayList = new ArrayList<>();
    String sql = "SELECT * FROM display WHERE subject LIKE ? ORDER BY created_at DESC";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, "%" + subject + "%");
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            DisplayDTO display = new DisplayDTO();
            display.setId(rs.getInt("id"));
            display.setSubject(rs.getString("subject"));
            display.setContent(rs.getString("content"));
            display.setCreatedAt(rs.getTimestamp("created_at"));
            displayList.add(display);
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    return displayList;
}

	public boolean deleteDisplayById(int id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM display WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return result;
    }

}
