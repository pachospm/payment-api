CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE accounts(
    id BIGSERIAL PRIMARY KEY,
    account_number VARCHAR(20) NOT NULL DEFAULT 0.00,
    currency VARCHAR(3) NOT NULL DEFAULT 'COP',
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    user_id BIGINT NOT NULL REFERENCES users(id),
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE transactions(
    id BIGSERIAL PRIMARY KEY,
    origin_id BIGINT NOT NULL REFERENCES accounts(id),
    destination_id BIGINT NOT NULL REFERENCES accounts(id),
    amount NUMERIC(15,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    exchange_rate NUMERIC(10,6),
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    description VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_accounts_user ON accounts(user_id);
CREATE INDEX idx_transactions_origin ON transactions(origin_id);
CREATE INDEX idx_transactions_status ON transactions(destination_id);
CREATE INDEX idx_transactions_status ON transactions(status);
CREATE INDEX idx_transactions_date ON transactions(created_at);