CREATE OR REPLACE PACKAGE project_del AS 
    PROCEDURE backupTable(tableName VARCHAR2);
    --PROCEDURE deleteTableAll(tableName VARCHAR2);
    --PROCEDURE deleteTableWhere(tableName VARCHAR2, whereClause VARCHAR2);
END project_del;

