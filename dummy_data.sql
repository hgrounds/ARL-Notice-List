-- INSERT INTO nl_arl_emp
DROP TABLE NL_ARL_Emp CASCADE CONSTRAINTS ;

CREATE TABLE NL_ARL_Emp
(
 user_id             INTEGER NOT NULL ,
 name                VARCHAR2 (4000) ,
 status              VARCHAR2 (255) ,
 status_eff_date     DATE ,
 lab_code            INTEGER ,
 division_code       INTEGER ,
 NL_Member_member_id INTEGER
 ) ; 
CREATE UNIQUE INDEX NL_ARL_Emp__IDX ON NL_ARL_Emp
(
 NL_Member_member_id ASC 
 )
;
ALTER TABLE NL_ARL_Emp ADD CONSTRAINT NL_ARL_Emp_PK PRIMARY KEY ( user_id ) ; 

INSERT INTO nl_arl_emp (user_id, name, status,
  status_eff_date, lab_code, division_code)
VALUES (1, 'Steve Jobs', 'A', SYSDATE, 10, 100);
INSERT INTO nl_arl_emp (user_id, name, status,
  status_eff_date, lab_code, division_code)
VALUES (2, 'Bill Gates', 'A', SYSDATE, 10, 101);
INSERT INTO nl_arl_emp (user_id, name, status,
  status_eff_date, lab_code, division_code)
VALUES (3, 'Noam Chomsky', 'A', SYSDATE, 10, 102);
INSERT INTO nl_arl_emp (user_id, name, status,
  status_eff_date, lab_code, division_code)
VALUES (4, 'Barrack Obama', 'I', SYSDATE, 11, 105);
INSERT INTO nl_arl_emp (user_id, name, status,
  status_eff_date, lab_code, division_code)
VALUES (5, 'Heather Wilson', 'A', SYSDATE, 12, 107);
INSERT INTO nl_arl_emp (user_id, name, status,
  status_eff_date, lab_code, division_code)
VALUES (6, 'Salvador Dali', 'A', SYSDATE, 12, 107);
INSERT INTO nl_arl_emp (user_id, name, status,
  status_eff_date, lab_code, division_code)
VALUES (7, 'Wolfgang Mozart', 'A', SYSDATE, 13, 109);
INSERT INTO nl_arl_emp (user_id, name, status,
  status_eff_date, lab_code, division_code)
VALUES (8, 'Leonard Bernstein', 'A', SYSDATE, 13, 110);

-- INSERT INTO nl_division
DROP TABLE NL_division CASCADE CONSTRAINTS ;

CREATE TABLE NL_division
(
 division_id   INTEGER NOT NULL ,
 name          VARCHAR2 (4000) ,
 NL_lab_lab_id INTEGER
 ) ;
CREATE UNIQUE INDEX NL_division__IDX ON NL_division
(
 NL_lab_lab_id ASC
 )
;
ALTER TABLE NL_division ADD CONSTRAINT NL_division_PK PRIMARY KEY ( division_id ) ;

INSERT INTO nl_division (division_id, name)
VALUES (100, 'Apple');
INSERT INTO nl_division (division_id, name)
VALUES (101, 'Microsoft');
INSERT INTO nl_division (division_id, name)
VALUES (102, 'Hegemony');
INSERT INTO nl_division (division_id, name)
VALUES (105, 'President');
INSERT INTO nl_division (division_id, name)
VALUES (107, 'Congressman');
INSERT INTO nl_division (division_id, name)
VALUES (109, 'Classical');
INSERT INTO nl_division (division_id, name)
VALUES (110, 'Musical');

-- INSERT INTO nl_lab
DROP TABLE NL_lab CASCADE CONSTRAINTS ;

CREATE TABLE NL_lab
(
 lab_id                  INTEGER NOT NULL ,
 name                    VARCHAR2 (4000) ,
 NL_division_division_id INTEGER
 ) ;
CREATE UNIQUE INDEX NL_lab__IDX ON NL_lab
(
 NL_division_division_id ASC
 )
;
ALTER TABLE NL_lab ADD CONSTRAINT NL_lab_PK PRIMARY KEY ( lab_id ) ;

INSERT INTO nl_lab (lab_id, name)
VALUES (10, 'Computing');
INSERT INTO nl_lab (lab_id, name)
VALUES (11, 'Politics');
INSERT INTO nl_lab (lab_id, name)
VALUES (12, 'Painting');
INSERT INTO nl_lab (lab_id, name)
VALUES (13, 'Composing');
