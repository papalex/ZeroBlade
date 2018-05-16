CREATE TABLE public.mts_period
(
  mts_period_id bigserial PRIMARY KEY not null,
  period date not null
);
CREATE INDEX "mts_periodidx" ON public."mts_period" (period);
COMMENT ON COLUMN public.mts_period.mts_period_id IS 'Идентификатор';
COMMENT ON COLUMN public.mts_period.period IS 'Период';
COMMENT ON TABLE public.mts_period IS 'Периоды MTS';
