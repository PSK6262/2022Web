<!DOCTYPE html>
<html lang="kr">
    <head>
 		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 		<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core"%>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <%@ page import="gamerParty.BoardDAO" %>
        <%@ page import="gamerParty.BoardController" %>
        <%@ page import="gamerParty.Account" %>
		<%@ page import="java.io.PrintWriter" %>
        
        <title>게이머 파티 - 같이 게임할땐? 게이머 파티!</title>
        <link href="http://somewebsite.com/css/bootstrap.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    </head>
    <body>
        <%
    		String sessionEmail = null;
			String nickname = null;
        	String prefergame = null;
			String preferrole = null;
			String icon = null;
			String email = null;
			BoardDAO dao = new BoardDAO();	
    		Account acc;	
    		
    		if(session.getAttribute("email") != null){
    			sessionEmail = (String)session.getAttribute("email");
    		}
    		else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인이 되어있지 않습니다.')");
				script.println("location.href='/board.nhn?action=listBoard&fpage=1'");
				script.println("</script>");
			}
    		
    		if(sessionEmail != null){
				acc = dao.listInfo(sessionEmail);
    			nickname = acc.getNickname();
    			preferrole = acc.getPreferrole();
    			prefergame = acc.getPrefergame();
    			icon = acc.getIcon();
			}		
    		
    		String InfoError = (String)request.getAttribute("InfoError");
		%>
    	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
				<img class="logo" src="GamerParty.png" alt="logo" onclick="javascript:location.href='board.nhn?action=listBoard&fpage=1';">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="board.nhn?action=listBoard&fpage=1">메인</a></li>
                        <li class="nav-item"><a class="nav-link" href="board.nhn?action=">관리자 설정</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
	            	<div class="card mb-4 mt-3">
	                    <div class="card-header text-center fs-5 bg-secondary text-white" style="margin=0;">개인정보</div>
	                    <div class="card-body">
	                       	<div class="input-group">
	                            <div class="container mt-2">               	
		                            <form method="post" action="board.nhn?action=myInfoChange" enctype="multipart/form-data">
		          						<div class="row g-3">
									    	<div class="col-12 text-center">
									    		<div class="container w-50 text-center">
					                              	<%if(icon==null){ %>
					                              	<img src="testicon.png" alt="profile" class="img-thumbnail" style="width : 200px; height: 200px;">
					                               	<%} else {%>
					                               	<img src="<%=icon%>" alt="profile" class="img-thumbnail" style="width : 200px; height: 200px;">
					                               	<%} %>
					                               	<div class="input-group mb-3">
				  										<input type="file" name="icon" class="form-control">
													</div>
					                            </div>
									            <label for="myemail" class="form-label">이메일<span class="text-muted"></span></label>
									  			<input maxlength="30" type="text" class="form-control" style="border:none" name="myemail" placeholder="<%=sessionEmail%>" readonly><br>
									  			
									  			<label for="nickname" class="form-label">닉네임<span class="text-muted"> (최소 4자, 최대 20자)</span></label>
									            <input maxlength="20" type="text" class="form-control" name="nickname"><br>

									            <hr class="my-4">
									            <label for="password" class="form-label">비밀번호<span class="text-muted"> (최소 6자, 최대 20자)</span></label>
									            <input maxlength="20" type="password" class="form-control" name="password"><br>
									            <hr class="my-4">
									            <label for="prefergame" class="form-label">선호하는 게임<span class="text-muted"> (최대 20자 , 선택사항)</span></label>
									            <input maxlength="20" type="text" class="form-control" name="prefergame"><br>
									            <hr class="my-4">
									            <label for="preferrole" class="form-label">선호하는 포지션<span class="text-muted"> (최대 10자 , 선택사항)</span></label>
									            <input maxlength="10" type="text" class="form-control" name="preferrole"><br>
									            <%if(InfoError != null) {%>
													<div class="alert alert-danger alert-dismissible fade show mt-3">
														<%=InfoError%>		
														<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
													</div>
												<%} %>
												<input type="submit" class="btn btn-primary" value="변경"></button>
									        </div>
									    </div>
		          					</form>
								</div>
							</div>
	                        <br>
						</div>
					</div>
				</div>
			</div>
		</div>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Gamer Party 2022</p></div>
            <div class="container"><p class="m-0 text-center text-white">Contact : zps1412@naver.com </p></div>
            <div class="container"><p class="m-0 text-center text-white">안동대학교 박성국 , 서인교</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>