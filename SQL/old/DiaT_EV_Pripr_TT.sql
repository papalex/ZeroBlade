INSERT INTO public.dictonary (pkey, dictonary, dictonary_type, name, icon_filename, description, sort, sort_show, is_visible, abbreviation, user_id) VALUES ('PRIORITY|SHOW_STOPPER', 'SHOW_STOPPER', 'PRIORITY', 'Критический', '/dsn/ico/16/smile_devil.png'
  , '


Критический - бросить все и заниматься только этой задачей до полного ее исполнения

', 60, 60, 1, 'PRT_SwStp',7464);
update "public"."dictonary" SET "abbreviation" = 'PRT_HIGH' WHERE "pkey" LIKE 'PRIORITY|HIGH' ESCAPE '#';
UPDATE "public"."dictonary" SET "abbreviation" = 'PRT_NORM' WHERE "pkey" LIKE 'PRIORITY|NORMAL' ESCAPE '#';
update public.dictonary set icon_filename = p.icon_filename, description = p.description from dictonary d2
  join priority p on p.priority=d2.dictonary and d2.dictonary_type= 'PRIORITY' where dictonary.dictonary_type= 'PRIORITY' and d2.pkey = dictonary.pkey;

insert into dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id,icon_filename,description)
  select ('PRIORITY|' || priority)as pkey, priority as dictonary, 'PRIORITY' as dictonary_type,
    name, sort,sort_show,is_visible, ('PRT_'||abbreviation)as abbreviation, 7464 as user_id, icon_filename,description
  from priority where not exists(select 'x' from dictonary d2 where d2.dictonary=priority.priority);

ALTER TABLE public.crond_task DROP CONSTRAINT "crond_task_priority_fkey-> priority";
ALTER TABLE public.crond_task ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public.crond_task ALTER COLUMN priority SET DEFAULT 'PRIORITY|MEDIUM'::character varying;
update public.crond_task set priority = 'PRIORITY|' || priority;
ALTER TABLE public.crond_task
  ADD CONSTRAINT "crond_task > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey);

ALTER TABLE public.crond_task_execute DROP CONSTRAINT "crond_task_execute_priority_fkey-> priority";
ALTER TABLE public.crond_task_execute ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public.crond_task_execute ALTER COLUMN priority SET DEFAULT 'PRIORITY|MEDIUM'::character varying;
update public.crond_task_execute set priority = 'PRIORITY|' || priority;
ALTER TABLE public.crond_task_execute
  ADD CONSTRAINT "crond_task_execute > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey);


ALTER TABLE public.sendmail DROP CONSTRAINT "sendmail > priority";
ALTER TABLE public.sendmail ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
update public.sendmail set priority = 'PRIORITY|' || priority;
ALTER TABLE public.sendmail ALTER COLUMN priority SET DEFAULT 'PRIORITY|MEDIUM'::character varying;


ALTER TABLE public.sendmail
  ADD CONSTRAINT "sendmail > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey) ON UPDATE CASCADE;

ALTER TABLE public."sendmail_R" DROP CONSTRAINT "sendmail_R > priority";
ALTER TABLE public."sendmail_R" ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
update public."sendmail_R" set priority = 'PRIORITY|' || priority;
ALTER TABLE public."sendmail_R" ALTER COLUMN priority SET DEFAULT 'PRIORITY|MEDIUM'::character varying;
ALTER TABLE public."sendmail_R"
  ADD CONSTRAINT "sendmail_R > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey) ON UPDATE CASCADE;

ALTER TABLE public.message DROP CONSTRAINT "message_priority_fkey->priority";
ALTER TABLE public.message ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public.message ALTER COLUMN priority SET DEFAULT 'PRIORITY|MEDIUM'::character varying;
update public.message set priority = 'PRIORITY|' || priority;
ALTER TABLE public.message
  ADD CONSTRAINT "message > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey);

---task_diag
INSERT INTO dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id)
VALUES
  ('DICTONARY_TYPE|DIAGEVENT', 'DIAGEVENT', 'DICTONARY_TYPE', 'Справочник событий диаграмм', 10000, 10000, 1, 'DT_DiEvt', 7464);

