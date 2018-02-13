CREATE OR REPLACE PACKAGE BODY project_del AS 

    PROCEDURE validateTable(p_tableName VARCHAR2, doBackup VARCHAR2) IS
        l_bkpTableName VARCHAR2(200);
        l_count1 number;
        l_count2 number;
        l_stmt1 varchar2(200);
    BEGIN
        SELECT COUNT(*) INTO l_count1 FROM tab WHERE tname = UPPER(p_tableName);
        IF l_count1 = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Table does not exist');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Table Exists');
            l_bkpTableName := CONCAT(p_tableName, '_BKP');
            l_stmt1 := 'SELECT COUNT(*) FROM '||p_tableName;
            EXECUTE IMMEDIATE l_stmt1 INTO l_count2;
            IF l_count2 = 0 THEN
                DBMS_OUTPUT.PUT_LINE('TABLE EMPTY. WHY TRUNCATE/DELETE ?');
            ELSE
                IF doBackup = 'Y' or doBackup = 'y' THEN
                    DBMS_OUTPUT.PUT_LINE('DO BACKUP and DELETE');
                    backupTable(l_bkpTableName, p_tableName);
                    deleteTableAll(p_tableName);
                ELSIF doBackup = 'N' or doBackup = 'n' THEN
                    DBMS_OUTPUT.PUT_LINE('JUST DELETE');
                END IF;
            END IF;
        END IF;
        COMMIT;
    END validateTable;

    PROCEDURE validateTable(p_tableName VARCHAR2, whereClause VARCHAR2, doBackup VARCHAR2) IS
        l_bkpTableName VARCHAR2(200);
        l_count1 number;
        l_count2 number;
        l_stmt1 varchar2(200);
    BEGIN
        SELECT COUNT(*) INTO l_count1 FROM tab WHERE tname = UPPER(p_tableName);
        IF l_count1 = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Table does not exist');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Table Exists');
            l_bkpTableName := CONCAT(p_tableName, '_BKP');
            l_stmt1 := 'SELECT COUNT(*) FROM '||p_tableName;
            EXECUTE IMMEDIATE l_stmt1 INTO l_count2;
            IF l_count2 = 0 THEN
                DBMS_OUTPUT.PUT_LINE('TABLE EMPTY. WHY TRUNCATE/DELETE ?');
            ELSE
                IF doBackup = 'Y' or doBackup = 'y' THEN
                    DBMS_OUTPUT.PUT_LINE('DO BACKUP and DELETE');
                    backupTable(l_bkpTableName, p_tableName);
                ELSIF doBackup = 'N' or doBackup = 'n' THEN
                    DBMS_OUTPUT.PUT_LINE('JUST DELETE');
                END IF;
            END IF;
        END IF;
        COMMIT;
    END validateTable;

    PROCEDURE backupTable(p_tableName VARCHAR2, p_sourceTable VARCHAR2) IS
        l_stmt1 VARCHAR2(200);
        l_count1 number;
    BEGIN
        SELECT COUNT(*) INTO l_count1 FROM tab WHERE tname = UPPER(p_tableName);
        IF l_count1 = 0 THEN
            DBMS_OUTPUT.PUT_LINE('CREATING BACKUP TABLE : '||p_tableName);
            l_stmt1 := 'CREATE TABLE '||p_tableName||' AS SELECT * FROM '||p_sourceTable;
            --USE : grant create any table to allwyn
            EXECUTE IMMEDIATE l_stmt1;
        ELSE
            DBMS_OUTPUT.PUT_LINE('DROPPING AND CREATING BACKUP TABLE : '||p_tableName);
            l_stmt1 := 'DROP TABLE '||p_tableName;
            EXECUTE IMMEDIATE l_stmt1;
            l_stmt1 := 'CREATE TABLE '||p_tableName||' AS SELECT * FROM '||p_sourceTable;
            EXECUTE IMMEDIATE l_stmt1;
        END IF;
    END backupTable;

    PROCEDURE deleteTableAll(tableName VARCHAR2) IS
        l_stmt1 VARCHAR2(200);
    BEGIN
        l_stmt1 := 'DELETE FROM '||tableName;
        EXECUTE IMMEDIATE l_stmt1;
    END deleteTableAll;


END project_del;
