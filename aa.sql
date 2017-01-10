create table member ( memberid varchar(10) not null primary key, 					
                       password varchar(10) not null, 					
                       grade char(1) not null, 					
                       name varchar(60) null, 					
                       telephone varchar(20) null, 					
                       handphone varchar(20) null, 					
                       cameracount integer(2) default 0 not null,					
                       ipaddress varchar(30) null, 					
                       listenport integer(5) default 20001 not null,					
                       camerainfo1 varchar(30) null, 					
                       camerainfo2 varchar(30) null, 					
                       camerainfo3 varchar(30) null, 					
                       camerainfo4 varchar(30) null, 					
                       camerainfo5 varchar(30) null, 					
                       camerainfo6 varchar(30) null, 					
                       camerainfo7 varchar(30) null, 					
                       camerainfo8 varchar(30) null, 					
                       joindate char(8) not null, 					
                       usestartdate char(8) not null, 					
                       useenddate char(8) not null, 					
                       deleteyn integer(1) default 0 not null,					
                       regtime char(14) not null);					
					
					
create table initsetting ( memberid varchar(10) not null primary key, 					
                       laborchannel1 varchar(50) null, 					
                       laborchannel2 varchar(50) null, 					
                       laborchannel3 varchar(50) null, 					
                       laborchannel4 varchar(50) null, 					
                       laborchannel5 varchar(50) null, 					
                       laborchannel6 varchar(50) null, 					
                       laborchannel7 varchar(50) null, 					
                       laborchannel8 varchar(50) null, 					
                       laborchannel9 varchar(50) null, 					
                       laborchannel10 varchar(50) null, 					
                       onoffchannel1 varchar(50) null, 					
                       onoffchannel2 varchar(50) null, 					
                       onoffchannel3 varchar(50) null, 					
                       onoffchannel4 varchar(50) null, 					
                       onoffchannel5 varchar(50) null, 					
                       onoffchannel6 varchar(50) null, 					
                       onoffchannel7 varchar(50) null, 					
                       onoffchannel8 varchar(50) null, 					
                       onoffchannel9 varchar(50) null, 					
                       onoffchannel10 varchar(50) null, 					
                       hightemperature integer(2) default 42 not null, 					
                       lowtemperature integer(2) default 8 not null, 					
                       sensorcount integer(2) default 0 not null, 					
                       regtime char(14) not null);					
					
					
create table nutrientstate ( memberid varchar(10) not null, 					
                       ec float(5,2) default -1 not null, 					
                       ph float(5,2) default -1 not null, 					
                       wm2 integer(4) default -1 not null, 					
                       supplycount integer(5) default 0 not null, 					
                       type varchar(10) not null, 					
                       workmethod integer(3) default 0 not null, 					
                       regtime char(14) not null);					
					
					
create table sensorstate ( memberid varchar(10) not null, 					
                       temperature1 float(5,2) default -1 not null, 					
                       humidity1 float(5,2) default -1 not null, 					
                       carbondioxide1 integer(5) default -1 not null, 					
                       temperature2 float(5,2) default -1 not null, 					
                       humidity2 float(5,2) default -1 not null, 					
                       carbondioxide2 integer(5) default -1 not null, 					
                       temperature3 float(5,2) default -1 not null, 					
                       humidity3 float(5,2) default -1 not null, 					
                       carbondioxide3 integer(5) default -1 not null, 					
                       temperature4 float(5,2) default -1 not null, 					
                       humidity4 float(5,2) default -1 not null, 					
                       carbondioxide4 integer(5) default -1 not null, 					
                       regtime char(14) not null);					
					
					
create table farmingdaily ( memberid varchar(10) not null, 					
                       daydate char(8) not null, 					
                       cultivationspecies varchar(1000) null, 					
                       cultivationcropsstate varchar(1000) null, 					
                       yield varchar(1000) null, 					
                       note varchar(1000) null, 					
                       regtime char(14) not null);					
					
					
create table notification ( noticenumber integer(10) not null primary key auto_increment, 					
                       title varchar(500) not null, 					
                       hitcount integer(10) default 0 not null, 					
                       content varchar(4000) null, 					
                       regtime char(14) not null);

INSERT INTO ifarmers.member (memberid, password, grade, name, telephone, handphone, cameracount, ipaddress, listenport, camerainfo1, camerainfo2, camerainfo3, camerainfo4, camerainfo5, camerainfo6, camerainfo7, camerainfo8, joindate, usestartdate, useenddate, deleteyn, regtime) VALUES ('ss', '1234', '1', 'USER', null, null, 0, null, 20001, null, null, null, null, null, null, null, null, now(), '', now(), 0, now());


create table innercablesensorstate ( memberid varchar(10) not null,
                                     temperature float(5,2) default -1 not null,
                                     regtime char(14) not null);