insert into dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id,icon_filename,description)
  select ('DIAGEVENT|' || diagevent)as pkey, diagevent as dictonary, 'DIAGEVENT' as dictonary_type,
    name, sort,sort_show,is_visible, ('DiEvt_'||abbreviation)as abbreviation, 7464 as user_id, icon_filename,description
  from diagevent where not exists(select 'x' from dictonary d2 where d2.dictonary=diagevent.diagevent and d2.dictonary_type = 'DIAGEVENT');

INSERT INTO dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id)
VALUES
  ('DICTONARY_TYPE|DIAGTYPE', 'DIAGTYPE', 'DICTONARY_TYPE', 'Справочник типов диаграмм', 10000, 10000, 1, 'DT_DiTyp', 7464);

insert into dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id,icon_filename,description)
  select ('DIAGTYPE|' || diagtype)as pkey, diagtype as dictonary, 'DIAGTYPE' as dictonary_type,
    name, sort,sort_show,is_visible, ('DiEvt_'||abbreviation)as abbreviation, 7464 as user_id, icon_filename,description
  from diagtype where not exists(select 'x' from dictonary d2 where d2.dictonary=diagtype.diagtype and d2.dictonary_type = 'DIAGTYPE');

INSERT INTO dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id)
VALUES
  ('DICTONARY_TYPE|TASK_TYPE', 'TASK_TYPE', 'DICTONARY_TYPE', 'Типы процессов', 10000, 10000, 1, 'DT_TaskTyp', 7464);

insert into dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id,icon_filename,description)
  select ('TASK_TYPE|' || task_type)as pkey, task_type as dictonary, 'TASK_TYPE' as dictonary_type,
    name, sort,sort_show,is_visible, ('TaskTyp_'||abbreviation)as abbreviation, 7464 as user_id, icon_filename,description
  from task_type where not exists(select 'x' from dictonary d2 where d2.dictonary=task_type.task_type and d2.dictonary_type = 'TASK_TYPE');

ALTER TABLE public.task DROP CONSTRAINT "task_priority_fkey->priority";
alter table public.task drop constraint "task->task_type";
ALTER TABLE public.task ALTER COLUMN task_type TYPE varchar(129) USING task_type::varchar(129);
ALTER TABLE public.task ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public.task ALTER COLUMN priority SET DEFAULT 'PRIORITY|MEDIUM'::character varying;

ALTER TABLE public.task DISABLE TRIGGER tf_task_upd;
update public.task set priority = 'PRIORITY|' || priority;
ALTER TABLE public.task ENABLE TRIGGER tf_task_upd;

ALTER TABLE public.task
  ADD CONSTRAINT "task > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey);
alter table public.task ADD CONSTRAINT "task > task_type" FOREIGN KEY (task_type)
REFERENCES dictonary (pkey) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE public."task_R" ALTER COLUMN task_type TYPE varchar(129) USING task_type::varchar(129);
ALTER TABLE public."task_R" ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public."task_R" ALTER COLUMN priority SET DEFAULT 'PRIORITY|MEDIUM'::character varying;
update public."task_R" set priority = 'PRIORITY|' || priority;

---task_diag
ALTER TABLE public.task_diag DROP CONSTRAINT "task_diag_priority_fkey->priority";
ALTER TABLE public.task_diag ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public.task_diag ALTER COLUMN priority SET DEFAULT 'PIORITY|MEDIUM'::character varying;
update public.task_diag set priority = 'PRIORITY|' || priority;
ALTER TABLE public.task_diag
  ADD CONSTRAINT "task_diag > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey);
ALTER TABLE public.task_diag DROP CONSTRAINT "task_diag_diag_type_fkey->diag_type";
ALTER TABLE public.task_diag ALTER COLUMN diagtype TYPE varchar(129) USING diagtype::varchar(129);
update public.task_diag set diagtype = 'DIAGTYPE|' || diagtype;
ALTER TABLE public.task_diag
  ADD CONSTRAINT "task_diag > diag_type"
