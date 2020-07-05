INSERT INTO mdsys.sdo_geom_metadata_table
(sdo_owner, sdo_table_name,sdo_column_name, sdo_srid, sdo_diminfo)
VALUES
('UMIT',
'GEOMETRY_EXAMPLES', -- TABLE_NAME
'GEOM', -- COLUMN_NAME
NULL, -- SRID specifying a geodetic coordinate system
SDO_DIM_ARRAY -- DIMINFO attribute for storing dimension bounds, tolerance
(
SDO_DIM_ELEMENT
(
'X', -- DIMENSION NAME for first dimension
-180, -- SDO_LB for the dimension: -180 degrees
180, -- SDO_UB for the dimension: 180 degrees
0.05 -- Tolerance of 0.5 meters (not 0.5 degrees: geodetic SRID)
),
SDO_DIM_ELEMENT
(
'Y', -- DIMENSION NAME for second dimension
-90, -- SDO_LB for the dimension: -90 degrees
90, -- SDO_UB for the dimension: 90 degrees
0.05 -- Tolerance of 0.5 meters (not 0.5 degrees: geodetic SRID)
),
SDO_DIM_ELEMENT('Z', -100, 20000, 0.05)

)
);

INSERT INTO mdsys.sdo_geom_metadata_table
(sdo_owner, sdo_table_name,sdo_column_name, sdo_srid, sdo_diminfo)
VALUES
('UMIT',
'THREED', -- TABLE_NAME
'GEOM', -- COLUMN_NAME
NULL, -- SRID specifying a geodetic coordinate system
SDO_DIM_ARRAY -- DIMINFO attribute for storing dimension bounds, tolerance
(
SDO_DIM_ELEMENT
(
'X', -- DIMENSION NAME for first dimension
-180, -- SDO_LB for the dimension: -180 degrees
180, -- SDO_UB for the dimension: 180 degrees
0.05 -- Tolerance of 0.5 meters (not 0.5 degrees: geodetic SRID)
),
SDO_DIM_ELEMENT
(
'Y', -- DIMENSION NAME for second dimension
-90, -- SDO_LB for the dimension: -90 degrees
90, -- SDO_UB for the dimension: 90 degrees
0.05 -- Tolerance of 0.5 meters (not 0.5 degrees: geodetic SRID)
),
SDO_DIM_ELEMENT('Z', -100, 20000, 0.05)
)
);

CREATE INDEX umit1_sidx ON SYS.GEOMETRY_EXAMPLES(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX;