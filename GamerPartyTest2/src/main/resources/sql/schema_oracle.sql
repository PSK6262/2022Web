-- ============================================================
-- GamerParty (2022Web) Oracle DB Schema & Seed Data
-- Database: Oracle 19c (buildup / 1234@BUILDUP)
-- ============================================================

-- 기존 테이블 삭제 (존재할 경우)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BOARD CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ACCOUNT CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- 1. ACCOUNT 테이블 생성
CREATE TABLE ACCOUNT (
    aid         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email       VARCHAR2(100) NOT NULL UNIQUE,
    password    VARCHAR2(100) NOT NULL,
    nickname    VARCHAR2(50)  NOT NULL,
    prefergame  VARCHAR2(100) DEFAULT '없음',
    preferrole  VARCHAR2(50)  DEFAULT '없음',
    image       VARCHAR2(500),
    ban         NUMBER(1)     DEFAULT 0 NOT NULL -- 0: 일반, 1: 밴, 2: 관리자
);

-- 2. BOARD 테이블 생성
CREATE TABLE BOARD (
    aid         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title       VARCHAR2(200) NOT NULL,
    username    VARCHAR2(50)  NOT NULL,
    img         VARCHAR2(255),
    "DATE"      TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
    content     VARCHAR2(4000),
    type        VARCHAR2(10)  DEFAULT '1' -- '1': 모집, '2': 자유
);

-- 3. 초기 시드 데이터 삽입
-- 관리자 계정 (ban=2)
INSERT INTO ACCOUNT (email, password, nickname, prefergame, preferrole, image, ban)
VALUES ('admin@gamerparty.com', '1234', '총괄관리자', '리그 오브 레전드', '올라운더', NULL, 2);

-- 테스트 유저 계정 (ban=0)
INSERT INTO ACCOUNT (email, password, nickname, prefergame, preferrole, image, ban)
VALUES ('gamer1@test.com', '1234', '페이커팬1호', '리그 오브 레전드', '미드', NULL, 0);

INSERT INTO ACCOUNT (email, password, nickname, prefergame, preferrole, image, ban)
VALUES ('gamer2@test.com', '1234', '옵치장인', '오버워치 2', '탱커', NULL, 0);

INSERT INTO ACCOUNT (email, password, nickname, prefergame, preferrole, image, ban)
VALUES ('gamer3@test.com', '1234', '배그포친키', '배틀그라운드', '스나이퍼', NULL, 0);

-- 개발자 계정 (박성국)
INSERT INTO ACCOUNT (email, password, nickname, prefergame, preferrole, image, ban)
VALUES ('qkrxotn60@naver.com', '1234', '박성국', '오버워치 2 / 롤', '플렉스', NULL, 0);

-- 샘플 게시글
INSERT INTO BOARD (title, username, img, "DATE", content, type)
VALUES ('[롤] 오늘 저녁 칼바람/자랭 5인큐 하실 분 모십니다!', '페이커팬1호', NULL, CURRENT_TIMESTAMP - INTERVAL '2' HOUR, '디스코드 마이크 필수! 즐겜 매너 유저 환영합니다. 편하게 댓글 남겨주세요~', '1');

INSERT INTO BOARD (title, username, img, "DATE", content, type)
VALUES ('[오버워치] 그랜드마스터 목표 힐탱 듀오 구해요 (마스터 3 이상)', '옵치장인', NULL, CURRENT_TIMESTAMP - INTERVAL '1' HOUR, '아나/키리코 주력 힐러 구합니다. 저녁 9시부터 12시까지 달립니다!', '1');

INSERT INTO BOARD (title, username, img, "DATE", content, type)
VALUES ('오늘 롤 패치노트 신규 챔피언 써보신 분 후기 좀요', '총괄관리자', NULL, CURRENT_TIMESTAMP - INTERVAL '30' MINUTE, '미드에서 성능 괜찮은지 궁금합니다. 카운터는 누가 있나요?', '2');

INSERT INTO BOARD (title, username, img, "DATE", content, type)
VALUES ('스팀 세일 게임 추천받습니다! (협동/코옵 위주)', '배그포친키', NULL, CURRENT_TIMESTAMP - INTERVAL '10' MINUTE, '친구들이랑 할만한 4인 코옵 게임 추천 부탁드려요!', '2');

COMMIT;
EXIT;
