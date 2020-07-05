CREATE TABLE MYBOX
(
id VARCHAR2(100),
name VARCHAR2(100),
description VARCHAR2(100),
geom SDO_GEOMETRY
);



INSERT INTO USER_SDO_GEOM_METADATA ( TABLE_NAME, COLUMN_Name, DimInfo,srid ) 
VALUES( 'MYBOX', 'GEOM', MDSYS.SDO_DIM_ARRAY(MDSYS.SDO_DIM_ELEMENT('X',-180,180,0.05),MDSYS.SDO_DIM_ELEMENT('Y',-90,90,0.05),MDSYS.SDO_DIM_ELEMENT('Z',-100,10000,0.05) ),4327 );

CREATE INDEX mybox_3dindex ON MYBOX(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS ('SDO_INDX_DIMS=3');

--Rectangle
INSERT INTO MYBOX (id,name,description,geom)VALUES
('1','Test','Deneme',
SDO_GEOMETRY
(
3003, -- SDO_GTYPE format: D00T. Set to 3003 for a 3-dimensional polygon
4327, -- World coordinate system
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


---Solid with 6 Rectangles --Bu Ornek 12c son versiyonda calismadi

INSERT INTO MYBOX VALUES
('2','Test','Deneme',
SDO_GEOMETRY
(
3008, -- SDO_GTYPE format: D00T. Set to 3008 for a 3-dimensional Solid
4327, -- World coordinate system
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
INSERT INTO MYBOX VALUES
('3','Test','Deneme',
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
INSERT INTO MYBOX VALUES
('4','Test','Deneme',
SDO_Geometry (3008,4327,NULL ,  
 SDO_Elem_Info_Array(1,1007,3),  
 SDO_Ordinate_Array(0.0,0.0,0.0,
10.0,20.0,20.0
)));


--Multi Solid Minimum Reps
INSERT INTO MYBOX VALUES
('5','Test','Deneme',
SDO_Geometry (3009,4327,NULL ,  
 SDO_Elem_Info_Array(1,1007,3,7,1007,3),  
 SDO_Ordinate_Array(-2.0,1.0,3.0,
-3.0,-1.0,0.0,
0.0,0.0,0.0,
1.0,1.0,1.0
)));

  SELECT gm.id,gm.name,gm.description
  FROM MYBOX gm
  WHERE SDO_ANYINTERACT(gm.GEOM,
        SDO_GEOMETRY
        (
        3001, -- SDO_GTYPE: D00T. Set to 4001 as it is a 4-dimensional point
        4327, -- SDO_SRID
        NULL, -- SDO_POINT_TYPE is null
        SDO_ELEM_INFO_ARRAY(1,1,1), -- Indicates a point element
        SDO_ORDINATE_ARRAY(4,2,3) -- Store the four ordinates here
        )
        ) ='TRUE';