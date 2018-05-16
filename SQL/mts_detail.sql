CREATE TABLE mts_detail
(
  mts_detail_id bigserial NOT NULL,
  mts_period bigint not null,
  mts_number_id bigint NOT NULL, -- Телефонный номер
  service_date timestamp without time zone NOT NULL, -- Время оказания услуги
  destination character varying(100),
  operator_name character varying(100), -- Название мобильного оператора
  operator_division character varying(100), -- Название регионального подразделения мобильного оператора
  service_type character varying(16), -- Тип услуги
  --a character(1), -- Какая-та шняга
  amount character varying, -- Количество оказанной услуги, зависит от service_type
  cost numeric(10,4),
  specified_amount character varying, -- Приведенное количество оказанной услуги в соответствии с тарифом. Зависит от service_type
  specified_cost numeric(10,4), -- Приведенная стоимость услуги в соответствии с тарифом
  --period timestamp without time zone NOT NULL,
  is_in smallint, -- Входящий звонок
  CONSTRAINT mts_details_pkey PRIMARY KEY (mts_detail_id),
  CONSTRAINT "mts_details > mts_number" FOREIGN KEY (mts_number_id) REFERENCES mts_number (mts_number_id) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT "mts_details > mts_period" FOREIGN KEY (mts_period) REFERENCES mts_period (mts_period_id) ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT mts_detail_cost_chk CHECK (cost >= 0::numeric),
  CONSTRAINT mts_detail_is_in_chk CHECK (is_in = ANY (ARRAY[0, 1])),
  CONSTRAINT mts_detail_specified_cost_chk CHECK (specified_cost >= 0::numeric)
)
WITH (
OIDS=FALSE
);
ALTER TABLE mts_detail
  OWNER TO postgres;
GRANT ALL ON TABLE mts_detail TO postgres;
GRANT ALL ON TABLE mts_detail TO public;
COMMENT ON COLUMN mts_detail.mts_detail_id IS 'Идентификатор';
COMMENT ON COLUMN mts_detail.mts_period IS 'Период';
COMMENT ON COLUMN mts_detail.mts_number_id IS 'Тел. номер';
COMMENT ON COLUMN mts_detail.service_date IS 'Дата услуги';
COMMENT ON COLUMN mts_detail.destination IS 'Номер второго абонента';
COMMENT ON COLUMN mts_detail.operator_name IS 'Название мобильного оператора';
COMMENT ON COLUMN mts_detail.operator_division IS 'Название регионального подразделения мобильного оператора';
COMMENT ON COLUMN mts_detail.service_type IS 'Тип услуги';
--COMMENT ON COLUMN mts_detail.a IS 'Какая-та шняга';
COMMENT ON COLUMN mts_detail.amount IS 'Количество оказанной услуги, зависит от service_type';
COMMENT ON COLUMN mts_detail.specified_amount IS 'Приведенное количество оказанной услуги в соответствии с тарифом. Зависит от service_type';
COMMENT ON COLUMN mts_detail.specified_cost IS 'Приведенная стоимость услуги в соответствии с тарифом';
COMMENT ON COLUMN mts_detail.is_in IS 'Входящий звонок';

CREATE INDEX mts_detail_destination_idx ON mts_detail (destination COLLATE pg_catalog."default");
CREATE INDEX mts_detail_idx ON mts_detail USING btree (mts_detail_id);
CREATE INDEX mts_detail_is_in_idx ON mts_detail USING btree (is_in);
CREATE INDEX mts_detail_mobile_operator_division_idx ON mts_detail USING btree (operator_division COLLATE pg_catalog."default");
CREATE INDEX mts_detail_mobile_operator_name_idx ON mts_detail USING btree (operator_name COLLATE pg_catalog."default");
CREATE INDEX mts_detail_mobile_phone_number_id_idx ON mts_detail USING btree (mts_number_id);
CREATE INDEX mts_detail_period_idx ON mts_detail USING btree (mts_period);
CREATE INDEX mts_detail_service_date_idx ON mts_detail USING btree (service_date);
CREATE INDEX mts_detail_service_type_idx ON mts_detail USING btree (service_type COLLATE pg_catalog."default");
CREATE INDEX mts_detail_specified_amount_idx ON mts_detail USING btree (specified_amount COLLATE pg_catalog."default");
CREATE INDEX mts_detail_specified_cost_idx ON mts_detail USING btree (specified_cost);