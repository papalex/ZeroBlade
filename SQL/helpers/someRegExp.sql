/*select * from task_param where task_diag_param in ('SCANNED_FILE',
                                                   'INTEGRATED_FILE',
                                                   'ADDITIONAL_FILES',
                                                   'POST_MAIL_INVENTORY_ATTACHMENT_LIST');
*/
--a:2:{i:0;a:3:{s:4:"name";s:10:"Схема";s:17:"task_diag_file_id";s:4:"1591";s:13:"document_type";s:8:"APPENDIX";}i:1;a:3:{s:4:"name";s:18:"Рисунок - 1";s:17:"task_diag_file_id";s:4:"1593";s:13:"document_type";s:5:"RULES";}}



/*select
  regexp_replace ('a:2:{i:0;a:3:{s:4:"name";s:10:"Схема";s:17:"task_diag_file_id";s:4:"1591";s:13:"document_type";s:8:"APPENDIX";}i:1;a:3:{s:4:"name";s:18:"Рисунок - 1";s:17:"task_diag_file_id";s:4:"1593";s:13:"document_type";s:5:"RULES";}}'
  ,'("document_type";s:)(\d+):"(' || (select string_agg(document_type, '|') from document_type_del) || ')"'
  ,'\1\2:"document_type|\3','g'),
 regexp_matches ('s:13:"document_type";s:5:"RULES";}','(?:"document_type";s:\d+:)(".*")','g');


--limit 10
*/
/*
a:2:{i:0;a:3:{s:4:"name";s:22:"Приложение 1";s:17:"task_diag_file_id";s:3:"949";s:13:
"document_type";s:8:"APPENDIX";}i:1;a:3:{s:4:"name";s:22:"Приложение 2";s:17:"task_diag_file_id";s:3:"953";s:13:"document_type";s:11:"INSTRUCTION";}}
a:2:{i:0;a:3:{s:4:"name";s:22:"Приложение 1";s:17:"task_diag_file_id";s:3:"949";s:13:
  dovument_type|APPENDIX;}i:1;a:3:{s:4:"name";s:22:"Приложение 2";s:17:"task_diag_file_id";s:3:"953";s:13:dovument_type|INSTRUCTION;}}
 */
select * from (select distinct c.client_id, u.f_ms as owner, case when cuh.client_id is null then 0 else 1 end as is_hidden,
                                            case when c.name is not null then c.name else c.fms end as name, c.document_id, c.dealer_code, c.last_modify_deal,
                                            case when c.last_modify_add>t.create_date then c.last_modify_add else t.create_date end as last_modify_add, tt.region from client c
  inner join client_access_user_cache cau on cau.client_id=c.client_id
                                             and (cau.user_id=7464 or 1=1)
                                             and cau.is_view_property=1
  inner join "user" u on u.user_id=c.owner
  inner join (select max(create_date) as create_date, id from "client_H" group by id) t on t.id=c.client_id
  left outer join client_user_hide cuh on cuh.client_id=c.client_id
                                          and (cuh.user_id=7464 or 1=1)
  left outer join (select array_to_string(array_agg(region), '<br/>') as region, client_id
                   from (select distinct fa.name || ' ' || fa.abbr || '. (' || substring(fa.kladr_id, 1, 2) || ')' as region, cc.client_id from fias_addr fa
                     inner join company c on c.region=cast(substring(fa.kladr_id, 1, 2) as smallint)
                     inner join client_company cc on cc.company_id=c.company_id
                   where length(fa.kladr_id)=11
                         and fa.kladr_id like '__000000000') as ttt
                   group by client_id) tt on tt.client_id=c.client_id
               where (2=2) and (cuh.client_id is null)) as t
where (1=1)   order by name  limit 20
select json_agg( _text)--, task_param_id



