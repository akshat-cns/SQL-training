WITH ranked_images AS (
    SELECT 
        image_id,
        score,
        ROW_NUMBER() OVER (ORDER BY score desc) AS row_num_desc,
        ROW_NUMBER() OVER (ORDER BY score ASC) AS row_num_asc
        FROM images
), 
positive_samples AS (
    SELECT 
        image_id,
        1 AS weak_label
        FROM ranked_images
        WHERE 
        row_num_desc%3=1 AND row_num_desc<=10000
),
negative_samples AS (
    SELECT 
        image_id,
        0 AS weak_label
        FROM ranked_images
        WHERE 
        row_num_asc%3=1 AND row_num_asc<=10000
)
SELECT image_id,weak_label FROM (
    SELECT * FROM positive_samples UNION ALL
    SELECT * FROM negative_samples
) AS samples 
ORDER BY image_id;