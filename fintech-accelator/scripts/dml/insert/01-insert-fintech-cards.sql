-- INSERT PAYMENT METHODS
SELECT DISTINCT name AS payment_methods
FROM fintech.payment_methods

-- INSERT payment methods
INSERT INTO fintech.payment_methods (name) VALUES ('Apple Pay');

-- INSERT Foreing Key
-- FK : issuers
-- FK : 
INSERT INTO fintech.franchises (name, issuer_id, country_code)
VALUES ('UpFranchisesBDI-2025', 'ISU-5621631365820580507321210', (SELECT country_code FROM fintech.countries WHERE name = 'Colombia' LIMIT 1));
