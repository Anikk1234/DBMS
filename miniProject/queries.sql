select clinical_trial_address from sample;
 show columns from sample;



-- question no a:
SELECT drug_name
FROM sample
WHERE LOWER(`side_effect_[0]`) LIKE '%nausea%'
   OR LOWER(`side_effect_[1]`) LIKE '%nausea%'
   OR LOWER(`side_effect_[2]`) LIKE '%nausea%'
   OR LOWER(`side_effect_[3]`) LIKE '%nausea%';
  
  
  
-- question no b:
SELECT drug_name
FROM sample
WHERE interacts_with LIKE '%butabarbital%';



-- question no c:
SELECT DISTINCT drug_name
FROM sample
WHERE 
  (
    LOWER(`side_effect_[0]`) = 'cough'
    OR LOWER(`side_effect_[1]`) = 'cough'
    OR LOWER(`side_effect_[2]`) = 'cough'
    OR LOWER(`side_effect_[3]`) = 'cough'
  )
AND 
  (
    LOWER(`side_effect_[0]`) = 'headache'
    OR LOWER(`side_effect_[1]`) = 'headache'
    OR LOWER(`side_effect_[2]`) = 'headache'
    OR LOWER(`side_effect_[3]`) = 'headache'
  );



-- question no d:
SELECT drug_name
FROM sample
WHERE disease_category= 'Endocrine';



-- question no e:
SELECT drug_name, COUNT(*) as freq
FROM sample
WHERE disease_category = 'Immunological'
  AND drug_name NOT IN (
    SELECT distinct drug_name from sample WHERE disease_category = 'Hematological'
  )
GROUP BY drug_name
ORDER BY freq DESC
LIMIT 3;


-- question no f:
SELECT DISTINCT disease_name
FROM sample
WHERE drug_name = 'hydrocortisone'
  AND disease_name NOT IN (
    SELECT disease_name FROM sample WHERE drug_name = 'etanercept'
  );
  
  
  
  -- question no g:
SELECT side_effect, COUNT(*) AS freq
FROM (
    SELECT side_effect_[0] AS side_effect FROM sample WHERE disease_name LIKE '%asthma%'
    UNION ALL
    SELECT side_effect_[1] FROM sample WHERE disease_name LIKE '%asthma%'
    UNION ALL
    SELECT side_effect_[2] FROM sample WHERE disease_name LIKE '%asthma%'
    UNION ALL
    SELECT side_effect_[3] FROM sample WHERE disease_name LIKE '%asthma%'
    
) AS asthma_side_effects
WHERE side_effect IS NOT NULL
GROUP BY side_effect
ORDER BY freq DESC
LIMIT 10;



-- question no h:
SELECT drug_name
FROM sample
WHERE clinical_trial_participants > 30
GROUP BY drug_name
HAVING COUNT(*) > 3;



-- question no i:
SELECT drug_name, clinical_trial_start_date, clinical_trial_completion_date, COUNT(*) AS total_trials
FROM sample
GROUP BY drug_name, clinical_trial_start_date, clinical_trial_completion_date
ORDER BY total_trials DESC
LIMIT 1;



-- question no j:
SELECT clinical_trial_main_researcher
FROM sample
WHERE disease_category IN ('Respiratory', 'Cardiovascular')
GROUP BY clinical_trial_main_researcher
HAVING COUNT(DISTINCT disease_category) = 2;



-- question no k:
SELECT clinical_trial_main_researcher, COUNT(*) AS trial_count
FROM sample
WHERE disease_category IN ('Respiratory', 'Cardiovascular')
GROUP BY clinical_trial_main_researcher
HAVING COUNT(DISTINCT disease_category) = 2
ORDER BY trial_count DESC
LIMIT 3;



-- question no l:
SELECT DISTINCT drug_category
FROM sample
WHERE clinical_trial_address = 'United States'
  AND drug_category NOT IN (
    SELECT DISTINCT drug_category
    FROM sample
    WHERE clinical_trial_address != 'United States'
  );