


CREATE TABLE public.mts_aggregate
(
  mts_aggregate_id bigserial PRIMARY KEY not null,
  mts_number_id bigint not null,
  mts_period_id bigint not null,
  mts_service_agg_type character varying(64) NOT NULL,
  cost numeric(12,2) not null,
  CONSTRAINT mts_aggregate_amount_chk CHECK (amount >= 0),
  CONSTRAINT "mts_aggregate > mts_period" FOREIGN KEY (mts_period_id) REFERENCES "mts_period" (mts_period_id) ON UPDATE CASCADE ON DELETE CASCADE ,
  CONSTRAINT "mts_aggregate > mts_number" FOREIGN KEY (mts_number_id) REFERENCES "mts_number" (mts_number_id) ON UPDATE CASCADE ON DELETE NO ACTION,
  CONSTRAINT "mts_aggregate > mts_service_agg_type" FOREIGN KEY (mts_service_agg_type)
  REFERENCES mts_service_agg_type (mts_service_agg_type) ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE INDEX "mts_aggregate_periodidx" ON public."mts_aggregate" (mts_period_id);
CREATE INDEX "mmts_aggregate_numberidx" ON public."mts_aggregate" (mts_number_id);
CREATE INDEX "mts_aggregate_service_agg_typeidx" ON public."mts_aggregate" (mts_service_agg_type);
COMMENT ON COLUMN public.mts_aggregate.mts_aggregate_id IS 'Идентификатор';
COMMENT ON COLUMN public.mts_aggregate.mts_period_id IS 'Период';
COMMENT ON COLUMN public.mts_aggregate.mts_number_id IS 'Номер';
COMMENT ON COLUMN public.mts_aggregate.cost IS 'Сумма';
COMMENT ON COLUMN public.mts_aggregate.mts_service_agg_type IS 'Тип услуги';
COMMENT ON TABLE public.mts_aggregate IS 'Статистика дополнительных услуг MTS';
