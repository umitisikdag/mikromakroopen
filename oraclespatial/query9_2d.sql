insert into user_sdo_geom_metadata values ('GEOMETRY_EXAMPLES2', 'GEOM',
mdsys.sdo_dim_array (
mdsys.sdo_dim_element ('x', 1, 100, .0000005),
mdsys.sdo_dim_element ('y', 1, 100, .0000005)), 8307);

CREATE INDEX umitnew_sidx ON GEOMETRY_EXAMPLES2(geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX;