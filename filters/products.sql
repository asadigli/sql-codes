SELECT
    `_Inventory19075`.`_ID`  as real_id,
    `_Inventory19075`.`_OID` as  `organization_id` ,
    MD5( `_Inventory19075`.`_ID` ) as `id`,
    `_Inventory19075`.`_Code` as  `code` ,
    `_Inventory19075`.`_Pck41770` as  `barcode` ,
    `_Inventory19075`.`_Pck41775` as  `name` ,
    `_Inventory11695`.`_Pck15408` as brand,
    MD5(`_Inventory11695`.`_ID`) as brand_id,
    product_category.`name` as categories,
    price_query.`prices`,
    `_Inventory19075`.`_Pck41777` as  `stock_shelf` ,
    `_Inventory19075`.`_Pck41778` as  `stock_code` ,
    `_Inventory19075`.`_Pck41779` as  `stock_status` ,
    `_Inventory19075`.`_Rvled` as  `is_active` ,
    `_Inventory19075`.`_Pck41710` as  `stock_min` ,
    `_Inventory19075`.`_Pck41711` as  `stock_max` ,
    (SELECT
        `_Segments11115`.`_Pck16976`
     FROM `_Segments11115`
     WHERE `_Segments11115`.`_DstDate` IS NULL
     AND `_Segments11115`.`_OID` = 0
     AND `_Segments11115`.`_Pck16914Jnt` = `_Inventory19075`.`_ID`
     ORDER BY `_Segments11115`.`_Pck16915` DESC
     LIMIT 1) as cost_price,
     `_Inventory19075`.`_Pck41717` as  `vat_rate` ,
     CONCAT(`_Inventory76055`.`_Pck77655`, ' ',`_Inventory76055`.`_Pck77656`) as employee_name,
     `_Inventory19075`.`_Pck41711` as  `comment` ,
     `_Inventory19075`.`_CrtDate` as  `created_at`
FROM `_Inventory19075`
  LEFT JOIN (
    SELECT prc.`product_id`,
            GROUP_CONCAT(DISTINCT prc.`price` SEPARATOR ',') as prices
    FROM (
        SELECT
            `_Segments16795`.`_Pck40784Jnt` as  `product_id` ,
            CONCAT(`_Inventory16575`.`_Pck40497`,'|',`_Segments16795`.`_Pck40788`) as price
            FROM `_Segments16795`
            LEFT JOIN `_Inventory16575` ON `_Inventory16575`.`_ID` = `_Segments16795`.`_Pck40785Jnt`
            WHERE `_Segments16795`.`_DstDate` IS NULL
          ) as prc
          GROUP BY prc.`product_id`) price_query ON price_query.`product_id` =  `_Inventory19075`.`_ID`
    LEFT JOIN (
        SELECT ctg.`product_id`,
               GROUP_CONCAT(DISTINCT ctg.`name` SEPARATOR ',') as name
        FROM (
          SELECT
              `_Segments17410`.`_Pck16181Jnt` as  `product_id` ,
              `_Inventory17075`.`_Pck15760` as  `name`
          FROM `_Segments17410`
          LEFT JOIN `_Inventory17075` ON `_Inventory17075`.`_ID` = `_Segments17410`.`_Pck16180Jnt`
          WHERE `_Segments17410`.`_DstDate` IS NULL
          AND `_Inventory17075`.`_DstDate` IS NULL
        ) as ctg
        GROUP BY ctg.`product_id`) product_category ON product_category.`product_id` =  `_Inventory19075`.`_ID`
LEFT JOIN `_Inventory76055` ON `_Inventory76055`.`_ID` =  `_Inventory19075`.`_Pck41774Jnt`  AND `_Inventory76055`.`_DstDate` IS NULL
LEFT JOIN `_Inventory11695` ON `_Inventory11695`.`_ID` =  `_Inventory19075`.`_Pck41777Jnt`  AND `_Inventory11695`.`_DstDate` IS NULL
LEFT JOIN `_Inventory17515` ON `_Inventory17515`.`_ID` =  `_Inventory19075`.`_Pck41715Jnt`  AND `_Inventory17515`.`_DstDate` IS NULL
WHERE  `_Inventory19075`.`_OID`  = 0
AND `_Inventory19075`.`_DstDate` IS NULL
ORDER BY `_Inventory19075`.`_CrtDate`
DESC
LIMIT 100
