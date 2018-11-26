CREATE TABLE place (
id SERIAL PRIMARY KEY,
place_name VARCHAR(150) NOT NULL,
created_on TIMESTAMP NOT NULL DEFAULT NOW(),
updated_on TIMESTAMP NOT NULL DEFAULT NOW());

CREATE OR REPLACE FUNCTION trigger_set_update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_on = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION trigger_set_create_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.created_on = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON place
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_update_timestamp();

CREATE TRIGGER set_timestamp
BEFORE INSERT ON place
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_create_timestamp();
