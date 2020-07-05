INSERT INTO geometry_examples VALUES
(
'3-D Simple Solid',
'3-dimensional Solid with 6 rectangle polygons as its boundary ',
SDO_GEOMETRY
(
3008, -- SDO_GTYPE format: D00T. Set to 3008 for a 3-dimensional Solid
NULL, -- No coordinate system
NULL, --- No data in SDO_POINT attribute
SDO_ELEM_INFO_ARRAY
(
1, -- Offset of a Simple solid element
1007, --- Etype for a Simple solid
1, -- Indicates all surfaces are specified explicitly
1, -- Offset of composite element
1006, --- Etype for composite surface element
6, -- Number of composing elements;
-- element triplets for each element follow
1, 1003,3, --Axis-aligned Rectangle element descriptor
7, 1003,3, --Axis-aligned Rectangle element descriptor
13, 1003,3 , --Axis-aligned Rectangle element descriptor
19, 1003,3, -- Axis-aligned Rectangle element descriptor
25, 1003,3, --–Axis-aligned Rectangle element descriptor
31, 1003,3 --Axis-aligned Rectangle element descriptor
),
SDO_ORDINATE_ARRAY
(
4,2,2,2,0,2, -- max-, min- corners for Back face (normal: -ve Z-axis)
2,0,4,4,2,4, -- min-, max- corners for Front face (normal: +ve Z axis)
4,0,2,4,2,4, -- min-, max- corners for Right face (normal: +ve X axis)
2,2,4,2,0,2, -- min-, max- corners for Left face (normal: –ve X axis)
4,0,4,2,0,2, -- max-, min- for Bottom face (normal: –ve Y axis)
2,2,2,4,2,4 -- min-, max- corners for Top face (normal: +ve Y axis)
)
)
);