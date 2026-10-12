<!DOCTYPE html>
<html lang="kr">
    <head>
 		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 		<% request.setCharacterEncoding("utf-8"); %>
 		<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core"%>
		<%@ page import="gamerParty.BoardDAO" %>
		<%@ page import="java.io.PrintWriter" %>
		
		<jsp:useBean id="user" class="gamerParty.Account" scope="page"/> 
		
		<jsp:setProperty name="user" property="email"/>
		<jsp:setProperty name="user" property="password"/>
		<jsp:setProperty name="user" property="nickname"/>
		<jsp:setProperty name="user" property="prefergame"/>
		<jsp:setProperty name="user" property="preferrole"/> <!--form에서 받아온것-->
        
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
			String email=null;
			if(session.getAttribute("email")!=null){
				email=(String)session.getAttribute("email");
			}
			if(email!=null){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인 되어있습니다.')");
				script.println("location.href='../board.nhn?action=listBoard&fpage=1'");
				script.println("</script>");	
			}
			
			if(user.getEmail()==null || user.getPassword()==null || user.getNickname()==null){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('필수 정보를 모두 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				BoardDAO dao = new BoardDAO();
				int result = dao.addAccount(user);
				if(result==1){
					session.setAttribute("email", user.getEmail());
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('회원가입이 완료되었습니다.');");
					script.println("location.href='../board.nhn?action=listBoard&fpage=1'");
					script.println("</script>");
				}
				else if(result==-2){
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류가 발생했습니다,\n 또는 이미 등록된 이메일이 존재합니다.')");
					script.println("history.back()"); // 이전 상황으로 되돌리기
					script.println("</script>");		
				}
			}
		%>
    </body>
</html>
