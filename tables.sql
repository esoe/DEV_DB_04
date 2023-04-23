-- Скрипт создает таблицы,
-- устанавливает поля таблиц и типы данных полей

--repository "Библиотечный фонд"
create table "library"."repository"(
	"id" SERIAL,
	"title" VARCHAR(300),
	"instances" INTEGER,
	"isbn" INTEGER,
	"year" DATE,
	"bindings_id" INTEGER,
	"publishers_id" INTEGER,
	"genres_id" INTEGER
);

--entity "Вид переплета" as bindings
create table "library"."bindings"(
    "id" SERIAL,
    "type" VARCHAR(10)
);

--authors "Авторы"
create table "library"."authors"(
    "id" SERIAL,
    "fio" VARCHAR(50),
    "country" VARCHAR(30)
);

--barcodes "Штрихкоды"
create table"library"."barcodes"(
    "id" SERIAL,
    "value" INTEGER,
    "repository_id" INTEGER
);

--bibliography "Библиография"
create table "library"."bibliography"(
    repository_id INTEGER,
    authors_id INTEGER
);

--genres "Жанры"
create table "library"."genres"(
    "id" SERIAL,
    "value" VARCHAR(30)
);

--publishers "Издательства"
create table "library"."publishers"(
  "id" SERIAL,
  "name" VARCHAR(50),
  "address" VARCHAR(300),
  "phone" INTEGER,
  "contactname" VARCHAR(150)
);

--accounts "Карточка читателя"
create table "library"."accounts"(
    "id" SERIAL,
    "fname" VARCHAR(50),
    "sname" VARCHAR(50),
    "lname" VARCHAR(50),
    "address" VARCHAR(300),
    "phone" INTEGER,
    "pasport_id" INTEGER,
    "sertificate_id" INTEGER,
    "account_id" INTEGER
);

--pasports "Паспорт"
create table "library"."pasports"(
    "id" SERIAL,
    "serial" INTEGER,
    "number" INTEGER
);

--certificates "Свидетельство о рождении"
create table "library"."certificates"(
    "id" SERIAL,
    "serial" VARCHAR(10),
    "number" INTEGER
);

--allocation "Выдача книг"
create table "library"."allocation"(
    "id" SERIAL,
    "account_id" INTEGER,
    "book_out" DATE,
    "book_in" DATE,
    "book_in_fact" DATE,
    "penalty" MONEY,
    "late" INTEGER,
    "barcode_id" INTEGER
);

--booking "Бронирование"
create table "library"."booking"(
    "id" SERIAL,
    "accounts_id" INTEGER,
    "repository_id" INTEGER,
    "date" DATE
);

