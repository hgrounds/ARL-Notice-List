DROP SEQUENCE NL_ARL_Emp_seq ; 
create sequence NL_ARL_Emp_seq 
start with 100 
increment by 1 
nomaxvalue 
;
DROP TRIGGER NL_ARL_Emp_PK_trig 
; 

create or replace trigger NL_ARL_Emp_PK_trig 
before insert on NL_ARL_Emp
for each row 
begin 
select NL_ARL_Emp_seq.nextval into :new.user_id from dual; 
end; 
/

DROP SEQUENCE NL_Document_seq ; 
create sequence NL_Document_seq 
start with 100 
increment by 1 
nomaxvalue 
;
DROP TRIGGER NL_Document_PK_trig 
; 

create or replace trigger NL_Document_PK_trig 
before insert on NL_Document
for each row 
begin 
select NL_Document_seq.nextval into :new.document_id from dual; 
end; 
/

DROP SEQUENCE NL_Member_seq ; 
create sequence NL_Member_seq 
start with 100 
increment by 1 
nomaxvalue 
;
DROP TRIGGER NL_Member_PK_trig 
; 

create or replace trigger NL_Member_PK_trig 
before insert on NL_Member
for each row 
begin 
select NL_Member_seq.nextval into :new.member_id from dual; 
end; 
/

DROP SEQUENCE NL_division_seq ; 
create sequence NL_division_seq 
start with 100 
increment by 1 
nomaxvalue 
;
DROP TRIGGER NL_division_PK_trig 
; 

create or replace trigger NL_division_PK_trig 
before insert on NL_division
for each row 
begin 
select NL_division_seq.nextval into :new.division_id from dual; 
end; 
/

DROP SEQUENCE NL_lab_seq ; 
create sequence NL_lab_seq 
start with 100 
increment by 1 
nomaxvalue 
;
DROP TRIGGER NL_lab_PK_trig 
; 

create or replace trigger NL_lab_PK_trig 
before insert on NL_lab
for each row 
begin 
select NL_lab_seq.nextval into :new.lab_id from dual; 
end; 
/

DROP INDEX NL_Member_member_id_FK_0 ;
CREATE INDEX NL_Member_member_id_FK_0 ON NL_ARL_Emp(NL_Member_member_id) ;
DROP INDEX NL_Member_member_id_FK_1 ;
CREATE INDEX NL_Member_member_id_FK_1 ON NL_Document(NL_Member_member_id) ;
DROP INDEX NL_ARL_Emp_user_id_FK_2 ;
CREATE INDEX NL_ARL_Emp_user_id_FK_2 ON NL_Member(NL_ARL_Emp_user_id) ;
DROP INDEX NL_lab_lab_id_FK_3 ;
CREATE INDEX NL_lab_lab_id_FK_3 ON NL_division(NL_lab_lab_id) ;
DROP INDEX NL_division_division_i_FK_4 ;
CREATE INDEX NL_division_division_i_FK_4 ON NL_lab(NL_division_division_id) ;
DROP INDEX NL_Member_member_id_FK_5 ;
CREATE INDEX NL_Member_member_id_FK_5 ON NL_mem_NL(NL_Member_member_id) ;
DROP INDEX NL_Member_member_id1_FK_6 ;
CREATE INDEX NL_Member_member_id1_FK_6 ON NL_mem_NL(NL_Member_member_id1) ;
