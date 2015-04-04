drop sequence rec_seq;

create sequence rec_seq MINVALUE 100;

commit;

CREATE INDEX search_index1 ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX search_index2 ON persons(last_name) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX search_index3 ON radiology_record(diagnosis) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX search_index4 ON radiology_record(description) INDEXTYPE IS CTXSYS.CONTEXT;
