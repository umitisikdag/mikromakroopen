
---Geometriyi iceren tablo

CREATE TABLE "umit3_buildings" (gid serial PRIMARY KEY,"bin" int8);
SELECT AddGeometryColumn('','umit3_buildings','the_geom','2805','MULTIPOLYGON',2);
INSERT INTO umit3_buildings(bin, the_geom) 
VALUES('5', ST_GeomFromText('MULTIPOLYGON(((235670.354215375 
894016.780856,235668.324215375 894025.050856,235681.154215375
 894028.210856,235683.184215375 894019.940856,235670.354215375 894016.780856)))', 2805) )

CREATE TABLE "umit4_buildings" (gid serial PRIMARY KEY,"bin" int8);
SELECT AddGeometryColumn('','umit4_buildings','the_geom','4326','POLYGON',3);
INSERT INTO umit4_buildings(bin, the_geom) 
VALUES('6', ST_GeomFromText('POLYGON((0.11 0.22 1,0.15 0.22 1,0.129 0.35 1,0.11 0.22 1))', 4326) )

--Data Tablosu
CREATE TABLE Adres (
   ID             INT PRIMARY KEY      
   DEPT           CHAR(50) NOT NULL,
  );

INSERT INTO Adres (ID,DEPT) Values ('1','Merhaba Mahallesi');

pgAdmin de SQLView olarak asagidaki sorgular denenir ve calistirilir.

--View ornekleri
SELECT adres.id,umit3_buildings.the_geom FROM public.umit3_buildings
INNER JOIN public.adres ON public.adres.ID=public.umit3_buildings.gid
ORDER BY id ASC 


SELECT adres.id,umit4_buildings.the_geom FROM public.umit4_buildings
INNER JOIN public.adres ON public.adres.ID=public.umit4_buildings.gid
ORDER BY id ASC 

--View u Geoserver a eklemek
Katmanlar-Yeni Kaynak Ekle-Vİew u olusturacagimiz workspace secilir

Sonra "Yeni Sanal Tablo SQL View yapilandir" secilip

Sanal Tablo ismi verdikten sonra

pgAdmin de view icin haziladigimiz kodlar ornek olarak 


SELECT adres.id,umit3_buildings.the_geom FROM public.umit3_buildings
INNER JOIN public.adres ON public.adres.ID=public.umit3_buildings.gid
ORDER BY id ASC 


SELECT adres.id,umit4_buildings.the_geom FROM public.umit4_buildings
INNER JOIN public.adres ON public.adres.ID=public.umit4_buildings.gid
ORDER BY id ASC 


SQL ifadesi penceresine yapistirilir.