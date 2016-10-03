create table t86_1_host_location
(
	host_num varchar2(30) primary key,
	nation varchar2(30) not null,
	addr varchar2(30) not null,
	zip_code varchar2(30) not null,
	detail_addr varchar2(30),
	X_point varchar2(30) not null,
	Y_point varchar2(30) not null
);

select * from T86_1_HOST_LOCATION;