SET FOREIGN_KEY_CHECKS = 0;

SET @tables = (
    SELECT GROUP_CONCAT(table_name)
    FROM information_schema.tables
    WHERE table_schema = 'cdh8zs'
);

SET @stmt = CONCAT('DROP TABLE IF EXISTS ', @tables);
PREPARE stmt FROM @stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET FOREIGN_KEY_CHECKS = 1;

DROP TABLE Player;
DROP TABLE Team;
DROP TABLE Coach;