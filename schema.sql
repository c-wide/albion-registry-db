CREATE TABLE players (
    name VARCHAR(25) NOT NULL,
    player_id VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    avatar VARCHAR(255),
    avatar_ring VARCHAR(255),
    first_seen TIMESTAMPTZ NOT NULL,
    last_seen TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (player_id, region)
);

CREATE INDEX idx_players_region_name ON players(region, name);

CREATE TABLE guilds (
    name VARCHAR(50) NOT NULL,
    guild_id VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    first_seen TIMESTAMPTZ NOT NULL,
    last_seen TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (guild_id, region)
);

CREATE INDEX idx_guild_region_name ON guilds(region, name);

CREATE TABLE alliances (
    name VARCHAR(50),
    tag VARCHAR(5) NOT NULL,
    alliance_id VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    skip_name_check BOOLEAN NOT NULL DEFAULT false,
    first_seen TIMESTAMPTZ NOT NULL,
    last_seen TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (alliance_id, region)
);

CREATE INDEX idx_alliance_region_name ON alliances(region, name);
CREATE INDEX idx_alliance_region_tag ON alliances(region, tag);

CREATE TABLE player_guild_memberships (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    player_id VARCHAR(50) NOT NULL,
    guild_id VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL,
    first_seen TIMESTAMPTZ NOT NULL,
    last_seen TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (player_id, region) REFERENCES players(player_id, region),
    FOREIGN KEY (guild_id, region) REFERENCES guilds(guild_id, region)
);

CREATE TABLE guild_alliance_memberships (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    guild_id VARCHAR(50) NOT NULL,
    alliance_id VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL,
    first_seen TIMESTAMPTZ NOT NULL,
    last_seen TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (guild_id, region) REFERENCES guilds(guild_id, region),
    FOREIGN KEY (alliance_id, region) REFERENCES alliances(alliance_id, region)
);
