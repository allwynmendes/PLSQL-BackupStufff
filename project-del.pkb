CREATE OR REPLACE PACKAGE BODY project_del AS 
    PROCEDURE backupTable(tableName VARCHAR2) IS

    BEGIN
        DBMS_OUTPUT.PUT_LINE('TABLE NAME : ' || tableName);
    END backupTable;


END project_del;