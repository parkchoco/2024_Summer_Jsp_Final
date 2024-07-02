USE Final_projectDB;
CREATE TABLE history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255),
    points INT,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from history;

desc history;

drop table history;

insert into history
values (3, 'ks970079', 10, '2024-06-05 03:22:22.0')

insert into history
values (4, 'ks970079', 10, '2024-06-06 03:22:22.0')

insert into history
values (5, 'ks970079', 10, '2024-06-13 03:22:22.0')