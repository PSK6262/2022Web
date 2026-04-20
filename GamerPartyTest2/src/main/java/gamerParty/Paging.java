package gamerParty;

import java.sql.SQLException;

public class Paging {
	private BoardDAO dao;
	private int rowsCount;
	private int pageElements;
	private int lastPage;
	
	public Paging() {
		try {
			dao = new BoardDAO();
			pageElements=5;
			rowsCount = dao.getAidNumber();
			lastPage = (int)Math.ceil((double)rowsCount/pageElements);
		} catch (SQLException e) {
			e.getStackTrace();
		}
	}
	public int getLastPage() {
		return lastPage;
	}
}
