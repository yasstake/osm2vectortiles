SELECT p.osm_id,
    p.name,
    p.type,
    ST_X(topoint(ST_Transform(p.geometry, 4326))::geometry) AS lon,
    ST_Y(topoint(ST_Transform(p.geometry, 4326))::geometry) AS lat
FROM osm_places AS p