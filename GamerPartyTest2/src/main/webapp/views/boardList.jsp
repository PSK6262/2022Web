<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>게이머 파티 - 같이 게임할 땐? 게이머 파티!</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap Icons & Google Font Pretendard -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
<%
    String email = null;
    BoardDAO dao = new BoardDAO();
    Account acc;
    
    if (session.getAttribute("email") != null) {
        email = (String) session.getAttribute("email");
    }
    if (email != null) {
        acc = dao.listInfo(email);
        if (acc == null) {
            acc = new Account();
        }
    } else {
        acc = new Account();
    }
    String icon = acc.getIcon();
%>
    <!-- Global Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
        <div class="container">
            <a class="navbar-brand-logo" href="board.nhn?action=listBoard&fpage=1">
                <img src="assets/images/GamerParty.png" alt="GamerParty Logo">
                <span class="navbar-brand-title">GAMER PARTY</span>
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                    <li class="nav-item">
                        <a class="nav-link active" href="board.nhn?action=listBoard&fpage=1"><i class="bi bi-house-door-fill me-1"></i> 메인 피드</a>
                    </li>
                    <% if (email != null) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="board.nhn?action=myInfoPage"><i class="bi bi-person-circle me-1"></i> 내 프로필</a>
                    </li>
                    <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="board.nhn?action=AccountPage"><i class="bi bi-person-plus me-1"></i> 회원가입</a>
                    </li>
                    <% } %>
                    <li class="nav-item">
                        <a class="nav-link" href="board.nhn?action=Admin"><i class="bi bi-shield-lock me-1"></i> 관리자 설정</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Banner -->
    <header class="hero-banner">
        <div class="container hero-content">
            <span class="hero-badge"><i class="bi bi-controller"></i> 함께하면 200% 더 즐거운 협동 게이밍 커뮤니티</span>
            <h1 class="hero-title">같이 게임할 땐? 게이머 파티!</h1>
            <p class="hero-subtitle">롤 5인큐, 옵치 듀오, 스팀 코옵 파티원까지! 마음 맞는 듀오와 크루를 바로 찾아보세요.</p>
            <% if (email == null) { %>
            <a href="board.nhn?action=AccountPage" class="hero-btn">
                <i class="bi bi-lightning-charge-fill"></i> 3초만에 회원가입하고 파티 찾기
            </a>
            <% } else { %>
            <div class="d-inline-flex align-items-center gap-2 bg-dark bg-opacity-50 px-4 py-2 rounded-pill border border-secondary border-opacity-25">
                <i class="bi bi-emoji-smile text-info"></i>
                <span>환영합니다, <strong><%= acc.getNickname() != null ? acc.getNickname() : "게이머" %></strong>님! 함께할 파티를 찾아보세요.</span>
            </div>
            <% } %>
        </div>
    </header>

    <!-- Main Container -->
    <div class="container pb-5">
        <div class="row g-4">
            <!-- Left Sidebar (Login / User Profile) -->
            <div class="col-lg-4">
                <% if (email == null) { %>
                <!-- Login Card -->
                <div class="gp-card">
                    <div class="gp-card-header">
                        <span><i class="bi bi-box-arrow-in-right me-2 text-primary"></i>게이머 로그인</span>
                    </div>
                    <div class="gp-card-body">
                        <form method="post" action="views/login.jsp">
                            <div class="mb-3">
                                <label for="email" class="form-label">아이디 (이메일)</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-envelope"></i></span>
                                    <input maxlength="30" type="email" class="form-control border-start-0" name="email" placeholder="gamer@example.com" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <label for="password" class="form-label mb-0">비밀번호</label>
                                    <a href="board.nhn?action=findAccount" class="text-decoration-none small text-muted">비밀번호 찾기</a>
                                </div>
                                <div class="input-group mt-1">
                                    <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-key"></i></span>
                                    <input maxlength="20" type="password" class="form-control border-start-0" name="password" placeholder="비밀번호 입력" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-gp-primary w-100 mb-2 py-2">
                                <i class="bi bi-box-arrow-in-right me-1"></i> 로그인
                            </button>
                            <a href="board.nhn?action=AccountPage" class="btn btn-gp-secondary w-100 py-2">
                                <i class="bi bi-person-plus me-1"></i> 신규 회원가입
                            </a>
                        </form>
                    </div>
                </div>
                <% } else { %>
                <!-- Profile Card -->
                <div class="gp-card">
                    <div class="gp-card-header">
                        <span><i class="bi bi-person-vcard me-2 text-info"></i>내 프로필 정보</span>
                        <a href="board.nhn?action=myInfoPage" class="btn btn-sm btn-outline-light py-0 px-2" style="font-size:0.8rem;">수정</a>
                    </div>
                    <div class="gp-card-body text-center">
                        <div class="profile-avatar-wrap">
                            <% if (icon == null || icon.equals("/img/") || icon.equals("없음") || icon.trim().isEmpty()) { %>
                            <img src="assets/images/testicon.png" alt="profile" class="profile-avatar-img">
                            <% } else { %>
                            <img src="<%= icon %>" alt="profile" class="profile-avatar-img" onerror="this.src='assets/images/testicon.png'">
                            <% } %>
                        </div>
                        <h4 class="profile-name"><%= acc.getNickname() != null ? acc.getNickname() : "게이머" %></h4>
                        <p class="profile-email"><%= acc.getEmail() %></p>
                        
                        <div class="mt-3 text-start">
                            <div class="profile-meta-chip">
                                <span class="profile-meta-label"><i class="bi bi-controller me-1"></i>선호 게임</span>
                                <span class="profile-meta-value"><%= acc.getPrefergame() != null && !acc.getPrefergame().isEmpty() ? acc.getPrefergame() : "미설정" %></span>
                            </div>
                            <div class="profile-meta-chip">
                                <span class="profile-meta-label"><i class="bi bi-crosshair me-1"></i>주 포지션</span>
                                <span class="profile-meta-value"><%= acc.getPreferrole() != null && !acc.getPreferrole().isEmpty() ? acc.getPreferrole() : "미설정" %></span>
                            </div>
                        </div>

                        <div class="d-flex gap-2 mt-4">
                            <a href="board.nhn?action=myInfoPage" class="btn btn-gp-secondary flex-grow-1">
                                <i class="bi bi-gear me-1"></i> 계정 설정
                            </a>
                            <a href="views/logout.jsp" class="btn btn-gp-danger flex-grow-1">
                                <i class="bi bi-box-arrow-right me-1"></i> 로그아웃
                            </a>
                        </div>
                    </div>
                </div>
                <% } %>
                
                <!-- Quick Tips Card -->
                <div class="gp-card">
                    <div class="gp-card-header">
                        <span><i class="bi bi-info-circle me-2 text-warning"></i>파티 모집 팁</span>
                    </div>
                    <div class="gp-card-body small text-muted">
                        <ul class="list-unstyled mb-0 d-flex flex-column gap-2">
                            <li><i class="bi bi-check2-circle text-success me-1"></i> 글 제목에 <strong>[게임명]</strong>을 적으면 파티원을 더 빨리 만나요.</li>
                            <li><i class="bi bi-check2-circle text-success me-1"></i> 디스코드 음성 채팅 여부를 본문에 적어주세요.</li>
                            <li><i class="bi bi-check2-circle text-success me-1"></i> 비매너 및 트롤 행위 시 계정이 영구 제재될 수 있습니다.</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Right Main (Board List & Post Action) -->
            <div class="col-lg-8">
                <div class="gp-card">
                    <div class="gp-card-header">
                        <div class="d-flex align-items-center gap-2">
                            <i class="bi bi-chat-square-text-fill text-primary"></i>
                            <span>파티원 모집 & 커뮤니티</span>
                        </div>
                        <% if (session.getAttribute("email") != null) { %>
                        <button class="btn btn-sm btn-gp-primary" type="button" data-bs-toggle="collapse" data-bs-target="#addForm" aria-expanded="false" aria-controls="addForm">
                            <i class="bi bi-pencil-square me-1"></i> 새 글 쓰기
                        </button>
                        <% } %>
                    </div>
                    <div class="gp-card-body p-0">
                        <!-- Error Alert -->
                        <c:if test="${error != null}">
                        <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>오류 안내:</strong> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        </c:if>

                        <!-- Post Create Collapse Form -->
                        <% if (session.getAttribute("email") != null) { %>
                        <div class="collapse border-bottom bg-light p-4" id="addForm">
                            <div class="card border shadow-sm">
                                <div class="card-body p-4">
                                    <h5 class="fw-bold mb-3"><i class="bi bi-pencil me-2 text-primary"></i>새 게시글 작성</h5>
                                    <form method="post" action="board.nhn?action=addBoard" enctype="multipart/form-data">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label">작성자 닉네임</label>
                                                <input type="text" name="username" class="form-control bg-light" value="<%= acc.getNickname() %>" readonly>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">카테고리 태그</label>
                                                <div class="d-flex gap-3 pt-1">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="type" id="typeRecruit" value="1" checked>
                                                        <label class="form-check-label fw-bold text-success" for="typeRecruit">
                                                            <i class="bi bi-people-fill me-1"></i> 파티 모집
                                                        </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="type" id="typeFree" value="2">
                                                        <label class="form-check-label fw-bold text-primary" for="typeFree">
                                                            <i class="bi bi-chat-dots-fill me-1"></i> 자유 토크
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label class="form-label">제목</label>
                                                <input maxlength="100" type="text" name="title" class="form-control" placeholder="예: [롤] 오늘 저녁 칼바람/자랭 5인큐 하실 분!" required>
                                            </div>
                                            <div class="col-12">
                                                <label class="form-label">첨부 이미지 (선택)</label>
                                                <input type="file" name="file" class="form-control" accept="image/*">
                                            </div>
                                            <div class="col-12">
                                                <label class="form-label">게시글 내용</label>
                                                <textarea rows="5" name="content" class="form-control" maxlength="2000" placeholder="내용을 작성해주세요 (원하는 플레이 시간대, 디스코드 마이크 여부 등)" required></textarea>
                                            </div>
                                            <div class="col-12 text-end pt-2">
                                                <button type="button" class="btn btn-gp-secondary me-2" data-bs-toggle="collapse" data-bs-target="#addForm">취소</button>
                                                <button type="submit" class="btn btn-gp-primary">
                                                    <i class="bi bi-check-lg me-1"></i> 게시글 등록
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <% } %>

                        <!-- Board Table -->
                        <div class="table-responsive">
                            <table class="gp-table">
                                <thead>
                                    <tr>
                                        <th style="width: 70px; text-align: center;">번호</th>
                                        <th style="width: 90px; text-align: center;">태그</th>
                                        <th>제목</th>
                                        <th style="width: 120px;">작성자</th>
                                        <th style="width: 150px; text-align: center;">작성일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty boardlist}">
                                        <tr>
                                            <td colspan="5" class="text-center py-5 text-muted">
                                                <i class="bi bi-chat-square-dots fs-1 d-block mb-2 text-secondary opacity-50"></i>
                                                등록된 게시글이 없습니다. 첫 번째 글을 작성해보세요!
                                            </td>
                                        </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="board" items="${boardlist}">
                                            <tr onclick="location.href='board.nhn?action=getBoard&aid=${board.aid}';">
                                                <td style="text-align: center;" class="text-muted small">${board.aid}</td>
                                                <td style="text-align: center;">
                                                    <c:choose>
                                                        <c:when test="${board.type == '1'}">
                                                            <span class="gp-tag gp-tag-recruit"><i class="bi bi-people-fill me-1"></i>모집</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="gp-tag gp-tag-free"><i class="bi bi-chat-dots-fill me-1"></i>자유</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <span class="gp-table-title">${board.title}</span>
                                                </td>
                                                <td class="text-secondary small">
                                                    <i class="bi bi-person me-1"></i>${board.username}
                                                </td>
                                                <td style="text-align: center;" class="text-muted small">
                                                    ${board.date}
                                                </td>
                                            </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Pagination -->
                <%
                    Paging p = new Paging();
                    int recentPage = 1;
                    try {
                        String fpageParam = request.getParameter("fpage");
                        if (fpageParam != null) {
                            recentPage = Integer.parseInt(fpageParam);
                        }
                    } catch (Exception ex) {
                        recentPage = 1;
                    }
                    int totalLastPage = p.getLastPage();
                    if (totalLastPage < 1) totalLastPage = 1;
                    
                    int startP = Math.max(1, recentPage - 2);
                    int endP = Math.min(totalLastPage, recentPage + 2);
                %>
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <% if (recentPage > 1) { %>
                        <li class="page-item">
                            <a class="page-link" href="board.nhn?action=listBoard&fpage=<%= recentPage - 1 %>" aria-label="Previous">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        <% } %>

                        <% for (int i = startP; i <= endP; i++) { %>
                            <% if (recentPage == i) { %>
                            <li class="page-item active"><span class="page-link"><%= i %></span></li>
                            <% } else { %>
                            <li class="page-item"><a class="page-link" href="board.nhn?action=listBoard&fpage=<%= i %>"><%= i %></a></li>
                            <% } %>
                        <% } %>

                        <% if (recentPage < totalLastPage) { %>
                        <li class="page-item">
                            <a class="page-link" href="board.nhn?action=listBoard&fpage=<%= recentPage + 1 %>" aria-label="Next">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                        <% } %>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Global Footer -->
    <footer class="gp-footer">
        <div class="container text-center">
            <div class="mb-2">
                <span class="fw-bold text-light">GAMER PARTY</span> &middot; 게이머들을 위한 매칭 & 커뮤니티 플랫폼
            </div>
            <p class="mb-1 text-muted small">Copyright &copy; 2026 Gamer Party. All rights reserved.</p>
            <p class="mb-0 text-muted small">개발자: 안동대학교 박성국 &middot; Contact: <a href="mailto:qkrxotn60@naver.com">qkrxotn60@naver.com</a></p>
        </div>
    </footer>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>
