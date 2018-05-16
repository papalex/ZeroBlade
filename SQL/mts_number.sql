CREATE TABLE public.mts_number
(
  mts_number_id bigserial PRIMARY KEY not null,
  mts_person_account_id bigint not null,
  number character varying(12) NOT NULL,
  user_id int NOT NULL,
  mts_tariff_plan character varying(64) NOT NULL,
  limitamount numeric(10,2) default 0,
  is_active smallint default 1,
  active_date date,
  user__id int NOT NULL,
  CONSTRAINT mts_number_number_check check (number ~ '^\d{1,11}$'),
  CONSTRAINT mts_number_is_active_chk CHECK (is_active = ANY (ARRAY[0, 1])),
  CONSTRAINT mts_number_limit_chk CHECK (limitamount >= 0),--назвал поле "суммалимита" что бы не использовать limit
  CONSTRAINT "mts_number > user" FOREIGN KEY (user_id) REFERENCES "user" (user_id),
  CONSTRAINT "mts_number > user (createdby)" FOREIGN KEY (user__id) REFERENCES "user" (user_id),
  CONSTRAINT "mts_number > mts_tariff_plan" FOREIGN KEY (mts_tariff_plan) REFERENCES "mts_tariff_plan" (mts_tariff_plan) ON UPDATE CASCADE ON DELETE NO ACTION,

  CONSTRAINT "mts_number > mts_person_account" FOREIGN KEY (mts_person_account_id)
  REFERENCES "mts_person_account" (mts_person_account_id)ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE INDEX "mts_number_person_account_idx" ON public."mts_number" (mts_person_account_id);
CREATE INDEX "mts_number_createdbyidx" ON public."mts_number" (user__id);
CREATE INDEX "mts_number_userididx" ON public."mts_number" (user_id);
CREATE INDEX "mts_number_numberidx" ON public."mts_number" (number);
CREATE INDEX "mts_number_tariffidx" ON public."mts_number" (mts_tariff_plan);
CREATE INDEX "mts_number_activedateidx" ON public."mts_number" (active_date);
CREATE INDEX "mts_number_activeidx" ON public."mts_number" (is_active);

COMMENT ON COLUMN public.mts_number.mts_number_id IS 'Идентификатор';
COMMENT ON COLUMN public.mts_number.mts_person_account_id IS 'Лицевой счет';
COMMENT ON COLUMN public.mts_number.number IS 'Тел. Номер';
COMMENT ON COLUMN public.mts_number.user_id IS 'Пользователь';
COMMENT ON COLUMN public.mts_number.mts_tariff_plan IS 'Тарифный план';
COMMENT ON COLUMN public.mts_number.limitamount IS 'Дополнительный лимит';
COMMENT ON COLUMN public.mts_number.is_active IS 'Активен';
COMMENT ON COLUMN public.mts_number.user__id IS 'Автор';
COMMENT ON COLUMN public.mts_number.active_date IS 'Дата передачи';
COMMENT ON TABLE public.mts_number IS 'Лицевые счета MTS';

create table "mts_number_R"
(
  revision_id bigserial    not null
    constraint "mts_number_R_pkey"
    primary key,
  mts_number_id bigint not null,
  mts_person_account_id bigint not null,
  number character varying(12) NOT NULL,
  user_id int NOT NULL,
  mts_tariff_plan character varying(64) NOT NULL,
  limitamount numeric(10,2) default 0,
  is_active smallint default 0,
  active_date date,
  user__id int NOT NULL
);
CREATE INDEX "mts_number_R_person_account_idx" ON public."mts_number_R" (mts_person_account_id);
CREATE INDEX "mts_number_R_createdbyidx" ON public."mts_number_R" (user__id);
CREATE INDEX "mts_number_R_userididx" ON public."mts_number_R" (user_id);
CREATE INDEX "mts_number_R_numberidx" ON public."mts_number_R" (number);
CREATE INDEX "mts_number_R_tariffidx" ON public."mts_number_R" (mts_tariff_plan);
CREATE INDEX "mts_number_R_activedateidx" ON public."mts_number_R" (active_date);
CREATE INDEX "mts_number_R_activeidx" ON public."mts_number_R" (is_active);


create table "mts_number_H"
(
  history_id  bigserial               not null
    constraint "mts_number_H_pkey"
    primary key,
  create_date timestamp default now() not null,
  revision_id bigint,
  id bigint
);

comment on table "mts_number_H"
is 'История изменения номеров MTS';

comment on column "mts_number_H".history_id
is 'Идентификатор';

comment on column "mts_number_H".create_date
is 'Дата создания ревизии';

comment on column "mts_number_H".revision_id
is 'Идентификатор ревизии';

create index "mts_number_H_create_date_idx"
  on "mts_number_H" (create_date);

create index "mts_numbert_H_revision_id_idx"
  on "mts_number_H" (revision_id);

CREATE OR REPLACE function tf_mts_number_ins()
  returns trigger
language plpgsql
as $$
declare
  o integer;
  n varchar;
BEGIN
  execute 'insert into "' || TG_TABLE_NAME || '_H" (id) values ($1.' || TG_TABLE_NAME || '_id)' using NEW;
  if (NEW.is_active = 1) then
    update mts_number set is_active=0 , user__id  = NEW.user__id where mts_number_id <> NEW.mts_number_id and is_active =1 and number = NEW.number;-- using NEW;
  end if;
  return NEW;
END;
$$;
ALTER FUNCTION tf_mts_number_ins()
OWNER TO postgres;
GRANT EXECUTE ON FUNCTION tf_mts_number_ins() TO postgres;
GRANT EXECUTE ON FUNCTION tf_mts_number_ins() TO public;

create trigger tf_mts_number_ins_a
  after insert
  on mts_number
  for each row
execute procedure tf_mts_number_ins();
create trigger tf_mts_number_upd_a
  after update
  on mts_number
  for each row
execute procedure tf_upd();
create trigger tf_mts_number_del_a
  after delete
  on mts_number
  for each row
execute procedure tf_del();




