

-------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE "umit3_buildings" (gid serial PRIMARY KEY,"bin" int8);
SELECT AddGeometryColumn('','umit3_buildings','the_geom','2805','MULTIPOLYGON',2);
INSERT INTO umit3_buildings(bin, the_geom) 
VALUES('5', ST_GeomFromText('MULTIPOLYGON(((235670.354215375 
894016.780856,235668.324215375 894025.050856,235681.154215375
 894028.210856,235683.184215375 894019.940856,235670.354215375 894016.780856)))', 2805) )

-------------------------------------------------------------------------------------------------------------------------------------------------------

--http://workshops.boundlessgeo.com/postgis-intro/geometries.html

CREATE TABLE umit5 (name varchar, geom geometry);

INSERT INTO umit5 VALUES
  ('Point', 'POINT(0 0)'),
  ('Linestring', 'LINESTRING(0 0, 1 1, 2 1, 2 2)'),
  ('Polygon', 'POLYGON((0 0, 1 0, 1 1, 0 1, 0 0))'),
  ('PolygonWithHole', 'POLYGON((0 0, 10 0, 10 10, 0 10, 0 0),(1 1, 1 2, 2 2, 2 1, 1 1))'),
  ('Collection', 'GEOMETRYCOLLECTION(POINT(2 0),POLYGON((0 0, 1 0, 1 1, 0 1, 0 0)))');

-------------------------------------------------------------------------------------------------------------------------------------------------------

---http://workshops.boundlessgeo.com/postgis-intro/3d.html
---https://postgis.net/docs/using_postgis_dbmanagement.html

CREATE TABLE umit6 (name varchar, geom geometry);


INSERT INTO umit6 VALUES ('Polyhedra','POLYHEDRALSURFACE(((0 0 0, 0 0 1, 0 1 1, 0 1 0, 0 0 0)), ((0 0 0, 0 1 0, 1 1 0, 1 0 0, 0 0 0)), 
                                                        ((0 0 0, 1 0 0, 1 0 1, 0 0 1, 0 0 0)), ((1 1 0, 1 1 1, 1 0 1, 1 0 0, 1 1 0)), 
                                                        ((0 1 0, 0 1 1, 1 1 1, 1 1 0, 0 1 0)), ((0 0 1, 1 0 1, 1 1 1, 0 1 1, 0 0 1)))');


---------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE umit7 (name varchar);

SELECT AddGeometryColumn('','umit7','the_geom','2805','POLYHEDRALSURFACE',3);

