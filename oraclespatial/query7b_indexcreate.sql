DROP INDEX UMIT.umit3dindex;

--CREATE INDEX umitsidx ON GEOMETRY_EXAMPLES(GEOM)
--INDEXTYPE IS MDSYS.SPATIAL_INDEX;

CREATE INDEX UMIT.umit3dindex ON UMIT.GEOMETRY_EXAMPLES(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS ('SDO_INDX_DIMS=3');


insert into user_sdo_geom_metadata values
('UMIT.GEOMETRY_EXAMPLES', 'GEOM',
SDO_DIM_ARRAY(
SDO_DIM_ELEMENT('X', 29214140, 29219040, 0.05),
SDO_DIM_ELEMENT('Y', 43364000, 43372640, 0.05),
SDO_DIM_ELEMENT('Z', 0, 2000, 0.05)),
NULL);




