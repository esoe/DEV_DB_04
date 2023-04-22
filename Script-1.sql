-- создаем базу
create database "DevDB2023_igoniku";
-- создаем схему
create schema library;

--создаем таблицу
create table "library"."repository"(
	"id" INTEGER,
	"title" VARCHAR(300),
	"instances" INTEGER,
	"isbn" INTEGER,
	"year" DATE,
	"bindings_id" INTEGER,
	"publishers_id" INTEGER,
	"genres_id" INTEGER);
-- добавляем PK
alter table "library"."repository"
	add constraint pk_id primary key(id);
alter table "library"."repository"
	alter column "id" add generated always as identity;

--Добавляем FK
ALTER TABLE child_table_name
ADD [CONSTRAINT foreign_key_name]
  FOREIGN KEY (column)
    REFERENCES parent_table_name (column);

--удаление таблицы
drop table "library".repository;

__________________________________________________________________________________

create table "library"."test"(
	"id" INTEGER,
	"title" VARCHAR(300));

alter table "library"."test"
	alter column "id" set not null,
	alter column "id" add generated always as identity;

insert into "library"."test"(title) values('qwerty');

select * from "library"."test";
drop table "library".test;