<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="gamerParty.BoardDAO" %>
<%@ page import="gamerParty.Account" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>내 프로필 관리 - 게이머 파티</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
<%
    String sessionEmail = null;
    String nickname = null;
    String prefergame = null;
    String preferrole = null;
    String icon = null;
    BoardDAO dao = new BoardDAO();
    Account acc;
    
    if (session.getAttribute("email") != null) {
        sessionEmail = (String) session.getAttribute("email");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인이 필요한 서비스입니다.');");
        script.println("location.href='board.nhn?action=listBoard&fpage=1';");
        script.println("</script>");
        return;
    }
    
    if (sessionEmail != null) {
        acc = dao.listInfo(sessionEmail);
        if (acc != null) {
            nickname = acc.getNickname();
            preferrole = acc.getPreferrole();
            prefergame = acc.getPrefergame();
            icon = acc.getIcon();
        }
    }
    
    String InfoError = (String) request.getAttribute("InfoError");
%>
    <!-- Global Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
        <div class="container">
            <a class="navbar-brand-logo" href="board.nhn?action=listBoard&fpage=1">
                <img src="assets/images/GamerParty.png" alt="GamerParty Logo">
                <span class="navbar-brand-title">GAMER PARTY</span>
            </a>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="board.nhn?action=listBoard&fpage=1"><i class="bi bi-house-door me-1"></i> 메인 피드</a></li>
                    <li class="nav-item"><a class="nav-link" href="board.nhn?action=Admin"><i class="bi bi-shield-lock me-1"></i> 관리자 설정</a></li>
                    <li class="nav-item"><a class="nav-link text-danger" href="views/logout.jsp"><i class="bi bi-box-arrow-right me-1"></i> 로그아웃</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container auth-wrapper">
        <div class="gp-card">
            <div class="gp-card-header text-center justify-content-center py-3">
                <h4 class="mb-0 fw-bold"><i class="bi bi-person-gear me-2 text-info"></i>내 프로필 정보 수정</h4>
            </div>
            <div class="gp-card-body p-4 p-md-5">
                <form method="post" action="board.nhn?action=myInfoChange" enctype="multipart/form-data">
                    <!-- Profile Avatar Upload Section -->
                    <div class="text-center mb-4">
                        <div class="profile-avatar-wrap">
                            <% if (icon == null || icon.equals("/img/") || icon.equals("없음") || icon.trim().isEmpty()) { %>
                            <img src="assets/images/testicon.png" alt="profile" class="profile-avatar-img">
                            <% } else { %>
                            <img src="<%= icon %>" alt="profile" class="profile-avatar-img" onerror="this.src='assets/images/testicon.png'">
                            <% } %>
                        </div>
                        <div class="w-75 mx-auto">
                            <label class="form-label small text-muted">새 프로필 사진 업로드</label>
                            <input type="file" name="icon" class="form-control form-control-sm" accept="image/*">
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label">이메일 계정</label>
                            <input type="text" class="form-control bg-light" name="myemail" value="<%= sessionEmail %>" readonly>
                        </div>

                        <div class="col-12">
                            <label class="form-label">닉네임 <span class="text-muted">(최소 4자, 변경 시 입력)</span></label>
                            <input maxlength="20" type="text" class="form-control" name="nickname" value="<%= nickname != null ? nickname : "" %>" placeholder="새 닉네임 입력">
                        </div>

                        <div class="col-12">
                            <label class="form-label">새 비밀번호 <span class="text-muted">(최소 6자, 변경 시 입력)</span></label>
                            <input maxlength="20" type="password" class="form-control" name="password" placeholder="변경할 경우에만 입력하세요">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">선호하는 게임</label>
                            <input maxlength="20" type="text" class="form-control" name="prefergame" value="<%= prefergame != null && !prefergame.equals("없음") ? prefergame : "" %>" placeholder="예: 리그 오브 레전드">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">주 포지션 / 역할</label>
                            <input maxlength="10" type="text" class="form-control" name="preferrole" value="<%= preferrole != null && !preferrole.equals("없음") ? preferrole : "" %>" placeholder="예: 미드, 서포터">
                        </div>
                    </div>

                    <% if (InfoError != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show mt-3">
                        <i class="bi bi-exclamation-circle me-1"></i><%= InfoError %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <hr class="my-4">

                    <div class="d-flex gap-2">
                        <a href="board.nhn?action=listBoard&fpage=1" class="btn btn-gp-secondary flex-grow-1">취소</a>
                        <button type="submit" class="btn btn-gp-primary flex-grow-1">
                            <i class="bi bi-check-lg me-1"></i> 변경사항 저장
                        </button>
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