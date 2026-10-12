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
		<jsp:setProperty name="user" property="nickname" />
		<jsp:setProperty name="user" property="prefergame" />
		<jsp:setProperty name="user" property="preferrole" />
    </head>
    <body>
	<%
		session.invalidate();
	%>
	<script>
		alert('로그아웃 되었습니다.');
		location.href = "../board.nhn?action=listBoard&fpage=1";
	</script>
    </body>	
</html>
