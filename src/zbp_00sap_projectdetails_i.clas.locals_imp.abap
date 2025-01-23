CLASS lhc_Z00SAP_ProjectDetails_I DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Z00SAP_ProjectDetails_I RESULT result.
    METHODS add_line FOR MODIFY
      IMPORTING keys FOR ACTION prodet~add_line RESULT result.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR prodet RESULT result.
    METHODS is_update_allowed
      RETURNING VALUE(update_allowed) TYPE abap_bool.
    METHODS is_create_allowed
      RETURNING VALUE(create_allowed) TYPE abap_bool.
    METHODS is_delete_allowed
      RETURNING VALUE(delete_allowed) TYPE abap_bool.
     METHODS is_addline_allowed
       RETURNING VALUE(addline_allowed) TYPE abap_bool.

*    METHODS create FOR MODIFY
*      IMPORTING entities FOR CREATE Z00SAP_ProjectDetails_I.

*    METHODS update FOR MODIFY
*      IMPORTING entities FOR UPDATE Z00SAP_ProjectDetails_I.
*
*    METHODS delete FOR MODIFY
*      IMPORTING keys FOR DELETE Z00SAP_ProjectDetails_I.
*
*    METHODS read FOR READ
*      IMPORTING keys FOR READ Z00SAP_ProjectDetails_I RESULT result.

ENDCLASS.

