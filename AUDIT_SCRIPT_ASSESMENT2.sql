-- FOR AUDIT CUSTOMER TABLE
DROP TABLE AUDIT_CUSTOMER CASCADE CONSTRAINTS;

-- CREATING TABLE TO KEEP TRACK OF CUSTOMER DETAIL IF INSERTED, DELETED OR UPDATED
CREATE TABLE AUDIT_CUSTOMER(
    CUST_ID NUMBER(5) NOT NULL,
    CUST_NAME VARCHAR2(30) NOT NULL,
    CUST_PHONENO NUMBER(15) UNIQUE,
    CUST_ADDRESS VARCHAR2(30) NOT NULL,
    CUST_EMAIL VARCHAR2(30) UNIQUE,
    AUDIT_USER VARCHAR2(50),
    AUDIT_DATE DATE,
    AUDIT_ACTION VARCHAR2(6)
);

-- TRIGGER FOR AUDIT_CUSTOMER TABLE
COMMIT;
CREATE OR REPLACE TRIGGER trg_auditcustomer
  AFTER INSERT OR DELETE OR UPDATE ON CUSTOMER
  FOR EACH ROW
DECLARE
  v_trg_action VARCHAR2(6);
BEGIN
  IF updating
  THEN
    
    v_trg_action := 'UPDATE';
  ELSIF deleting
  THEN
    
    v_trg_action := 'DELETE';
  ELSIF inserting
  THEN
    
    v_trg_action := 'INSERT';
  ELSE
    
    v_trg_action := NULL;
  END IF;
  
  -- if v_trg_action is DELETE OR UPDATE then insert new table values
  IF v_trg_action IN ('DELETE','UPDATE') THEN
      
   INSERT INTO AUDIT_CUSTOMER
  ( CUST_ID,  CUST_NAME,  CUST_PHONENO, CUST_ADDRESS, CUST_EMAIL, AUDIT_USER,  AUDIT_DATE,  AUDIT_ACTION)
   VALUES
  (:OLD.CUST_ID, :OLD.CUST_NAME, :OLD.CUST_PHONENO, :OLD.CUST_ADDRESS, :OLD.CUST_EMAIL, UPPER(v('APP_USER')), SYSDATE, v_trg_action);
  ELSE
      -- if v_trg_action is INSERT then insert new table values
   INSERT INTO AUDIT_CUSTOMER
   ( CUST_ID,  CUST_NAME,  CUST_PHONENO, CUST_ADDRESS, CUST_EMAIL, AUDIT_USER,  AUDIT_DATE,  AUDIT_ACTION)
   VALUES
   (:NEW.CUST_ID, :NEW.CUST_NAME, :NEW.CUST_PHONENO, :NEW.CUST_ADDRESS, :NEW.CUST_EMAIL, UPPER(v('APP_USER')), SYSDATE, v_trg_action);
  END IF;
END trg_auditcustomer;
/

-- FOR AUDIT_STAFF TABLE
DROP TABLE AUDIT_STAFF CASCADE CONSTRAINTS;

-- CREATING TABLE TO KEEP TRACK OF STAFF DETAIL IF INSERTED, DELETED OR UPDATED
CREATE TABLE AUDIT_STAFF(
    STAFF_ID NUMBER(5) NOT NULL,
    STAFF_NAME VARCHAR2(20),
    GENDER VARCHAR2(20),
    JOB VARCHAR2(20),
    STAFF_SALARY NUMBER(10),
    SHIFT VARCHAR2(20),
    STAFF_MGR NUMBER(5),
    CPS_ID NUMBER(4) NOT NULL,
    AUDIT_USER VARCHAR2(50),
    AUDIT_DATE DATE,
    AUDIT_ACTION VARCHAR2(6)
);

-- TRIGGER FOR AUDIT_STAFF TABLE
COMMIT;
CREATE OR REPLACE TRIGGER trg_auditstaff
  AFTER INSERT OR DELETE OR UPDATE ON STAFF
  FOR EACH ROW
DECLARE
  v_trigaction VARCHAR2(6);
