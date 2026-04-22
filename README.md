test
====

test 


-- ============================================================
-- 1. REFERENCE TABLE: Valid CAAR Role Names
-- ============================================================
CREATE TABLE ref_roles
(
    role_name       VARCHAR2(100)   NOT NULL,
    description     VARCHAR2(1000),
    created_by      VARCHAR2(255)   NOT NULL,
    created_at_utc  TIMESTAMP       NOT NULL,
    CONSTRAINT ref_roles_pk 
        PRIMARY KEY (role_name)
);

-- Seed data
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('BOOKING_FIRM',        'Legal entity that books the trade in its internal systems',                                         'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('BRANCH',              'Operational regulatory establishment of a Booking Firm in a host jurisdiction',                     'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('CLIENT',              'Legal or natural person that is the economic beneficiary of listed derivatives transactions',        'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('ASSET_OWNER',         'Ultimate economic beneficiary of the assets and risks',                                             'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('INVESTMENT_FUND',     'Legally constituted pool of assets created to invest according to a defined strategy',              'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('ASSET_MANAGER',       'Regulated legal entity that manages assets and makes investment decisions on behalf of Clients',    'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('FUND_ADMINISTRATOR',  'Regulated service provider for operational, accounting and reporting functions of a fund',          'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('INVESTMENT_ADVISOR',  'Entity that provides investment advice without discretionary control over assets',                  'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('CLEARING_FIRM',       'Legally incorporated entity authorized to clear listed derivatives, direct CCP member',             'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('EXECUTING_FIRM',      'Regulated intermediary that executes listed derivatives orders on an Exchange',                     'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('FLOOR_BROKER',        'Licensed individual or firm executing orders on the physical trading floor as agent',               'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('EXCHANGE',            'Regulated trading venue providing facilities for listing, price discovery and execution',           'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('CLEARING_HOUSE',      'Central Counterparty (CCP) that clears listed derivatives by novating between counterparties',     'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('CUSTODIAN',           'Regulated entity that safeguards client assets and collateral for listed derivatives positions',    'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_roles (role_name, description, created_by, created_at_utc) VALUES
    ('REGULATORY_AUTHORITY','Public or statutory body empowered to supervise and regulate the listed derivatives ecosystem',    'SYSTEM', SYSTIMESTAMP);

COMMIT;


-- ============================================================
-- 2. REFERENCE TABLE: Valid Role Relationship Rules
-- ============================================================
CREATE TABLE ref_relationship_rules
(
    rule_id               NUMBER          NOT NULL,
    from_role_name        VARCHAR2(100)   NOT NULL,
    to_role_name          VARCHAR2(100)   NOT NULL,
    relationship_type     VARCHAR2(100)   NOT NULL,
    description           VARCHAR2(1000),
    created_by            VARCHAR2(255)   NOT NULL,
    created_at_utc        TIMESTAMP       NOT NULL,
    CONSTRAINT ref_relationship_rules_pk
        PRIMARY KEY (rule_id),
    CONSTRAINT ref_rel_rules_uq
        UNIQUE (from_role_name, to_role_name, relationship_type),
    CONSTRAINT ref_rel_rules_from_fk
        FOREIGN KEY (from_role_name) REFERENCES ref_roles (role_name),
    CONSTRAINT ref_rel_rules_to_fk
        FOREIGN KEY (to_role_name)   REFERENCES ref_roles (role_name)
);

CREATE SEQUENCE ref_relationship_rules_seq START WITH 1 INCREMENT BY 1;

-- Seed data from CAAR relationships slide
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'BOOKING_FIRM',   'BRANCH',              'Operates Through',                'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'BRANCH',         'BRANCH',              'Books Through',                   'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'BOOKING_FIRM',   'CLEARING_FIRM',       'Clears Through',                  'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'BOOKING_FIRM',   'EXECUTING_FIRM',      'Executes Through',                'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'BOOKING_FIRM',   'BOOKING_FIRM',        'Provides Operational Services To','SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'CLEARING_FIRM',  'CLEARING_HOUSE',      'Clearing Member Of',              'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'EXECUTING_FIRM', 'EXCHANGE',            'Trading Member Of',               'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'CLEARING_HOUSE', 'EXCHANGE',            'Clears From',                     'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'CLEARING_FIRM',  'CLIENT',              'Executes For',                    'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'CLEARING_FIRM',  'CLIENT',              'Clears For',                      'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'ASSET_OWNER',    'INVESTMENT_FUND',     'Owns',                            'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'INVESTMENT_FUND','ASSET_MANAGER',       'Managed By',                      'SYSTEM', SYSTIMESTAMP);
INSERT INTO ref_relationship_rules
    (rule_id, from_role_name, to_role_name, relationship_type, created_by, created_at_utc)
VALUES (ref_relationship_rules_seq.NEXTVAL,
    'ASSET_OWNER',    'FUND_ADMINISTRATOR',  'Administrated By',                'SYSTEM', SYSTIMESTAMP);

COMMIT;


-- ============================================================
-- 3. AUDIT TABLE
-- ============================================================
CREATE TABLE audit_log
(
    audit_id        NUMBER          NOT NULL,
    table_name      VARCHAR2(100)   NOT NULL,
    record_id       VARCHAR2(255)   NOT NULL,
    operation       VARCHAR2(10)    NOT NULL,
    changed_by      VARCHAR2(255)   NOT NULL,
    changed_at_utc  TIMESTAMP       NOT NULL,
    old_values      CLOB,
    new_values      CLOB,
    session_info    VARCHAR2(1000),
    CONSTRAINT audit_log_pk
        PRIMARY KEY (audit_id),
    CONSTRAINT audit_log_op_ck
        CHECK (operation IN ('INSERT', 'UPDATE', 'DELETE'))
);

CREATE SEQUENCE audit_log_seq START WITH 1 INCREMENT BY 1;

-- Index for common query patterns
CREATE INDEX audit_log_table_record_idx 
    ON audit_log (table_name, record_id);
CREATE INDEX audit_log_changed_at_idx  
    ON audit_log (changed_at_utc);
CREATE INDEX audit_log_changed_by_idx  
    ON audit_log (changed_by);







