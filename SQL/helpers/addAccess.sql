insert into user_groupe (user_id,  groupe_id, user__id, end_date) (select 7464 AS user_id,  groupe_id, 7464 AS user__id, end_date
                                                                   from user_groupe WHERE user_id = 6795 AND groupe_id
                                                                                                             not in (select groupe_id from user_groupe where user_id = 7464));
insert into user_groupe_cache (user_id,  groupe_id) (select 7464 AS user_id,  groupe_id
                                                     from user_groupe_cache WHERE user_id = 6795 AND groupe_id
                                                                                                     not in (select groupe_id from user_groupe_cache where user_id = 7464));

insert into user_access_section(user_id,section_id,is_write,is_view) select 7464 as "user_id",uas.section_id, 1 ,0 from user_access_section uas where 1=1 group by uas.section_id;
insert into user_access_question(user_id,question_id,is_write,is_view) select 7464 as "user_id",uas.question_id, 1 ,0 from user_access_question uas where 1=1 group by uas.question_id;