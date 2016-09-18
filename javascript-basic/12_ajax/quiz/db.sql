create table t86_ajax_users
(
	no number primary key,
	id varchar2(200) not null,
	name varchar2(200) not null,
	pass varchar2(200) not null
);
create sequence t86_ajax_user;

insert into t86_ajax_users (no, id, name, pass)
values (t86_ajax_user.nextval, 'admin', '관리자', 'admin');

select * from t86_ajax_users;

select * from T86_1_HOST_LOCATION;
select * from T86_1_HOST_PREVIEW;
select * from T86_1_HOSTING_STATUS;
select * from T86_1_HOST_LOCATION;
select * from T86_1_HOST_DETAIL;

create sequence seq_temp;