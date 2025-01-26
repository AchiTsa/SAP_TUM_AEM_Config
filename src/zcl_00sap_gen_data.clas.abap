CLASS zcl_00sap_gen_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_00sap_gen_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*  Update z00sap_et SET url =
*'sapgui:-SYSTEM=S40&-CLIENT=300&-USER=DEV-086&-LANGUAGE=EN&-REUSE=1&-COMMAND="""SCU3 TABNAME=Z00SAP_PROJECTS;tabfirst=X;alv_grid=X;"""'
*  name = 'google' where et_id = 'DB97C5F056CB1EEFB49F93B42455C0B5'.
*
*
*  if sy-subrc = 0.

*  ENDIF.

*
*    DATA inserted_line TYPE z00sap_col_names.
*    inserted_line-id = 1.
*    inserted_line-name = 'Three-Tier Architecture'.
*    INSERT z00sap_col_names FROM inserted_line.
*
*    inserted_line-id = 2.
*    inserted_line-name = 'Extension Style'.
*    INSERT z00sap_col_names FROM inserted_line.
*
*    inserted_line-id = 3.
*    inserted_line-name ='Extension Task'.
*    INSERT z00sap_col_names FROM inserted_line.
*
*    inserted_line-id = 4.
*    inserted_line-name ='Extension Domain'.
*    INSERT z00sap_col_names FROM inserted_line.
*
*    inserted_line-id = 5.
*    inserted_line-name ='Core Extension Domain'.
*    INSERT z00sap_col_names FROM inserted_line.
*
*    inserted_line-id = 6.
*    inserted_line-name ='Technical Extension Building Block'.
*    INSERT z00sap_col_names FROM inserted_line.
*
*    inserted_line-id = 7.
*    inserted_line-name ='Color'.
*    INSERT z00sap_col_names FROM inserted_line.
*
*    inserted_line-id = 8.
*    inserted_line-name ='Reasoning'.
*    INSERT z00sap_col_names FROM inserted_line.
*
*    inserted_line-id = 9.
*    inserted_line-name ='Hierarchy'.
*    INSERT z00sap_col_names FROM inserted_line.
*
*    inserted_line-id = 10.
*    inserted_line-name ='Link'.
*    INSERT z00sap_col_names FROM inserted_line.


*    DATA: lt_project  TYPE TABLE OF z00sap_projects,
*          lt_tl       TYPE TABLE OF z00sap_tl,
*          lt_es       TYPE TABLE OF z00sap_es,
*          lt_et       TYPE TABLE OF z00sap_et,
*          lt_tbb      TYPE TABLE OF z00sap_tbb,
*          lt_columns  TYPE TABLE OF z00sap_columns,
*          lt_col_vals TYPE TABLE OF z00sap_col_vals,
*          lt_struct   TYPE TABLE OF z00sap_struct.
*
*
*    " Variables to hold generated IDs
*    DATA lv_projectid TYPE sysuuid_x16.
*    DATA lv_tierid  TYPE sysuuid_x16.
*    DATA lv_es_id TYPE sysuuid_x16.
*    DATA lv_et_id TYPE sysuuid_x16.
*    DATA lv_tbb_id TYPE sysuuid_x16.
*    DATA lv_column_key TYPE sysuuid_x16.
*    DATA lv_val_id TYPE sysuuid_x16.
*    DATA lv_struct_id TYPE sysuuid_x16.
*
*    TRY.
*        lv_projectid = cl_system_uuid=>create_uuid_x16_static( ).
*        lv_tierid = cl_system_uuid=>create_uuid_x16_static( ).
*        lv_es_id = cl_system_uuid=>create_uuid_x16_static( ).
*        lv_et_id = cl_system_uuid=>create_uuid_x16_static( ).
*        lv_tbb_id = cl_system_uuid=>create_uuid_x16_static( ).
*        lv_column_key = cl_system_uuid=>create_uuid_x16_static( ).
*        lv_val_id = cl_system_uuid=>create_uuid_x16_static( ).
*        lv_struct_id = cl_system_uuid=>create_uuid_x16_static( ).
*      CATCH cx_uuid_error INTO DATA(e_text_gen).
*    ENDTRY.
*
*    APPEND VALUE #( projectid = lv_projectid
*                    version = 'VERSION_1' " Replace with valid version
*                    projectname = 'test'
*                    sapversion = 'test'
*                    author = 'tester'
*                    lastchanged = ''
*                    ) TO lt_project.
*
*    APPEND VALUE #( tierid = lv_tierid
*                    projectid = lv_projectid
*                    version = 'VERSION_1' " Replace with valid version
*                    tierlevel = 'TIER_LEVEL_1' ) TO lt_tl.
*
*    APPEND VALUE #( es_id = lv_es_id
*                    tierid = lv_tierid
*                    stylename = 'StyleNameExample' ) TO lt_es.
*
*    APPEND VALUE #( et_id = lv_et_id
*                    es_id = lv_es_id
*                    taskname = 'TaskNameExample' ) TO lt_et.
*
*    APPEND VALUE #( tbb_id = lv_tbb_id
*                    et_id = lv_et_id
*                    tbb_name = 'TBBNameExample' ) TO lt_tbb.
*
*    APPEND VALUE #( mandt = sy-mandt
*                    column_key = lv_column_key
*                    columns = 'COL001'
*                    column_description = 'Example Column'
*                    data_type = 'CHAR'
*                    col_width = 10
*                    col_order = 1 ) TO lt_columns.
*
*    APPEND VALUE #( mandt = sy-mandt
*                    val_id = lv_val_id
*                    column_key = lv_column_key
*                    value = 'Example Value'
*                    is_sap = abap_true
*                    is_editable = abap_false
*                    tbb_id = lv_tbb_id ) TO lt_col_vals.
*
*    APPEND VALUE #( client = sy-mandt
*                    struct_id = lv_struct_id
*                    path_name = '/path/to/example'
*                    tbb_id = lv_tbb_id ) TO lt_struct.
*    DELETE FROM z00sap_projects.
*    DELETE FROM z00sap_tl.
*    DELETE FROM z00sap_es.
*    DELETE FROM z00sap_et.
*    DELETE FROM z00sap_tbb.
*    DELETE FROM z00sap_columns.
*    DELETE FROM z00sap_col_vals.
*    DELETE FROM z00sap_struct.

    " Insert data into database tables
*    INSERT z00sap_projects FROM TABLE lt_project.
*    INSERT z00sap_tl       FROM TABLE lt_tl.
*    INSERT z00sap_es       FROM TABLE lt_es.
*    INSERT z00sap_et       FROM TABLE lt_et.
*    INSERT z00sap_tbb      FROM TABLE lt_tbb.
*    INSERT z00sap_columns  FROM TABLE lt_columns.
*    INSERT z00sap_col_vals FROM TABLE lt_col_vals.
*    INSERT z00sap_struct   FROM TABLE lt_struct.

*  DATA: lv_project_name TYPE String.
*  lv_project_name = 'project'.
*
*  UPDATE z00sap_proj_d
*  SET projectname = @lv_project_name
*  WHERE version LIKE 'achi'.

*    DELETE FROM z00sap_projects.
*    DELETE FROM z00sap_tl.
*    DELETE FROM z00sap_es.
*    DELETE FROM z00sap_et.
*    DELETE FROM z00sap_tbb.
*    DELETE FROM z00sap_proj_d.

**********************************************************************
* execute this line when logging throws exception
*    Delete From DBTABLOG where TABNAME = 'Z00SAP_PROJECTS'.
**********************************************************************




  ENDMETHOD.


ENDCLASS.
