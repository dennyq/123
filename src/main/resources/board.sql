create database hssecurity;
# ============================================================
drop table machine;
create table machine ( memberid varchar(50) not null primary key,
                       password varchar(20) not null,
                       grade char(1) not null,
                       name varchar(60) null,
                       contactpoint varchar(60) null,
                       note varchar(100) null,
                       joindate char(8) not null,
                       outdate char(8) not null,
                       usestartdate char(8) not null,
                       useenddate char(8) not null,
                       regtime char(14) not null);

# ============================================================
drop table member;
create table member ( memberid char(10) not null primary key,
                      password varchar(20) not null,
                      name varchar(60) not null,
                      contactpoint varchar(60) null,
                      note varchar(100) null,
                      regtime char(14) not null);

# ============================================================
drop table mappinginfo;
create table mappinginfo ( memberid varchar(50) not null,
                           memberid char(10) not null);

# ============================================================
drop table scanning_hist;
create table scanning_hist ( memberid varchar(50) not null,
                             scantime varchar(14) not null,
                             cardkind integer(3) not null,
                             name varchar(60) null,
                             juminnumber varchar(14) null,
                             issuedate varchar(10) null,
                             licensenumber varchar(30) null,
                             serialnumber varchar(20) null,
                             realcardflag char(1) default '2' not null,
                             realnameflag integer(3) default 3  not null,
                             adultflag char(1) default '2' not null,
                             imagefilepath varchar(40) not null,
                             generalimagefile varchar(60) not null,
                             irimagefile varchar(60) not null,
                             signimagefile varchar(60) not null,
                             regtime char(14) not null);



# ============================================================
# CREATE TABLE machine
# (
#   memberid VARCHAR(50) PRIMARY KEY NOT NULL  ,
#   password VARCHAR(20) NOT NULL ,
#   grade CHAR(1)  NOT NULL ,
#   name VARCHAR(60) NULL ,
#   contactpoint VARCHAR(60) NULL ,
#   note VARCHAR(100) NULL ,
#   joindate CHAR(8) NOT NULL ,
#   outdate CHAR(8) NOT NULL ,
#   usestartdate CHAR(8) NOT NULL ,
#   useenddate CHAR(8) NOT NULL ,
#   regtime CHAR(14) NOT NULL
#
# );
#
# CREATE TABLE mappinginfo
# (
#   memberid VARCHAR(50) NULL  ,
#   memberid CHAR(10)
#
# );
#
# CREATE TABLE member
# (
#   memberid VARCHAR(50) PRIMARY KEY NOT NULL ,
#   password VARCHAR(20) NOT NULL,
#   name VARCHAR(60) NOT NULL ,
#   contactpoint VARCHAR(60) NULL ,
#   note VARCHAR(100) NOT NULL ,
#   regtime CHAR(14) NOT NULL
#
# );
#
#
# CREATE TABLE scanning_hist
# (
#   memberid VARCHAR(50) NOT NULL ,
#   scantime VARCHAR(14) NOT NULL,
#   cardkind int(3) NOT NULL ,
#   name VARCHAR(60)  NULL ,
#   juminnumber VARCHAR(14) NULL,
#   issuedate VARCHAR(10) NULL,
#   licensenumber VARCHAR(30) NULL,
#   serialnumber VARCHAR(20) NULL,
#   realcardflag CHAR(1) NOT NULL ,
#   realnameflag INT(3) NOT NULL ,
#   adultflag CHAR(1) NOT NULL ,
#   imagefilepath VARCHAR(40) NOT NULL ,
#   generalimagefile VARCHAR(60) NOT NULL ,
#   irimagefile VARCHAR(60) NOT NULL ,
#   signimagefile VARCHAR(60) NOT NULL ,
#   regtime CHAR(14) NOT NULL
# );


SELECT
  member_no,
  member_email,
  member_nm,
  member_type,
  cert_birth,
  member_status,
  auth_yn,
  del_yn,
  organ_seq,
  if(member_type in ('A','G','C','O'),'Y','N') as isAdmin