FOREIGN KEY (diagtype) REFERENCES dictonary (pkey);

ALTER TABLE public.subtask DROP CONSTRAINT "subtask_priority_fkey->priority";
ALTER TABLE public.subtask ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public.subtask ALTER COLUMN priority SET DEFAULT 'PRIORITY|MEDIUM'::character varying;

ALTER TABLE public."subtask" DISABLE TRIGGER tf_subtask_upd;
ALTER TABLE public."subtask" DISABLE TRIGGER tf_subtask_upd_b;
update public.subtask set priority = 'PRIORITY|' || priority;
ALTER TABLE public."subtask" ENABLE TRIGGER tf_subtask_upd;
ALTER TABLE public."subtask" ENABLE TRIGGER tf_subtask_upd_b;

ALTER TABLE public.subtask
  ADD CONSTRAINT "subtask > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey);


ALTER TABLE public."subtask_R" ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public."subtask_R" ALTER COLUMN priority SET DEFAULT 'PRIORITY|MEDIUM'::character varying;
update public."subtask_R" set priority = 'PRIORITY|' || priority;


ALTER TABLE public.task_diag_event DROP CONSTRAINT "task_diag_event > priority";
ALTER TABLE public.task_diag_event ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public.task_diag_event ALTER COLUMN priority SET DEFAULT 'PIORITY|MEDIUM'::character varying;
update public.task_diag_event set priority = 'PRIORITY|' || priority;
ALTER TABLE public.task_diag_event
  ADD CONSTRAINT "task_diag_event > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey);
ALTER TABLE public.task_diag_event DROP CONSTRAINT "task_diag_event > diagevent";
ALTER TABLE public.task_diag_event ALTER COLUMN diagevent TYPE varchar(129) USING diagevent::varchar(129);
update public.task_diag_event set diagevent = 'DIAGEVENT|' || diagevent;
ALTER TABLE public.task_diag_event
  ADD CONSTRAINT "task_diag_event > diagevent"
FOREIGN KEY (diagevent) REFERENCES dictonary (pkey);


ALTER TABLE public.task_diag_node DROP CONSTRAINT "task_diag_node_priority_fkey->priority";
ALTER TABLE public.task_diag_node ALTER COLUMN priority TYPE varchar(129) USING priority::varchar(129);
ALTER TABLE public.task_diag_node ALTER COLUMN priority SET DEFAULT 'PIORITY|MEDIUM'::character varying;

ALTER TABLE public.task_diag_node DISABLE TRIGGER tf_task_diag_node_upd_a;
update public.task_diag_node set priority = 'PRIORITY|' || priority;
ALTER TABLE public.task_diag_node Enable TRIGGER tf_task_diag_node_upd_a;
ALTER TABLE public.task_diag_node
  ADD CONSTRAINT "task_diag_node > priority"
FOREIGN KEY (priority) REFERENCES dictonary (pkey);

UPDATE "public"."groupe" SET code = 'ACTIVITY_TYPE',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2337;
UPDATE "public"."groupe" SET code = 'DOCUMENT_TYPE',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2336;
UPDATE "public"."groupe" SET code = 'CONTRACT_TYPE',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2351;
--UPDATE "public"."groupe" SET code = 'PRIORITY',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2321; --уже есть 3625
UPDATE "public"."groupe" SET code = 'ORIGINAL_TYPE',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2349;
UPDATE "public"."groupe" SET code = 'WORK_STATE',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2323;
--UPDATE "public"."groupe" SET code = 'PAYMENT_FORM_TYPE',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2348; --уже есть 3201
UPDATE "public"."groupe" SET code = 'DIAGTYPE',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2333;
UPDATE "public"."groupe" SET code = 'CURRENCY_RATE_TYPE',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2352;
UPDATE "public"."groupe" SET code = 'TASK_TYPE',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2335;
UPDATE "public"."groupe" SET code = 'DIAGEVENT',"groupe_type" = 'DICTONARY' WHERE "groupe_id" = 2334;

