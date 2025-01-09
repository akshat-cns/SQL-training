WITH RankedItems AS (
    SELECT ai.account_id,i.type,ai.quality,
    ROW_NUMBER() OVER (PARTITION BY ai.account_id, i.type
        ORDER BY 
            CASE 
                WHEN ai.quality = 'epic' THEN 1
                WHEN ai.quality = 'common' THEN 2
                WHEN ai.quality = 'rare' THEN 3
            END
        ) AS rank FROM accounts_items ai JOIN items i ON ai.item_id = i.id
)
SELECT a.username, i.type, r.quality, i.name FROM RankedItems 
JOIN accounts a ON a.id = r.account_id
JOIN items i ON r.type = i.type
WHERE r.rank = 1 ORDER BY a.username,
    CASE 
        WHEN i.type = 'armor' THEN 1
        WHEN i.type = 'shield' THEN 2
        WHEN i.type = 'sword' THEN 3
    END;
