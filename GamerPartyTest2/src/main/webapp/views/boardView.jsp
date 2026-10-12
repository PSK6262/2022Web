<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${board.title} - 게이머 파티</title>
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
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="board.nhn?action=listBoard&fpage=1"><i class="bi bi-house-door-fill me-1"></i> 메인 피드</a></li>
                    <li class="nav-item"><a class="nav-link" href="board.nhn?action=myInfoPage"><i class="bi bi-person-circle me-1"></i> 내 프로필</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="gp-card">
                    <!-- Post Header -->
                    <div class="gp-card-header flex-column align-items-start py-4">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <span class="gp-tag gp-tag-recruit"><i class="bi bi-tag-fill me-1"></i>게시글 #${board.aid}</span>
                        </div>
                        <h2 class="fw-bold mb-3 text-white">${board.title}</h2>
                        <div class="d-flex align-items-center gap-3 text-secondary small">
                            <span><i class="bi bi-person-fill me-1"></i>${board.username}</span>
                            <span>&bull;</span>
                            <span><i class="bi bi-clock me-1"></i>${board.date}</span>
                        </div>
                    </div>

                    <!-- Post Body -->
                    <div class="gp-card-body p-4 p-md-5">
                        <c:if test="${not empty board.img && board.img != '/img/'}">
                        <div class="text-center mb-4 p-2 bg-light rounded-3 border">
                            <img class="img-fluid rounded-3 shadow-sm" src="${board.img}" alt="Attached image" onerror="this.parentElement.style.display='none'">
                        </div>
                        </c:if>

                        <div class="p-3 bg-light rounded-3 border" style="min-height: 180px; font-size: 1.05rem; line-height: 1.7; white-space: pre-wrap;">
<c:out value="${board.content}"/>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-between align-items-center mt-5 pt-3 border-top">
                            <a href="board.nhn?action=listBoard&fpage=1" class="btn btn-gp-secondary">
                                <i class="bi bi-arrow-left me-1"></i> 목록으로 돌아가기
                            </a>
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-outline-primary" onclick="alert('게시글 링크가 복사되었습니다!');">
                                    <i class="bi bi-share me-1"></i> 공유
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
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