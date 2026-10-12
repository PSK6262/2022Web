<!DOCTYPE html>
<html lang="kr">
    <head>
 		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 		<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core"%>
		<%@ page import="gamerParty.BoardDAO" %>
		<%@ page import="java.io.PrintWriter" %>
 		<%@ page import="gamerParty.mail" %>
 		<jsp:useBean id="user" class="gamerParty.Account" scope="page" />
		
		<jsp:setProperty name="user" property="email" />
	</head>
    <body>
		<% 
			request.setCharacterEncoding("utf-8");
	    	BoardDAO dao = new BoardDAO();
			String pw = dao.getPassword(user.getEmail());
			if(pw == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이메일이 존재하지 않거나 오류가 발생했습니다.')");
				script.println("location.href='../board.nhn?action=findAccount'");
				script.println("</script>");		
			}
			else {
				mail m = new mail(user.getEmail(),"게이머 파티 비밀번호 찾기","비밀 번호는 "+pw+" 입니다.");	
				
				if(m.sendMail() == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('해당 이메일로 비밀번호가 송신되었습니다.')");
					script.println("location.href='../board.nhn?action=listBoard&fpage=1'");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('해당 이메일로 송신하는 데 실패했습니다. 다시 시도해 주세요.')");
					script.println("location.href='../board.nhn?action=findAccount'");
					script.println("</script>");	
				}
			}
		%>
	</body>
</html>