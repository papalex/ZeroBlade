CREATE TABLE public.mts_number_mts_period
(
  mts_number_mts_period_id bigserial PRIMARY KEY not null,
  mts_number_id bigint not null,
  mts_period_id bigint not null,
  amount numeric(10,2) not null,
  CONSTRAINT mts_number_period_amount_chk CHECK (amount > 0),
  CONSTRAINT "mts_numberpriod > mts_period" FOREIGN KEY (mts_period_id) REFERENCES "mts_period" (mts_period_id) ON UPDATE CASCADE ON DELETE CASCADE ,
  CONSTRAINT "mts_numberpriod > mts_number" FOREIGN KEY (mts_number_id) REFERENCES "mts_number" (mts_number_id) ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE INDEX "mts_number_mts_period_periodidx" ON public."mts_number_mts_period" (mts_period_id);
CREATE INDEX "mts_number_mts_period_numberidx" ON public."mts_number_mts_period" (mts_number_id);
COMMENT ON COLUMN public.mts_number_mts_period.mts_number_mts_period_id IS 'Идентификатор';
COMMENT ON COLUMN public.mts_number_mts_period.mts_period_id IS 'Период';
COMMENT ON COLUMN public.mts_number_mts_period.mts_number_id IS 'Номер';
COMMENT ON COLUMN public.mts_number_mts_period.amount IS 'Сумма';
COMMENT ON TABLE public.mts_number_mts_period IS 'Дополнительные ежемесячные компенсации MTS';
