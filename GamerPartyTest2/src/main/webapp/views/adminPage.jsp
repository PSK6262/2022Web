<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>관리자 콘솔 - 게이머 파티</title>
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
                    <li class="nav-item"><a class="nav-link" href="board.nhn?action=myInfoPage"><i class="bi bi-person-circle me-1"></i> 내 프로필</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container auth-wrapper">
        <div class="gp-card">
            <div class="gp-card-header text-center justify-content-center py-3 bg-dark text-white">
                <h4 class="mb-0 fw-bold"><i class="bi bi-shield-lock-fill me-2 text-danger"></i>관리자 제어 콘솔</h4>
            </div>
            <div class="gp-card-body p-4 p-md-5">
                <div class="alert alert-secondary small d-flex align-items-center mb-4">
                    <i class="bi bi-exclamation-triangle-fill fs-5 text-warning me-2"></i>
                    <div>관리자 권한(계정 레벨 2)을 보유한 계정으로만 작업이 수행됩니다.</div>
                </div>

                <form method="post" action="views/loginAdmin.jsp">
                    <div class="mb-3">
                        <label for="email" class="form-label">관리자 계정 아이디 (이메일)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-person-badge"></i></span>
                            <input maxlength="30" type="email" class="form-control" name="email" placeholder="admin@gamerparty.com" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label">관리자 비밀번호</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-key-fill"></i></span>
                            <input maxlength="20" type="password" class="form-control" name="password" placeholder="비밀번호" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">수행할 관리 작업 선택</label>
                        <div class="d-flex flex-column gap-2 p-3 bg-light rounded-3 border">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="type" id="workType1" value="1" checked>
                                <label class="form-check-label fw-bold text-danger" for="workType1">
                                    <i class="bi bi-trash-fill me-1"></i> [1] 불량 게시글 강제 삭제 (대상 번호: 게시글 번호 aid)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="type" id="workType2" value="2">
                                <label class="form-check-label fw-bold text-success" for="workType2">
                                    <i class="bi bi-person-badge-fill me-1"></i> [2] 관리자 권한 부여 (대상 번호: 유저 번호 aid)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="type" id="workType3" value="3">
                                <label class="form-check-label fw-bold text-warning" for="workType3">
                                    <i class="bi bi-slash-circle-fill me-1"></i> [3] 유저 계정 밴 처리 (대상 번호: 유저 번호 aid)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="type" id="workType4" value="4">
                                <label class="form-check-label fw-bold text-info" for="workType4">
                                    <i class="bi bi-arrow-counterclockwise me-1"></i> [4] 유저 계정 밴 해제 (대상 번호: 유저 번호 aid)
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="action_uid" class="form-label">대상 번호 (게시글 번호 또는 유저 번호)</label>
                        <input maxlength="10" type="number" class="form-control" name="action_uid" placeholder="숫자 번호 입력 (예: 1)" required>
                    </div>

                    <button type="submit" class="btn btn-gp-danger w-100 py-2 fs-6 mb-3">
                        <i class="bi bi-lightning-fill me-1"></i> 관리자 명령 실행
                    </button>

                    <div class="text-center">
                        <a href="board.nhn?action=listBoard&fpage=1" class="text-muted text-decoration-none small">
                            <i class="bi bi-arrow-left me-1"></i> 메인 피드로 돌아가기
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
