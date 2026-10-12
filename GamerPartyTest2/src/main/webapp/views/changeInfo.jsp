<!DOCTYPE html>
<html lang="kr">
    <head>
 		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 		<% request.setCharacterEncoding("utf-8"); %>
 		<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core"%>
		<%@ page import="gamerParty.BoardDAO" %>
		<%@ page import="gamerParty.Account" %>
		<%@ page import="gamerParty.BoardController" %>
		<%@ page import="java.io.PrintWriter" %>
		
		<jsp:useBean id="user" class="gamerParty.Account" scope="page"/> 
		
		<jsp:setProperty name="user" property="email"/>
		<jsp:setProperty name="user" property="nickname"/>
		<jsp:setProperty name="user" property="prefergame"/>
		<jsp:setProperty name="user" property="preferrole"/> <!--form에서 받아온것-->
		<jsp:setProperty name="user" property="icon"/>
        <jsp:setProperty name="user" property="password"/>
        
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>게이머 파티 - 같이 게임할땐? 게이머 파티!</title>
        <link href="http://somewebsite.com/css/bootstrap.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
		<%
			BoardDAO dao = new BoardDAO();	
			Account acc = new Account();
			String emailSession=null;
	
			if(session.getAttribute("email") != null){
				emailSession = (String)session.getAttribute("email");
			}
			else {
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('로그인이 되어있지 않습니다.')");
				script.println("location.href='../board.nhn?action=listBoard&fpage=1'");
				script.println("</script>");	
			}
			
			String email = (String)request.getAttribute("email");
			String password = (String)request.getAttribute("password");
			String nickname = (String)request.getAttribute("nickname");
			String prefergame = (String)request.getAttribute("prefergame");
			String preferrole = (String)request.getAttribute("preferrole");
			String file = (String)request.getAttribute("file");
			
			acc.setEmail(email);
			acc.setPassword(password);
			acc.setNickname(nickname);
			acc.setPrefergame(prefergame);
			acc.setPreferrole(preferrole);
			acc.setIcon(file);
			
			int process = dao.changeInfo(acc);
			
			if(process == 1){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('변경되었습니다.')");
				script.println("location.href='../board.nhn?action=myInfoPage'");
				script.println("</script>");
			}
			else if(process == -2){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('변경되었습니다.')");
				script.println("location.href='../board.nhn?action=myInfoPage'");
				script.println("</script>");
			}
			else {
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('오류가 발생하여 처리되지 못했습니다.')");
				script.println("location.href='../board.nhn?action=myInfoPage'");
				script.println("</script>");
			}
		%>
    </body>
</html>