INSERT INTO umit7 VALUES ('Polyhedra',ST_GeomFromText('POLYHEDRALSURFACE(((0 0 0, 0 0 1, 0 1 1, 0 1 0, 0 0 0)), ((0 0 0, 0 1 0, 1 1 0, 1 0 0, 0 0 0)), 
                                                        ((0 0 0, 1 0 0, 1 0 1, 0 0 1, 0 0 0)), ((1 1 0, 1 1 1, 1 0 1, 1 0 0, 1 1 0)), 
                                                        ((0 1 0, 0 1 1, 1 1 1, 1 1 0, 0 1 0)), ((0 0 1, 1 0 1, 1 1 1, 0 1 1, 0 0 1)))',2805));
                                                        
-------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE "umit8" (gid serial PRIMARY KEY,"bin" int8);
SELECT AddGeometryColumn('','umit8','the_geom','2805','MULTIPOLYGON',3);
INSERT INTO umit8(bin, the_geom) 
VALUES('5', ST_GeomFromText('MULTIPOLYGON(((0 0 0,4 0 0,4 4 0,0 4 0,0 0 0),(1 1 0,2 1 0,2 2 0,1 2 0,1 1 0)),((-1 -1 0,-1 -2 0,-2 -2 0,-2 -1 0,-1 -1 0)))', 2805) )


INSERT INTO umit8(bin, the_geom) 
VALUES('6', ST_GeomFromText('MULTIPOLYGON(((0 0 0,4 0 0,4 4 0,0 4 0,0 0 0)),((-1 -1 5,-1 -2 5,-2 -2 5,-2 -1 5,-1 -1 5)))', 2805) )




-------------------------------------------------------------------------------------------------------------------------------------------------------

---Binalarin taban alanlari 12m yukseltme(lod2), yukseltilmis polyhedral yuzeyin taban alanini almak
---https://postgis.net/docs/reference.html#reference_sfcgal
---https://postgis.net/docs/ST_Extrude.html
---https://postgis.net/docs/ST_GeometryN.html

CREATE EXTENSION postgis_sfcgal;


CREATE TABLE "umit4_buildings" (gid serial PRIMARY KEY,"bin" int8);
SELECT AddGeometryColumn('','umit4_buildings','the_geom','4326','POLYGON',3);
INSERT INTO umit4_buildings(bin, the_geom) 
VALUES('6', ST_GeomFromText('POLYGON((0.11 0.22 1,0.15 0.22 1, 0.15 0.30 1,0.11 0.30 1,0.11 0.22 1))', 4326) );

--2 boyutlu polygondan extrusion ile kup yapmak
ALTER TABLE umit4_buildings
ADD COLUMN lod2 geometry('POLYHEDRALSURFACEZ',4326);

UPDATE umit4_buildings 
SET lod2=ST_Extrude(the_geom, 0, 0, 1);

--Kub un alt kenarini polygon olarak eklemek
ALTER TABLE umit4_buildings
ADD COLUMN lod2_bottom geometry('POLYGONZ',4326);

UPDATE umit4_buildings 
SET lod2_bottom=ST_GeometryN(lod2,1);


--Kub un ust kenarini polygon olarak eklemek
ALTER TABLE umit4_buildings
ADD COLUMN lod2_top geometry('POLYGONZ',4326);

UPDATE umit4_buildings 
SET lod2_top=ST_GeometryN(lod2,2);

--Kub un yan kenarini polygon olarak eklemek
ALTER TABLE umit4_buildings
ADD COLUMN lod2_side geometry('POLYGONZ',4326);

UPDATE umit4_buildings 
SET lod2_side=ST_GeometryN(lod2,3);


--Zmin bulmak
ALTER TABLE umit4_buildings
ADD zmin int ;

UPDATE umit4_buildings 
SET zmin=subquery.st_zmin
FROM(SELECT ST_ZMin (lod2) from umit4_buildings)AS subquery;

--Zmax bulmak
ALTER TABLE umit4_buildings
ADD zmax int ;

UPDATE umit4_buildings 
SET zmax=subquery.st_zmax
FROM(SELECT ST_ZMax (lod2) from umit4_buildings)AS subquery;

--Zmin ve Zmax dan yuksekligi bulmak
ALTER TABLE umit4_buildings
ADD derive_z int ;

UPDATE umit4_buildings 
SET derive_z=subquery.diff
FROM(SELECT zmax-zmin as diff from umit4_buildings)AS subquery;


-------------------------------------------------------------------------------------------------------------------------------------------------------

-----SELECT Sorgulari

--https://postgis.net/docs/reference.html
--https://postgis.net/docs/ST_AsGeoJSON.html
SELECT ST_AsGeoJSON(the_geom) from umit4_buildings;

--https://postgis.net/docs/ST_AsEWKT.html
SELECT ST_AsEWKT (lod2_bottom) from umit4_buildings;

--GML 3
--https://postgis.net/docs/ST_AsGML.html
SELECT ST_AsGML(3, lod2)  from umit4_buildings;

--GML2
SELECT ST_AsGML(2, the_geom)  from umit4_buildings;

--KML
--https://postgis.net/docs/ST_AsKML.html
SELECT  ST_AsKML (lod2_bottom)  from umit4_buildings;

--Text
--https://postgis.net/docs/ST_AsText.html
SELECT  ST_AsText (lod2)  from umit4_buildings;


SELECT ST_ZMax (lod2) from umit4_buildings;

SELECT ST_ZMin (lod2) from umit4_buildings;


--GML 3
--https://postgis.net/docs/ST_AsGML.html
SELECT ST_AsGML(3, the_geom)  from umit7;


--Text
--https://postgis.net/docs/ST_AsText.html
SELECT  ST_AsText (the_geom)  from umit7;

--X3D
--https://postgis.net/docs/ST_AsText.html
SELECT  ST_AsX3D (the_geom)  from umit7;


--KML
SELECT  ST_AsKML (the_geom)  from umit8;
-------------------------------------------------------------------------------------------------------------------------------------------------------------


ALTER TABLE bina2 ALTER COLUMN geom TYPE geometry(MultiPolygon, 7869) USING ST_SetSRID(geom, 7869);
