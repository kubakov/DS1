-- 1
with tab as (
  select i.iid as iid, i.name as inst_name, ar.rid as rid, ar.name as author_name, 
    count(distinct a.aid) as article_count 
  from z_institution i
  join z_article_institution ai on ai.iid=i.iid
  join z_article a on ai.aid=a.aid
  join z_year_field_journal yfj on yfj.year=a.year and yfj.jid=a.jid
  join z_article_author aa on a.aid=aa.aid
  join z_author ar on aa.rid=ar.rid
  where i.town like 'Praha%' and yfj.ranking='Decil'
  group by i.iid, i.name, ar.rid, ar.name
)
select * from tab t1
where t1.article_count >= all (
  select t2.article_count from tab t2
  where t1.iid=t2.iid
)
order by t1.article_count desc

-- 2

SELECT z_author.rid, z_author.name
FROM 
	z_author
WHERE
	z_author.rid IN(
		SELECT z_author.rid
		FROM z_journal
		JOIN z_article ON z_journal.jid = z_article.jid
		JOIN z_article_author ON z_article.aid = z_article_author.aid
		JOIN z_author ON z_article_author.rid = z_author.rid
		WHERE z_journal.issn = '0004-3702'
	)
	AND NOT z_author.rid IN(
		SELECT z_author.rid
		FROM z_journal
		JOIN z_article ON z_journal.jid = z_article.jid
		JOIN z_article_author ON z_article.aid = z_article_author.aid
		JOIN z_author ON z_article_author.rid = z_author.rid
		WHERE z_journal.issn = '2169-3536'
	)
ORDER BY z_author.rid

-- 3

SELECT z_field_ford.name, 
(
	SELECT COUNT(z_article.aid) FROM z_article
	JOIN z_year_field_journal ON z_year_field_journal.jid = z_article.jid AND z_year_field_journal.year = z_article.year
	WHERE z_year_field_journal.fid = z_field_ford.fid
) AS pocet,
(
	SELECT COUNT(z_article.aid) FROM z_article
	JOIN z_year_field_journal ON z_year_field_journal.jid = z_article.jid AND z_year_field_journal.year = z_article.year
	WHERE z_year_field_journal.fid = z_field_ford.fid AND z_year_field_journal.ranking = 'Decil'
) AS pocet_decil,
(
	SELECT COUNT(z_article.aid) FROM z_article
	JOIN z_article_institution ON z_article_institution.aid = z_article.aid
	JOIN z_institution ON z_institution.iid = z_article_institution.iid
	JOIN z_year_field_journal ON z_year_field_journal.jid = z_article.jid AND z_year_field_journal.year = z_article.year
	WHERE z_year_field_journal.fid = z_field_ford.fid AND z_institution.name = 'Vysoká škola báňská - Technická univerzita Ostrava'
) AS pocet_VSB
FROM
	z_field_ford
	JOIN z_field_of_science ON z_field_of_science.sid = z_field_ford.sid
WHERE z_field_of_science.name = 'Engineering and Technology'
ORDER BY z_field_ford.name