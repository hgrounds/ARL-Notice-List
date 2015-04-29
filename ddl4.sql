DROP VIEW nl_member_view;
DROP VIEW nl_nl_view;

CREATE VIEW nl_member_view AS
SELECT m.member_id, m.type, e.name, m.status_eff_date, e.lab_code, e.division_code, 
    m.status, m.nl_arl_emp_user_id
FROM nl_member m JOIN nl_arl_emp e
ON e.user_id = m.nl_arl_emp_user_id
WHERE type <> 'Notice List';

CREATE OR REPLACE TRIGGER member_trigger
  INSTEAD OF INSERT ON nl_member_view
  FOR EACH ROW
BEGIN
  INSERT INTO nl_member(
    member_id,
    type,
    name,
    status_eff_date,
    lab_code,
    division_code,
    status,
    nl_arl_emp_user_id )
  VALUES (
    :new.member_id,
    :new.type,
    :new.name,
    SYSDATE,
    :new.lab_code,
    :new.division_code,
    :new.status,
    :new.nl_arl_emp_user_id ) ;
END;
/

CREATE VIEW nl_nl_view AS
SELECT member_id, type, name, division_code, status, description,
  ownership_div_code, external_view_name
FROM nl_member
WHERE type = 'Notice List';

CREATE OR REPLACE TRIGGER nl_trigger
  INSTEAD OF INSERT ON nl_nl_view
  FOR EACH ROW
BEGIN
  INSERT INTO nl_member(
    member_id,
    type,
    name,
    status_eff_date,
    division_code,
    status,
    description,
    ownership_div_code,
    external_view_name)
  VALUES (
    :new.member_id,
    'Notice List',
    :new.name,
    SYSDATE,
    :new.division_code,
    :new.status,
    :new.description,
    :new.ownership_div_code,
    :new.external_view_name) ;
END;
/
