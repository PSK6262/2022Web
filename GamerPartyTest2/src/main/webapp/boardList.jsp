<!DOCTYPE html>
<html lang="kr">
    <head>
 		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 		<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core"%>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>게이머 파티 - 같이 게임할땐? 게이머 파티!</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="css/styles.css" rel="stylesheet" />
        <%@ page import="gamerParty.BoardDAO" %>
        <%@ page import="gamerParty.BoardController" %>
        <%@ page import="gamerParty.Paging" %>
        <%@ page import="gamerParty.Account" %>
        <jsp:useBean id="user" class="gamerParty.Account" scope="page" />
		<jsp:setProperty name="user" property="email" />
		<jsp:setProperty name="user" property="password" />
		<jsp:setProperty name="user" property="nickname" />
		<jsp:setProperty name="user" property="prefergame" />
		<jsp:setProperty name="user" property="preferrole" />
    </head>
    <body>
    	<%
    		String email = null;
			BoardDAO dao = new BoardDAO();	
    		Account acc;	
    		
    		if(session.getAttribute("email") != null){
    			email = (String)session.getAttribute("email");
    		}
			if(email != null){
				acc = dao.listInfo(email);
			}
			else {
				acc = new Account();	
			}
			String icon = acc.getIcon();
		%>
    	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
				<img class="logo" src="GamerParty.png" alt="logo" onclick="javascript:location.href='board.nhn?action=listBoard&fpage=1';">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <% if(email != null){ %>
                        <li class="nav-item"><a class="nav-link" href="board.nhn?action=myInfoPage">개인정보</a></li>
                    <%	}%>
                        <li class="nav-item"><a class="nav-link" href="board.nhn?action=Admin">관리자 설정</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <header class="py-5 bg-light border-bottom mb-4"  style="background-image:URL(banner_resize.jpg); background-position:center top">
            <div class="container">
                <a href="board.nhn?action=AccountPage" style="text-decoration:none; color:black;">
	                <div class="text-center my-5">
	                    <h1 class="fw-bolder">같이 게임할땐? 게이머 파티!</h1>
	                    <p class="lead mb-0 fw-bolder">회원가입 하러 가기</p>
	                </div>
                </a>
            </div>
        </header>
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <% if(email == null) {%>
                    <div class="card mb-4 mt-3">
	                	<div class="card-header text-center fs-5 bg-secondary text-white" style="margin=0;">개인정보</div>
	                    	<div class="card-body">
	                            <div class="input-group">
									<form method="post" action="login.jsp" style="width:100%">
									<div class="col-12 text-center" style="margin=0;">
										<label for="email" class="form-label">이메일(아이디) <span class="text-muted"></span></label>
					        			<input maxlength="30" type="email" class="form-control" name="email" placeholder="anu@example.com">
					        		</div><br>
					            	<div class="col-12 text-center" style="margin=0;"">
					            		<label for="password" class="form-label">비밀번호</label>
					            		<input maxlength="20" type="password" class="form-control input-sm" name="password" placeholder="****" required>
					        		</div>
					        	</div>
					            <hr class="my-4">
						        <input type="submit" class="w-100 btn btn-primary btn-lg" value="로그인"><br><br>
						        <input type="submit" class="w-100 btn btn-primary btn-lg" name="findAcc" value="비밀번호 찾기" onclick="location.href='board.nhn?action=findAccount'">
							</div>
	                    </div>
						</form>
					</div>
                    <%} else {%>
	                    <div class="card mb-4 mt-3">
	                        <div class="card-header text-center fs-5 bg-secondary text-white" style="margin=0;">개인정보</div>
	                        <div class="card-body">
	                            <div class="input-group">
	                                <div class="container w-50">
	                                	<%if(icon == "/img/" || icon == null){%>
	                                	<img src="testicon.png" alt="profile_basic" class="img-thumbnail" style="width : 99%; height: 99%;">
	                                	<%} else { %>
	                                	<img src=<%=icon%> alt="profile" class="img=thumbnail" style="width : 99%; height: 99%;">
	                                	<%} %>
	                                </div>
	                                <br>
	                                <div class="container mt-2">
		                                <ul class="list-group text-center list-group-flush">
		                                	<li class="list-group-item fs-4 fw-bold" style="border=none;"><%=acc.getNickname() %></li>
		                                	<li class="list-group-item" style="border=none;">이메일 : <%=acc.getEmail() %></li>
		                                	<li class="list-group-item" style="border=none;">선호하는 게임 : <%=acc.getPrefergame() %></li>
		                                	<li class="list-group-item" style="border=none;">선호하는 포지션 : <%=acc.getPreferrole() %></li>
		                                </ul>
	                                </div>
	                            </div>
	                            <br>
	                            <div class="container text-center">
	                            	<button class="btn btn-primary" id="button-search" type="button" style="margin:0;" onclick="location.href='logout.jsp'">로그아웃</button>
	                            </div>
	                        </div>
	                    </div>  
	                </div>                    
	                <%} %>
                <div class="col-lg-8">
                        <div class="card-body ">
                        	<div class="card-header text-center fs-4 bg-secondary text-white" style="margin=0;">게시판</div>
                        	<table class="table table-hover table-responsive">
					            <thead>
					                <tr>
					                    <th>번호</th>
					                   	<th>태그</th>
					                    <th>제목</th>
					                    <th>작성자</th>
					                    <th>작성일</th>
					                </tr>
					            </thead>
					            <tbody>
									<c:forEach var="board" items="${boardlist}" varStatus="status">
									<tr>
										<td class="col-md-1" onclick="location.href='board.nhn?action=getBoard&aid=${board.aid}';" style="cursor:pointer;"><c:out value="${board.aid}"/></td>
										<c:choose>
											<c:when test="${board.type == '1'}">
												<td class="col-md-1" onclick="location.href='board.nhn?action=getBoard&aid=${board.aid}';" style="cursor:pointer;"><c:out value="모집"/></td>
											</c:when>
											<c:otherwise>
												<td class="col-md-1" onclick="location.href='board.nhn?action=getBoard&aid=${board.aid}';" style="cursor:pointer;"><c:out value="자유"/></td>	
											</c:otherwise>
										</c:choose>
										<td class="col-md-3" onclick="location.href='board.nhn?action=getBoard&aid=${board.aid}';" style="cursor:pointer;"><c:out value="${board.title}"/></td>
										<td class="col-md-1" onclick="location.href='board.nhn?action=getBoard&aid=${board.aid}';" style="cursor:pointer;"><c:out value="${board.username}"/></td>
										<td class="col-md-1" onclick="location.href='board.nhn?action=getBoard&aid=${board.aid}';" style="cursor:pointer;"><c:out value="${board.date}"/></td>
									</tr>
									</c:forEach>
					            </tbody>
					        </table>
					        <c:if test="${error != null}">
							<div class="alert alert-danger alert-dismissible fade show mt-3">
								에러 발생: ${error}
							<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
							</div>
							</c:if>
						    <div class="container text-center">
					        <% if(session.getAttribute("email")!=null) {%>
						        <button class="btn btn-primary" style="margin:0;" type="button" data-bs-toggle="collapse" data-bs-target="#addForm" aria-expanded="false" aria-controls="addForm">글작성</button>
								<div class="collapse" id="addForm">
								  <div class="card card-body">
									<form method="post" action="/board.nhn?action=addBoard" enctype="multipart/form-data">
										<label class="form-label">닉네임</label>
										<input type="text" name="username" class="form-control" value="<%=acc.getNickname() %>" readonly>		
										<label class="form-label">제목</label>
										<input maxlength="30" type="text" name="title" class="form-control">
										<label class="form-label">이미지</label>
										<input type="file" name="file" class="form-control">
										<label class="form-label">태그</label>
										<br>	
										<input type="radio" class="btn-check" name="type" id="success-outlined" value='1' autocomplete="off" checked>
										<label class="btn btn-outline-success" for="success-outlined">모집</label>
										
										<input type="radio" class="btn-check" name="type" id="danger-outlined" value='2' autocomplete="off">
										<label class="btn btn-outline-secondary" for="danger-outlined">자유</label>
										<br>
										<br>
										<label class="form-label">글내용</label>
										<textarea cols="50" rows="5" name="content" class="form-control" maxlength="10"></textarea>
										<button type="submit" class="btn btn-success mt-3">저장</button>
									</form>
								  	</div>
								</div>
							<%} %>
							</div>

						</div>
						<% Paging p = new Paging(); 
							int recentPage = Integer.parseInt(request.getParameter("fpage"));
							int previousPage = recentPage-1;
							int nextPage = recentPage+1;
						%>
	                  	<nav aria-label="Pagination">
		                        <ul class="pagination justify-content-center my-4">
	                        <% for(int i=previousPage;i<=nextPage;i++) {
	                        	if(previousPage==0) {previousPage=1; continue;}
	                        	if(recentPage == i) {
	                        %>
	                            <li class="page-item active"><a class="page-link" href="board.nhn?action=listBoard&fpage=<%=i%>"><%=i%></a></li>
	                        <%	}
	                     		else {%>
		                            <li class="page-item"><a class="page-link" href="board.nhn?action=listBoard&fpage=<%=i%>"><%=i%></a></li>
	                     		<% }
	                        	if(nextPage==p.getLastPage()){nextPage--; continue;}
	                     	}
	                        %>
	                        </ul>
	                    </nav>
                  	</div> 
       		</div>
       	</div>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Gamer Party 2022</p></div>
            <div class="container"><p class="m-0 text-center text-white">Contact : qkrxotn60@naver.com </p></div>
            <div class="container"><p class="m-0 text-center text-white">안동대학교 박성국</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
