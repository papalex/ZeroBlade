INSERT INTO "public"."groupe_type"
("groupe_type", "name", "icon_filename", "description", "sort", "sort_show", "is_visible", "abbreviation", "uid36")
VALUES ('MTS',
        'Доступ к статистике мобильных телефонов МТС',
        'NULL',
        '<p>Управление группами по работе с оператором МТС<br>Доступ к статистике мобильных телефонов МТС</p>',
        DEFAULT,
        DEFAULT, 1, 'MTS', 'NULL');

INSERT INTO "public"."groupe" ("code", "name", "is_disabled", "ldap", "groupe_type", "is_manager", "is_special", "is_inherit", "department_name", "abbreviation", "user__id", "organization_tree_id", "description", "uid24", "post")
  VALUES ( 'MTS_ADMIN', 'Администратор функционала МТС', DEFAULT, 'NULL', 'MTS', DEFAULT, DEFAULT, DEFAULT, 'NULL', 'NULL', 7464, 'NULL', 'NULL', 'NULL', 'NULL');
INSERT INTO "public"."groupe" ("code", "name", "is_disabled", "ldap", "groupe_type", "is_manager", "is_special", "is_inherit", "department_name", "abbreviation", "user__id", "organization_tree_id", "description", "uid24", "post")
  VALUES ( 'MTS_BLOCKED', 'Скрытая стаистика', DEFAULT, 'NULL', 'MTS', DEFAULT, DEFAULT, DEFAULT, 'NULL', 'NULL', 7464, 'NULL', 'NULL', 'NULL', 'NULL')
;
INSERT INTO "public"."groupe" ("code", "name", "is_disabled", "ldap", "groupe_type", "is_manager", "is_special", "is_inherit", "department_name", "abbreviation", "user__id", "organization_tree_id", "description", "uid24", "post")
  VALUES ( 'MTS_DETAIL', 'Доступ к отображению детальной статистики', DEFAULT, 'NULL', 'MTS', DEFAULT, DEFAULT, DEFAULT, 'NULL', 'NULL', 7464, 'NULL', 'NULL', 'NULL', 'NULL')
;
INSERT INTO "public"."groupe" ("code", "name", "is_disabled", "ldap", "groupe_type", "is_manager", "is_special", "is_inherit", "department_name", "abbreviation", "user__id", "organization_tree_id", "description", "uid24", "post")
  VALUES ( 'MTS_GIVE_NUMBER', 'Группа получателей уведомлений о выдаче симки в сочетании с доступо к юрлицам', DEFAULT, 'NULL', 'MTS', DEFAULT, DEFAULT, DEFAULT, 'NULL', 'NULL', 7464, 'NULL', 'NULL', 'NULL', 'NULL')
;
INSERT INTO "public"."groupe" ("code", "name", "is_disabled", "ldap", "groupe_type", "is_manager", "is_special", "is_inherit", "department_name", "abbreviation", "user__id", "organization_tree_id", "description", "uid24", "post")
  VALUES ('MTS_VIEW_TRUE_AMOUNT', 'Просмотр стоимости тарифного плана', DEFAULT, 'NULL', 'MTS', DEFAULT, DEFAULT, DEFAULT, 'NULL', 'NULL', 7464, 'NULL', 'NULL', 'NULL', 'NULL')
;
INSERT INTO "public"."groupe" ("code", "name", "is_disabled", "ldap", "groupe_type", "is_manager", "is_special", "is_inherit", "department_name", "abbreviation", "user__id", "organization_tree_id", "description", "uid24", "post")
  VALUES ('MTS_EDIT', 'Право редактировать МТС', DEFAULT, 'NULL', 'MTS', DEFAULT, DEFAULT, DEFAULT, 'NULL', 'NULL', 7464, 'NULL', 'NULL', 'NULL', 'NULL')
;
INSERT INTO "public"."groupe" ("code", "name", "is_disabled", "ldap", "groupe_type", "is_manager", "is_special", "is_inherit", "department_name", "abbreviation", "user__id", "organization_tree_id", "description", "uid24", "post")
  VALUES ('MTS_RP_MOSCOW', 'Доступ к мобильным телефонам МТС - ООО Русский проект(Москва)', DEFAULT, 'NULL', 'MTS', DEFAULT, DEFAULT, DEFAULT, 'NULL', 'NULL', 7464, 'NULL', 'NULL', 'NULL', 'NULL')
;
INSERT INTO "public"."groupe" ("code", "name", "is_disabled", "ldap", "groupe_type", "is_manager", "is_special", "is_inherit", "department_name", "abbreviation", "user__id", "organization_tree_id", "description", "uid24", "post")
  VALUES ('MTS_FINVEST', 'Доступ к мобильным телефонам МТС - ООО Финвест', DEFAULT, 'NULL', 'MTS', DEFAULT, DEFAULT, DEFAULT, 'NULL', 'NULL', 7464, 'NULL', 'NULL', 'NULL', 'NULL')
;
