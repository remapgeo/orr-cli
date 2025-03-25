

CREATE TRIGGER trigger_update_regiao_{{schema}}
BEFORE INSERT OR UPDATE OF geom ON "{{schema}}".features
FOR EACH ROW
EXECUTE FUNCTION ob_geometry_informations_trigger();

CREATE TRIGGER trigger_ob_update_date_modification_{{schema}}
BEFORE UPDATE ON "{{schema}}".features
FOR EACH ROW
EXECUTE FUNCTION ob_update_date_modification();
