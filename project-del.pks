CREATE OR REPLACE PACKAGE project_del AS 
    PROCEDURE validateTable(p_tableName VARCHAR2, doBackup varchar2);
    PROCEDURE validateTable(p_tableName VARCHAR2, whereClause VARCHAR2, doBackup varchar2);
    PROCEDURE backupTableAll(p_tableName VARCHAR2, p_sourceTable VARCHAR2);
    PROCEDURE backupTableWhere(p_tableName VARCHAR2, whereClause VARCHAR2, p_sourceTable VARCHAR2);
    PROCEDURE deleteTableAll(tableName VARCHAR2);
    PROCEDURE deleteTableWhere(tableName VARCHAR2, whereClause VARCHAR2);
END project_del;

