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
        <link href="http://somewebsite.com/css/bootstrap.css" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    </head>
    <body>
    	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
				<img class="logo" src="GamerParty.png" alt="logo" onclick="javascript:location.href='board.nhn?action=listBoard&fpage=1';">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="board.nhn?action=listBoard&fpage=1">메인</a></li>
                        <li class="nav-item"><a class="nav-link" href="board.nhn?action=myInfoPage">개인정보</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container" style="padding-left: 500px;">
            <div class="row">
                <div class="col-lg-6">
	            	<div class="card mb-2 mt-3">
	                	<div class="card-header text-center fs-5 bg-secondary text-white" style="margin=0;">비밀번호 찾기</div>
	            	    	<div class="card-body">
	                            <div class="input-group">
									<form method="post" action="findAccountAction.jsp" style="width:100%">
									<div class="col-12 text-center" style="margin=0;">
										<label for="email" class="form-label">아이디(이메일)</label><br>
					        			<input maxlength="30" type="email" class="form-control" name="email" required>
					        			<br><br>
					        			<input type="submit" class="w-100 btn btn-primary btn-lg" value="메일 보내기"><br><br>
					        		</div><br>
					        	</div>
							</div>
						</form>
	                 </div>
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
