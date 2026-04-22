-- ============================================================
-- relationship_rules
-- ============================================================
CREATE TABLE relationship_rules
(
    rule_id            NUMBER          NOT NULL,
    from_role_name     VARCHAR2(100)   NOT NULL,
    to_role_name       VARCHAR2(100)   NOT NULL,
    relationship_type  VARCHAR2(100)   NOT NULL,
    CONSTRAINT relationship_rules_pk
        PRIMARY KEY (rule_id),
    CONSTRAINT relationship_rules_uq
        UNIQUE (from_role_name, to_role_name, relationship_type),
    CONSTRAINT relationship_rules_from_fk
        FOREIGN KEY (from_role_name) REFERENCES role_names (role_name),
    CONSTRAINT relationship_rules_to_fk
        FOREIGN KEY (to_role_name)   REFERENCES role_names (role_name)
);

CREATE SEQUENCE relationship_rules_seq START WITH 1 INCREMENT BY 1;

-- Seed data from CAAR relationships slide
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'BOOKING_FIRM',    'BRANCH',             'OPERATES_THROUGH');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'BRANCH',          'BRANCH',             'BOOKS_THROUGH');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'BOOKING_FIRM',    'CLEARING_FIRM',      'CLEARS_THROUGH');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'BOOKING_FIRM',    'EXECUTING_FIRM',     'EXECUTES_THROUGH');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'BOOKING_FIRM',    'BOOKING_FIRM',       'PROVIDES_OPERATIONAL_SERVICES_TO');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'CLEARING_FIRM',   'CLEARING_HOUSE',     'CLEARING_MEMBER_OF');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'EXECUTING_FIRM',  'EXCHANGE',           'TRADING_MEMBER_OF');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'CLEARING_HOUSE',  'EXCHANGE',           'CLEARS_FROM');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'CLEARING_FIRM',   'CLIENT',             'EXECUTES_FOR');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'CLEARING_FIRM',   'CLIENT',             'CLEARS_FOR');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'ASSET_OWNER',     'INVESTMENT_FUND',    'OWNS');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'INVESTMENT_FUND', 'ASSET_MANAGER',      'MANAGED_BY');
INSERT INTO relationship_rules (rule_id, from_role_name, to_role_name, relationship_type)
VALUES (relationship_rules_seq.NEXTVAL, 'ASSET_OWNER',     'FUND_ADMINISTRATOR', 'ADMINISTRATED_BY');

COMMIT;