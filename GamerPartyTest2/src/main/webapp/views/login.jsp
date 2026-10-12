<!DOCTYPE html>
<html lang="kr">
    <head>
 		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 		<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core"%>
		<%@ page import="gamerParty.BoardDAO" %>
		<%@ page import="java.io.PrintWriter" %>
		
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>게이머 파티 - 같이 게임할땐? 게이머 파티!</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="css/styles.css" rel="stylesheet" />
        
        <jsp:useBean id="user" class="gamerParty.Account" scope="page" />
		
		<jsp:setProperty name="user" property="email" />
		<jsp:setProperty name="user" property="password" />
    </head>
    <body>
	<%  //세션상태 체크
		request.setCharacterEncoding("utf-8");
		String email = null;
		if(session.getAttribute("email") != null){
			email = (String)session.getAttribute("email");
		}
		//이미 로그인 했는지 체크
		if(email != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다.')");
			script.println("location.href='../board.nhn?action=listBoard&fpage=1'");
			script.println("</script>");
		}
		BoardDAO dao = new BoardDAO();
		int result = dao.login(user.getEmail(), user.getPassword());
		if (result == 2) {
			session.setAttribute("email", user.getEmail());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='../board.nhn?action=listBoard&fpage=1'");
			script.println("</script>");	
		}
		else if(result == 1){
			session.setAttribute("email", user.getEmail());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='../board.nhn?action=listBoard&fpage=1'");
			script.println("</script>");
		}else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류')");
			script.println("history.back()");
			script.println("</script>");
		}else if(result == -3){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('해당 계정은 정지 상태입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
    </body>	
</html>
