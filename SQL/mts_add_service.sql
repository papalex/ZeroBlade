
/*Статистика дополнительных услуг - mts_add_service

	В таблице содержится информация о подключении дополнительных услуг, в таблице имеются следующие поля:
mts_add_service_id - bigserial - Идентификатор
mts_period_id - bigint - Период - ключ на mts_period, not null, cascade update delete
mts_number_id - bigint - Номер - ключ на mts_number, not null, cascade update
name - varchar(127) - Услуга - not null
service_date - timestamp without time zone - Дата списания - not null
cost - numeric(12,2) - Стоимость - >=0, not null

*/
CREATE TABLE mts_add_service
(
  mts_add_service_id bigserial PRIMARY KEY NOT NULL,  
  mts_period_id bigint not null,
  mts_number_id bigint not null,
  name character varying(127) not null,
  service_date timestamp without time zone not null,
  cost numeric(12,2), -- Общая сумма счета к оплате
  CONSTRAINT "mts_period_file > mts_period" FOREIGN KEY (mts_period_id) REFERENCES mts_period (mts_period_id) ON UPDATE CASCADE ON DELETE CASCADE ,
  CONSTRAINT "mts_aggregate > mts_number" FOREIGN KEY (mts_number_id) REFERENCES "mts_number" (mts_number_id) ON UPDATE CASCADE ON DELETE NO ACTION,  
  --CONSTRAINT mts_period_file_uni UNIQUE (period, mobile_phone_krp_company_account_id),
  CONSTRAINT mts_period_file_amount_chk CHECK (amount >= 0::numeric)
  
)
WITH (
OIDS=FALSE
);
ALTER TABLE mts_add_service
  OWNER TO postgres;
GRANT ALL ON TABLE mts_add_service TO postgres;
GRANT ALL ON TABLE mts_add_service TO public;
COMMENT ON TABLE mts_add_service IS 'Статистика дополнительных услуг ';
COMMENT ON COLUMN mts_add_service.mts_period_id IS 'Отчетный период';
COMMENT ON COLUMN mts_add_service.cost IS 'Общая сумма счета к оплате';
COMMENT ON COLUMN mts_add_service.mts_number_id IS 'Тел. Номер';
COMMENT ON COLUMN mts_add_service.name IS 'Услуга';


CREATE INDEX mts_add_service_service_dateidx ON mts_add_service (service_date);
CREATE INDEX mts_add_service_mts_number_idx ON mts_add_service (mts_number_id);
CREATE INDEX mts_add_service_name_idx ON mts_add_service USING btree (name);
CREATE INDEX mts_add_service_period_idx ON mts_add_service USING btree (mts_period_id);





