-- Скрипт добавления ограничений к таблицам

--entity "Библиотечный фонд" as repository
	-- PK
	alter table "library"."repository"
		add constraint pk_repository_id primary key(id);
	
	--Если pk INTEGER, тогда добавляем автогенерацию
	--(в нашем случае тип pk выбран SERIAL)
	--alter table "library"."repository"
	--	alter column "id" add generated always as identity;
	--удаление ограничений
	--	alter table "library"."repository"
	--		drop constraint pk_id;
	-- FK
	alter table "library"."repository"
		add constraint fk_bindings_id
			foreign key("bindings_id")
				references "library"."bindings" ("id"),
		add constraint fk_publishers_id
			foreign key("publishers_id")
				references "library"."publishers" ("id"),
		add constraint fk_genres_id
			foreign key("genres_id")
				references "library"."genres" ("id");
	--Удаление ограничения
		--	alter table "library"."repository"
		--		drop constraint fk_bindings_id;
	-- not null
	alter table "library"."repository"
		alter column "title" set not null,
		alter column "isbn" set not null;
	-- null
	
	-- unique
	alter table "library"."repository"
		add constraint unique_repository_isbn
			unique("isbn");
	
	-- Ограничения CHECK
	alter table "library"."repository"
		add constraint ck_repository_year
			check ("year"::date < now()),
		add constraint ck_repository_instances
			check ("instances" >= 0);

--entity "Вид переплета" as bindings
	--PK
	alter table "library"."bindings"
		add constraint pk_bindings_id primary key(id);
	--FK
	-- not null
	alter table "library"."bindings"
		alter column "type" set not null;
	--unique
	alter table "library"."bindings"
		add constraint unique_bindings_type
			unique("type");
	--CHECK
	alter table "library"."bindings"
		add constraint ck_bindings_type
			check ("type" in ('жесткий', 'мягкий'));
	
--entity "Авторы" as authors
	-- добавляем PK
	alter table "library"."authors"
		add constraint pk_authors_id primary key(id);
	-- not null
	alter table "library"."authors"
		alter column "fio" set not null;
	
--entity "Штрихкоды" as barcodes
	-- добавляем PK
	alter table "library"."barcodes"
		add constraint pk_barcodes_id primary key(id);
	-- not null
	alter table "library"."barcodes"
		alter column "value" set not null;
	alter table "library"."barcodes"
		alter column "repository_id" set not null;
	--unique
	alter table "library"."barcodes"
		add constraint unique_barcodes_value
			unique("value");
	-- FK
	alter table "library"."barcodes"
		add constraint fk_barcodes_repository_id
			foreign key("repository_id")
				references "library"."repository" ("id");
	
--entity "Библиография" as bibliography
	--PK не предусмотрен
	-- not null
	alter table "library"."bibliography"
		alter column "repository_id" set not null,
		alter column "authors_id" set not null;
	-- FK
	alter table "library"."bibliography"
		add constraint fk_bibliography_repository_id
			foreign key("repository_id")
				references "library"."repository" ("id"),
		add constraint fk_bibliography_authors_id
			foreign key("authors_id")
				references "library"."authors" ("id");
	
--entity "Жанры" as genres
	-- добавляем PK
	alter table "library"."genres"
		add constraint pk_genres_id primary key(id);
	-- not null
	alter table "library"."genres"
		alter column "value" set not null;
	--unique
	alter table "library"."genres"
		add constraint unique_genres_value
			unique("value");
	
--entity "Издательства" as publishers
	-- добавляем PK
	alter table "library"."publishers"
		add constraint pk_publishers_id primary key(id);
	-- not null
	alter table "library"."publishers"
		alter column "name" set not null;
	--unique
	alter table "library"."publishers"
		add constraint unique_publishers_name
			unique("name");
	
--entity "Карточка читателя" as accounts
	-- PK
	alter table "library"."accounts"
		add constraint pk_accounts_id primary key(id);
	
	-- FK
	alter table "library"."accounts"
		add constraint fk_pasport_id
			foreign key("pasport_id")
				references "library"."pasports" ("id");
	alter table "library"."accounts"
		add constraint fk_sertificate_id
			foreign key("sertificate_id")
				references "library"."certificates" ("id");
				-- напутал название certificates/sertificate
--entity "Паспорт" as pasports
	-- добавляем PK
	alter table "library"."pasports"
		add constraint pk_pasports_id primary key(id);
	--CHECK
	--количество цифр в поле
	
--entity "Свидетельство о рождении" as certificates
	-- добавляем PK
	alter table "library"."certificates"
		add constraint pk_certificates_id primary key(id);
	--CHECK
	--количество символов в поле
	--количество цифр в поле
--entity "Выдача книг" as allocation
	-- добавляем PK
	alter table "library"."allocation"
		add constraint pk_allocation_id primary key(id);
	-- null
	-- not null
	alter table "library"."allocation"
		alter column "barcode_id" set not null;
	-- FK
	alter table "library"."allocation"
		add constraint fk_barcodes_id
			foreign key("barcode_id")
				references "library"."barcodes" ("id");
	--CHECK
	alter table "library"."allocation"
		add constraint ck_allocation_penalty
			check ("penalty" >= 0::money or null),
		add constraint ck_allocation_late
			check ("late" >= 0 or null);
	
--entity "Бронирование" as booking
	-- PK
	alter table "library"."booking"
		add constraint pk_booking_id primary key(id);
	-- FK
	alter table "library"."booking"
		add constraint fk_booking_repository_id
			foreign key("repository_id")
				references "library"."repository" ("id");
	--not null
	alter table "library"."booking"
		alter column "repository_id" set not null;
	-- DEFAULT
	alter table "library"."booking"
		alter column "date"
			set default current_date;