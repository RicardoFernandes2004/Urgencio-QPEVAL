CREATE SCHEMA IF NOT EXISTS urgencio;
SET search_path TO urgencio;

CREATE TYPE severity AS ENUM ('low', 'medium', 'high', 'critical');
CREATE TYPE status AS ENUM ('open', 'in_progress', 'resolved', 'closed');
CREATE TYPE area as ENUM ('backend', 'frontend', 'database', 'infrastructure', 'devops', 'security', 'other');
CREATE TYPE customer_tier as ENUM ('free', 'standard', 'premium', 'enterprise');


CREATE TABLE IF NOT EXISTS urgencio.issue(
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES urgencio.project(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    severity severity NOT NULL,
    status status NOT NULL,
    area area NOT NULL,
    priority_score INT,
    customer_tier customer_tier NOT NULL

)

CREATE TABLE IF NOT EXISTS urgencio.project(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS urgencio.comment(
    id SERIAL PRIMARY KEY,
    issue_id INT REFERENCES urgencio.issue(id) ON DELETE CASCADE,
    author VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);