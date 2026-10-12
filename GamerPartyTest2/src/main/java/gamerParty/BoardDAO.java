package gamerParty;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
	final String JDBC_DRIVER = "oracle.jdbc.OracleDriver";
	final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/BUILDUP";
	final String JDBC_USER = "buildup";
	final String JDBC_PW = "1234";
	
	// DB 연결을 가져오는 메서드
	public Connection open() {
		Connection conn = null;
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PW);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public List<Board> getAll(int start,int size) throws Exception {
		Connection conn = open();
		List<Board> boardList = new ArrayList<>();
		String sql = "select aid, username, title, type, TO_CHAR(\"DATE\", 'YYYY-MM-DD HH24:MI:SS') as cdate from board order by aid desc offset ? rows fetch next ? rows only";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,start);
		pstmt.setInt(2, size);
		ResultSet rs = pstmt.executeQuery();
		
		try(conn; pstmt; rs) {
			while(rs.next()) {
				Board n = new Board();
				n.setAid(rs.getInt("aid"));
				n.setUsername(rs.getString("username"));
				n.setTitle(rs.getString("title"));
				n.setDate(rs.getString("cdate")); 
				n.setType(rs.getString("type"));
				boardList.add(n);
			}
			return boardList;			
		}
	}
	
	public Board getBoard(int aid) throws SQLException {
		Connection conn = open();
		
		Board n = new Board();
		String sql = "select aid, username, title, img, TO_CHAR(\"DATE\", 'YYYY-MM-DD HH24:MI:SS') as cdate, content from board where aid=?";
	
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, aid);
		ResultSet rs = pstmt.executeQuery();
		
		try(conn; pstmt; rs) {
			if(rs.next()) {
				n.setAid(rs.getInt("aid"));
				n.setUsername(rs.getString("username"));
				n.setTitle(rs.getString("title"));
				n.setImg(rs.getString("img"));
				n.setDate(rs.getString("cdate"));
				n.setContent(rs.getString("content"));
			}
			return n;
		}
	}
	
	public void addBoard(Board n) throws Exception {
		Connection conn = open();
		
		String sql = "insert into board(title,username,img,\"DATE\",content,type) values(?,?,?,CURRENT_TIMESTAMP,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		try(conn; pstmt) {
			pstmt.setString(1, n.getTitle());
			pstmt.setString(2, n.getUsername());
			pstmt.setString(3, n.getImg());
			pstmt.setString(4, n.getContent());
			pstmt.setString(5, n.getType());
			pstmt.executeUpdate();
		}
	}
	
	public void delBoard(int aid) throws SQLException {
		Connection conn = open();
		
		String sql = "delete from board where aid=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		try(conn; pstmt) {
			pstmt.setInt(1, aid);
			// 삭제된 뉴스 기사가 없을 경우
			if(pstmt.executeUpdate() == 0) {
				conn.close();
				throw new SQLException("DB에러");
			}
			conn.close();
		}
	}
	public int getAidNumber() throws SQLException{
		Connection conn = open();
		String sql = "select count(aid) from board";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int n = 0;
		while(rs.next()) {
			n = rs.getInt(1);
		}
		conn.close();
		return n;
	}
	
	public int addAccount(Account n) throws Exception {
		Connection conn = open();
		
		String sql = "insert into account(email,password,nickname,prefergame,preferrole,ban) values(?,?,?,?,?,0)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		if(n.getPrefergame() == null) {
			n.setPrefergame("없음");
		}
		if(n.getPreferrole() == null) {
			n.setPreferrole("없음");
		}
		try(conn; pstmt) {
			pstmt.setString(1, n.getEmail());
			pstmt.setString(2, n.getPassword());
			pstmt.setString(3, n.getNickname());
			pstmt.setString(4, n.getPrefergame());
			pstmt.setString(5, n.getPreferrole());
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			conn.close();
			e.printStackTrace();
		}
		conn.close();
		return -2;
	}	
	
	public int login(String userId, String userPw) throws Exception {
		Connection conn = open();
		String sql = "select password , ban from account where email = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1 , userId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("password").equals(userPw)) {
					if(rs.getInt("ban") == 1) {
						conn.close();
						return -3;
					}
					else if(rs.getInt("ban") == 2) {
						conn.close();
						return 2;
					}
					conn.close();
					return 1;
				}
				else {
					conn.close();
					return 0;
				}
			}
			conn.close();
			return -1;
		} catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		conn.close();
		return -2;
	}
	
	public Account listInfo(String email) throws Exception {
		Account acc = null;
		Connection conn = open();
		String sql = "select * from account where email = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		
		try(conn; pstmt; rs) {
			while(rs.next()) {
				acc = new Account();
				acc.setEmail(rs.getString("email"));
				acc.setNickname(rs.getString("nickname"));
				acc.setPrefergame(rs.getString("prefergame"));
				acc.setPreferrole(rs.getString("preferrole"));
				acc.setIcon(rs.getString("image"));
			}
		}
		catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		conn.close();
		return acc;
	}
	public Account listInfoAll(String email) throws Exception {
		Account acc = null;
		Connection conn = open();
		String sql = "select * from account where email = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		
		try(conn; pstmt; rs) {
			while(rs.next()) {
				acc = new Account();
				acc.setEmail(rs.getString("email"));
				acc.setNickname(rs.getString("nickname"));
				acc.setPrefergame(rs.getString("prefergame"));
				acc.setPreferrole(rs.getString("preferrole"));
				acc.setIcon(rs.getString("image"));
				acc.setPassword(rs.getString("password"));
			}
		}
		catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		conn.close();
		return acc;
	}
	public int changeInfo(Account acc) throws Exception {
		Connection conn = open();
		String sql = null;
		
		if(acc.getNickname().equals("") && acc.getIcon().equals("/img/") && acc.getPassword().equals("") && acc.getPrefergame().equals("") && acc.getPreferrole().equals("")) {
			return 0;
		}
		
		if(!acc.getNickname().equals("없음")) {
			if(!acc.getNickname().equals("") && !acc.getNickname().equals(null) && ((String)acc.getNickname()).length() >= 4) {
				sql = "UPDATE ACCOUNT SET NICKNAME = ? WHERE EMAIL = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, acc.getNickname());
				pstmt.setString(2, acc.getEmail());
				pstmt.executeUpdate();
			}
		}
		if(acc.getIcon() != null) {
			if(!acc.getIcon().equals("/img/") && !acc.getIcon().equals("")) {
				sql = "UPDATE ACCOUNT SET IMAGE = ? WHERE EMAIL = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, acc.getIcon());
				pstmt.setString(2, acc.getEmail());
				pstmt.executeUpdate();	
			}
		}
		if(!acc.getPassword().equals("없음")){
			if(!acc.getPassword().equals("") && !acc.getPassword().equals(null) && ((String)acc.getPassword()).length() >= 6) {
				sql = "UPDATE ACCOUNT SET PASSWORD = ? WHERE EMAIL = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, acc.getPassword());
				pstmt.setString(2, acc.getEmail());
				pstmt.executeUpdate();	
			}
		}
		if(!acc.getPrefergame().equals("없음")) {
			if(!acc.getPrefergame().equals("") && !acc.getPrefergame().equals(null)) {
				sql = "UPDATE ACCOUNT SET PREFERGAME = ? WHERE EMAIL = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, acc.getPrefergame());
				pstmt.setString(2, acc.getEmail());
				pstmt.executeUpdate();
			}
		}
		if(!acc.getPreferrole().equals("없음")) {
			if(!acc.getPreferrole().equals("") && !acc.getPreferrole().equals(null)) {
				sql = "UPDATE ACCOUNT SET PREFERROLE = ? WHERE EMAIL = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, acc.getPreferrole());
				pstmt.setString(2, acc.getEmail());
				pstmt.executeUpdate();	
			}
		}
		conn.close();
		return 1;
	}
	public void setStatus(int actionUid, int status) throws Exception {
		Connection conn = open();
	
		String sql = "update account set ban = ? where aid = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, status);
		pstmt.setInt(2, actionUid);
		
		pstmt.executeUpdate();
		
		conn.close();
	}
	public int adminWork(int workType,int actionUid) throws Exception {
		switch(workType) {
			case 1: delBoard(actionUid);
					return 1;
		
			case 2: setStatus(2,actionUid);
					return 1;
					
			case 3: setStatus(1,actionUid);
					return 1;
					
			case 4: setStatus(0,actionUid);
					return 1;
		}
		return 0;
	}
	public String getPassword(String email) throws Exception {
		Connection conn = open();
		
		String sql = "select password from account where email = ?";
		String userPassword = null;
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,email);
		
		ResultSet rs = pstmt.executeQuery();
		
		try(conn; pstmt; rs) {
			while(rs.next()) {
				userPassword = rs.getString("password");
			}
		}
		catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		conn.close();
		return userPassword;
	}
}
