SELECT
    `_Document41310`.`_ID` AS `id`,
    `_Document41310`.`_Pck45811` AS  `seller` ,
    `_Document41310`.`_Pck45804Jnt` AS `seller_id`,
    `_Document41310`.`_Code` AS  `code` ,
    `_Document41310`.`_Pck45803` AS  `operation_date` ,
    `_Inventory17775`.`_ID` AS `customer_id`,
    IFNULL(`_Document41310`.`_Pck45807`,`_Document41310`.`_Pck45806`) AS customer,
    `_Document41310`.`_Pck45815` AS  `branch` ,
    `_Document41310`.`_Pck45805` AS  `status` ,
    CASE WHEN `_Document41310`.`_Pck45817` IS NOT NULL OR `_Document41310`.`_Pck45817` != '' THEN `_Document41310`.`_Pck45817` * 100 ELSE 0 END AS `discount_rate`,
    `_Document41310`.`_Pck45816` AS  `price` ,
    `_Document41310`.`_Pck45819` AS  `converted_price` ,
    CASE WHEN `_Document41310`.`_Pck45818` IS NOT NULL OR `_Document41310`.`_Pck45818` != '' THEN `_Document41310`.`_Pck45818` + `_Document41310`.`_Pck45819` ELSE NULL END AS `original_price`,
    `_Document41310`.`_Pck45825` AS  `vat_amount` ,
    `_Document41310`.`_Pck45826` AS  `amount_without_vat` ,
    `_Document41310`.`_Pck45824` AS  `vat_rate` ,
    `_Document41310`.`_Pck45823` AS  `currency` ,
    `_Document41310`.`_Pck45822` AS  `currency_value` ,
    `_Document41310`.`_Pck45828` AS  `comment` ,
    `_Document41310`.`_Pck45829` AS  `is_locked` ,
    `_Document41310`.`_Pck45833` AS  `paid_at` ,
    IFNULL(`_Document41310`.`_Pck45834`,0) AS paid_amount,
    (SELECT COUNT(1)
     FROM `_Document41310_Ls975`
     WHERE `_Document41310_Ls975`.`_DstDate` IS NULL
     AND `_Document41310_Ls975`.`_InvID` = `_Document41310`.`_ID`) AS product_count,
    (SELECT GROUP_CONCAT(CONCAT(`_Document41670`.`_Code`,'|ARRAY_DIVIDER|',`_Document41670`.`_ID`))
     FROM `_Document41670`
     WHERE `_Document41670`.`_InvID` = `_Document41310`.`_ID`
     AND `_Document41670`.`_DstDate` IS NULL
     AND `_Document41670`.`_Pck46239` = '0x00RS2') AS return_codes,
    `_Record11715`.`_Pck12537` AS  `bonus_amount` ,
    CASE WHEN `_Document41310`.`_Pck45833` IS NULL THEN '0' ELSE '1' END AS is_paid,
    (SELECT
        `_Inventory49065`.`_Pck54290`
     FROM `_Document41310_Ls975`
     LEFT JOIN `_Inventory49065` ON `_Document41310_Ls975`.`_Pck41315644Jnt` = `_Inventory49065`.`_ID` AND `_Inventory49065`.`_DstDate` IS NULL
     WHERE `_Document41310_Ls975`.`_InvID` = `_Document41310`.`_ID`
     AND `_Document41310_Ls975`.`_DstDate` IS NULL
     AND `_Document41310_Ls975`.`_OID` = 1
     LIMIT 1) AS warehouse,
    IFNULL((SELECT SUM(`_Record40680`.`_Pck45132` * `_Record40680`.`_Pck45134`)
            FROM `_Record40680`
            WHERE `_Record40680`.`_DstDate` IS NULL
            AND `_Record40680`.`_OID` = 1
            AND `_Record40680`.`_Pck45128Jnt` = `_Document41310`.`_ID`),0) AS cost_price
FROM `_Document41310`
LEFT JOIN `_Inventory7740` ON `_Inventory7740`.`_ID` = `_Document41310`.`_Pck45821Jnt` AND `_Inventory7740`.`_DstDate` IS NULL
LEFT JOIN `_Inventory17775` ON `_Inventory17775`.`_ID` = `_Document41310`.`_Pck45812Jnt` AND `_Inventory17775`.`_DstDate` IS NULL
LEFT JOIN `_Record11715` ON `_Record11715`.`_Pck12527Jnt` = `_Document41310`.`_ID` AND `_Record11715`.`_Pck12525Jnt` IS NOT NULL AND `_Record11715`.`_DstDate` IS NULL
WHERE `_Document41310`.`_OID` = 1
AND `_Document41310`.`_DstDate` IS NULL
AND `_Document41310`.`_Pck45803` >= '2023-08-01'
AND `_Document41310`.`_Pck45803` < '2023-08-29 00:00:00'
ORDER BY `_Document41310`.`_Pck45803`, `_Document41310`.`_Code` ASC
