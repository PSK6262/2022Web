<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>회원가입 - 게이머 파티</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
    <!-- Global Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
        <div class="container">
            <a class="navbar-brand-logo" href="board.nhn?action=listBoard&fpage=1">
                <img src="assets/images/GamerParty.png" alt="GamerParty Logo">
                <span class="navbar-brand-title">GAMER PARTY</span>
            </a>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="board.nhn?action=listBoard&fpage=1"><i class="bi bi-house-door me-1"></i> 메인으로</a></li>
                    <li class="nav-item"><a class="nav-link" href="board.nhn?action=findAccount"><i class="bi bi-key me-1"></i> 계정찾기</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Auth Form Container -->
    <div class="container auth-wrapper">
        <div class="gp-card">
            <div class="gp-card-header text-center justify-content-center py-3">
                <h4 class="mb-0 fw-bold"><i class="bi bi-person-plus-fill me-2 text-primary"></i>게이머 파티 회원가입</h4>
            </div>
            <div class="gp-card-body p-4 p-md-5">
                <p class="text-muted text-center mb-4 small">아이디와 선호 게임 정보를 입력하고 바로 파티에 합류하세요!</p>
                <form class="needs-validation" action="views/createAccountAction.jsp" method="post">
                    <div class="row g-3">
                        <div class="col-12">
                            <label for="email" class="form-label">아이디 (이메일 주소) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted"><i class="bi bi-envelope"></i></span>
                                <input maxlength="30" type="email" class="form-control" name="email" placeholder="gamer@example.com" required>
                            </div>
                            <div class="form-text">로그인 및 비밀번호 찾기 시 수신받을 이메일을 입력하세요.</div>
                        </div>

                        <div class="col-12">
                            <label for="password" class="form-label">비밀번호 <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted"><i class="bi bi-lock"></i></span>
                                <input maxlength="20" type="password" class="form-control" name="password" placeholder="최대 20자" required>
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="nickname" class="form-label">닉네임 <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted"><i class="bi bi-tag"></i></span>
                                <input maxlength="20" type="text" class="form-control" name="nickname" placeholder="커뮤니티에서 활동할 닉네임" required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label for="prefergame" class="form-label">선호하는 게임 <span class="text-muted">(선택)</span></label>
                            <input maxlength="20" type="text" class="form-control" name="prefergame" placeholder="예: 롤, 옵치, 발로란트">
                        </div>

                        <div class="col-md-6">
                            <label for="preferrole" class="form-label">주 포지션 / 역할 <span class="text-muted">(선택)</span></label>
                            <input maxlength="10" type="text" class="form-control" name="preferrole" placeholder="예: 미드, 힐러, 타격대">
                        </div>
                    </div>

                    <hr class="my-4">

                    <button type="submit" class="btn btn-gp-primary w-100 py-2 fs-6 mb-3">
                        <i class="bi bi-check-circle me-1"></i> 회원가입 완료
                    </button>
                    
                    <div class="text-center">
                        <a href="board.nhn?action=listBoard&fpage=1" class="text-muted text-decoration-none small">
                            <i class="bi bi-arrow-left me-1"></i> 로그인 및 메인 피드로 돌아가기
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Global Footer -->
    <footer class="gp-footer">
        <div class="container text-center">
            <p class="mb-1 text-muted small">Copyright &copy; 2026 Gamer Party. All rights reserved.</p>
            <p class="mb-0 text-muted small">개발자: 안동대학교 박성국 &middot; Contact: <a href="mailto:qkrxotn60@naver.com">qkrxotn60@naver.com</a></p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
