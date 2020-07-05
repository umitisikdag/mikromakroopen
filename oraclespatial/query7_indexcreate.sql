INSERT INTO user_sdo_geom_metadata
(table_name, column_name, srid, diminfo)
VALUES
(
'GEOMETRY_EXAMPLES', -- TABLE_NAME
'GEOM', -- COLUMN_NAME
8307, -- SRID specifying a geodetic coordinate system
SDO_DIM_ARRAY -- DIMINFO attribute for storing dimension bounds, tolerance
(
SDO_DIM_ELEMENT
(
'LONGITUDE', -- DIMENSION NAME for first dimension
-180, -- SDO_LB for the dimension: -180 degrees
180, -- SDO_UB for the dimension: 180 degrees
0.5 -- Tolerance of 0.5 meters (not 0.5 degrees: geodetic SRID)
),
SDO_DIM_ELEMENT
(
'LATITUDE', -- DIMENSION NAME for second dimension
-90, -- SDO_LB for the dimension: -90 degrees
90, -- SDO_UB for the dimension: 90 degrees
0.5 -- Tolerance of 0.5 meters (not 0.5 degrees: geodetic SRID)
)
)
);


CREATE INDEX umit1_sidx ON SYS.GEOMETRY_EXAMPLES(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX;