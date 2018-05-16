
/*В данной таблице хранятся файлы с выставленными счетами в pdf, таблица имеет следующие поля:
mts_period_file_id - bigserial - Идентификатор
krp_company - varchar(64) - Юрлицо КРП, ключ на krp_company, not null, cascade update
  mts_period_id - bigint - Период, ключ на mts_period, not null, cascade delete update
files_id - bigserial - Файл - ключ на files, not null, cascade update
  user_id - integer - Прикрепивший, ключ на user, not null, cascade update
create_date - timestamp without time zone - Дата создания, значение по умолчанию now(), not null
amount - numeric(10, 2) - сумма счета, >=0, not null
is_approve - smallint - Утвержден, значение по умолчанию 0, допустимые значения 0, 1, not null
*/
CREATE TABLE mts_period_files
(
  mts_period_file_id bigserial NOT NULL,
  --period timestamp without time zone NOT NULL, -- Отчетный период
  mts_period_id bigint not null,
  --filename character varying(255) NOT NULL, -- Название файла
  files_id  bigserial not null,
  krp_company character varying(12) NOT NULL,
  --mobile_phone_krp_company_account_id bigint NOT NULL,
  is_approve smallint NOT NULL DEFAULT 0,
  --account_number character varying, -- Номер счета
  amount numeric(10,2), -- Общая сумма счета к оплате
  create_date timestamp without time zone default now() not null,
  user_id integer not null,

  CONSTRAINT mts_period_files_pkey PRIMARY KEY (mts_period_file_id),
  CONSTRAINT "mts_period_file > krp_company" FOREIGN KEY (krp_company) REFERENCES krp_company (krp_company) ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "mts_period_file > mts_period" FOREIGN KEY (mts_period_id) REFERENCES mts_period (mts_period_id) ON UPDATE CASCADE ON DELETE CASCADE ,
  CONSTRAINT "mts_period_file > files" FOREIGN KEY (files_id) REFERENCES files (files_id) ON UPDATE CASCADE ON DELETE NO ACTION ,
  CONSTRAINT "mts_period_file > user" FOREIGN KEY (user_id) REFERENCES "user" (user_id) ON UPDATE CASCADE ON DELETE NO ACTION ,
  --CONSTRAINT mts_period_file_uni UNIQUE (period, mobile_phone_krp_company_account_id),
  CONSTRAINT mts_period_file_amount_chk CHECK (amount >= 0::numeric),
  CONSTRAINT mts_period_file_is_approve_chk CHECK (is_approve = ANY (ARRAY[0, 1]))
)
WITH (
OIDS=FALSE
);
ALTER TABLE mts_period_files
  OWNER TO postgres;
GRANT ALL ON TABLE mts_period_files TO postgres;
GRANT ALL ON TABLE mts_period_files TO public;
COMMENT ON TABLE mts_period_files IS 'Разобранные документы полученные от мобильных операторов';
COMMENT ON COLUMN mts_period_files.mts_period_id IS 'Отчетный период';
COMMENT ON COLUMN mts_period_files.files_id IS 'Название файла';
COMMENT ON COLUMN mts_period_files.krp_company IS 'Юрлицо КРП';
COMMENT ON COLUMN mts_period_files.amount IS 'Общая сумма счета к оплате';

CREATE INDEX "fki_mts_period_files > krp_company" ON mts_period_files USING btree (krp_company);
CREATE INDEX mts_period_files_fileidx ON mts_period_files (files_id);
CREATE INDEX mts_period_files_is_approve_idx ON mts_period_files USING btree (is_approve);
CREATE INDEX mts_period_files_period_idx ON mts_period_files USING btree (mts_period_id);





