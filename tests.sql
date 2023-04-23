
create table "library"."test"(
	"id" INTEGER,
	"title" VARCHAR(300));

alter table "library"."test"
	alter column "id" set not null,
	alter column "id" add generated always as identity;

insert into "library"."test"(title) values('qwerty');

select * from "library"."test";
drop table "library".test;