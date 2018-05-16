CREATE TABLE public.mts_person_account
(
  mts_person_account_id bigserial PRIMARY KEY not null,
  mts_contract_id bigint not null,
  number character varying(12) NOT NULL,
  user__id int NOT NULL,
  CONSTRAINT mts_person_account_check check (number ~ '^\d{1,11}$'),
  CONSTRAINT "mts_person_account > user" FOREIGN KEY (user__id) REFERENCES "user" (user_id),
  CONSTRAINT "mts_person_account > mts_contract" FOREIGN KEY (mts_contract_id)
  REFERENCES "mts_contract" (mts_contract_id)ON UPDATE CASCADE ON DELETE NO ACTION
);
CREATE INDEX "mts_person_account_contractidx" ON public."mts_person_account" (mts_contract_id);
CREATE INDEX "mts_person_account_userididx" ON public."mts_person_account" (user__id);
CREATE INDEX "mts_person_account_numberidx" ON public."mts_person_account" (number);
COMMENT ON COLUMN public.mts_person_account.mts_person_account_id IS 'Идентификатор';
COMMENT ON COLUMN public.mts_person_account.number IS 'Тел. Номер';
COMMENT ON COLUMN public.mts_person_account.user__id IS 'Автор';
COMMENT ON TABLE public.mts_person_account IS 'Лицевые счета MTS';

create table "mts_person_account_R"
(
  revision_id bigserial    not null
    constraint "mts_person_account_R_pkey"
    primary key,
  mts_person_account_id bigint not null,
  mts_contract_id bigint not null,
  number character varying(12) NOT NULL,
  user__id int NOT NULL
);
CREATE INDEX "mts_person_account_R_contractidx" ON public."mts_person_account_R" (mts_contract_id);
CREATE INDEX "mts_person_account_R_userididx" ON public."mts_person_account_R" (user__id);
CREATE INDEX "mts_person_account_R_numberidx" ON public."mts_person_account_R" (number);


create table "mts_person_account_H"
(
  history_id  bigserial               not null
    constraint "mts_person_account_H_pkey"
    primary key,
  create_date timestamp default now() not null,
  revision_id bigint,
  id bigint
);
------ here
comment on table "mts_person_account_H"
is 'История лиц. счета MTS';

comment on column "mts_person_account_H".history_id
is 'Идентификатор';

comment on column "mts_person_account_H".create_date
is 'Дата создания ревизии';

comment on column "mts_person_account_H".revision_id
is 'Идентификатор ревизии';

create index "mts_person_account_H_create_date_idx"
  on "mts_person_account_H" (create_date);

create index "mts_person_account_H_revision_id_idx"
  on "mts_person_account_H" (revision_id);

create trigger tf_mts_person_account_ins
  after insert
  on mts_person_account
  for each row
execute procedure tf_ins();
create trigger tf_mts_person_account_upd
  after update
  on mts_person_account
  for each row
execute procedure tf_upd();
create trigger tf_mts_person_account_del
  after delete
  on mts_person_account
  for each row
execute procedure tf_del();