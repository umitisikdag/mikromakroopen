-- Create the threed table and a 3D index
CREATE TABLE UMIT.threed (id NUMBER, geom SDO_GEOMETRY);
INSERT INTO UMIT.threed VALUES (1,
SDO_GEOMETRY (3001, NULL, SDO_POINT_TYPE (1,1,1), NULL, NULL));
insert into user_sdo_geom_metadata values ('UMIT.THREED', 'GEOM',
mdsys.sdo_dim_array (
mdsys.sdo_dim_element ('x', 1, 100, .0000005),
mdsys.sdo_dim_element ('y', 1, 100, .0000005),
mdsys.sdo_dim_element ('z', 1, 200, .0000005)), null);
CREATE INDEX UMIT.threed_sidx ON UMIT.threed(geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS ('sdo_indx_dims=3');