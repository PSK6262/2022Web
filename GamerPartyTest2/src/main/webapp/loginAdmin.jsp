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
		<jsp:setProperty name="user" property="type" />
		<jsp:setProperty name="user" property="action_uid" />
		
    </head>
    <body>
	<%  //세션상태 체크
		request.setCharacterEncoding("utf-8");

		BoardDAO dao = new BoardDAO();
		int result = dao.login(user.getEmail(), user.getPassword());
		int work_result;
		
		if(result == 2) {
			PrintWriter script = response.getWriter();
			work_result = dao.adminWork(user.getType(),user.getAction_uid());
			if(work_result == 1){
				script.println("<script>");
				script.println("alert('정상적으로 처리되었습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				script.println("<script>");
				script.println("alert('오류가 발생하여 실행하지 못했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
		else if(result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB오류')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자 로그인에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
    </body>	
</html>
