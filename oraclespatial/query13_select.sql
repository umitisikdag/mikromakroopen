/*SELECT gm.GEOM 
  FROM KUTU3 gm
  WHERE SDO_CONTAINS(gm.GEOM,
        SDO_GEOMETRY
        (
        3001, -- SDO_GTYPE: D00T. Set to 4001 as it is a 4-dimensional point
        NULL, -- SDO_SRID
        NULL, -- SDO_POINT_TYPE is null
        SDO_ELEM_INFO_ARRAY(1,1,1), -- Indicates a point element
        SDO_ORDINATE_ARRAY(3,0,3) -- Store the four ordinates here
        )
        ) = 'TRUE';
        
        
        SELECT gm.GEOM
  FROM KUTU3 gm
  WHERE SDO_RELATE(gm.GEOM,
        SDO_GEOMETRY
        (
        3001, -- SDO_GTYPE: D00T. Set to 4001 as it is a 4-dimensional point
        NULL, -- SDO_SRID
        NULL, -- SDO_POINT_TYPE is null
        SDO_ELEM_INFO_ARRAY(1,1,1), -- Indicates a point element
        SDO_ORDINATE_ARRAY(3,0,3) -- Store the four ordinates here
        ),'MASK=ANYINTERACT'
        ) = 'TRUE';
        */
        
               SELECT gm.GEOM
  FROM KUTU3 gm
  WHERE SDO_FILTER(gm.GEOM,
        SDO_GEOMETRY
        (
        2003, -- SDO_GTYPE: D00T. Set to 4001 as it is a 4-dimensional point
        NULL, -- SDO_SRID
        NULL, -- SDO_POINT_TYPE is null
        SDO_ELEM_INFO_ARRAY(1,1003,3), -- Indicates a point element
        SDO_ORDINATE_ARRAY(0.0001,0.0001,0.0002,0.0002) -- Store the four ordinates here
        )--,'MASK=CONTAINS'
        ) = 'TRUE';
        
        
                       SELECT gm.GEOM
  FROM KUTU3 gm
  WHERE SDO_FILTER(gm.GEOM,
        SDO_GEOMETRY
        (
        2003, -- SDO_GTYPE: D00T. Set to 4001 as it is a 4-dimensional point
        NULL, -- SDO_SRID
        NULL, -- SDO_POINT_TYPE is null
        SDO_ELEM_INFO_ARRAY(1,1003,3), -- Indicates a point element
        SDO_ORDINATE_ARRAY(29.0001,29.0001,40.0002,40.0002) -- Store the four ordinates here
        )--,'MASK=CONTAINS'
        ) = 'TRUE';
    -----------------------------------------------------------------------------    
  SELECT gm.GEOM
  FROM KUTU3 gm
  WHERE SDO_ANYINTERACT(gm.GEOM,
        SDO_GEOMETRY
        (
        3001, -- SDO_GTYPE: D00T. Set to 4001 as it is a 4-dimensional point
        NULL, -- SDO_SRID
        NULL, -- SDO_POINT_TYPE is null
        SDO_ELEM_INFO_ARRAY(1,1,1), -- Indicates a point element
        SDO_ORDINATE_ARRAY(31,31,31) -- Store the four ordinates here
        )
        ) ='TRUE';
   ---------------------------------------------------------------------------------
      
      
      --Noktanin spatial index i olmadigi icin yapamaz 
      SELECT gm.GEOM
  FROM KUTU3 gm
  WHERE SDO_INSIDE(
        SDO_GEOMETRY
        (
        3001, -- SDO_GTYPE: D00T. Set to 4001 as it is a 4-dimensional point
        NULL, -- SDO_SRID
        NULL, -- SDO_POINT_TYPE is null
        SDO_ELEM_INFO_ARRAY(1,1,1), -- Indicates a point element
        SDO_ORDINATE_ARRAY(3,0,3) -- Store the four ordinates here
        ),gm.GEOM
        ) ='TRUE';