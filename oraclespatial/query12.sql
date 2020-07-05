CREATE TABLE KUTU3 (GEOM MDSYS.SDO_GEOMETRY);


INSERT INTO USER_SDO_GEOM_METADATA ( TABLE_NAME, COLUMN_Name, DimInfo ) 
VALUES( 'KUTU3', 'GEOM', MDSYS.SDO_DIM_ARRAY(MDSYS.SDO_DIM_ELEMENT('X',-180,180,0.05),MDSYS.SDO_DIM_ELEMENT('Y',-90,90,0.05),MDSYS.SDO_DIM_ELEMENT('Z',-100,10000,0.05) ) );

CREATE INDEX kutu3_3dindex ON KUTU3(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS ('SDO_INDX_DIMS=3');

--Rectangle
INSERT INTO KUTU3 (geom) VALUES
(
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
10, 0, 10, -- coordinates for min-corner of Exterior ring
20, 0, 20 -- coordinates for max-corner of Exterior ring
)
)
);


---Solid with 6 Rectangles

INSERT INTO KUTU3 VALUES
(

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

--Solid with All Coords
INSERT INTO KUTU3 VALUES
(
SDO_Geometry (3008,NULL,NULL ,  
 SDO_Elem_Info_Array(1,1007,1,1,1006,6,1,1003,1,16,1003,1,31,1003,1,46,1003,1,61,1003,1,76,1003,1),  
 SDO_Ordinate_Array(1.0,0.0,-1.0,
1.0,1.0,-1.0,
1.0,1.0,1.0,
1.0,0.0,1.0,
1.0,0.0,-1.0,
1.0,0.0,1.0,
0.0,0.0,1.0,
0.0,0.0,-1.0,
1.0,0.0,-1.0,
1.0,0.0,1.0,
0.0,1.0,1.0,
0.0,1.0,-1.0,
0.0,0.0,-1.0,
0.0,0.0,1.0,
0.0,1.0,1.0,
1.0,1.0,-1.0,
0.0,1.0,-1.0,
0.0,1.0,1.0,
1.0,1.0,1.0,
1.0,1.0,-1.0,
1.0,1.0,1.0,
0.0,1.0,1.0,
0.0,0.0,1.0,
1.0,0.0,1.0,
1.0,1.0,1.0,
1.0,1.0,-1.0,
1.0,0.0,-1.0,
0.0,0.0,-1.0,
0.0,1.0,-1.0,
1.0,1.0,-1.0
)
)

);

--Single Solid Minimum Reps
INSERT INTO KUTU3 VALUES
(
SDO_Geometry (3008,NULL,NULL ,  
 SDO_Elem_Info_Array(1,1007,3),  
 SDO_Ordinate_Array(0.0,0.0,0.0,
10.0,20.0,20.0
)));


--Multi Solid Minimum Reps
INSERT INTO KUTU3 VALUES
(
SDO_Geometry (3009,NULL,NULL ,  
 SDO_Elem_Info_Array(1,1007,3,7,1007,3),  
 SDO_Ordinate_Array(-2.0,1.0,3.0,
-3.0,-1.0,0.0,
0.0,0.0,0.0,
1.0,1.0,1.0
)));