CLASS lhc_Z00SAP_ProjectDetails_I IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.
*
**  METHOD create.
**  DATA: lt_projects TYPE TABLE OF z00sap_projects,
**        lt_tl       TYPE TABLE OF z00sap_tl,
**        lt_es       TYPE TABLE OF z00sap_es,
**        lt_et       TYPE TABLE OF z00sap_et,
**        lt_tbb      TYPE TABLE OF z00sap_tbb,
**        lt_colvals  TYPE TABLE OF z00sap_col_vals,
**        lt_cols     TYPE TABLE OF z00sap_columns.
**
**  " Map projects
**  lt_projects = VALUE #( FOR ls_entity IN entities
**    ( projectid = ls_entity-Projectid
**      version   = ls_entity-Version
**      sapversion = ls_entity-SapVersion
**      author    = ls_entity-Author
**      lastchanged = ls_entity-LastChanged
**      projectname = ls_entity-ProjectName
**      createdby   = ls_entity-CreatedBy
**      createdat   = ls_entity-CreatedAt
**      locallastchangedby = ls_entity-LocalLastChangedBy
**      locallastchangedat = ls_entity-LocalLastChangedAt
**      lastchangedat = ls_entity-LastChangedAt ) ).
**
**  " Map TL (tier levels)
**  lt_tl = VALUE #( FOR ls_entity IN entities
**    ( tierid = ls_entity-Tierid
**      tierlevel = ls_entity-TierLevel
**      projectid = ls_entity-TL_Projectid
**      version   = ls_entity-TL_Version ) ).
**
**  " Map ES (styles)
**  lt_es = VALUE #( FOR ls_entity IN entities
**    ( es_id = ls_entity-ES_Id
**      tierid = ls_entity-ES_Tierid
**      stylename = ls_entity-StyleName ) ).
**
**  " Map ET (tasks)
**  lt_et = VALUE #( FOR ls_entity IN entities
**    ( et_id = ls_entity-ET_Id
**      es_id = ls_entity-ET_ES_Id
**      taskname = ls_entity-TaskName ) ).
**
**  " Map TBB (blocks)
**  lt_tbb = VALUE #( FOR ls_entity IN entities
**    ( tbb_id = ls_entity-tbbid
**      et_id  = ls_entity-tbbetid
**      tbb_name = ls_entity-tbbname ) ).
**
**  " Map COL_VALS (column values)
**  lt_colvals = VALUE #( FOR ls_entity IN entities
**    ( val_id = ls_entity-colvalid
**      column_key = ls_entity-colvalscolumnkey
**      reasoning_id = ls_entity-reasoningid
**      value = ls_entity-value
**      is_sap = ls_entity-issap
**      is_editable = ls_entity-iseditable
**      tbb_id = ls_entity-colvalstbbid ) ).
**
**  " Map COLUMNS
**  lt_cols = VALUE #( FOR ls_entity IN entities
**    ( column_key = ls_entity-columnkey
**      columns = ls_entity-colcolumn
**      column_description = ls_entity-columndesc
**      data_type = ls_entity-columndtype
**      col_width = ls_entity-columnwidth
**      col_order = ls_entity-columnorder
**      created_by = ls_entity-colcreatedby
**      created_at = ls_entity-colcreatedat
**      local_last_changed_by = ls_entity-collocallastchangedby
**      local_last_changed_at = ls_entity-collocallastchangedat
**      last_changed_at = ls_entity-collastchangedat ) ).
**
**  " Persist to database
**  INSERT z00sap_projects FROM TABLE @lt_projects.
**  INSERT z00sap_tl FROM TABLE @lt_tl.
**  INSERT z00sap_es FROM TABLE @lt_es.
**  INSERT z00sap_et FROM TABLE @lt_et.
**  INSERT z00sap_tbb FROM TABLE @lt_tbb.
**  INSERT z00sap_col_vals FROM TABLE @lt_colvals.
**  INSERT z00sap_columns FROM TABLE @lt_cols.
**ENDMETHOD.
*
*
*  METHOD update.
**      DATA: lt_projects TYPE TABLE OF z00sap_projects,
**            ls_project  LIKE LINE OF lt_projects.
**
**      LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>).
**        CLEAR ls_project.
**
**        " Fetch existing data for this project
**        SELECT * FROM z00sap_projects
**          WHERE projectid = @<fs_entity>-Projectid
**            AND version   = @<fs_entity>-Version
**          INTO CORRESPONDING FIELDS OF @ls_project.
**        ENDSELECT.
**
**        " Update only modified fields
**        IF <fs_entity>-%control-SapVersion = '01'.
**          ls_project-sapversion = <fs_entity>-SapVersion.
**        ENDIF.
**        IF <fs_entity>-%control-Author = '01'.
**          ls_project-author = <fs_entity>-Author.
**        ENDIF.
**        " (Repeat for other fields if necessary...)
**
**        APPEND ls_project TO lt_projects.
**      ENDLOOP.
**
**      " Update database
**      UPDATE z00sap_projects FROM TABLE @lt_projects.
*    ENDMETHOD.
*
*
*  METHOD delete.
*
**    DATA: lt_keys TYPE RANGE OF z00sap_projects-projectid.
**
**    lt_keys = VALUE #(
**      FOR ls_key IN keys
**      ( sign = 'I' option = 'EQ' low = ls_key-Projectid )
**    ).
**
**    DELETE FROM z00sap_projects WHERE projectid IN @lt_keys.
*  ENDMETHOD.
*
*
*  METHOD read.
**  SELECT FROM z00sap_projects AS pr
**    INNER JOIN z00sap_tl       AS tl
**      ON pr.projectid = tl.projectid AND pr.version = tl.version
**    INNER JOIN z00sap_es       AS es
**      ON tl.tierid = es.tierid
**    INNER JOIN z00sap_et       AS et
**      ON es.es_id = et.es_id
**    INNER JOIN z00sap_tbb      AS tbb
**      ON et.et_id = tbb.et_id
**    INNER JOIN z00sap_col_vals AS colvals
**      ON tbb.tbb_id = colvals.tbb_id
**    INNER JOIN z00sap_columns  AS cols
**      ON colvals.column_key = cols.column_key
**    FIELDS
**      pr.projectid,
**      pr.version,
**      pr.sapversion,
**      pr.author,
**      pr.lastchanged,
**      pr.projectname,
**      pr.createdby,
**      pr.createdat,
**      pr.locallastchangedby,
**      pr.locallastchangedat,
**      pr.lastchangedat,
**      tl.tierid,
**      tl.tierlevel,
**      es.es_id,
**      es.stylename,
**      et.et_id,
**      et.taskname,
**      tbb.tbb_name,
**      colvals.value,
**      cols.columns
**    WHERE pr.projectid IN @keys-projectid
**      AND pr.version IN @keys-version
**    INTO TABLE @result.
*ENDMETHOD.



  METHOD add_line.
    DATA lines_for_add TYPE TABLE FOR UPDATE Z00SAP_PROJECTDETAILS_I.
   DATA(keys_with_tbb_id) = keys.



      READ ENTITIES OF Z00SAP_PROJECTDETAILS_I IN LOCAL MODE
     ENTITY prodet
       FIELDS ( Author Color Core_Extension_Domain ET_Id Extension_Domain Hierachy Projectid Version )
       WITH CORRESPONDING #( keys_with_tbb_id )
     RESULT DATA(prodets).
