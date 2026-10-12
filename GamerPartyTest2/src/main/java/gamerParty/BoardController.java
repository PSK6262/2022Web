package gamerParty;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.beanutils.BeanUtils;




@WebServlet("/board.nhn")
@MultipartConfig(maxFileSize=1024*1024*2, location="c:/Temp/img")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private BoardDAO dao;
	private ServletContext ctx;
	
	// 웹 리소스 기본 경로 지정
	private final String START_PAGE = "index.jsp";
	
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		new java.io.File("c:/Temp/img").mkdirs();
		dao = new BoardDAO();
		ctx = getServletContext();		
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		dao = new BoardDAO();
		
		// 자바 리플렉션을 사용해 if, switch 없이 요청에 따라 구현 메서드가 실행되도록 함.
		Method m;
		String view = null;
		
		// action 파라미터 없이 접근한 경우
		if (action == null) {
			action = "listBoard";
		}
		
		try {
			// 현재 클래스에서 action 이름과 HttpServletRequest 를 파라미터로 하는 메서드 찾음
				m = this.getClass().getMethod(action, HttpServletRequest.class);
				view = (String)m.invoke(this, request);
			// 메서드 실행후 리턴값 받아옴
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
			// 에러 로그를 남기고 view 를 로그인 화면으로 지정, 앞에서와 같이 redirection 사용도 가능.
			ctx.log("요청 action 없음!!");
			request.setAttribute("error", "action 파라미터가 잘못 되었습니다!!");
			view = START_PAGE;
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		// POST 요청 처리후에는 리디렉션 방법으로 이동 할 수 있어야 함.
		if(view.startsWith("redirect:/")) {
			// redirect/ 문자열 이후 경로만 가지고 옴
			String rview = view.substring("redirect:/".length());
			response.sendRedirect(rview);
		} else {
			// 지정된 뷰로 포워딩, 포워딩시 컨텍스트경로는 필요없음.
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);	
		}
	}
    
    public String addBoard(HttpServletRequest request) {
		Board n = new Board();
		try {						
			// 이미지 파일 저장
	        Part part = request.getPart("file");
	        String fileName = getFilename(part);
	        if(fileName != null && !fileName.isEmpty()){
	            part.write(fileName);
	        }	        
	        // 입력값을 News 객체로 매핑
	        System.out.println(request.getParameter("type"));
	        
			BeanUtils.populate(n, request.getParameterMap());
			
	        // 이미지 파일 이름을 News 객체에도 저장
	        n.setImg("/img/"+fileName);

			dao.addBoard(n);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("뉴스 추가 과정에서 문제 발생!!");
			request.setAttribute("error", "글이 정상적으로 등록되지 않았습니다!!");
			return listBoard(request);
		}
		
		return "redirect:/board.nhn?action=listBoard&fpage=1";
		
	}

	public String deleteBoard(HttpServletRequest request) {
    	int aid = Integer.parseInt(request.getParameter("aid"));
		try {
			dao.delBoard(aid);
		} catch (SQLException e) {
			e.printStackTrace();
			ctx.log("뉴스 삭제 과정에서 문제 발생!!");
			request.setAttribute("error", "글이 정상적으로 삭제되지 않았습니다!!");
			return listBoard(request);
		}
		return "redirect:/board.nhn?action=listBoard&fpage=1";
	}

	public String listBoard(HttpServletRequest request) {
    	List<Board> list;
        
    	BoardDAO dao = new BoardDAO();
        int pageElements=5;   // 페이지당 글 개수를 바꾸고싶으면 이거 고치기

		try {
	    	String fpage = request.getParameter("fpage");
	    	if(fpage==null){
	    		fpage = "1";
	    	}
	    	
	    	int page_f = Integer.parseInt(fpage);
	    	int startPage = (page_f-1)*pageElements; //
			
			list = dao.getAll(startPage,pageElements); // startPage부터 lastPage만큼만 가져옴

	    	request.setAttribute("boardlist", list);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("뉴스 목록 생성 과정에서 문제 발생!!");
			request.setAttribute("error", "글 목록이 정상적으로 처리되지 않았습니다!!");
		}
    	return "views/boardList.jsp";
    }
    
    public String getBoard(HttpServletRequest request) {
        int aid = Integer.parseInt(request.getParameter("aid"));
        try {
			Board n = dao.getBoard(aid);
			request.setAttribute("board", n);
		} catch (SQLException e) {
			e.printStackTrace();
			ctx.log("뉴스를 가져오는 과정에서 문제 발생!!");
			request.setAttribute("error", "글을 정상적으로 가져오지 못했습니다!!");
		}
    	return "views/boardView.jsp";
    }
        
    // multipart 헤더에서 파일이름 추출
	private String getFilename(Part part) {
        String fileName = null;   
        // 파일이름이 들어있는 헤더 영역을 가지고 옴
        String header = part.getHeader("content-disposition");
        //part.getHeader -> form-data; name="img"; filename="사진5.jpg"
        
        // 파일 이름이 들어있는 속성 부분의 시작위치를 가져와 쌍따옴표 사이의 값 부분만 가지고옴
        int start = header.indexOf("filename=");
        fileName = header.substring(start+10,header.length()-1);        
        return fileName; 
	}
	public String AccountPage(HttpServletRequest request) {
		return "views/createAccount.jsp";
	}
	public String addAccount(HttpServletRequest request) throws Exception{
		request.setCharacterEncoding("utf-8");
		Account n = new Account();
		try {						
			dao.addAccount(n);
		} catch (Exception e) {
			e.printStackTrace();
			ctx.log("계정 생성 과정에서 문제 발생!!");
			request.setAttribute("error", "계정 생성이 정상적으로 등록되지 않았습니다!!");
		}
		return "redirect:/board.nhn?action=listBoard&fpage=1";
	}
	public String myInfoPage(HttpServletRequest request) {
		return "views/InfoPage.jsp";
	}
	public String Admin(HttpServletRequest request) {
		return "views/adminPage.jsp";
	}
	public String myInfoChange(HttpServletRequest request) {
		Account acc = new Account();
		HttpSession session = request.getSession();
		try {				
	        Part part = request.getPart("icon");
	        String email = (String)session.getAttribute("email");
	        String nickname = request.getParameter("nickname");
	        String password = request.getParameter("password");
	        String prefergame = request.getParameter("prefergame");
	        String preferrole = request.getParameter("preferrole");
	        String fileName = getFilename(part);
	        
	        if(fileName != null && !fileName.isEmpty()){
	            part.write(fileName);
	        }	    
	        acc.setEmail(email);
	        acc.setNickname(nickname);
	        acc.setIcon("/img/"+fileName);
	        acc.setPassword(password);
	        acc.setPrefergame(prefergame);
	        acc.setPreferrole(preferrole);
	        
	        dao.changeInfo(acc);

		} catch (Exception e) {
			e.printStackTrace();
		}
        return "redirect:/board.nhn?action=listBoard&fpage=1";
	}
	public String findAccount(HttpServletRequest request) {
		return "views/findAccount.jsp";
	}
}