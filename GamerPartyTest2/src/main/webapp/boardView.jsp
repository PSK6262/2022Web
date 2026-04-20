<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<meta name="description" content="" />
<meta name="author" content="" />
<link href="http://somewebsite.com/css/bootstrap.css" rel="stylesheet">
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link href="css/styles.css" rel="stylesheet" />
<title>${board.title} - 같이 게임할땐? 게이머 파티!</title>
</head>
   <body>
   <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
			 <img class="logo" src="GamerParty.png" alt="logo" onclick="javascript:location.href='board.nhn?action=listBoard&fpage=1&fpage=1';">
             <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
             <div class="collapse navbar-collapse" id="navbarSupportedContent">
                 <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="board.nhn?action=listBoard&fpage=1">메인</a></li>
                    <li class="nav-item"><a class="nav-link" href="board.nhn?action=myInfoPage">개인 정보</a></li>
                 </ul>
             </div>
        </div>
   </nav>
   <div class="container w-75 mt-5 mx-auto">
    <h1>${board.title}</h1>
    <p>글쓴이 : ${board.username}</p>
    <p>작성일 : ${board.date}</p>
    <hr>
    <div class="container text-center h-20">
    	<img class="card-img-top img-fluid" src="${board.img}" onerror="this.style.display='none'">
	</div>
    <div class="card w-80 mx-auto">
	    <div class="card-body">
	    	<p class="card-text">${board.content}</p>
	    </div>
    </div>
    <hr>
    <a href="javascript:history.back()" class="btn btn-primary"> << Back </a>
    </div>
    </body>
</html>