*data(yk) = keys_with_tbb_id[ 0 ]-Projectid.
   LOOP AT prodets ASSIGNING FIELD-SYMBOL(<prodet>).
     DATA:
     lt_tbb      TYPE TABLE OF z00sap_tbb.
     data(et_id_sel) = <prodet>-ET_Id.
     data(project_id_sel) = <prodet>-projectid.
     data(version_id_sel) = <prodet>-version.

     data(tbb_name) = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-Tech_Extension_Building_Block.
     data(color) = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-color.
     data(hierarchy) = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-hierarchy.
     data(link) = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-link.
     data(reasoning) = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-reasoning.
     data(coreextensiondomain) = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-coreextensiondomain.
     data(extensiondomain) = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-extensiondomain.

     append value #(
     tbb_id = cl_system_uuid=>create_uuid_x16_static( )
       et_id               = <prodet>-ET_Id


       tbb_name            =  keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-Tech_Extension_Building_Block
         projectid           = <prodet>-projectid


  version             = <prodet>-version

  extensiondomain     = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-extensiondomain
  coreextensiondomain = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-coreextensiondomain
  color               = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-color
  reasoning           = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-reasoning
  hierarchy           = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-hierarchy
  link                = keys_with_tbb_id[ %tky = <prodet>-%tky ]-%param-link


       ) to lt_tbb.

       INSERT z00sap_tbb      FROM TABLE lt_tbb.


     APPEND VALUE #( %tky       = <prodet>-%tky

                   ) TO lines_for_add.
   ENDLOOP.
  ENDMETHOD.

  METHOD get_global_authorizations.



    IF requested_authorizations-%update = if_abap_behv=>mk-on.
    " Check create authorization

    IF is_update_allowed( ) = abap_true.
      result-%update = if_abap_behv=>auth-allowed.
    ELSE.
      result-%update = if_abap_behv=>auth-unauthorized.

    ENDIF.
    ENDIF.

    IF requested_authorizations-%create = if_abap_behv=>mk-on.
    IF is_create_allowed( ) = abap_true.
      result-%create = if_abap_behv=>auth-allowed.
    ELSE.
      result-%create = if_abap_behv=>auth-unauthorized.
    ENDIF.
    ENDIF.

    IF requested_authorizations-%delete = if_abap_behv=>mk-on.
    " Check delete authorization
      IF is_delete_allowed( ) = abap_true.
      result-%delete = if_abap_behv=>auth-allowed.
    ELSE.
      result-%delete = if_abap_behv=>auth-unauthorized.
    ENDIF.
    ENDIF.

     IF requested_authorizations-%action-add_line = if_abap_behv=>mk-on.
    " Check delete authorization
      IF is_addline_allowed( ) = abap_true.
      result-%action-add_line = if_abap_behv=>auth-allowed.
    ELSE.
      result-%action-add_line = if_abap_behv=>auth-unauthorized.
    ENDIF.
    ENDIF.


  ENDMETHOD.

  METHOD is_update_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '02'.
    update_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*     update_allowed = abap_true.
  ENDMETHOD.

  METHOD is_create_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '01'.
    create_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*     create_allowed = abap_true.
  ENDMETHOD.

  METHOD is_delete_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '06'.
    delete_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*     delete_allowed = abap_true.
  ENDMETHOD.

  METHOD is_addline_allowed.
   AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '02'.
    addline_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*     addline_allowed = abap_true.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_Z00SAP_PROJECTDETAILS_I DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

*    METHODS finalize REDEFINITION.
*
*    METHODS check_before_save REDEFINITION.
*
*    METHODS save REDEFINITION.
*
*    METHODS cleanup REDEFINITION.
*
*    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_Z00SAP_PROJECTDETAILS_I IMPLEMENTATION.

*  METHOD finalize.
*  ENDMETHOD.
*
*  METHOD check_before_save.
*  ENDMETHOD.
*
*  METHOD save.
*  ENDMETHOD.
*
*  METHOD cleanup.
*  ENDMETHOD.
*
*  METHOD cleanup_finalize.
*  ENDMETHOD.

ENDCLASS.
