CREATE OR REPLACE FUNCTION ob_update_date_modification()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


/* DONE: add na criçao do features
CREATE TRIGGER "{{schema}}".trigger_ob_update_date_modification
BEFORE UPDATE ON "{{schema}}".features
FOR EACH ROW
EXECUTE FUNCTION ob_update_date_modification();
*/