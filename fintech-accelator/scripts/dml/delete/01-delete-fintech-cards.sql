-- DELETE last payment method
DELETE FROM fintech.payment_methods
WHERE methods_id = (SELECT methods_id 
                    FROM fintech.payment_methods
                    WHERE name = 'Apple Pay');