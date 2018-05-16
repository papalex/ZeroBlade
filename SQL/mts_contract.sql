CREATE TABLE public.mts_contract
(
  mts_contract_id bigserial PRIMARY KEY not null,
  krp_company character varying(64) NOT NULL,
  region character varying(64) NOT NULL,
  number character varying(12) NOT NULL,
  user__id int NOT NULL,
  CONSTRAINT mts_contract_number_check check (number ~ '^\d{1,11}$'),
  CONSTRAINT "mts_contract > user" FOREIGN KEY (user__id) REFERENCES "user" (user_id),
  CONSTRAINT "mts_contract > krp_company" FOREIGN KEY (krp_company)
  REFERENCES "krp_company" (krp_company)ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE INDEX mts_contract_krpcompanyidx ON public.mts_contract (krp_company);
CREATE INDEX mts_contract_userididx ON public.mts_contract (user__id);
CREATE INDEX mts_contract_numberidx ON public.mts_contract (number);
CREATE INDEX mts_contract_regionidx ON public.mts_contract (region);
COMMENT ON COLUMN public.mts_contract.mts_contract_id IS 'Идентификатор';
COMMENT ON COLUMN public.mts_contract.number IS 'Тел. Номер';
COMMENT ON COLUMN public.mts_contract.krp_company IS 'Юрлицо КРП';
COMMENT ON COLUMN public.mts_contract.region IS 'Регион';
COMMENT ON COLUMN public.mts_contract.user__id IS 'Автор';
COMMENT ON TABLE public.mts_contract IS 'Контракты MTS';



create table "mts_contract_R"
(
  revision_id bigserial    not null
    constraint "mts_contract_R_pkey"
    primary key,
  mts_contract_id bigint not null,
  krp_company character varying(64) NOT NULL,
  region character varying(64) NOT NULL,
  number character varying(12) NOT NULL,
  user__id int NOT NULL
);
CREATE INDEX "mts_contract_R_krpcompanyidx" ON "public"."mts_contract_R" (krp_company);
CREATE INDEX "mts_contract_R_userididx" ON "public"."mts_contract_R" (user__id);
CREATE INDEX "mts_contract_R_numberidx" ON "public"."mts_contract_R" (number);
CREATE INDEX "mts_contract_R_regionidx" ON "public"."mts_contract_R" (region);


create table "mts_contract_H"
(
  history_id  bigserial               not null
    constraint "mts_contract_H_pkey"
    primary key,
  create_date timestamp default now() not null,
  revision_id bigint,
  id bigint
);
------ here
comment on table "mts_contract_H"
is 'История контрактов MTS';

comment on column "mts_contract_H".history_id
is 'Идентификатор';

comment on column "mts_contract_H".create_date
is 'Дата создания ревизии';

comment on column "mts_contract_H".revision_id
is 'Идентификатор ревизии';

create index "mts_contract_H_create_date_idx"
  on "mts_contract_H" (create_date);

create index "mts_contract_H_revision_id_idx"
  on "mts_contract_H" (revision_id);

create trigger tf_mts_contract_ins
  after insert
  on mts_contract
  for each row
execute procedure tf_ins();
create trigger tf_mts_contract_upd
  after update
  on mts_contract
  for each row
execute procedure tf_upd();
create trigger tf_mts_contract_del
  after delete
  on mts_contract
  for each row
execute procedure tf_del();