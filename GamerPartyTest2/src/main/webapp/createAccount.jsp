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
    </head>
    <body>
    	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
				<img class="logo" src="GamerParty.png" alt="logo" onclick="javascript:location.href='board.nhn?action=listBoard&fpage=1';">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="board.nhn?action=findAccount">계정찾기</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <header class="py-5 bg-light border-bottom mb-4"  style="background-image:URL(banner_resize.jpg); background-position:center top">
            <div class="container">
            	<a href="board.nhn?action=listBoard&fpage=1" style="text-decoration:none; color:black;">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">같이 게임할땐? 게이머 파티!</h1>
	                <p class="lead mb-0 fw-bolder">홈페이지로 이동하기</p>
                </div>
                </a>
            </div>
        </header>
       <div class="container">
            <div class="row">
                    <div class="card mb-4">
	                	<div class="card-header text-center fs-5 fw-bolder" style="margin=0;">회원가입 정보입력</div>
	                    	<div class="card-body">
	                            <div class="input-group">
	        						<form class="needs-validation" action="createAccountAction.jsp" method="post">
	          							<div class="row g-3">
	            							<div class="col-12">
								            	<label for="email" class="form-label">이메일(아이디)<span class="text-muted"> (최대 30자)</span></label>
								                <input maxlength="30" type="email" class="form-control" name="email" placeholder="anu@example.com">
								            </div>
								            <div class="col-12">
								                <label for="password" class="form-label">비밀번호<span class="text-muted"> (최대 20자)</span></label>
								                <input maxlength="20" type="password" class="form-control" name="password" placeholder="****" required>
								            </div>
								            <div class="col-12">
								                <label for="nickname" class="form-label">닉네임<span class="text-muted"> (최대 20자)</span></label>
								                <input maxlength="20" type="text" class="form-control" name="nickname" placeholder="닉네임">
								            </div>
								            <div class="col-md-6">
								                <label for="prefergame" class="form-label">선호하는 게임<span class="text-muted"> (풀 네임 입력, 선택사항)</span></label>
											    <input maxlength="20" type="text" class="form-control" name="prefergame" placeholder="오버워치, 스타크래프트, 등..">
								            </div>
								            <div class="col-md-6">
								                <label for="preferrole" class="form-label">선호하는 포지션<span class="text-muted"> (선택사항)</span></label>
								                <input maxlength="10" type="text" class="form-control" name="preferrole" placeholder="역할, 직업, 종족 등..">
								            </div>
								        </div>
	          							<hr class="my-4">
	          							<input type="submit" class="w-100 btn btn-primary btn-lg mb-5" value="회원가입">
	        						</form>
	      						</div>
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
