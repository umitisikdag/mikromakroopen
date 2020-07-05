SELECT gm.NAME, gm.DESCRIPTION
  FROM UMIT.GEOMETRY_EXAMPLES gm
  WHERE SDO_INSIDE(gm.GEOM,
            SDO_GEOMETRY
(
3003, -- SDO_GTYPE format: D00T. Set to 3003 for a 3-dimensional polygon
NULL, -- No coordinate system
NULL, --- No data in SDO_POINT attribute
SDO_ELEM_INFO_ARRAY(
1, -- Offset for ordinates of the Exterior Ring in SDO_ORDINATE_ARRAY
1003, -- ETYPE for Exterior ring
3 -- Connected by straight lines
),
SDO_ORDINATE_ARRAY
(
2, 0, 2, -- coordinates for min-corner of Exterior ring
4, 0, 4 -- coordinates for max-corner of Exterior ring
)
)
            ) = 'TRUE';