FROM se_member
WHERE member_email = #{member_email}
#       <if test='super_pwd != "Y" and member_pwd != null and member_pwd != ""'>
AND member_pwd = #{member_pwd}
# </if>
#     AND del_yn = 'N'

select * from member
where member = ''and password = ''
;

# INSERT INTO hssecurity.member(
#   memberid
#   ,password
#   ,name
#   ,contactpoint
#   ,note
#   ,regtime
# ) VALUES (
#   'admin' -- memberid - IN varchar(50)
#   ,'1234' -- password - IN varchar(20)
#   ,'admin' -- name - IN varchar(60)
#   ,''  -- contactpoint - IN varchar(60)
#   ,NULL -- note - IN varchar(100)
#   ,NULL -- regtime - IN char(14)
# )
#
INSERT INTO hssecurity.member(
  memberid
  ,password
  ,name
  ,contactpoint
  ,note
  ,regtime
) VALUES (
  'admin' -- memberid - IN varchar(50)
  ,'1234' -- password - IN varchar(20)
  ,'관리자' -- name - IN varchar(60)
  ,''  -- contactpoint - IN varchar(60)
  ,NULL -- note - IN varchar(100)
  ,NULL -- regtime - IN char(14)
);

INSERT INTO hssecurity.machine(
memberid
,password
,grade
,name
,contactpoint
,note
,joindate
,outdate
,usestartdate
,useenddate
,regtime
) VALUES (
'admin' -- memberid - IN varchar(50)
,'1234' -- password - IN varchar(20)
,'1' -- grade - IN char(1)
,''  -- name - IN varchar(60)
,''  -- contactpoint - IN varchar(60)
,''  -- note - IN varchar(100)
,DATE_FORMAT(now()+0,'%Y%m%d')-- joindate - IN char(8)
,DATE_FORMAT(now()+0,'%Y%m%d')-- outdate - IN char(8)
,DATE_FORMAT(now()+0,'%Y%m%d')-- usestartdate - IN char(8)
,DATE_FORMAT(now()+0,'%Y%m%d')-- useenddate - IN char(8)
,DATE_FORMAT(now()+0,'%Y%m%d')-- regtime - IN char(14)
);

select
  memberid, password, grade, name, contactpoint, note, joindate, outdate, usestartdate, useenddate, regtime
from machine
where memberid = 'admin' and password = '1234'
;


SELECT COUNT(0)
FROM machine
WHERE memberid = 'admin'
--       #     AND del_yn = 'N' AND member_status = 'F'
-- #       <if test='super_pwd != "Y" and member_pwd != null and member_pwd != ""'>
-- # AND member_pwd = #{member_pwd}
-- # </if>




	/* FORUM */
	CREATE TABLE se_board (
		brd_seq BIGINT NOT NULL,  /* 글번호 */
		brd_type char(1) NOT NULL,
		member_no varchar(50) NOT NULL,  /* 사용자ID */
		brd_pwd varchar(50),  /* 글비밀번호 */
		subject varchar(100) NOT NULL,  /* 글제목 */
		contents varchar(500),  /* 글내용 */
		brd_cnt smallint NOT NULL,  /* 글조회수 */
		brd_re_ref smallint,  /* 글그룹번호 */
		brd_re_lev smallint,  /* 답변글번호 */
		brd_re_seq smallint,  /* 답변글순서 */
		brd_status smallint , /* 진행여부 */
		del_yn CHAR(1) DEFAULT 'N',
		reg_date CHAR(14),
		reg_ip CHAR(17),
		reg_member BIGINT,
		upd_date CHAR(14),
		upd_ip CHAR(17),
		upd_member BIGINT
	)


	/* FORUM 기본키 */
	ALTER TABLE [MY_SCHEMA][FORUM]
		ADD
			CONSTRAINT [PK_FORUM]
			PRIMARY KEY NONCLUSTERED (
				[POST_IDX] ASC
			)


	CREATE TABLE se_member
	(
		member_no BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
		member_email VARCHAR(150) NOT NULL,
		member_nm VARCHAR(100) NOT NULL,
		member_type VARCHAR(20),
		member_pwd VARCHAR(100),
		member_mphone VARCHAR(30),
		member_hphone VARCHAR(30),
		member_img_key VARCHAR(200),
		country_code VARCHAR(30),
		auth_code VARCHAR(50),
		auth_yn CHAR(1) DEFAULT 'N',
		privacy_yn CHAR(1),
		mail_rcv_yn CHAR(1),
		mail_change_cnt INT,
		old_member_email VARCHAR(150),
		cert_yn CHAR(1) DEFAULT 'N',
		cert_birth CHAR(8),
		tch_cert_yn CHAR(1) DEFAULT 'N',
		member_entr_path VARCHAR(100),
		member_entr_device VARCHAR(20),
		member_status VARCHAR(50) DEFAULT 'C',
		member_level INT DEFAULT 1,
		member_memo LONGTEXT,
		zip_no CHAR(6),
		del_yn CHAR(1) DEFAULT 'N',
		reg_date CHAR(14),
		reg_ip CHAR(17),
		reg_member BIGINT,
		upd_date CHAR(14),
		upd_ip CHAR(17),
		upd_member BIGINT,
		addr1 VARCHAR(100),
		addr2 VARCHAR(100),
		road_addr VARCHAR(100),
		member_gender CHAR(1) DEFAULT 'M',
		organ_seq BIGINT
	);
	CREATE INDEX se_member_idx2 ON se_member (member_email);
	CREATE INDEX se_member_idx3 ON se_member (member_img_key);


# 	//////////////////////게시판//////////////////////

	drop table SE_ARTICLE;

	create table se_article
	(
		article_seq bigint primary key not null auto_increment comment '게시글순번',
		article_type char(1) not null comment '게시글타입공통코드참조:cmnzx(0:교육게시판,1,2,3,4)',
		article_status char(1) comment '게시글상태공통코드참조:cmnzw(0:오픈,1:진행중,2:완료,3:만료)',
		article_cnt bigint not null default 0 comment '글조회수',

		article_re_ref bigint comment '답변글참조번호',
		article_re_lev smallint comment '답변글레벨',
		article_re_seq smallint comment '답변글순서',

		title varchar(200) comment '게시글제목',
		contents varchar(500) comment '게시글내용',

		image_file_key varchar(200) comment '이미지파일키',
		attach_file_key varchar(200) comment '첨부파일키',

		str_dtime char(14) default null comment '시작일시',
		end_dtime char(14) default null comment '종료일시',

		secret_yn char(1) not null default 'N' comment '비밀글여부',

		del_yn char(1) not null default 'N' comment '삭제여부',
		del_date char(14) comment '삭제일',
		del_ip char(17) comment '삭제자아이피',
		del_member bigint comment '삭제멤버',

		reg_date char(14) comment '등록일',
		reg_ip char(17) comment '등록자아이피',
		reg_member bigint comment '등록자',

		upd_date char(14) comment '수정자',
		upd_ip char(17) comment '수정자아이피',
		upd_member bigint comment '수정멤버'
	);
	ALTER TABLE SE_ARTICLE DROP INDEX SE_ARTICLE_INDEX1
	;
	CREATE UNIQUE INDEX SE_ARTICLE_INDEX1 ON SE_ARTICLE (ARTICLE_TYPE, DEL_YN);
