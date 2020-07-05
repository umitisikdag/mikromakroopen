
---Binalarin taban alanlari 12m yukseltme(lod2), yukseltilmis polyhedral yuzeyin taban alanini almak
---https://postgis.net/docs/reference.html#reference_sfcgal
---https://postgis.net/docs/ST_Extrude.html
---https://postgis.net/docs/ST_GeometryN.html

CREATE EXTENSION postgis_sfcgal;


CREATE TABLE "umit10" (gid serial PRIMARY KEY,"bin" int8);
SELECT AddGeometryColumn('','umit10','the_geom','4326','POLYGON',3);
INSERT INTO umit10(bin, the_geom) 
VALUES('6', ST_GeomFromText('POLYGON((0.11 0.22 1,0.15 0.22 1, 0.15 0.30 1,0.11 0.30 1,0.11 0.22 1))', 4326) );

--2 boyutlu polygondan extrusion ile kup yapmak
ALTER TABLE umit10
ADD COLUMN lod2 geometry('POLYHEDRALSURFACEZ',4326);

UPDATE umit10 
SET lod2=ST_Extrude(the_geom, 0, 0, 1);

--Kub un alt kenarini polygon olarak eklemek
ALTER TABLE umit10
ADD COLUMN lod2_bottom geometry('POLYGONZ',4326);

UPDATE umit10 
SET lod2_bottom=ST_GeometryN(lod2,1);


--Kub un ust kenarini polygon olarak eklemek
ALTER TABLE umit10
ADD COLUMN lod2_top geometry('POLYGONZ',4326);

UPDATE umit10 
SET lod2_top=ST_GeometryN(lod2,2);

--Kub un yan kenarini polygon olarak eklemek
ALTER TABLE umit10
ADD COLUMN lod2_side geometry('POLYGONZ',4326);

UPDATE umit10 
SET lod2_side=ST_GeometryN(lod2,3);


--Kub un yan kenarini polygon olarak eklemek
ALTER TABLE umit10
ADD COLUMN lod2_side2 geometry('POLYGONZ',4326);

UPDATE umit10 
SET lod2_side2=ST_GeometryN(lod2,4);


--Kub un yan kenarini polygon olarak eklemek
ALTER TABLE umit10
ADD COLUMN lod2_side3 geometry('POLYGONZ',4326);

UPDATE umit10 
SET lod2_side3=ST_GeometryN(lod2,5);


--Kub un yan kenarini polygon olarak eklemek
ALTER TABLE umit10
ADD COLUMN lod2_side4 geometry('POLYGONZ',4326);

UPDATE umit10 
SET lod2_side4=ST_GeometryN(lod2,6);


--Zmin bulmak
ALTER TABLE umit10
ADD zmin int ;

UPDATE umit10 
SET zmin=subquery.st_zmin
FROM(SELECT ST_ZMin (lod2) from umit10)AS subquery;

--Zmax bulmak
ALTER TABLE umit10
ADD zmax int ;

UPDATE umit10 
SET zmax=subquery.st_zmax
FROM(SELECT ST_ZMax (lod2) from umit10)AS subquery;

--Zmin ve Zmax dan yuksekligi bulmak
ALTER TABLE umit10
ADD derive_z int ;

UPDATE umit10 
SET derive_z=subquery.diff
FROM(SELECT zmax-zmin as diff from umit10)AS subquery;


--KML
SELECT  ST_AsKML (lod2_side2)  from umit10;


--GeoJSON
SELECT  ST_AsGeoJSON (lod2_side2)  from umit10;