USE Final_projectDB;

CREATE TABLE memo(
    id varchar(10) not null,
    content TEXT null,
    primary key(id),
    FOREIGN KEY(id) REFERENCES member(id)
) default CHARSET=utf8;



select * from memo; 
DELETE from member;