BEGIN
  IF updating
  THEN
    
    v_trigaction := 'UPDATE';
  ELSIF deleting
  THEN
    
    v_trigaction := 'DELETE';
  ELSIF inserting
  THEN
    
    v_trigaction := 'INSERT';
  ELSE
    
    v_trigaction := NULL;
  END IF;
  
  -- if v_trigaction is DELETE OR UPDATE then insert new table values
  IF v_trigaction IN ('DELETE','UPDATE') THEN
      
   INSERT INTO AUDIT_STAFF
  ( STAFF_ID,  STAFF_NAME,  GENDER, JOB, STAFF_SALARY, SHIFT, STAFF_MGR, CPS_ID, AUDIT_USER,  AUDIT_DATE,  AUDIT_ACTION)
   VALUES
  (:OLD.STAFF_ID, :OLD.STAFF_NAME, :OLD.GENDER, :OLD.JOB, :OLD.STAFF_SALARY, :OLD.SHIFT, :OLD.STAFF_MGR, :OLD.CPS_ID, UPPER(v('APP_USER')), SYSDATE, v_trigaction);
  ELSE
    
  -- if v_trigaction is insert then insert new table values
   INSERT INTO AUDIT_STAFF
  ( STAFF_ID,  STAFF_NAME,  GENDER, JOB, STAFF_SALARY, SHIFT, STAFF_MGR, CPS_ID, AUDIT_USER,  AUDIT_DATE,  AUDIT_ACTION)
   VALUES
  (:NEW.STAFF_ID, :NEW.STAFF_NAME, :NEW.GENDER, :NEW.JOB, :NEW.STAFF_SALARY, :NEW.SHIFT, :NEW.STAFF_MGR, :NEW.CPS_ID, UPPER(v('APP_USER')), SYSDATE, v_trigaction);
  END IF;
END trg_auditstaff;
/


-- FOR AUDIT_OWNER TABLE
DROP TABLE AUDIT_OWNER CASCADE CONSTRAINTS;

-- CREATING TABLE TO KEEP TRACK OF OWWNER DETAIL IF INSERTED, DELETED OR UPDATED
CREATE TABLE AUDIT_OWNER(
    OWNER_ID NUMBER(5) NOT NULL,
    OWNER_NAME VARCHAR2(30),
    OWNER_ADDRESS VARCHAR2(30),
    OWNER_AGE NUMBER(3),
    TYPE_OWNER VARCHAR2(20),
    NO_CARAVAN_OWNED NUMBER(8),
    OWNER_MGR NUMBER(8),
    AUDIT_USER VARCHAR2(50),
    AUDIT_DATE DATE,
    AUDIT_ACTION VARCHAR2(6)
);

-- TRIGGER FOR AUDIT_OWNER TABLE
COMMIT;
CREATE OR REPLACE TRIGGER trg_auditowner
  AFTER INSERT OR DELETE OR UPDATE ON OWNER
  FOR EACH ROW
DECLARE
  v_trigaction VARCHAR2(6);
BEGIN
  IF updating
  THEN
    
    v_trigaction := 'UPDATE';
  ELSIF deleting
  THEN
    
    v_trigaction := 'DELETE';
  ELSIF inserting
  THEN
    
    v_trigaction := 'INSERT';
  ELSE
    
    v_trigaction := NULL;
  END IF;
    -- if v_trigaction is DELETE OR UPDATE then insert new table values
  IF v_trigaction IN ('DELETE','UPDATE') THEN
      
   INSERT INTO AUDIT_OWNER
  ( OWNER_ID,  OWNER_NAME,  OWNER_ADDRESS, OWNER_AGE, TYPE_OWNER, NO_CARAVAN_OWNED, OWNER_MGR, AUDIT_USER,  AUDIT_DATE,  AUDIT_ACTION)
   VALUES
  (:OLD.OWNER_ID, :OLD.OWNER_NAME, :OLD.OWNER_ADDRESS, :OLD.OWNER_AGE, :OLD.TYPE_OWNER, :OLD.NO_CARAVAN_OWNED,:OLD.OWNER_MGR, UPPER(v('APP_USER')), SYSDATE, v_trigaction);
  ELSE
      -- if v_trigaction is INSERT then insert new table values
   INSERT INTO AUDIT_OWNER
  ( OWNER_ID,  OWNER_NAME,  OWNER_ADDRESS, OWNER_AGE, TYPE_OWNER, NO_CARAVAN_OWNED,OWNER_MGR, AUDIT_USER,  AUDIT_DATE,  AUDIT_ACTION)
   VALUES
  (:NEW.OWNER_ID, :NEW.OWNER_NAME, :NEW.OWNER_ADDRESS, :NEW.OWNER_AGE, :NEW.TYPE_OWNER, :NEW.NO_CARAVAN_OWNED,:NEW.OWNER_MGR, UPPER(v('APP_USER')), SYSDATE, v_trigaction);
  END IF;
END trg_auditowner;
/