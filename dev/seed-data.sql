-- TeamIO Seed Data Script (Expanded)
-- Run this after migrations to populate sample data for development/testing
-- Usage: make db-seed (from dev/ directory)
--
-- ID Convention:
--   Users:              a0000xxx-0000-0000-0000-000000000001
--   Organizations:      b0000xxx-0000-0000-0000-000000000001
--   Fields:             c0000xxx-0000-0000-0000-000000000001
--   Leagues:            d0000xxx-0000-0000-0000-000000000001
--   Seasons:            e0000xxx-0000-0000-0000-000000000001
--   Divisions:          f0000xxx-0000-0000-0000-000000000001
--   Coaches:            10000xxx-0000-0000-0000-000000000001
--   Teams:              11000xxx-0000-0000-0000-000000000001
--   Guardians:          12000xxx-0000-0000-0000-000000000001
--   Players:            13000xxx-0000-0000-0000-000000000001
--   Player-Guardians:   14000xxx-0000-0000-0000-000000000001
--   Scheduled Events:   15000xxx-0000-0000-0000-000000000001
--   Calendar Subs:      16000xxx-0000-0000-0000-000000000001
--   Field Availability: 17000xxx-0000-0000-0000-000000000001
--   League Orgs:        18000xxx-0000-0000-0000-000000000001
--   User Orgs:          19000xxx-0000-0000-0000-000000000001
--   Registrations:      1a000xxx-0000-0000-0000-000000000001
--   Field Fee Schedules:1b000xxx-0000-0000-0000-000000000001

