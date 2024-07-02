USE Final_projectDB;

create table member ( 
    id varchar(10) not null,
    password varchar(10) not null,
    name varchar(10) not null,
    phone varchar(20),
    address varchar(90),
    point int default 0,
    primary key(id) 
) default CHARSET=utf8;


select * from member; 

ALTER TABLE member CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;

ALTER TABLE member ADD level int default 0;

drop table member;

insert into member
values ('12', '12', '12', '12', '12', 1000, 0)
