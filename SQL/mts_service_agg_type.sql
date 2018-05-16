CREATE TABLE mts_service_agg_type
(
  mts_service_agg_type character varying(64) NOT NULL,
  name character varying(255), -- Название
  CONSTRAINT mobile_service_agg_type_pkey PRIMARY KEY (mts_service_agg_type),
  CONSTRAINT mobile_service_agg_type_uni UNIQUE (name)
)
WITH (
OIDS=FALSE
);
ALTER TABLE mobile_service_agg_type
  OWNER TO postgres;
GRANT ALL ON TABLE mobile_service_agg_type TO postgres;
GRANT ALL ON TABLE mobile_service_agg_type TO public;
COMMENT ON TABLE mobile_service_agg_type
IS 'тип аггрегированной услуги';
COMMENT ON COLUMN mobile_service_agg_type.name IS 'Название';