# 	CREATE UNIQUE INDEX SE_ARTICLE_INDEX2 ON SE_ARTICLE (SYS_NC00015$);
	drop table se_article_comment;

	create table se_article_comment
	(
		cmnt_seq bigint primary key not null auto_increment comment '댓글순번',
		article_type char(1) not null comment '게시글타입',
		article_seq bigint not null comment '게시글순번',
		cmnt_cnt bigint not null default 0 comment '댓글조회수',

		cmnt_re_ref bigint comment '댓글참조번호',
		cmnt_re_lev smallint comment '댓글레벨',
		cmnt_re_seq smallint comment '댓글순서',

		cmnt_text varchar(700) not null comment '댓글내용',

		secret_yn char(1) not null default 'N' comment '비밀글여부',
		del_yn char(1) not null default 'N' comment '삭제여부',
		del_date char(14) comment '삭제일',
		del_ip char(17) comment '삭제자아이피',
		del_member bigint comment '삭제멤버',

		reg_date char(14) comment '등록일',
		reg_ip char(17) comment '등록자아이피',
		reg_member bigint comment '등록자',

		upd_date char(14) comment '수정자',
		upd_ip char(17) comment '수정자아이피',
		upd_member bigint comment '수정멤버'

	);
	ALTER TABLE se_article_comment DROP INDEX SE_ARTICLE_COMMENT_INDEX1
	;
	CREATE UNIQUE INDEX SE_ARTICLE_COMMENT_INDEX1 ON SE_ARTICLE_COMMENT (article_seq, ARTICLE_TYPE);



	Select BBS_SEQ, BBSPREFIX, ARTICLE_TITLE, ARTICLE_CONTENTS, ATTACH_KEY, LINEUP_CODE, PARENTS_SEQ, GROUP_SEQ, HIT, REG_MEMBER_SEQ, REG_DTIME, DEL_YN, MOD_MEMBER_SEQ, MOD_DTIME, ARTICLE_SEQ, STR_DTIME, TOP_NOTICE_CHK, END_DTIME, COMPANY_CODE from englider.enl_article
	USE englider;

	CREATE TABLE `enl_article` (
		`BBS_SEQ` int(10) unsigned NOT NULL AUTO_INCREMENT,
		`BBSPREFIX` varchar(1000) DEFAULT NULL,
		`ARTICLE_TITLE` varchar(1000) DEFAULT NULL COMMENT '글제목',
		`ARTICLE_CONTENTS` longtext COMMENT '글내용',
		`ATTACH_KEY` varchar(1000) DEFAULT NULL,
		`LINEUP_CODE` varchar(1000) DEFAULT NULL,
		`PARENTS_SEQ` int(10) DEFAULT NULL COMMENT '부모번호',
		`GROUP_SEQ` int(10) DEFAULT NULL COMMENT '1:공지사항, 2:QnA, 3:FAQ',
		`HIT` varchar(1000) DEFAULT NULL COMMENT '조회수',
		`REG_MEMBER_SEQ` int(10) DEFAULT NULL COMMENT '등록자번호',
		`REG_DTIME` char(14) DEFAULT NULL COMMENT '등록일시',
		`DEL_YN` varchar(1000) DEFAULT NULL COMMENT '삭제여부',
		`MOD_MEMBER_SEQ` int(10) DEFAULT NULL COMMENT '수정자번호',
		`MOD_DTIME` char(14) DEFAULT NULL COMMENT '수정일시',
		`ARTICLE_SEQ` int(10) NOT NULL COMMENT '글번호',
		`STR_DTIME` char(14) DEFAULT NULL COMMENT '시작일시',
		`TOP_NOTICE_CHK` char(1) DEFAULT NULL COMMENT '탑공지여부',
		`END_DTIME` char(14) DEFAULT NULL COMMENT '종료일시',
		`COMPANY_CODE` varchar(100) DEFAULT NULL COMMENT '총관리자거래처코드',
		PRIMARY KEY (`BBS_SEQ`,`ARTICLE_SEQ`)
	) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8;

	Select REPLY_SEQ, BBS_SEQ, REPLY_CONTENTS, REG_MEMBER_SEQ, REG_DTIME, group_seq, DEL_YN from englider.enl_article_reply
	USE englider;

	CREATE TABLE `enl_article_reply` (
		`REPLY_SEQ` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '순번',
		`BBS_SEQ` int(10) unsigned NOT NULL COMMENT '게시판순번',
		`REPLY_CONTENTS` longtext NOT NULL COMMENT '댓글내용',
		`REG_MEMBER_SEQ` int(10) NOT NULL COMMENT '등록자번호',
		`REG_DTIME` char(14) NOT NULL COMMENT '등록일시',
		`group_seq` int(10) NOT NULL COMMENT '1:공지사항, 2:QnA, 3:FAQ',
		`DEL_YN` char(1) DEFAULT NULL COMMENT '삭제여부',
		PRIMARY KEY (`REPLY_SEQ`)
	) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;


	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (3,247,'안녕하세요. 잉글라이더 운영팀 입니다. 문제가 있는 교재명을 알려주시면 테스트 해보도록 하겠습니다. 이용에 불편을 드려 죄송합니다.',550,'20130118113548',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (7,247,'예상하기에는 기호로 인해 발생하는 문제 같습니다.',550,'20130118114036',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (8,247,'문장에 콤마나 물음표 등이 포함되어 있는데, 문제를 맞출 때 기호를 넣지 않으면 통과가 되지 않는 것 입니다.',550,'20130118114134',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (12,249,'안녕하세요. 댓글로 답변드리기가 어려워 이메일로 답변 드렸습니다. 감사합니다.',550,'20130131180038',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (14,254,'1. 교과서는 출판사와 계약이 필요한 부분이라 아직 명확하게 말씀드리기가 어렵습니다.',550,'20130215104159',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (15,254,'2. 현재 학습시간을 임의로 수정할 수 있는 방법은 없습니다. 말씀하신 부분에 대해서는 논의를 해봐야 할 것 같습니다.',550,'20130215104238',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (16,254,'아직 불확실한 부분이 있기는 하지만 새교과서는 3월 부터 본격적으로 탑재가 될 것 같습니다.',550,'20130215162314',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (17,256,'fsdfsd',44040,'20140113121350',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (20,255,'wrwer',44040,'20140113123040',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (21,286,'sdfs',44040,'20140124162456',1,'Y');
	insert into englider.enl_article_reply(REPLY_SEQ,BBS_SEQ,REPLY_CONTENTS,REG_MEMBER_SEQ,REG_DTIME,group_seq,DEL_YN) values (22,255,'댓글..',19275,'20140509105042',1,'Y');

	UPDATE se_common_code
	set cd= '09'
	WHERE cd_class='SEW022' and cd_nm='생,명/유전공학'
	;
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','원자핵공학',	08,'SEW021','05',8);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','생,명/유전공학',	09,'SEW021','05',9);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','식/동물',	10,'SEW021','05',10);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','경영학',	11,'SEW021','06',11);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','국어국문',	12,'SEW021','07',12);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','영어영문',	13,'SEW021','07',13);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','중어중문',	14,'SEW021','07',14);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','일어일문',	15,'SEW021','07',15);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','노어노문',	16,'SEW021','07',16);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','불어불문',	17,'SEW021','07',17);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','독어독문',	18,'SEW021','07',18);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','서어서문',	19,'SEW021','07',19);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','국사',	20,'SEW021','07',20);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','동양사',	21,'SEW021','07',21);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','세계사',	22,'SEW021','07',22);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','역사일반',	23,'SEW021','07',23);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','철학/종교',	24,'SEW021','07',24);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','미학/미술사',	25,'SEW021','07',25);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','정치외교',	26,'SEW021','08',26);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','경제',	27,'SEW021','08',27);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','사회',	28,'SEW021','08',28);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','인류학',	29,'SEW021','08',29);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','지리학',	30,'SEW021','08',30);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','심리학',	31,'SEW021','08',31);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','사회복지',	32,'SEW021','08',32);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','언론정보',	33,'SEW021','08',33);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','수리과학',	34,'SEW021','09',34);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','통계학',	35,'SEW021','09',35);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','화학',	36,'SEW021','09',36);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','생명과학',	37,'SEW021','09',37);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','지구환경과학',	38,'SEW021','09',38);
	insert into se_common_code
	(cd_class, cd_nm, cd, upper_cd_class, upper_cd, prt_ord)
	values(
		'SEW022','물리천문학',	39,'SEW021','09',39);

