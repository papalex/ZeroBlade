CREATE TABLE public.mts_tariff_plan
(
  mts_tariff_plan character varying(64) PRIMARY KEY NOT NULL,
  name character varying(255) NOT NULL,
  description text,
  amount numeric(12,2) NOT NULL,
  is_visible smallint DEFAULT 0 NOT NULL,
  user__id int NOT NULL,
  CONSTRAINT "mts_tariff_plan > user" FOREIGN KEY (user__id) REFERENCES "user" (user_id),
  CONSTRAINT mts_tariff_plan_is_visible_chk CHECK (is_visible = ANY (ARRAY[0, 1])),
  CONSTRAINT mts_tariff_plan_amount_chk CHECK (amount >0)
);
CREATE INDEX mts_tariff_plan_nameidx ON public.mts_tariff_plan (name);
CREATE INDEX mts_tariff_plan_userididx ON public.mts_tariff_plan (user__id);
CREATE INDEX mts_tariff_plan_visibleidx ON public.mts_tariff_plan (is_visible);
COMMENT ON COLUMN public.mts_tariff_plan.mts_tariff_plan IS 'Тарифный план';
COMMENT ON COLUMN public.mts_tariff_plan.name IS 'Название';
COMMENT ON COLUMN public.mts_tariff_plan.description IS 'Описание';
COMMENT ON COLUMN public.mts_tariff_plan.amount IS 'Стоимость';
COMMENT ON COLUMN public.mts_tariff_plan.is_visible IS 'Видимость';
COMMENT ON COLUMN public.mts_tariff_plan.user__id IS 'Автор';
COMMENT ON TABLE public.mts_tariff_plan IS 'Тарифные планы сотового оператора';


create table "mts_tariff_plan_R"
(
  revision_id bigserial    not null
    constraint "mts_tariff_plan_R_pkey"
    primary key,
  mts_tariff_plan varchar(64)        not null,
  name            varchar(255)       not null,
  description     text,
  amount          numeric(12, 2)     not null,
  is_visible      smallint default 0 not null,
  user__id        integer            not null
);
create table "mts_tariff_plan_H"
(
  history_id  bigserial               not null
    constraint "mts_tariff_plan_H_pkey"
    primary key,
  create_date timestamp default now() not null,
  revision_id bigint,
  id character varying(64)
);

comment on table "mts_tariff_plan_H"
is 'История тарифных планов';

comment on column "mts_tariff_plan_H".history_id
is 'Идентификатор';

comment on column "mts_tariff_plan_H".create_date
is 'Дата создания ревизии';

comment on column "mts_tariff_plan_H".revision_id
is 'Идентификатор ревизии';

create index "mts_tariff_plan_H_create_date_id"
  on "mts_tariff_plan_H" (create_date);

create index "mts_tariff_plan_H_revision_id_idx"
  on "mts_tariff_plan_H" (revision_id);

create index "mts_tariff_plan_R_nameidx"
  on "mts_tariff_plan_R" (name);

create index "mts_tariff_plan_R_userididx"
  on "mts_tariff_plan_R" (user__id);

create index "mts_tariff_plan_R_visibleidx"
  on "mts_tariff_plan_R" (is_visible);


CREATE OR REPLACE FUNCTION tf_mts_tariff_plan_ins()
  RETURNS trigger AS
$BODY$
BEGIN
  insert into "mts_tariff_plan_H" (id) values (NEW.mts_tariff_plan);
  return NEW;
END;$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
ALTER FUNCTION tf_mts_tariff_plan_ins()
OWNER TO postgres;
GRANT EXECUTE ON FUNCTION tf_mts_tariff_plan_ins() TO postgres;
GRANT EXECUTE ON FUNCTION tf_mts_tariff_plan_ins() TO public;

create trigger tf_mts_tariff_plan_ins
  after insert
  on mts_tariff_plan
  for each row
execute procedure tf_mts_tariff_plan_ins();

create  OR REPLACE function tf_mts_tariff_plan_upd()
  returns trigger
language plpgsql
as $$
declare
  ins_id bigint;
BEGIN
  -- Копир старую ревизию
  insert into "mts_tariff_plan_R" (mts_tariff_plan, name, description, amount, is_visible, user__id)
  values (OLD.mts_tariff_plan,  OLD.name, OLD.description, OLD.amount, OLD.is_visible, OLD.user__id)
  returning revision_id into ins_id;
  -- Запоминаем номер сделанной ревизии в таблице истории
  update "mts_tariff_plan_H" set revision_id=ins_id where id=OLD.mts_tariff_plan and revision_id is null;
  -- Создаем новую запись в таблице истории
  insert into "mts_tariff_plan_H" (id) values (NEW.mts_tariff_plan);
  return NEW;
END;
$$
COST 100;
ALTER FUNCTION tf_mts_tariff_plan_upd()
OWNER TO postgres;
GRANT EXECUTE ON FUNCTION tf_mts_tariff_plan_upd() TO postgres;
GRANT EXECUTE ON FUNCTION tf_mts_tariff_plan_upd() TO public;
create trigger tf_mts_tariff_plan_upd
  after update
  on mts_tariff_plan
  for each row
execute procedure tf_mts_tariff_plan_upd();


CREATE OR REPLACE FUNCTION tf_mts_tariff_plan_del()
  RETURNS trigger AS
$BODY$
declare
  ins_id bigint;
BEGIN
  -- Копир старую ревизию
  insert into "mts_tariff_plan_R" (mts_tariff_plan, name, description, amount, is_visible, user__id)
  values (OLD.mts_tariff_plan,  OLD.name, OLD.description, OLD.amount, OLD.is_visible, OLD.user__id)
  returning revision_id into ins_id;
  -- Запоминаем номер сделанной ревизии в таблице истории
  update "mts_tariff_plan_H" set revision_id=ins_id where id=OLD.mts_tariff_plan and revision_id is null;
  insert into "mts_tariff_plan_H" (id) values (OLD.mts_tariff_plan);
  return OLD;
END;$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
ALTER FUNCTION tf_mts_tariff_plan_del()
OWNER TO postgres;
GRANT EXECUTE ON FUNCTION tf_mts_tariff_plan_del() TO postgres;
GRANT EXECUTE ON FUNCTION tf_mts_tariff_plan_del() TO public;
create trigger tf_mts_tariff_plan_del
  after delete
  on mts_tariff_plan
  for each row
execute procedure tf_mts_tariff_plan_del();