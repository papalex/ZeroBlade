alter table register_contract drop constraint "register_contract > contract_type";
alter table register_contract drop constraint "register_contract > currency_rate_type";
alter table register_contract drop constraint "register_contract > original_type";
alter table register_contract drop constraint "register_contract > payment_form_type";
alter table register_contract drop constraint "register_contract > storage";

--- CONTRACT_TYPE
INSERT INTO dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id)
  VALUES
  ('DICTONARY_TYPE|CONTRACT_TYPE', 'CONTRACT_TYPE', 'DICTONARY_TYPE', 'Типы Договоров', 10000, 10000, 1, 'DT_ContrTyp', 7464);

insert into dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id,icon_filename,description)
  select ('CONTRACT_TYPE|' || contract_type)as pkey, contract_type as dictonary, 'CONTRACT_TYPE' as dictonary_type,
   name, sort,sort_show,is_visible, ('ContrTyp_'||abbreviation)as abbreviation, 7464 as user_id, icon_filename,description
   from contract_type;

---payment_form_type
-- уже есть такой тип справочника, но для переноса старых значений делаем их невидимыми
/*INSERT INTO dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id)
  VALUES
  ('DICTONARY_TYPE|PAYMENT_FORM_TYPE', 'PAYMENT_FORM_TYPE', 'DICTONARY_TYPE', 'Формы оплаты', 10000, 10000, 1, 'DT_PayTyp', 7464);*/

insert into dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id,icon_filename,description)
  select ('PAYMENT_FORM_TYPE|' || payment_form_type)as pkey, payment_form_type as dictonary, 'PAYMENT_FORM_TYPE' as dictonary_type,
   name, sort,sort_show,0, ('PayTyp_'||abbreviation)as abbreviation, 7464 as user_id, icon_filename,description
   from payment_form_type where payment_form_type <> 'CASH';

---original_type
INSERT INTO dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id)
  VALUES
  ('DICTONARY_TYPE|ORIGINAL_TYPE', 'ORIGINAL_TYPE', 'DICTONARY_TYPE', 'Тип имеющейся формы/копии', 10000, 10000, 1, 'DT_Orig', 7464);

insert into dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id,icon_filename,description)
  select ('ORIGINAL_TYPE|' || original_type)as pkey, original_type as dictonary, 'ORIGINAL_TYPE' as dictonary_type,
   name, sort,sort_show,is_visible, ('Orig_'||abbreviation)as abbreviation, 7464 as user_id, icon_filename,description
   from original_type;

---currency_rate_type
INSERT INTO dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id)
  VALUES
  ('DICTONARY_TYPE|CURRENCY_RATE_TYPE', 'CURRENCY_RATE_TYPE', 'DICTONARY_TYPE', 'Способ определения курса', 10000, 10000, 1, 'DT_RateTyp', 7464);

insert into dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id,icon_filename,description)
  select ('CURRENCY_RATE_TYPE|' || currency_rate_type)as pkey, currency_rate_type as dictonary, 'CURRENCY_RATE_TYPE' as dictonary_type,
   name, sort,sort_show,is_visible, ('RateTyp_'||abbreviation)as abbreviation, 7464 as user_id, icon_filename,description
   from currency_rate_type;

---storage
INSERT INTO dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id)
  VALUES
  ('DICTONARY_TYPE|STORAGE', 'STORAGE', 'DICTONARY_TYPE', 'Хранилище', 10000, 10000, 1, 'DT_Stor', 7464);

insert into dictonary(pkey, dictonary, dictonary_type, name, sort, sort_show, is_visible, abbreviation, user_id,icon_filename,description)
  select ('STORAGE|' || storage)as pkey, storage as dictonary, 'STORAGE' as dictonary_type,
   name, sort,sort_show,is_visible, ('Stor_'||abbreviation)as abbreviation, 7464 as user_id, icon_filename,description
   from storage;

update register_contract set payment_form_type = (select d.pkey from dictonary d where payment_form_type = d.dictonary and d.dictonary_type = 'PAYMENT_FORM_TYPE');
update register_contract set original_type = (select d.pkey from dictonary d where original_type = d.dictonary and d.dictonary_type = 'ORIGINAL_TYPE');
update register_contract set storage = (select d.pkey from dictonary d where storage = d.dictonary and d.dictonary_type = 'STORAGE');
update register_contract set currency_rate_type = (select d.pkey from dictonary d where currency_rate_type = d.dictonary and d.dictonary_type = 'CURRENCY_RATE_TYPE');
update register_contract set contract_type = (select d.pkey from dictonary d where contract_type = d.dictonary and d.dictonary_type = 'CONTRACT_TYPE');

ALTER TABLE register_contract ADD CONSTRAINT "register_contract > contract_type" FOREIGN KEY (contract_type)
     REFERENCES dictonary (pkey) MATCH SIMPLE
     ON UPDATE CASCADE ON DELETE NO ACTION;
ALTER TABLE register_contract ADD CONSTRAINT "register_contract > currency_rate_type" FOREIGN KEY (currency_rate_type)
     REFERENCES dictonary (pkey) MATCH SIMPLE
     ON UPDATE CASCADE ON DELETE NO ACTION;
   ALTER TABLE register_contract ADD CONSTRAINT "register_contract > original_type" FOREIGN KEY (original_type)
     REFERENCES dictonary (pkey) MATCH SIMPLE
     ON UPDATE CASCADE ON DELETE NO ACTION;
   ALTER TABLE register_contract ADD CONSTRAINT "register_contract > payment_form_type" FOREIGN KEY (payment_form_type)
     REFERENCES dictonary (pkey) MATCH SIMPLE
     ON UPDATE CASCADE ON DELETE NO ACTION;
   ALTER TABLE register_contract ADD CONSTRAINT "register_contract > storage" FOREIGN KEY (storage)
     REFERENCES dictonary (pkey) MATCH SIMPLE
     ON UPDATE CASCADE ON DELETE NO ACTION;

update task_param tp set _varchar = dict.pkey from dictonary dict
   where dict.dictonary = tp._varchar
      and dict.dictonary_type = tp.task_diag_param
      and task_diag_param in( 'CURRENCY_RATE_TYPE'
      ,'PAYMENT_FORM_TYPE'
      ,'ORIGINAL_TYPE'
      ,'CONTRACT_TYPE'
      ,'STORAGE'
      )
      and not tp._varchar isnull;

update 	task_diag_task_diag_param set condition_dictonary = :val,condition_dictonary_ro=:valro where task_diag_param = :tdparam and condition_dictonary ilike :condlike



ALTER TABLE payment_form_type RENAME TO payment_form_type_DEL;
ALTER TABLE original_type RENAME TO original_type_DEL;
ALTER TABLE currency_rate_type RENAME TO currency_rate_type_DEL;
ALTER TABLE contract_type RENAME TO contract_type_DEL;

