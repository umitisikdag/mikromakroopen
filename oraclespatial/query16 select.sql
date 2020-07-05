  SELECT gm.id
  FROM MY3DTABLE gm
  WHERE SDO_ANYINTERACT(gm.GEOM,
        SDO_GEOMETRY
        (
        3001, -- SDO_GTYPE: D00T. Set to 4001 as it is a 4-dimensional point
        4327, -- SDO_SRID
        SDO_POINT_TYPE(29.043,41.055,60),--NULL, -- SDO_POINT_TYPE is null
        NULL,--SDO_ELEM_INFO_ARRAY(1,1,1), -- Indicates a point element
        NULL--SDO_ORDINATE_ARRAY(29.039,41.042,45) -- Store the four ordinates here
        )
        ) ='TRUE';