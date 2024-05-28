-- 스키마 생성 및 세션 설정
CREATE SCHEMA `phonetail` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE phonetail;
SET SESSION FOREIGN_KEY_CHECKS=0;

select*from member;

-- 기존 테이블 삭제
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS admin;
DROP TABLE IF EXISTS chat;
DROP TABLE IF EXISTS report;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS question;
DROP TABLE IF EXISTS member;

-- 테이블 생성
CREATE TABLE address
(
    zip_num varchar(15),
    sido varchar(30),
    gugun varchar(30),
    dong varchar(30),
    bunji varchar(20),
    zip_code varchar(30)
);

CREATE TABLE admin
(
    adminid varchar(45) NOT NULL,
    pwd varchar(45),
    name varchar(45),
    phone varchar(45),
    PRIMARY KEY (adminid)
);

CREATE TABLE chat
(
    cseq int NOT NULL AUTO_INCREMENT,
    content varchar(300) NOT NULL,
    indate datetime DEFAULT now() NOT NULL,
    userid varchar(45) NOT NULL,
    pseq int NOT NULL,
    PRIMARY KEY (cseq)
);

CREATE TABLE member
(
    userid varchar(45) NOT NULL,
    pwd varchar(45) NOT NULL,
    name varchar(45) NOT NULL,
    phone varchar(45) NOT NULL,
    email varchar(100) NOT NULL,
    zip_num varchar(45) NOT NULL,
    address1 varchar(100) NOT NULL,
    address2 varchar(100) NOT NULL,
    zip_code varchar(45) NOT NULL,
    usestate char(1) DEFAULT 'Y' NOT NULL,
    indate datetime DEFAULT now() NOT NULL,
    PRIMARY KEY (userid)
);

CREATE TABLE product
(
    pseq int NOT NULL AUTO_INCREMENT,
    brand varchar(45) NOT NULL COMMENT 'company > brand로 수정',
    series varchar(45) NOT NULL COMMENT '카테고리 필터 용',
    model varchar(45) NOT NULL COMMENT '카테고리 필터 용',
    price int NOT NULL,
    comment varchar(1000),
    image varchar(200),
    saveimagefile varchar(200) COMMENT 'no image가 있을수 있어서',
    sellstate char(1) DEFAULT 'N' COMMENT 'YorN',
    indate datetime DEFAULT now() NOT NULL,
    userid varchar(45) NOT NULL,
    PRIMARY KEY (pseq)
);

CREATE TABLE question
(
    qseq int NOT NULL AUTO_INCREMENT,
    title varchar(100) NOT NULL,
    content varchar(1000) NOT NULL,
    indate datetime DEFAULT now() NOT NULL,
    userid varchar(45) NOT NULL,
    qreply varchar(1000),
    PRIMARY KEY (qseq)
);

CREATE TABLE report
(
    reseq int NOT NULL AUTO_INCREMENT,
    pseq int NOT NULL,
    userid varchar(45) NOT NULL,
    retype int NOT NULL COMMENT '--0 - 광고성 콘텐츠(거래와 관련없는 글)
   --1 - 상품정보 부정확
   --2 - 안전거래를 거부해요
   --3 - 사기가 의심돼요(외부 채널 유도)
   --4 - 전문업자 같아요',
    recontent varchar(300) NOT NULL,
    restate char(1) DEFAULT 'N' NOT NULL COMMENT 'N:대기상태 Y:처리완료',
    PRIMARY KEY (reseq)
);

-- 외래 키 추가
ALTER TABLE chat
    ADD FOREIGN KEY (userid) REFERENCES member (userid) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE product
    ADD FOREIGN KEY (userid) REFERENCES member (userid) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE question
    ADD FOREIGN KEY (userid) REFERENCES member (userid) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE report
    ADD FOREIGN KEY (userid) REFERENCES member (userid) ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE chat
    ADD FOREIGN KEY (pseq) REFERENCES product (pseq) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE report
    ADD FOREIGN KEY (pseq) REFERENCES product (pseq) ON UPDATE RESTRICT ON DELETE RESTRICT;

-- 샘플 데이터 삽입
INSERT INTO address (zip_num, sido, gugun, dong, bunji, zip_code) VALUES
('12345', '서울특별시', '강남구', '삼성동', '123-45', '06100'),
('67890', '부산광역시', '해운대구', '우동', '678-90', '48095');

INSERT INTO admin (adminid, pwd, name, phone) VALUES
('admin1', 'password1', '관리자1', '010-1234-5678'),
('admin2', 'password2', '관리자2', '010-8765-4321');

INSERT INTO member (userid, pwd, name, phone, email, zip_num, address1, address2, zip_code, usestate, indate) VALUES
('user1', 'pwd1', '사용자1', '010-1111-2222', 'user1@example.com', '12345', '서울특별시 강남구 삼성동', '123-45', '06100', 'Y', now()),
('user2', 'pwd2', '사용자2', '010-3333-4444', 'user2@example.com', '67890', '부산광역시 해운대구 우동', '678-90', '48095', 'Y', now());

INSERT INTO product (brand, series, model, price, comment, image, saveimagefile, sellstate, indate, userid) VALUES
('Apple', 'iPhone', 'iPhone 13', 1000000, '최신 아이폰 모델', 'iphone13.jpg', 'iphone13.jpg', 'Y', now(), 'user1'),
('Samsung', 'Galaxy', 'Galaxy S21', 900000, '최신 갤럭시 모델', 'galaxys21.jpg', 'galaxys21.jpg', 'N', now(), 'user2');

INSERT INTO chat (content, indate, userid, pseq) VALUES
('이 제품에 대해 질문이 있습니다.', now(), 'user2', 1),
('언제 배송되나요?', now(), 'user1', 2);

INSERT INTO question (title, content, indate, userid, qreply) VALUES
('제품 문의', '이 제품의 기능에 대해 알고 싶습니다.', now(), 'user1', '답변 대기 중'),
('배송 문의', '언제 배송되나요?', now(), 'user2', '답변 대기 중');

INSERT INTO report (pseq, userid, retype, recontent, restate) VALUES
(1, 'user2', 3, '사기가 의심됩니다.', 'N'),
(2, 'user1', 1, '상품 정보가 부정확합니다.', 'Y');