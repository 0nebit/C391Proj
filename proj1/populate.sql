insert into persons values (1, 'FN1', 'LN1', 'addr1', 'email1', 'phone1');
insert into persons values (2, 'FN2', 'LN2', 'addr2', 'email2', 'phone2');
insert into persons values (3, 'FN3', 'LN3', 'addr3', 'email3', 'phone3');
insert into persons values (4, 'FN4', 'LN4', 'addr4', 'email4', 'phone4');
insert into persons values (5, 'FN5', 'LN5', 'addr4', 'email5', 'phone5');


insert into users values ('admin1', 'pass1', 'a', 1, TO_DATE('2015-01-01', 'YYYY-MM-DD'));
insert into users values ('user1', 'pass1', 'p', 2, TO_DATE('2015-02-02', 'YYYY-MM-DD'));
insert into users values ('user2', 'pass2', 'p', 3, TO_DATE('2015-02-12', 'YYYY-MM-DD'));
insert into users values ('doc1', 'pass1', 'd', 4, TO_DATE('2015-01-03', 'YYYY-MM-DD'));
insert into users values ('doc2', 'pass2', 'd', 5, TO_DATE('2015-01-19', 'YYYY-MM-DD'));
insert into users values ('rad1', 'pass1', 'r', 2, TO_DATE('2015-02-02', 'YYYY-MM-DD'));

insert into family_doctor values (4, 1);
insert into family_doctor values (4, 2);
insert into family_doctor values (5, 3);
insert into family_doctor values (5, 4);

insert into radiology_record values (1, 3, 4, 2, 'type 1', TO_DATE('2015-02-07', 'YYYY-MM-DD'), TO_DATE('2015-02-09', 'YYYY-MM-DD'), 'diag 1', 'description 1');