select regexp_matches(matche._text,'(?:"document_type";s:(\d+):)"(\w+)"','g') as founded,
  (regexp_matches(matche._text,'(?:"document_type";s:(\d+):)"(\w+)"','g'))[2] as val,
  (regexp_matches(matche._text,'(?:"document_type";s:(\d+):)"(\w+)"','g'))[1]::integer as len,
  /*(select regexp_replace(tp._text,'(?:"document_type";s:(\d+):)"(\w)"','"document_type";s:\1:"dovument_type|\2"', 'g')
   from task_param tp where tp.task_param_id = matche.task_param_id)
  ,regexp_replace(matche._text,'(?:"document_type";s:('||(matche.found)[1]||'):)"('||(matche.found)[2]||')"',
                  '"document_type";s:'||(matche.found)[1]||':"dovument_type|'||(matche.found)[2]||'"', 'g')
  ,regexp_matches(_text,'(?:"document_type";s:(\d+):)"(\w+)"',''), ':tt',
  character_length('document_type|' || regexp_matches(_text,'(?:"document_type";s:(?:\d+):)"(\w+)"','')::varchar(64))-2,*/
  _text, task_param_id
from task_param matche where matche.task_diag_param in ('SCANNED_FILE',
'INTEGRATED_FILE',
'ADDITIONAL_FILES',
'POST_MAIL_INVENTORY_ATTACHMENT_LIST')


-- SQL recursive Fractal :)

WITH RECURSIVE z(ix, iy, cx, cy, x, y, i) AS (
  SELECT ix, iy, x::float, y::float, x::float, y::float, 0
  FROM (select -1.88+0.016*i, i from generate_series(0,150) as i) as xgen(x,ix),
    (select -1.11+0.060*i, i from generate_series(0,36) as i) as ygen(y,iy)
  UNION ALL
  SELECT ix, iy, cx, cy, x*x - y*y + cx, y*x*2 + cy, i+1
  FROM z
  WHERE x * x + y * y < 16::float
        AND i < 27
)
SELECT array_to_string(array_agg(substring(' .,,,-----++++%%%%@@@@#### ',
                                           greatest(i,1), 1)),'')
FROM (
       SELECT ix, iy, max(i) AS i
       FROM z
       GROUP BY iy, ix
       ORDER BY iy, ix
     ) AS zt
GROUP BY iy
ORDER BY iy

WITH RECURSIVE t(n) AS (
  SELECT 1
  UNION ALL
  SELECT n+1 FROM t
)
SELECT n FROM t LIMIT 100;

WITH valuesandleghts AS (
    SELECT regexp_matches(matche._text,'(?:"document_type";s:(\d+):)"(\w+)"','g') as both,
           (regexp_matches(matche._text,'(?:"document_type";s:(\d+):)"(\w+)"','g'))[2] as val,
           (regexp_matches(matche._text,'(?:"document_type";s:(\d+):)"(\w+)"','g'))[1]::integer as len,
      _text, task_param_id
    from task_param matche where matche.task_diag_param in ('SCANNED_FILE',
                                                            'INTEGRATED_FILE',
                                                            'ADDITIONAL_FILES',
                                                            'POST_MAIL_INVENTORY_ATTACHMENT_LIST')
)select regexp_replace(valuesandleghts._text,'(?:"document_type";s:('||valuesandleghts.len||'):)"('||valuesandleghts.val||')"',
                          '"document_type";s:'||valuesandleghts.len +14||':"dovument_type|'||valuesandleghts.val||'"', 'g'),valuesandleghts.both,task.task_param_id,char_length('document_type|'||val)
   from valuesandleghts join task_param task on valuesandleghts.task_param_id = task.task_param_id
/*update task_param task set _text = regexp_replace(valuesandleghts._text,'(?:"document_type";s:('||valuesandleghts.len||'):)"('||valuesandleghts.val||')"',
                          '"document_type";s:'||valuesandleghts.len +14||':"dovument_type|'||valuesandleghts.val||'"', 'g')
    --,valuesandleghts.both,task.task_param_id,char_length('document_type|'||val)
   from valuesandleghts where task.task_param_id = 135079 and valuesandleghts.task_param_id = task.task_param_id*/
select _text from task_param where task_param_id=135079;