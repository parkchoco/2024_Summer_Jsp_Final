USE Final_projectDB;

create table member (
    id varchar(10) not null,
    password varchar(10) not null,
    name varchar(10) not null,
    phone varchar(20),
    address varchar(90),
    primary key(id) 
) default CHARSET=utf8;


select * from member; 


drop table member;

ALTER TABLE member ADD COLUMN content TEXT null;
ALTER TABLE member DROP COLUMN content;