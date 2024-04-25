INSERT INTO solution VALUES (1, (
  
  
  WITH clue1 AS (SELECT 'clue1' as clue, *
FROM crime_scene_report as csr
where type = 'murder'AND csr."date"=20180115 AND csr.city = 'SQL City')


, clue2pt1 AS (SELECT 'clue2pt1' as clue, *
FROM person AS p
			
WHERE p.address_number = (select MAX(address_number)
						from person
						where address_street_name ='Northwestern Dr'
						 )
				)


, clue2pt2 AS (SELECT 'clue2pt2' as clue, *
				FROM person AS p
			   	WHERE (p.name like 'Annabel%' or p.name like '%Annabel') AND 
			   p.address_street_name = 'Franklin Ave'
			   )
			   
			
, clue2 AS (SELECT * 
			FROM clue2pt1
			UNION 
			Select *
			FROM clue2pt2
			)


, clue3 AS (SELECT 'clue3' AS clue , * 
			
			FROM interview as i
			INNER JOIN clue2 as c
			on i.person_id = c.id
			)


, clue4pt1 AS (SELECT 'clue4pt1' as clue, * 
			
			FROM get_fit_now_member
			where id like '48Z%' AND membership_status = 'gold'
			
			)


,personanddriver AS (SELECT *
					 FROM drivers_license as d
					 INNER JOIN person as p
					 on d.id = p.license_id
					 )

,clue4pt2 AS 	(SELECT 'clue4pt2' as clue, *
				 
				 FROM personanddriver as pd
				 INNER JOIN clue4pt1 as c
				 ON c.person_id = pd."id:1"
				 where pd.plate_number like '%H42W'
				 OR pd.plate_number like '%H42W%' 
				 OR pd.plate_number like 'H42W%'
  				)
				
,getfitcheckinandmember AS (SELECT *
							FROM get_fit_now_member as m
							INNER JOIN get_fit_now_check_in as c
							ON m.id = c.membership_id
							)
			
			
,clue4pt3 AS (SELECT 'clue4pt3' as clue, *
			  FROM getfitcheckinandmember as cm
			  INNER JOIN clue4pt2 as c
			  ON c.name = cm.name
			  where check_in_date like '%0109'
			  )


SELECT name
FROM clue4pt3
              



              )
							
							);
        
        SELECT value FROM solution;
