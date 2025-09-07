# NORMALIZATION
# NORMALIZATION SATISFACTION
    Schema already satisfies **3NF**
## NORMALIZATION STEPS
1. **1NF**: Broke data into atomic attributes and set unique key (primary key) for each record
2. **2NF**: Chose surrogate primary keys (UUID) to avoid partial dependency issues
3. **3NF**: Ensured all non-key attributes depend only on the entity primary key, not on other non-key attributes