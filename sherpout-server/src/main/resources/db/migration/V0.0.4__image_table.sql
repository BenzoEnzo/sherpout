ALTER TABLE image
    ALTER COLUMN image_data TYPE VARCHAR(128) USING image_data::text;
ALTER TABLE image
    RENAME COLUMN image_data TO image_path;