-- ============================================================================
-- USERS (password is 'password123' hashed with argon2)
-- ============================================================================
INSERT INTO users (id, email, password_hash, first_name, last_name, phone, role, is_active, created_at, updated_at) VALUES
-- System admin user
('a0000001-0000-0000-0000-000000000001', 'sysadmin@getteamio.com', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'System', 'Admin', '555-0100', 'admin', true, NOW(), NOW()),
-- Commissioner (Riverside)
('a0000002-0000-0000-0000-000000000001', 'commissioner@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'League', 'Commissioner', '555-0101', 'commissioner', true, NOW(), NOW()),
-- Coaches (Riverside)
('a0000010-0000-0000-0000-000000000001', 'coach.smith@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'John', 'Smith', '555-0110', 'coach', true, NOW(), NOW()),
('a0000011-0000-0000-0000-000000000001', 'coach.johnson@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Sarah', 'Johnson', '555-0111', 'coach', true, NOW(), NOW()),
('a0000012-0000-0000-0000-000000000001', 'coach.williams@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Mike', 'Williams', '555-0112', 'coach', true, NOW(), NOW()),
('a0000013-0000-0000-0000-000000000001', 'coach.brown@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Emily', 'Brown', '555-0113', 'coach', true, NOW(), NOW()),
-- Parents/Guardians (Riverside)
('a0000020-0000-0000-0000-000000000001', 'parent.jones@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Robert', 'Jones', '555-0120', 'guardian', true, NOW(), NOW()),
('a0000021-0000-0000-0000-000000000001', 'parent.davis@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Jennifer', 'Davis', '555-0121', 'guardian', true, NOW(), NOW()),
('a0000022-0000-0000-0000-000000000001', 'parent.miller@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'David', 'Miller', '555-0122', 'guardian', true, NOW(), NOW()),
('a0000023-0000-0000-0000-000000000001', 'parent.wilson@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Lisa', 'Wilson', '555-0123', 'guardian', true, NOW(), NOW()),
-- Players (Riverside - existing)
('a0000030-0000-0000-0000-000000000001', 'player1@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Jake', 'Jones', NULL, 'player', true, NOW(), NOW()),
('a0000031-0000-0000-0000-000000000001', 'player2@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Emma', 'Davis', NULL, 'player', true, NOW(), NOW()),
('a0000032-0000-0000-0000-000000000001', 'player3@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Liam', 'Miller', NULL, 'player', true, NOW(), NOW()),
('a0000033-0000-0000-0000-000000000001', 'player4@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Sophia', 'Wilson', NULL, 'player', true, NOW(), NOW()),
('a0000034-0000-0000-0000-000000000001', 'player5@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Noah', 'Taylor', NULL, 'player', true, NOW(), NOW()),
('a0000035-0000-0000-0000-000000000001', 'player6@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Olivia', 'Anderson', NULL, 'player', true, NOW(), NOW()),
('a0000036-0000-0000-0000-000000000001', 'player7@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Mason', 'Thomas', NULL, 'player', true, NOW(), NOW()),
('a0000037-0000-0000-0000-000000000001', 'player8@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Ava', 'Jackson', NULL, 'player', true, NOW(), NOW()),
('a0000038-0000-0000-0000-000000000001', 'player9@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Ethan', 'White', NULL, 'player', true, NOW(), NOW()),
('a0000039-0000-0000-0000-000000000001', 'player10@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Isabella', 'Harris', NULL, 'player', true, NOW(), NOW()),
('a0000040-0000-0000-0000-000000000001', 'player11@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Aiden', 'Martin', NULL, 'player', true, NOW(), NOW()),
('a0000041-0000-0000-0000-000000000001', 'player12@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Mia', 'Garcia', NULL, 'player', true, NOW(), NOW()),

-- ===== NEW USERS =====
-- Commissioner (Valley Select)
('a0000003-0000-0000-0000-000000000001', 'commissioner.valley@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Carlos', 'Rivera', '555-0102', 'commissioner', true, NOW(), NOW()),
-- Commissioner (Tournament Org)
('a0000004-0000-0000-0000-000000000001', 'commissioner.tournament@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Patricia', 'Nguyen', '555-0103', 'commissioner', true, NOW(), NOW()),
-- Coaches (Valley Select)
('a0000014-0000-0000-0000-000000000001', 'coach.martinez@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Luis', 'Martinez', '555-0114', 'coach', true, NOW(), NOW()),
('a0000015-0000-0000-0000-000000000001', 'coach.lee@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Kevin', 'Lee', '555-0115', 'coach', true, NOW(), NOW()),
('a0000016-0000-0000-0000-000000000001', 'coach.patel@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Raj', 'Patel', '555-0116', 'coach', true, NOW(), NOW()),
('a0000017-0000-0000-0000-000000000001', 'coach.campbell@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Denise', 'Campbell', '555-0117', 'coach', true, NOW(), NOW()),
-- Parents/Guardians (Valley Select)
('a0000024-0000-0000-0000-000000000001', 'parent.chen@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Wei', 'Chen', '555-0124', 'guardian', true, NOW(), NOW()),
('a0000025-0000-0000-0000-000000000001', 'parent.brooks@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Tamika', 'Brooks', '555-0125', 'guardian', true, NOW(), NOW()),
('a0000026-0000-0000-0000-000000000001', 'parent.garcia@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Miguel', 'Garcia', '555-0126', 'guardian', true, NOW(), NOW()),
('a0000027-0000-0000-0000-000000000001', 'parent.kim@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Soo-Yeon', 'Kim', '555-0127', 'guardian', true, NOW(), NOW()),
-- Players (Valley Select travel baseball + Hillcrest soccer)
('a0000042-0000-0000-0000-000000000001', 'player13@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Dylan', 'Chen', NULL, 'player', true, NOW(), NOW()),
('a0000043-0000-0000-0000-000000000001', 'player14@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Marcus', 'Brooks', NULL, 'player', true, NOW(), NOW()),
('a0000044-0000-0000-0000-000000000001', 'player15@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Sofia', 'Garcia', NULL, 'player', true, NOW(), NOW()),
('a0000045-0000-0000-0000-000000000001', 'player16@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Hana', 'Kim', NULL, 'player', true, NOW(), NOW()),
('a0000046-0000-0000-0000-000000000001', 'player17@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Tyler', 'Reeves', NULL, 'player', true, NOW(), NOW()),
('a0000047-0000-0000-0000-000000000001', 'player18@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Jasmine', 'Okafor', NULL, 'player', true, NOW(), NOW()),
('a0000048-0000-0000-0000-000000000001', 'player19@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Brandon', 'Tran', NULL, 'player', true, NOW(), NOW()),
('a0000049-0000-0000-0000-000000000001', 'player20@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Aaliyah', 'Washington', NULL, 'player', true, NOW(), NOW()),
('a0000050-0000-0000-0000-000000000001', 'player21@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Ryan', 'Patel', NULL, 'player', true, NOW(), NOW()),
('a0000051-0000-0000-0000-000000000001', 'player22@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Chloe', 'Martinez', NULL, 'player', true, NOW(), NOW()),
('a0000052-0000-0000-0000-000000000001', 'player23@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Jayden', 'Campbell', NULL, 'player', true, NOW(), NOW()),
('a0000053-0000-0000-0000-000000000001', 'player24@teamio.local', '$argon2id$v=19$m=19456,t=2,p=1$PuvgXS+7WnX9hTsGPhjfhQ$/pxhEjh9AAacX1zCyBq4C6aVN18dajrmCN2U+3K5+gM', 'Zoe', 'Rivera', NULL, 'player', true, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- ORGANIZATIONS
-- ============================================================================
INSERT INTO organizations (id, name, slug, org_type, description, address, city, state, zip_code, phone, email, website, sport, competition_level, seeking_opponents, seeking_tournaments, travel_radius_miles, is_active, is_verified, created_at, updated_at) VALUES
('b0000001-0000-0000-0000-000000000001', 'Riverside Parks & Recreation', 'riverside-parks-recreation', 'parks_rec', 'Community sports programs for all ages', '123 Main Street', 'Riverside', 'CA', '92501', '555-1000', 'info@riversideparks.local', 'https://riversideparks.local', NULL, 'recreational', false, false, NULL, true, true, NOW(), NOW()),
('b0000002-0000-0000-0000-000000000001', 'Valley Select Baseball', 'valley-select-baseball', 'travel_team', 'Competitive travel baseball program serving the Hillcrest and Central Valley area', '450 Oak Ridge Drive', 'Hillcrest', 'CA', '92506', '555-2000', 'info@valleyselect.local', 'https://valleyselect.local', 'baseball', 'competitive', true, true, 75, true, true, NOW(), NOW()),
('b0000003-0000-0000-0000-000000000001', 'Central Valley Tournament Series', 'central-valley-tournament-series', 'tournament_org', 'Premier youth tournament organizer for the Central Valley region', '900 Tournament Blvd', 'Fresno', 'CA', '93721', '555-3000', 'info@cvtournaments.local', 'https://cvtournaments.local', NULL, 'competitive', false, false, NULL, true, true, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- FIELDS
-- ============================================================================
INSERT INTO fields (id, organization_id, name, description, address, city, state, zip_code, field_type, field_size, surface_type, has_lights, is_active, created_at, updated_at) VALUES
-- Riverside Parks fields (existing)
('c0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Central Park Field 1', 'Main soccer field', '500 Park Avenue', 'Riverside', 'CA', '92501', 'soccer', 'full', 'grass', true, true, NOW(), NOW()),
('c0000002-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Central Park Field 2', 'Secondary soccer field', '500 Park Avenue', 'Riverside', 'CA', '92501', 'soccer', 'full', 'grass', true, true, NOW(), NOW()),
('c0000003-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Riverside Sports Complex A', 'Multi-purpose turf field', '800 Sports Drive', 'Riverside', 'CA', '92502', 'multi-purpose', 'full', 'turf', true, true, NOW(), NOW()),
('c0000004-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Riverside Sports Complex B', 'Multi-purpose turf field', '800 Sports Drive', 'Riverside', 'CA', '92502', 'multi-purpose', 'full', 'turf', true, true, NOW(), NOW()),
('c0000005-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Community Center Gym', 'Indoor basketball court', '300 Community Way', 'Riverside', 'CA', '92503', 'basketball', 'full', 'hardwood', true, true, NOW(), NOW()),
-- Valley Select fields (NEW)
('c0000006-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'Hillcrest Sports Park Field 1', 'Primary baseball diamond with full amenities', '450 Oak Ridge Drive', 'Hillcrest', 'CA', '92506', 'baseball', 'full', 'grass', true, true, NOW(), NOW()),
('c0000007-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'Hillcrest Sports Park Field 2', 'Secondary baseball diamond', '450 Oak Ridge Drive', 'Hillcrest', 'CA', '92506', 'baseball', 'full', 'grass', true, true, NOW(), NOW()),
-- Tournament Org field (NEW)
('c0000008-0000-0000-0000-000000000001', 'b0000003-0000-0000-0000-000000000001', 'Central Valley Tournament Complex', 'Multi-field tournament complex with 4 diamonds', '900 Tournament Blvd', 'Fresno', 'CA', '93721', 'multi-purpose', 'full', 'turf', true, true, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- FIELD AVAILABILITY (recurring weekly schedules)
-- day_of_week: 0=Sunday, 1=Monday, ... 6=Saturday
-- ============================================================================
INSERT INTO field_availability (id, field_id, day_of_week, start_time, end_time, availability_type, created_at, updated_at) VALUES
-- Central Park Field 1 (Riverside)
('17000001-0000-0000-0000-000000000001', 'c0000001-0000-0000-0000-000000000001', 0, '08:00:00', '18:00:00', 'available', NOW(), NOW()),  -- Sunday
('17000002-0000-0000-0000-000000000001', 'c0000001-0000-0000-0000-000000000001', 1, '16:00:00', '21:00:00', 'available', NOW(), NOW()),  -- Monday
('17000003-0000-0000-0000-000000000001', 'c0000001-0000-0000-0000-000000000001', 2, '16:00:00', '21:00:00', 'available', NOW(), NOW()),  -- Tuesday
('17000004-0000-0000-0000-000000000001', 'c0000001-0000-0000-0000-000000000001', 3, '16:00:00', '21:00:00', 'available', NOW(), NOW()),  -- Wednesday
('17000005-0000-0000-0000-000000000001', 'c0000001-0000-0000-0000-000000000001', 4, '16:00:00', '21:00:00', 'available', NOW(), NOW()),  -- Thursday
('17000006-0000-0000-0000-000000000001', 'c0000001-0000-0000-0000-000000000001', 5, '16:00:00', '21:00:00', 'available', NOW(), NOW()),  -- Friday
('17000007-0000-0000-0000-000000000001', 'c0000001-0000-0000-0000-000000000001', 6, '08:00:00', '18:00:00', 'available', NOW(), NOW()),  -- Saturday

-- Central Park Field 2 (Riverside)
('17000008-0000-0000-0000-000000000001', 'c0000002-0000-0000-0000-000000000001', 0, '08:00:00', '18:00:00', 'available', NOW(), NOW()),
('17000009-0000-0000-0000-000000000001', 'c0000002-0000-0000-0000-000000000001', 1, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000010-0000-0000-0000-000000000001', 'c0000002-0000-0000-0000-000000000001', 2, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000011-0000-0000-0000-000000000001', 'c0000002-0000-0000-0000-000000000001', 3, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000012-0000-0000-0000-000000000001', 'c0000002-0000-0000-0000-000000000001', 4, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000013-0000-0000-0000-000000000001', 'c0000002-0000-0000-0000-000000000001', 5, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000014-0000-0000-0000-000000000001', 'c0000002-0000-0000-0000-000000000001', 6, '08:00:00', '18:00:00', 'available', NOW(), NOW()),

-- Riverside Sports Complex A
('17000015-0000-0000-0000-000000000001', 'c0000003-0000-0000-0000-000000000001', 0, '08:00:00', '18:00:00', 'available', NOW(), NOW()),
('17000016-0000-0000-0000-000000000001', 'c0000003-0000-0000-0000-000000000001', 1, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000017-0000-0000-0000-000000000001', 'c0000003-0000-0000-0000-000000000001', 2, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000018-0000-0000-0000-000000000001', 'c0000003-0000-0000-0000-000000000001', 3, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000019-0000-0000-0000-000000000001', 'c0000003-0000-0000-0000-000000000001', 4, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000020-0000-0000-0000-000000000001', 'c0000003-0000-0000-0000-000000000001', 5, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000021-0000-0000-0000-000000000001', 'c0000003-0000-0000-0000-000000000001', 6, '08:00:00', '18:00:00', 'available', NOW(), NOW()),

-- Riverside Sports Complex B
('17000022-0000-0000-0000-000000000001', 'c0000004-0000-0000-0000-000000000001', 0, '08:00:00', '18:00:00', 'available', NOW(), NOW()),
('17000023-0000-0000-0000-000000000001', 'c0000004-0000-0000-0000-000000000001', 1, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000024-0000-0000-0000-000000000001', 'c0000004-0000-0000-0000-000000000001', 2, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000025-0000-0000-0000-000000000001', 'c0000004-0000-0000-0000-000000000001', 3, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000026-0000-0000-0000-000000000001', 'c0000004-0000-0000-0000-000000000001', 4, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000027-0000-0000-0000-000000000001', 'c0000004-0000-0000-0000-000000000001', 5, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000028-0000-0000-0000-000000000001', 'c0000004-0000-0000-0000-000000000001', 6, '08:00:00', '18:00:00', 'available', NOW(), NOW()),

-- Community Center Gym
('17000029-0000-0000-0000-000000000001', 'c0000005-0000-0000-0000-000000000001', 0, '08:00:00', '18:00:00', 'available', NOW(), NOW()),
('17000030-0000-0000-0000-000000000001', 'c0000005-0000-0000-0000-000000000001', 1, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000031-0000-0000-0000-000000000001', 'c0000005-0000-0000-0000-000000000001', 2, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000032-0000-0000-0000-000000000001', 'c0000005-0000-0000-0000-000000000001', 3, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000033-0000-0000-0000-000000000001', 'c0000005-0000-0000-0000-000000000001', 4, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000034-0000-0000-0000-000000000001', 'c0000005-0000-0000-0000-000000000001', 5, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000035-0000-0000-0000-000000000001', 'c0000005-0000-0000-0000-000000000001', 6, '08:00:00', '18:00:00', 'available', NOW(), NOW()),

-- Hillcrest Sports Park Field 1
('17000036-0000-0000-0000-000000000001', 'c0000006-0000-0000-0000-000000000001', 0, '08:00:00', '18:00:00', 'available', NOW(), NOW()),
('17000037-0000-0000-0000-000000000001', 'c0000006-0000-0000-0000-000000000001', 1, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000038-0000-0000-0000-000000000001', 'c0000006-0000-0000-0000-000000000001', 2, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000039-0000-0000-0000-000000000001', 'c0000006-0000-0000-0000-000000000001', 3, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000040-0000-0000-0000-000000000001', 'c0000006-0000-0000-0000-000000000001', 4, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000041-0000-0000-0000-000000000001', 'c0000006-0000-0000-0000-000000000001', 5, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000042-0000-0000-0000-000000000001', 'c0000006-0000-0000-0000-000000000001', 6, '08:00:00', '18:00:00', 'available', NOW(), NOW()),

-- Hillcrest Sports Park Field 2
('17000043-0000-0000-0000-000000000001', 'c0000007-0000-0000-0000-000000000001', 0, '08:00:00', '18:00:00', 'available', NOW(), NOW()),
('17000044-0000-0000-0000-000000000001', 'c0000007-0000-0000-0000-000000000001', 1, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000045-0000-0000-0000-000000000001', 'c0000007-0000-0000-0000-000000000001', 2, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000046-0000-0000-0000-000000000001', 'c0000007-0000-0000-0000-000000000001', 3, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000047-0000-0000-0000-000000000001', 'c0000007-0000-0000-0000-000000000001', 4, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000048-0000-0000-0000-000000000001', 'c0000007-0000-0000-0000-000000000001', 5, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000049-0000-0000-0000-000000000001', 'c0000007-0000-0000-0000-000000000001', 6, '08:00:00', '18:00:00', 'available', NOW(), NOW()),

-- Central Valley Tournament Complex
('17000050-0000-0000-0000-000000000001', 'c0000008-0000-0000-0000-000000000001', 0, '08:00:00', '18:00:00', 'available', NOW(), NOW()),
('17000051-0000-0000-0000-000000000001', 'c0000008-0000-0000-0000-000000000001', 1, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000052-0000-0000-0000-000000000001', 'c0000008-0000-0000-0000-000000000001', 2, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000053-0000-0000-0000-000000000001', 'c0000008-0000-0000-0000-000000000001', 3, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000054-0000-0000-0000-000000000001', 'c0000008-0000-0000-0000-000000000001', 4, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000055-0000-0000-0000-000000000001', 'c0000008-0000-0000-0000-000000000001', 5, '16:00:00', '21:00:00', 'available', NOW(), NOW()),
('17000056-0000-0000-0000-000000000001', 'c0000008-0000-0000-0000-000000000001', 6, '08:00:00', '18:00:00', 'available', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- LEAGUES
-- ============================================================================
INSERT INTO leagues (id, organization_id, name, sport, description, commissioner_id, status, max_teams, min_players, max_players, created_at, updated_at) VALUES
-- Existing Riverside leagues
('d0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Youth Soccer League', 'soccer', 'Recreational soccer for kids ages 8-12', 'a0000002-0000-0000-0000-000000000001', 'active', 8, 6, 12, NOW(), NOW()),
('d0000002-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Adult Basketball League', 'basketball', 'Competitive basketball for adults 18+', 'a0000002-0000-0000-0000-000000000001', 'active', 6, 5, 10, NOW(), NOW()),
('d0000003-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Teen Flag Football', 'football', 'Flag football for teens 13-17', 'a0000002-0000-0000-0000-000000000001', 'active', 8, 7, 15, NOW(), NOW()),
-- NEW: Valley Select travel baseball
('d0000004-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'Valley Select 12U Travel', 'baseball', 'Competitive 12U travel baseball for the Central Valley region', 'a0000003-0000-0000-0000-000000000001', 'active', 8, 9, 15, NOW(), NOW()),
-- NEW: Inter-org soccer league hosted by Riverside
('d0000005-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'Tri-County Youth Soccer', 'soccer', 'Inter-organization youth soccer league spanning Riverside and Hillcrest communities', 'a0000002-0000-0000-0000-000000000001', 'active', 12, 7, 14, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- LEAGUE ORGANIZATIONS (inter-org memberships)
-- ============================================================================
INSERT INTO league_organizations (id, league_id, organization_id, role, max_teams, can_host_games, status, joined_at, created_at, updated_at) VALUES
-- Youth Soccer League: Riverside is host
('18000001-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'host', 8, true, 'active', NOW(), NOW(), NOW()),
-- Adult Basketball League: Riverside is host
('18000002-0000-0000-0000-000000000001', 'd0000002-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'host', 6, true, 'active', NOW(), NOW(), NOW()),
-- Teen Flag Football: Riverside is host
('18000003-0000-0000-0000-000000000001', 'd0000003-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'host', 8, true, 'active', NOW(), NOW(), NOW()),
-- Valley Select 12U Travel: Valley Select is host
('18000004-0000-0000-0000-000000000001', 'd0000004-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'host', 8, true, 'active', NOW(), NOW(), NOW()),
-- Tri-County Youth Soccer: Riverside is host
('18000005-0000-0000-0000-000000000001', 'd0000005-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'host', 6, true, 'active', NOW(), NOW(), NOW()),
-- Tri-County Youth Soccer: Valley Select is member
('18000006-0000-0000-0000-000000000001', 'd0000005-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'member', 4, true, 'active', NOW(), NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- DIVISIONS
-- ============================================================================
INSERT INTO divisions (id, league_id, name, age_group, min_age, max_age, skill_level, is_active, created_at, updated_at) VALUES
-- Existing divisions
('f0000001-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'U10 Division', '8-10', 8, 10, 'recreational', true, NOW(), NOW()),
('f0000002-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'U12 Division', '10-12', 10, 12, 'recreational', true, NOW(), NOW()),
('f0000003-0000-0000-0000-000000000001', 'd0000002-0000-0000-0000-000000000001', 'Open Division', '18+', 18, 99, 'competitive', true, NOW(), NOW()),
-- NEW: Valley Select 12U Travel division
('f0000004-0000-0000-0000-000000000001', 'd0000004-0000-0000-0000-000000000001', '12U Competitive', '11-12', 11, 12, 'competitive', true, NOW(), NOW()),
-- NEW: Tri-County Youth Soccer division
('f0000005-0000-0000-0000-000000000001', 'd0000005-0000-0000-0000-000000000001', 'U12 Tri-County', '10-12', 10, 12, 'competitive', true, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- SEASONS
-- ============================================================================
INSERT INTO seasons (id, league_id, name, year, season_type, status, registration_start, registration_end, season_start, season_end, created_at, updated_at) VALUES
-- Existing seasons
('e0000001-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'Spring 2026', 2026, 'spring', 'active', '2026-01-01 00:00:00+00', '2026-03-01 00:00:00+00', '2026-03-15 00:00:00+00', '2026-06-15 00:00:00+00', NOW(), NOW()),
('e0000002-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'Fall 2026', 2026, 'fall', 'planning', '2026-07-01 00:00:00+00', '2026-08-15 00:00:00+00', '2026-09-01 00:00:00+00', '2026-11-30 00:00:00+00', NOW(), NOW()),
('e0000003-0000-0000-0000-000000000001', 'd0000002-0000-0000-0000-000000000001', 'Winter 2026', 2026, 'winter', 'active', '2025-11-01 00:00:00+00', '2026-01-01 00:00:00+00', '2026-01-15 00:00:00+00', '2026-03-30 00:00:00+00', NOW(), NOW()),
-- NEW: Valley Select 12U Travel spring season
('e0000004-0000-0000-0000-000000000001', 'd0000004-0000-0000-0000-000000000001', 'Spring 2026 Travel', 2026, 'spring', 'active', '2025-12-01 00:00:00+00', '2026-02-15 00:00:00+00', '2026-03-01 00:00:00+00', '2026-06-30 00:00:00+00', NOW(), NOW()),
-- NEW: Tri-County Youth Soccer spring season
('e0000005-0000-0000-0000-000000000001', 'd0000005-0000-0000-0000-000000000001', 'Spring 2026 Tri-County', 2026, 'spring', 'active', '2026-01-15 00:00:00+00', '2026-03-01 00:00:00+00', '2026-03-15 00:00:00+00', '2026-06-15 00:00:00+00', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- COACHES
-- ============================================================================
INSERT INTO coaches (id, user_id, certification_level, years_experience, status, willing_to_head_coach, willing_to_assistant, created_at, updated_at) VALUES
-- Existing Riverside coaches
('10000001-0000-0000-0000-000000000001', 'a0000010-0000-0000-0000-000000000001', 'level2', 5, 'approved', true, true, NOW(), NOW()),
('10000002-0000-0000-0000-000000000001', 'a0000011-0000-0000-0000-000000000001', 'level1', 3, 'approved', true, true, NOW(), NOW()),
('10000003-0000-0000-0000-000000000001', 'a0000012-0000-0000-0000-000000000001', 'level2', 7, 'approved', true, false, NOW(), NOW()),
('10000004-0000-0000-0000-000000000001', 'a0000013-0000-0000-0000-000000000001', 'level1', 2, 'approved', false, true, NOW(), NOW()),
-- NEW: Valley Select coaches
('10000005-0000-0000-0000-000000000001', 'a0000014-0000-0000-0000-000000000001', 'level3', 10, 'approved', true, false, NOW(), NOW()),
('10000006-0000-0000-0000-000000000001', 'a0000015-0000-0000-0000-000000000001', 'level2', 6, 'approved', true, true, NOW(), NOW()),
('10000007-0000-0000-0000-000000000001', 'a0000016-0000-0000-0000-000000000001', 'level2', 4, 'approved', true, true, NOW(), NOW()),
('10000008-0000-0000-0000-000000000001', 'a0000017-0000-0000-0000-000000000001', 'level1', 3, 'approved', false, true, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- TEAMS
-- ============================================================================
INSERT INTO teams (id, league_id, division_id, season_id, coach_id, name, home_field_id, color_primary, color_secondary, created_at, updated_at) VALUES
-- U10 Soccer Teams (existing)
('11000001-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'f0000001-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', '10000001-0000-0000-0000-000000000001', 'Riverside Eagles', 'c0000001-0000-0000-0000-000000000001', '#1E40AF', '#FBBF24', NOW(), NOW()),
('11000002-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'f0000001-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', '10000002-0000-0000-0000-000000000001', 'Thunder FC', 'c0000002-0000-0000-0000-000000000001', '#DC2626', '#FFFFFF', NOW(), NOW()),
('11000003-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'f0000001-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', NULL, 'Green Machine', 'c0000003-0000-0000-0000-000000000001', '#16A34A', '#000000', NOW(), NOW()),
('11000004-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'f0000001-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', NULL, 'Blue Lightning', 'c0000004-0000-0000-0000-000000000001', '#0EA5E9', '#FFFFFF', NOW(), NOW()),
-- U12 Soccer Teams (existing)
('11000005-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'f0000002-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', '10000003-0000-0000-0000-000000000001', 'Strikers United', 'c0000001-0000-0000-0000-000000000001', '#7C3AED', '#F59E0B', NOW(), NOW()),
('11000006-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'f0000002-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', '10000004-0000-0000-0000-000000000001', 'Phoenix Rising', 'c0000002-0000-0000-0000-000000000001', '#F97316', '#1F2937', NOW(), NOW()),
('11000007-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'f0000002-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', NULL, 'Storm Chasers', 'c0000003-0000-0000-0000-000000000001', '#6366F1', '#E5E7EB', NOW(), NOW()),
('11000008-0000-0000-0000-000000000001', 'd0000001-0000-0000-0000-000000000001', 'f0000002-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', NULL, 'Red Devils', 'c0000004-0000-0000-0000-000000000001', '#B91C1C', '#FAFAFA', NOW(), NOW()),
-- NEW: Valley Select 12U Travel Baseball Teams
('11000009-0000-0000-0000-000000000001', 'd0000004-0000-0000-0000-000000000001', 'f0000004-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', '10000005-0000-0000-0000-000000000001', 'Valley Vipers', 'c0000006-0000-0000-0000-000000000001', '#1D4ED8', '#F59E0B', NOW(), NOW()),
('11000010-0000-0000-0000-000000000001', 'd0000004-0000-0000-0000-000000000001', 'f0000004-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', '10000006-0000-0000-0000-000000000001', 'Hillcrest Hawks', 'c0000007-0000-0000-0000-000000000001', '#991B1B', '#FFFFFF', NOW(), NOW()),
('11000011-0000-0000-0000-000000000001', 'd0000004-0000-0000-0000-000000000001', 'f0000004-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', '10000007-0000-0000-0000-000000000001', 'Diamond Dogs', 'c0000006-0000-0000-0000-000000000001', '#15803D', '#FAFAFA', NOW(), NOW()),
('11000012-0000-0000-0000-000000000001', 'd0000004-0000-0000-0000-000000000001', 'f0000004-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', '10000008-0000-0000-0000-000000000001', 'Central Sluggers', 'c0000007-0000-0000-0000-000000000001', '#7E22CE', '#E5E7EB', NOW(), NOW()),
-- NEW: Tri-County Youth Soccer - Hillcrest Teams (Valley Select org participating in soccer)
('11000013-0000-0000-0000-000000000001', 'd0000005-0000-0000-0000-000000000001', 'f0000005-0000-0000-0000-000000000001', 'e0000005-0000-0000-0000-000000000001', '10000007-0000-0000-0000-000000000001', 'Hillcrest FC', 'c0000003-0000-0000-0000-000000000001', '#0D9488', '#FFFFFF', NOW(), NOW()),
('11000014-0000-0000-0000-000000000001', 'd0000005-0000-0000-0000-000000000001', 'f0000005-0000-0000-0000-000000000001', 'e0000005-0000-0000-0000-000000000001', '10000008-0000-0000-0000-000000000001', 'Hillcrest United', 'c0000004-0000-0000-0000-000000000001', '#EA580C', '#1F2937', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- GUARDIANS
-- ============================================================================
INSERT INTO guardians (id, user_id, relationship_type, is_emergency_contact, created_at, updated_at) VALUES
-- Existing
('12000001-0000-0000-0000-000000000001', 'a0000020-0000-0000-0000-000000000001', 'father', true, NOW(), NOW()),
('12000002-0000-0000-0000-000000000001', 'a0000021-0000-0000-0000-000000000001', 'mother', true, NOW(), NOW()),
('12000003-0000-0000-0000-000000000001', 'a0000022-0000-0000-0000-000000000001', 'father', true, NOW(), NOW()),
('12000004-0000-0000-0000-000000000001', 'a0000023-0000-0000-0000-000000000001', 'mother', true, NOW(), NOW()),
-- NEW: Valley Select guardians
('12000005-0000-0000-0000-000000000001', 'a0000024-0000-0000-0000-000000000001', 'father', true, NOW(), NOW()),
('12000006-0000-0000-0000-000000000001', 'a0000025-0000-0000-0000-000000000001', 'mother', true, NOW(), NOW()),
('12000007-0000-0000-0000-000000000001', 'a0000026-0000-0000-0000-000000000001', 'father', true, NOW(), NOW()),
('12000008-0000-0000-0000-000000000001', 'a0000027-0000-0000-0000-000000000001', 'mother', true, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- PLAYERS (link users to teams)
-- ============================================================================
INSERT INTO players (id, user_id, team_id, jersey_number, position, status, created_at, updated_at) VALUES
-- Eagles players (existing)
('13000001-0000-0000-0000-000000000001', 'a0000030-0000-0000-0000-000000000001', '11000001-0000-0000-0000-000000000001', '10', 'forward', 'active', NOW(), NOW()),
('13000002-0000-0000-0000-000000000001', 'a0000031-0000-0000-0000-000000000001', '11000001-0000-0000-0000-000000000001', '7', 'midfielder', 'active', NOW(), NOW()),
('13000003-0000-0000-0000-000000000001', 'a0000032-0000-0000-0000-000000000001', '11000001-0000-0000-0000-000000000001', '1', 'goalkeeper', 'active', NOW(), NOW()),
-- Thunder FC players (existing)
('13000004-0000-0000-0000-000000000001', 'a0000033-0000-0000-0000-000000000001', '11000002-0000-0000-0000-000000000001', '4', 'defender', 'active', NOW(), NOW()),
('13000005-0000-0000-0000-000000000001', 'a0000034-0000-0000-0000-000000000001', '11000002-0000-0000-0000-000000000001', '9', 'forward', 'active', NOW(), NOW()),
('13000006-0000-0000-0000-000000000001', 'a0000035-0000-0000-0000-000000000001', '11000002-0000-0000-0000-000000000001', '11', 'midfielder', 'active', NOW(), NOW()),
-- Green Machine players (existing)
('13000007-0000-0000-0000-000000000001', 'a0000036-0000-0000-0000-000000000001', '11000003-0000-0000-0000-000000000001', '8', 'midfielder', 'active', NOW(), NOW()),
('13000008-0000-0000-0000-000000000001', 'a0000037-0000-0000-0000-000000000001', '11000003-0000-0000-0000-000000000001', '3', 'defender', 'active', NOW(), NOW()),
('13000009-0000-0000-0000-000000000001', 'a0000038-0000-0000-0000-000000000001', '11000003-0000-0000-0000-000000000001', '5', 'defender', 'active', NOW(), NOW()),
-- Blue Lightning players (existing)
('13000010-0000-0000-0000-000000000001', 'a0000039-0000-0000-0000-000000000001', '11000004-0000-0000-0000-000000000001', '12', 'forward', 'active', NOW(), NOW()),
('13000011-0000-0000-0000-000000000001', 'a0000040-0000-0000-0000-000000000001', '11000004-0000-0000-0000-000000000001', '6', 'midfielder', 'active', NOW(), NOW()),
('13000012-0000-0000-0000-000000000001', 'a0000041-0000-0000-0000-000000000001', '11000004-0000-0000-0000-000000000001', '2', 'defender', 'active', NOW(), NOW()),
-- NEW: Valley Vipers (travel baseball)
('13000013-0000-0000-0000-000000000001', 'a0000042-0000-0000-0000-000000000001', '11000009-0000-0000-0000-000000000001', '7', 'shortstop', 'active', NOW(), NOW()),
('13000014-0000-0000-0000-000000000001', 'a0000043-0000-0000-0000-000000000001', '11000009-0000-0000-0000-000000000001', '24', 'pitcher', 'active', NOW(), NOW()),
('13000015-0000-0000-0000-000000000001', 'a0000044-0000-0000-0000-000000000001', '11000009-0000-0000-0000-000000000001', '12', 'catcher', 'active', NOW(), NOW()),
-- NEW: Hillcrest Hawks (travel baseball)
('13000016-0000-0000-0000-000000000001', 'a0000045-0000-0000-0000-000000000001', '11000010-0000-0000-0000-000000000001', '3', 'first_base', 'active', NOW(), NOW()),
('13000017-0000-0000-0000-000000000001', 'a0000046-0000-0000-0000-000000000001', '11000010-0000-0000-0000-000000000001', '15', 'outfield', 'active', NOW(), NOW()),
('13000018-0000-0000-0000-000000000001', 'a0000047-0000-0000-0000-000000000001', '11000010-0000-0000-0000-000000000001', '22', 'second_base', 'active', NOW(), NOW()),
-- NEW: Diamond Dogs (travel baseball)
('13000019-0000-0000-0000-000000000001', 'a0000048-0000-0000-0000-000000000001', '11000011-0000-0000-0000-000000000001', '9', 'third_base', 'active', NOW(), NOW()),
('13000020-0000-0000-0000-000000000001', 'a0000049-0000-0000-0000-000000000001', '11000011-0000-0000-0000-000000000001', '1', 'pitcher', 'active', NOW(), NOW()),
('13000021-0000-0000-0000-000000000001', 'a0000050-0000-0000-0000-000000000001', '11000011-0000-0000-0000-000000000001', '14', 'outfield', 'active', NOW(), NOW()),
-- NEW: Central Sluggers (travel baseball)
('13000022-0000-0000-0000-000000000001', 'a0000051-0000-0000-0000-000000000001', '11000012-0000-0000-0000-000000000001', '5', 'shortstop', 'active', NOW(), NOW()),
('13000023-0000-0000-0000-000000000001', 'a0000052-0000-0000-0000-000000000001', '11000012-0000-0000-0000-000000000001', '21', 'catcher', 'active', NOW(), NOW()),
('13000024-0000-0000-0000-000000000001', 'a0000053-0000-0000-0000-000000000001', '11000012-0000-0000-0000-000000000001', '8', 'outfield', 'active', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- PLAYER-GUARDIAN RELATIONSHIPS
-- ============================================================================
INSERT INTO player_guardians (id, player_id, guardian_id, is_primary, created_at) VALUES
-- Existing
('14000001-0000-0000-0000-000000000001', '13000001-0000-0000-0000-000000000001', '12000001-0000-0000-0000-000000000001', true, NOW()),
('14000002-0000-0000-0000-000000000001', '13000002-0000-0000-0000-000000000001', '12000002-0000-0000-0000-000000000001', true, NOW()),
('14000003-0000-0000-0000-000000000001', '13000003-0000-0000-0000-000000000001', '12000003-0000-0000-0000-000000000001', true, NOW()),
('14000004-0000-0000-0000-000000000001', '13000004-0000-0000-0000-000000000001', '12000004-0000-0000-0000-000000000001', true, NOW()),
-- NEW: Valley Select player-guardian links
('14000005-0000-0000-0000-000000000001', '13000013-0000-0000-0000-000000000001', '12000005-0000-0000-0000-000000000001', true, NOW()),  -- Dylan Chen -> Wei Chen
('14000006-0000-0000-0000-000000000001', '13000014-0000-0000-0000-000000000001', '12000006-0000-0000-0000-000000000001', true, NOW()),  -- Marcus Brooks -> Tamika Brooks
('14000007-0000-0000-0000-000000000001', '13000015-0000-0000-0000-000000000001', '12000007-0000-0000-0000-000000000001', true, NOW()),  -- Sofia Garcia -> Miguel Garcia
('14000008-0000-0000-0000-000000000001', '13000016-0000-0000-0000-000000000001', '12000008-0000-0000-0000-000000000001', true, NOW())   -- Hana Kim -> Soo-Yeon Kim
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- SCHEDULED EVENTS (Games & Practices)
-- Includes completed past games with scores for demo
-- ============================================================================
INSERT INTO scheduled_events (id, season_id, event_type, title, description, start_time, end_time, field_id, home_team_id, away_team_id, home_score, away_score, status, created_at, updated_at) VALUES
-- ===== COMPLETED PAST GAMES (before 2026-03-18) =====
-- Week 1 Games (March 15, 2026) - COMPLETED with scores
('15000001-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'game', 'Eagles vs Thunder FC', 'U10 Division - Week 1', '2026-03-15 10:00:00+00', '2026-03-15 11:30:00+00', 'c0000001-0000-0000-0000-000000000001', '11000001-0000-0000-0000-000000000001', '11000002-0000-0000-0000-000000000001', 3, 1, 'completed', NOW(), NOW()),
('15000002-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'game', 'Green Machine vs Blue Lightning', 'U10 Division - Week 1', '2026-03-15 12:00:00+00', '2026-03-15 13:30:00+00', 'c0000002-0000-0000-0000-000000000001', '11000003-0000-0000-0000-000000000001', '11000004-0000-0000-0000-000000000001', 2, 2, 'completed', NOW(), NOW()),
('15000003-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'game', 'Strikers vs Phoenix Rising', 'U12 Division - Week 1', '2026-03-15 14:00:00+00', '2026-03-15 15:30:00+00', 'c0000003-0000-0000-0000-000000000001', '11000005-0000-0000-0000-000000000001', '11000006-0000-0000-0000-000000000001', 4, 2, 'completed', NOW(), NOW()),
('15000004-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'game', 'Storm Chasers vs Red Devils', 'U12 Division - Week 1', '2026-03-15 16:00:00+00', '2026-03-15 17:30:00+00', 'c0000004-0000-0000-0000-000000000001', '11000007-0000-0000-0000-000000000001', '11000008-0000-0000-0000-000000000001', 1, 3, 'completed', NOW(), NOW()),

-- Travel baseball completed games (early March 2026)
('15000030-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', 'game', 'Valley Vipers vs Hillcrest Hawks', '12U Travel - Week 1', '2026-03-07 10:00:00+00', '2026-03-07 12:00:00+00', 'c0000006-0000-0000-0000-000000000001', '11000009-0000-0000-0000-000000000001', '11000010-0000-0000-0000-000000000001', 5, 3, 'completed', NOW(), NOW()),
('15000031-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', 'game', 'Diamond Dogs vs Central Sluggers', '12U Travel - Week 1', '2026-03-07 13:00:00+00', '2026-03-07 15:00:00+00', 'c0000007-0000-0000-0000-000000000001', '11000011-0000-0000-0000-000000000001', '11000012-0000-0000-0000-000000000001', 2, 4, 'completed', NOW(), NOW()),
('15000032-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', 'game', 'Valley Vipers vs Diamond Dogs', '12U Travel - Week 2', '2026-03-14 10:00:00+00', '2026-03-14 12:00:00+00', 'c0000006-0000-0000-0000-000000000001', '11000009-0000-0000-0000-000000000001', '11000011-0000-0000-0000-000000000001', 3, 3, 'completed', NOW(), NOW()),
('15000033-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', 'game', 'Hillcrest Hawks vs Central Sluggers', '12U Travel - Week 2', '2026-03-14 13:00:00+00', '2026-03-14 15:00:00+00', 'c0000007-0000-0000-0000-000000000001', '11000010-0000-0000-0000-000000000001', '11000012-0000-0000-0000-000000000001', 1, 0, 'completed', NOW(), NOW()),

-- ===== UPCOMING SCHEDULED GAMES =====
-- Week 2 Soccer Games (March 22, 2026)
('15000005-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'game', 'Eagles vs Green Machine', 'U10 Division - Week 2', '2026-03-22 10:00:00+00', '2026-03-22 11:30:00+00', 'c0000001-0000-0000-0000-000000000001', '11000001-0000-0000-0000-000000000001', '11000003-0000-0000-0000-000000000001', NULL, NULL, 'scheduled', NOW(), NOW()),
('15000006-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'game', 'Thunder FC vs Blue Lightning', 'U10 Division - Week 2', '2026-03-22 12:00:00+00', '2026-03-22 13:30:00+00', 'c0000002-0000-0000-0000-000000000001', '11000002-0000-0000-0000-000000000001', '11000004-0000-0000-0000-000000000001', NULL, NULL, 'scheduled', NOW(), NOW()),

-- Week 3 Soccer Games (March 29, 2026)
('15000007-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'game', 'Eagles vs Blue Lightning', 'U10 Division - Week 3', '2026-03-29 10:00:00+00', '2026-03-29 11:30:00+00', 'c0000001-0000-0000-0000-000000000001', '11000001-0000-0000-0000-000000000001', '11000004-0000-0000-0000-000000000001', NULL, NULL, 'scheduled', NOW(), NOW()),
('15000008-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'game', 'Thunder FC vs Green Machine', 'U10 Division - Week 3', '2026-03-29 12:00:00+00', '2026-03-29 13:30:00+00', 'c0000002-0000-0000-0000-000000000001', '11000002-0000-0000-0000-000000000001', '11000003-0000-0000-0000-000000000001', NULL, NULL, 'scheduled', NOW(), NOW()),
('15000009-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'game', 'Strikers vs Storm Chasers', 'U12 Division - Week 2', '2026-03-29 14:00:00+00', '2026-03-29 15:30:00+00', 'c0000003-0000-0000-0000-000000000001', '11000005-0000-0000-0000-000000000001', '11000007-0000-0000-0000-000000000001', NULL, NULL, 'scheduled', NOW(), NOW()),

-- Upcoming travel baseball
('15000034-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', 'game', 'Valley Vipers vs Central Sluggers', '12U Travel - Week 3', '2026-03-21 10:00:00+00', '2026-03-21 12:00:00+00', 'c0000006-0000-0000-0000-000000000001', '11000009-0000-0000-0000-000000000001', '11000012-0000-0000-0000-000000000001', NULL, NULL, 'scheduled', NOW(), NOW()),
('15000035-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', 'game', 'Hillcrest Hawks vs Diamond Dogs', '12U Travel - Week 3', '2026-03-21 13:00:00+00', '2026-03-21 15:00:00+00', 'c0000007-0000-0000-0000-000000000001', '11000010-0000-0000-0000-000000000001', '11000011-0000-0000-0000-000000000001', NULL, NULL, 'scheduled', NOW(), NOW()),

-- Tri-County Soccer upcoming
('15000040-0000-0000-0000-000000000001', 'e0000005-0000-0000-0000-000000000001', 'game', 'Hillcrest FC vs Hillcrest United', 'Tri-County U12 - Week 1', '2026-03-22 14:00:00+00', '2026-03-22 15:30:00+00', 'c0000003-0000-0000-0000-000000000001', '11000013-0000-0000-0000-000000000001', '11000014-0000-0000-0000-000000000001', NULL, NULL, 'scheduled', NOW(), NOW()),

-- ===== PRACTICES =====
('15000010-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'practice', 'Eagles Practice', 'Weekly team practice', '2026-03-18 17:00:00+00', '2026-03-18 18:30:00+00', 'c0000001-0000-0000-0000-000000000001', '11000001-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),
('15000011-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'practice', 'Thunder FC Practice', 'Weekly team practice', '2026-03-18 17:00:00+00', '2026-03-18 18:30:00+00', 'c0000002-0000-0000-0000-000000000001', '11000002-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),
('15000012-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'practice', 'Green Machine Practice', 'Weekly team practice', '2026-03-19 17:00:00+00', '2026-03-19 18:30:00+00', 'c0000003-0000-0000-0000-000000000001', '11000003-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),
('15000013-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'practice', 'Blue Lightning Practice', 'Weekly team practice', '2026-03-19 17:00:00+00', '2026-03-19 18:30:00+00', 'c0000004-0000-0000-0000-000000000001', '11000004-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),
-- Travel baseball practices
('15000014-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', 'practice', 'Valley Vipers Practice', 'Weekly hitting and fielding', '2026-03-18 16:00:00+00', '2026-03-18 18:00:00+00', 'c0000006-0000-0000-0000-000000000001', '11000009-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),
('15000015-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', 'practice', 'Hillcrest Hawks Practice', 'Weekly hitting and fielding', '2026-03-19 16:00:00+00', '2026-03-19 18:00:00+00', 'c0000007-0000-0000-0000-000000000001', '11000010-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),

-- ===== MEETINGS =====
('15000020-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'meeting', 'Season Kickoff Meeting', 'All teams welcome - season overview and Q&A', '2026-03-14 18:00:00+00', '2026-03-14 19:30:00+00', 'c0000005-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, 'scheduled', NOW(), NOW()),

-- ===== TEAM MEETINGS, PARENT MEETINGS, PARTIES, FUNDRAISERS =====
('15000021-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'team_meeting', 'Eagles Team Meeting', 'Discuss upcoming tournament strategy', '2026-03-25 18:00:00+00', '2026-03-25 19:00:00+00', NULL, '11000001-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),
('15000022-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'parent_meeting', 'Eagles Parent Meeting', 'Volunteer sign-ups and snack schedule', '2026-03-26 19:00:00+00', '2026-03-26 20:00:00+00', NULL, '11000001-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),
('15000023-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'party', 'Eagles End-of-Month Pizza Party', 'Team celebration at Pizza Palace', '2026-03-28 17:00:00+00', '2026-03-28 19:00:00+00', NULL, '11000001-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),
('15000024-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', 'fundraiser', 'Eagles Car Wash Fundraiser', 'Raising money for tournament travel expenses', '2026-04-05 09:00:00+00', '2026-04-05 14:00:00+00', NULL, '11000001-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW()),
('15000025-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', 'parent_meeting', 'Valley Vipers Parent Meeting', 'Travel schedule and carpooling coordination', '2026-03-24 19:00:00+00', '2026-03-24 20:00:00+00', NULL, '11000009-0000-0000-0000-000000000001', NULL, NULL, NULL, 'scheduled', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- CALENDAR SUBSCRIPTIONS (Sample for coach user)
-- ============================================================================
INSERT INTO calendar_subscriptions (id, user_id, token, subscription_type, resource_id, name, event_types, include_cancelled, is_active, access_count, created_at, updated_at) VALUES
('16000001-0000-0000-0000-000000000001', 'a0000010-0000-0000-0000-000000000001', 'demo_coach_team_feed_token_xyz789abc', 'team', '11000001-0000-0000-0000-000000000001', 'Eagles Schedule', '["game", "practice", "scrimmage", "team_meeting", "parent_meeting", "party", "fundraiser"]', false, true, 0, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- USER-ORGANIZATION MEMBERSHIPS
-- ============================================================================
INSERT INTO user_organizations (id, user_id, organization_id, role, is_primary, joined_at, created_at, updated_at) VALUES
-- Riverside Parks & Recreation members
('19000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'admin', true, NOW(), NOW(), NOW()),
('19000002-0000-0000-0000-000000000001', 'a0000002-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'commissioner', true, NOW(), NOW(), NOW()),
('19000003-0000-0000-0000-000000000001', 'a0000010-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'coach', true, NOW(), NOW(), NOW()),
('19000004-0000-0000-0000-000000000001', 'a0000011-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'coach', true, NOW(), NOW(), NOW()),
('19000005-0000-0000-0000-000000000001', 'a0000012-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'coach', true, NOW(), NOW(), NOW()),
('19000006-0000-0000-0000-000000000001', 'a0000013-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'coach', true, NOW(), NOW(), NOW()),
('19000007-0000-0000-0000-000000000001', 'a0000020-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'guardian', true, NOW(), NOW(), NOW()),
('19000008-0000-0000-0000-000000000001', 'a0000021-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'guardian', true, NOW(), NOW(), NOW()),
('19000009-0000-0000-0000-000000000001', 'a0000022-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'guardian', true, NOW(), NOW(), NOW()),
('19000010-0000-0000-0000-000000000001', 'a0000023-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'guardian', true, NOW(), NOW(), NOW()),
-- Riverside player users as members
('19000011-0000-0000-0000-000000000001', 'a0000030-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000012-0000-0000-0000-000000000001', 'a0000031-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000013-0000-0000-0000-000000000001', 'a0000032-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000014-0000-0000-0000-000000000001', 'a0000033-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000015-0000-0000-0000-000000000001', 'a0000034-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000016-0000-0000-0000-000000000001', 'a0000035-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000017-0000-0000-0000-000000000001', 'a0000036-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000018-0000-0000-0000-000000000001', 'a0000037-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000019-0000-0000-0000-000000000001', 'a0000038-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000020-0000-0000-0000-000000000001', 'a0000039-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000021-0000-0000-0000-000000000001', 'a0000040-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000022-0000-0000-0000-000000000001', 'a0000041-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),

-- Valley Select Baseball members
('19000030-0000-0000-0000-000000000001', 'a0000003-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'commissioner', true, NOW(), NOW(), NOW()),
('19000031-0000-0000-0000-000000000001', 'a0000014-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'coach', true, NOW(), NOW(), NOW()),
('19000032-0000-0000-0000-000000000001', 'a0000015-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'coach', true, NOW(), NOW(), NOW()),
('19000033-0000-0000-0000-000000000001', 'a0000016-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'coach', true, NOW(), NOW(), NOW()),
('19000034-0000-0000-0000-000000000001', 'a0000017-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'coach', true, NOW(), NOW(), NOW()),
('19000035-0000-0000-0000-000000000001', 'a0000024-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'guardian', true, NOW(), NOW(), NOW()),
('19000036-0000-0000-0000-000000000001', 'a0000025-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'guardian', true, NOW(), NOW(), NOW()),
('19000037-0000-0000-0000-000000000001', 'a0000026-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'guardian', true, NOW(), NOW(), NOW()),
('19000038-0000-0000-0000-000000000001', 'a0000027-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'guardian', true, NOW(), NOW(), NOW()),
-- Valley Select player users
('19000039-0000-0000-0000-000000000001', 'a0000042-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000040-0000-0000-0000-000000000001', 'a0000043-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000041-0000-0000-0000-000000000001', 'a0000044-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000042-0000-0000-0000-000000000001', 'a0000045-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000043-0000-0000-0000-000000000001', 'a0000046-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000044-0000-0000-0000-000000000001', 'a0000047-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000045-0000-0000-0000-000000000001', 'a0000048-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000046-0000-0000-0000-000000000001', 'a0000049-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000047-0000-0000-0000-000000000001', 'a0000050-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000048-0000-0000-0000-000000000001', 'a0000051-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000049-0000-0000-0000-000000000001', 'a0000052-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),
('19000050-0000-0000-0000-000000000001', 'a0000053-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'player', true, NOW(), NOW(), NOW()),

-- Central Valley Tournament Series members
('19000060-0000-0000-0000-000000000001', 'a0000004-0000-0000-0000-000000000001', 'b0000003-0000-0000-0000-000000000001', 'commissioner', true, NOW(), NOW(), NOW()),

-- Multi-org user: admin (a0000001) is also a member of Valley Select (tests org switcher)
('19000070-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'admin', false, NOW(), NOW(), NOW()),
-- Multi-org user: Coach Garcia (a0000010) also coaches in Valley Select
('19000071-0000-0000-0000-000000000001', 'a0000010-0000-0000-0000-000000000001', 'b0000002-0000-0000-0000-000000000001', 'coach', false, NOW(), NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- REGISTRATIONS (player registrations for seasons)
-- ============================================================================
INSERT INTO registrations (id, player_id, season_id, guardian_id, status, registration_type, waiver_signed, waiver_signed_at, waiver_signed_by, payment_status, payment_amount, paid_amount, paid_at, created_at, updated_at) VALUES
-- Riverside Youth Soccer Spring 2026 registrations
('1a000001-0000-0000-0000-000000000001', '13000001-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', '12000001-0000-0000-0000-000000000001', 'approved', 'new', true, '2026-02-10 12:00:00+00', 'a0000020-0000-0000-0000-000000000001', 'paid', 75.00, 75.00, '2026-02-10 12:00:00+00', NOW(), NOW()),
('1a000002-0000-0000-0000-000000000001', '13000002-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', '12000002-0000-0000-0000-000000000001', 'approved', 'new', true, '2026-02-11 09:00:00+00', 'a0000021-0000-0000-0000-000000000001', 'paid', 75.00, 75.00, '2026-02-11 09:00:00+00', NOW(), NOW()),
('1a000003-0000-0000-0000-000000000001', '13000003-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', '12000003-0000-0000-0000-000000000001', 'approved', 'new', true, '2026-02-12 14:00:00+00', 'a0000022-0000-0000-0000-000000000001', 'paid', 75.00, 75.00, '2026-02-12 14:00:00+00', NOW(), NOW()),
('1a000004-0000-0000-0000-000000000001', '13000004-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', '12000004-0000-0000-0000-000000000001', 'approved', 'new', true, '2026-02-15 11:00:00+00', 'a0000023-0000-0000-0000-000000000001', 'paid', 75.00, 75.00, '2026-02-15 11:00:00+00', NOW(), NOW()),
('1a000005-0000-0000-0000-000000000001', '13000005-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', NULL, 'approved', 'new', true, '2026-02-16 10:00:00+00', NULL, 'paid', 75.00, 75.00, '2026-02-16 10:00:00+00', NOW(), NOW()),
('1a000006-0000-0000-0000-000000000001', '13000006-0000-0000-0000-000000000001', 'e0000001-0000-0000-0000-000000000001', NULL, 'approved', 'new', true, '2026-02-18 09:30:00+00', NULL, 'paid', 75.00, 75.00, '2026-02-18 09:30:00+00', NOW(), NOW()),

-- Valley Select 12U Travel Spring 2026 registrations
('1a000007-0000-0000-0000-000000000001', '13000013-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', '12000005-0000-0000-0000-000000000001', 'approved', 'new', true, '2026-01-20 10:00:00+00', 'a0000024-0000-0000-0000-000000000001', 'paid', 250.00, 250.00, '2026-01-20 10:00:00+00', NOW(), NOW()),
('1a000008-0000-0000-0000-000000000001', '13000014-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', '12000006-0000-0000-0000-000000000001', 'approved', 'new', true, '2026-01-22 14:00:00+00', 'a0000025-0000-0000-0000-000000000001', 'paid', 250.00, 250.00, '2026-01-22 14:00:00+00', NOW(), NOW()),
('1a000009-0000-0000-0000-000000000001', '13000015-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', '12000007-0000-0000-0000-000000000001', 'approved', 'new', true, '2026-01-25 11:00:00+00', 'a0000026-0000-0000-0000-000000000001', 'paid', 250.00, 250.00, '2026-01-25 11:00:00+00', NOW(), NOW()),
('1a000010-0000-0000-0000-000000000001', '13000016-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', '12000008-0000-0000-0000-000000000001', 'approved', 'new', true, '2026-01-28 09:00:00+00', 'a0000027-0000-0000-0000-000000000001', 'paid', 250.00, 250.00, '2026-01-28 09:00:00+00', NOW(), NOW()),
('1a000011-0000-0000-0000-000000000001', '13000017-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', NULL, 'approved', 'new', true, '2026-01-30 15:00:00+00', NULL, 'paid', 250.00, 250.00, '2026-01-30 15:00:00+00', NOW(), NOW()),
('1a000012-0000-0000-0000-000000000001', '13000018-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', NULL, 'approved', 'new', true, '2026-02-01 08:00:00+00', NULL, 'paid', 250.00, 250.00, '2026-02-01 08:00:00+00', NOW(), NOW()),
('1a000013-0000-0000-0000-000000000001', '13000019-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', NULL, 'approved', 'returning', true, '2026-02-03 10:00:00+00', NULL, 'paid', 250.00, 250.00, '2026-02-03 10:00:00+00', NOW(), NOW()),
('1a000014-0000-0000-0000-000000000001', '13000020-0000-0000-0000-000000000001', 'e0000004-0000-0000-0000-000000000001', NULL, 'approved', 'returning', true, '2026-02-05 12:00:00+00', NULL, 'paid', 250.00, 250.00, '2026-02-05 12:00:00+00', NOW(), NOW()),

-- A couple waitlisted registrations for fall soccer
('1a000015-0000-0000-0000-000000000001', '13000007-0000-0000-0000-000000000001', 'e0000002-0000-0000-0000-000000000001', NULL, 'pending', 'returning', false, NULL, NULL, 'pending', 75.00, NULL, NULL, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- FIELD FEE SCHEDULES
-- ============================================================================
INSERT INTO field_fee_schedules (id, field_id, fee_type, fee_cents, light_surcharge_cents, min_hours, deposit_cents, non_resident_markup_pct, description, is_active, created_at, updated_at) VALUES
-- Riverside Central Park fields: free for rec league (0 cents/hr)
('1b000001-0000-0000-0000-000000000001', 'c0000001-0000-0000-0000-000000000001', 'hourly', 0, 0, 1, 0, 0, 'Free for Riverside Parks rec league use', true, NOW(), NOW()),
('1b000002-0000-0000-0000-000000000001', 'c0000002-0000-0000-0000-000000000001', 'hourly', 0, 0, 1, 0, 0, 'Free for Riverside Parks rec league use', true, NOW(), NOW()),
-- Riverside fields: $15/hr for travel teams renting
('1b000003-0000-0000-0000-000000000001', 'c0000003-0000-0000-0000-000000000001', 'hourly', 1500, 500, 2, 5000, 25, 'Travel team rental rate for Sports Complex A', true, NOW(), NOW()),
('1b000004-0000-0000-0000-000000000001', 'c0000004-0000-0000-0000-000000000001', 'hourly', 1500, 500, 2, 5000, 25, 'Travel team rental rate for Sports Complex B', true, NOW(), NOW()),
-- Tournament Complex: $50/hr flat rate
('1b000005-0000-0000-0000-000000000001', 'c0000008-0000-0000-0000-000000000001', 'hourly', 5000, 1000, 2, 10000, 0, 'Tournament complex hourly rental', true, NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ============================================================================
-- OUTPUT SUMMARY
-- ============================================================================
DO $$
BEGIN
    RAISE NOTICE '==========================================';
    RAISE NOTICE 'TeamIO Seed Data Loaded Successfully!';
    RAISE NOTICE '==========================================';
    RAISE NOTICE 'Test Accounts (password: password123):';
    RAISE NOTICE '  - sysadmin@getteamio.com (System Admin)';
    RAISE NOTICE '  - commissioner@teamio.local (Commissioner - Riverside)';
    RAISE NOTICE '  - commissioner.valley@teamio.local (Commissioner - Valley Select)';
    RAISE NOTICE '  - commissioner.tournament@teamio.local (Commissioner - Tournament Org)';
    RAISE NOTICE '  - coach.smith@teamio.local (Coach - Riverside)';
    RAISE NOTICE '  - coach.martinez@teamio.local (Coach - Valley Select)';
    RAISE NOTICE '  - parent.jones@teamio.local (Guardian - Riverside)';
    RAISE NOTICE '  - parent.chen@teamio.local (Guardian - Valley Select)';
    RAISE NOTICE '==========================================';
    RAISE NOTICE 'Sample Data:';
    RAISE NOTICE '  - 3 Organizations (parks_rec, travel_team, tournament_org)';
    RAISE NOTICE '  - 8 Fields (5 Riverside, 2 Hillcrest, 1 Tournament)';
    RAISE NOTICE '  - 56 Field Availability slots (weekly schedules)';
    RAISE NOTICE '  - 5 Leagues (3 Riverside, 1 Valley Select, 1 Tri-County)';
    RAISE NOTICE '  - 6 League-Organization memberships';
    RAISE NOTICE '  - 5 Divisions';
    RAISE NOTICE '  - 5 Seasons';
    RAISE NOTICE '  - 8 Coaches';
    RAISE NOTICE '  - 14 Teams (8 soccer, 4 travel baseball, 2 tri-county)';
    RAISE NOTICE '  - 24 Players';
    RAISE NOTICE '  - 8 Guardians with player links';
    RAISE NOTICE '  - 27 Scheduled Events (8 completed games with scores)';
    RAISE NOTICE '  - 15 Registrations';
    RAISE NOTICE '  - 38 User-Org memberships';
    RAISE NOTICE '  - 5 Field Fee Schedules';
    RAISE NOTICE '==========================================';
END $$;
