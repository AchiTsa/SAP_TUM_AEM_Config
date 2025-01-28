CLASS lhc_Z00SAP_ProjectOverview_I DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    TYPES: BEGIN OF position ,
             value(10),
           END OF position,
           BEGIN OF position_reason ,
             value(10),
             description TYPE string,
           END OF position_reason,

           lt_postitions TYPE TABLE OF position, "input for check of extension task
           lt_errors     TYPE TABLE OF position_reason WITH NON-UNIQUE KEY value, "output for check of extension task
           BEGIN OF error_pos,"alle errors am schluss des checks
             extension_task  TYPE String,
             position_errors TYPE lt_errors,
           END OF error_pos,
           error_positions TYPE TABLE OF error_pos WITH NON-UNIQUE KEY extension_task.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Z00SAP_ProjectOverview_I RESULT result.
    METHODS duplicateproject FOR MODIFY
      IMPORTING keys FOR ACTION z00sap_projectoverview_i~duplicateproject.
    METHODS deleteproject FOR MODIFY
      IMPORTING keys FOR ACTION z00sap_projectoverview_i~deleteproject.
    METHODS uploadexceldata FOR MODIFY
      IMPORTING keys FOR ACTION projoverfile~uploadexceldata RESULT result.
    METHODS fields FOR DETERMINE ON MODIFY
      IMPORTING keys FOR projoverfile~fields.
    METHODS excelVal FOR VALIDATE ON SAVE
      IMPORTING keys FOR projoverfile~excelVal.
    METHODS exportExcelData FOR MODIFY
      IMPORTING keys FOR ACTION ProjOverFile~exportExcelData.

    CLASS-METHODS insert_col
      IMPORTING VALUE(fieldname) TYPE lvc_s_fcat-fieldname
                VALUE(ref_table) TYPE lvc_s_fcat-tabname
                VALUE(ref_field) TYPE lvc_s_fcat-fieldname
                VALUE(col_pos)   TYPE lvc_s_fcat-col_pos
                VALUE(coltext)   TYPE lvc_s_fcat-coltext
                VALUE(outputlen) TYPE lvc_s_fcat-outputlen
      CHANGING  feldkatalog      TYPE lvc_t_fcat.

    METHODS checkHierarchies FOR MODIFY
      IMPORTING keys FOR ACTION ProjOverFile~checkHierarchies.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ProjOverFile RESULT result.
    METHODS createUrls FOR DETERMINE ON SAVE
      IMPORTING keys FOR ProjOverFile~createUrls.
    METHODS validateProjectNameFilled FOR VALIDATE ON SAVE
      IMPORTING keys FOR ProjOverFile~validateProjectNameFilled.
    METHODS is_update_allowed
      RETURNING VALUE(update_allowed) TYPE abap_bool.
    METHODS is_create_allowed
      RETURNING VALUE(create_allowed) TYPE abap_bool.
    METHODS is_delete_allowed
      RETURNING VALUE(delete_allowed) TYPE abap_bool.
    METHODS is_deleteProject_allowed
      RETURNING VALUE(deleteProject_allowed) TYPE abap_bool.
    METHODS is_uploadExcelData_allowed
      RETURNING VALUE(uploadExcelData_allowed) TYPE abap_bool.
    METHODS is_exportExcelData_allowed
      RETURNING VALUE(exportExcelData_allowed) TYPE abap_bool.
    METHODS is_checkHierarchies_allowed
      RETURNING VALUE(checkHierarchies_allowed) TYPE abap_bool.
    METHODS is_duplicateProject_allowed
      RETURNING VALUE(duplicateProject_allowed) TYPE abap_bool.
    CLASS-METHODS validateHierarchy
      IMPORTING lt_hierarchy     TYPE lt_postitions
      RETURNING VALUE(error_tab) TYPE lt_errors.







ENDCLASS.

CLASS lhc_Z00SAP_ProjectOverview_I IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD duplicateProject.

    READ ENTITIES OF Z00SAP_ProjectOverview_I IN LOCAL MODE
      ENTITY Z00SAP_ProjectOverview_I
      FIELDS ( Projectid )
      WITH CORRESPONDING #( keys )
      RESULT DATA(projects).

    "find to be duplicated projects
    LOOP AT projects INTO DATA(project).
      DATA lt_existing_projects TYPE TABLE OF z00sap_projects.
      SELECT * FROM z00sap_projects
        INTO TABLE lt_existing_projects
        WHERE projectid = project-Projectid AND version = project-Version.

      "find related TLs
      DATA lt_tls TYPE TABLE OF z00sap_tl.
      SELECT * FROM z00sap_tl
        INTO TABLE lt_tls
        WHERE projectid = project-Projectid AND version = project-Version.

      "find related ESs
      DATA lt_ess TYPE TABLE OF z00sap_es.
      LOOP AT lt_tls INTO DATA(tl).
        SELECT * FROM z00sap_es
          APPENDING TABLE lt_ess
          WHERE tierid = tl-tierid.
      ENDLOOP.

      "find related ETs
      DATA lt_ets TYPE TABLE OF z00sap_et.
      LOOP AT lt_ess INTO DATA(es).
        SELECT * FROM z00sap_et
          APPENDING TABLE lt_ets
          WHERE es_id = es-es_id.
      ENDLOOP.

      "find related TBBs
      DATA lt_tbbs TYPE TABLE OF z00sap_tbb.
      LOOP AT lt_ets INTO DATA(et).
        SELECT * FROM z00sap_tbb
          APPENDING TABLE lt_tbbs
          WHERE et_id = et-et_id.
      ENDLOOP.

      DATA: l_projectid TYPE sysuuid_x16.
      DATA: l_version TYPE z00sap_version.
      LOOP AT lt_existing_projects INTO DATA(pro).
        TRY.
            DO.
              DATA: l_uuid_x16_pro TYPE sysuuid_x16.
              l_uuid_x16_pro = cl_system_uuid=>create_uuid_x16_static( ).
              SELECT SINGLE projectid FROM z00sap_projects INTO @DATA(existing_uuid_pro)
                  WHERE projectid = @l_uuid_x16_pro.
              IF sy-subrc <> 0.
                EXIT. " Exit the loop
              ENDIF.
            ENDDO.
            "assign new uuid to tier
            LOOP AT lt_tls INTO DATA(tl1).
              IF tl1-projectid = pro-projectid.
                tl1-projectid = l_uuid_x16_pro.
                MODIFY lt_tls FROM tl1 INDEX sy-tabix.
              ENDIF.
            ENDLOOP.
            "change to new uuid
            pro-projectid = l_uuid_x16_pro.
            l_projectid = l_uuid_x16_pro.
            l_version = pro-version.
            MODIFY lt_existing_projects FROM pro INDEX sy-tabix.
          CATCH cx_uuid_error INTO DATA(e_text_pro).
        ENDTRY.
      ENDLOOP.

      "generate new uuid for ETs
      LOOP AT lt_ets INTO DATA(et1).
        TRY.
            DO.
              DATA: l_uuid_x16_et TYPE sysuuid_x16.
              l_uuid_x16_et = cl_system_uuid=>create_uuid_x16_static( ).
              SELECT SINGLE et_id FROM z00sap_et INTO @DATA(existing_uuid_et)
                  WHERE et_id = @l_uuid_x16_et.
              IF sy-subrc <> 0.
                EXIT. " Exit the loop
              ENDIF.
            ENDDO.
            "assign new uuid to tbbs
            LOOP AT lt_tbbs INTO DATA(tbb3).
              IF tbb3-et_id = et1-et_id.
                tbb3-et_id = l_uuid_x16_et.
                MODIFY lt_tbbs FROM tbb3 INDEX sy-tabix.
              ENDIF.
            ENDLOOP.
            "change to new uuid
            et1-et_id = l_uuid_x16_et.
            et1-projectid = l_projectid.
            et1-version = l_version.
            MODIFY lt_ets FROM et1 INDEX sy-tabix.
          CATCH cx_uuid_error INTO DATA(e_text_et).
        ENDTRY.
      ENDLOOP.


      "generate new uuid for tbbs, and assign the new uuid to corresponding col values and structs
      LOOP AT lt_tbbs INTO DATA(tbb2).
        TRY.
            DO.
              DATA: l_uuid_x16_tbb TYPE sysuuid_x16.
              l_uuid_x16_tbb = cl_system_uuid=>create_uuid_x16_static( ).
              SELECT SINGLE tbb_id FROM z00sap_tbb INTO @DATA(existing_uuid_tbb)
                  WHERE tbb_id = @l_uuid_x16_tbb.
              IF sy-subrc <> 0.
                EXIT. " Exit the loop
              ENDIF.
            ENDDO.
            "change the tbb_id to newly generated
            tbb2-tbb_id = l_uuid_x16_tbb.
            tbb2-projectid = l_projectid.
            tbb2-version = l_version.
            MODIFY lt_tbbs FROM tbb2 INDEX sy-tabix.
          CATCH cx_uuid_error INTO DATA(e_text_tbb).
        ENDTRY.
      ENDLOOP.

      "generate new uuid for TL
      LOOP AT lt_tls INTO DATA(tl2).
        TRY.
            DO.
              DATA: l_uuid_x16_tier TYPE sysuuid_x16.
              l_uuid_x16_tier = cl_system_uuid=>create_uuid_x16_static( ).
              SELECT SINGLE tierid FROM z00sap_tl INTO @DATA(existing_uuid_tier)
                  WHERE tierid = @l_uuid_x16_tier.
              IF sy-subrc <> 0.
                EXIT. " Exit the loop
              ENDIF.
            ENDDO.
            "assign new uuid to es
            LOOP AT lt_ess INTO DATA(es1).
              IF es1-tierid = tl2-tierid.
                es1-tierid = l_uuid_x16_tier.
                MODIFY lt_ess FROM es1 INDEX sy-tabix.
              ENDIF.
            ENDLOOP.
            "change to new uuid
            tl2-tierid = l_uuid_x16_tier.
            tl2-projectid = l_projectid.
            tl2-version = l_version.
            MODIFY lt_tls FROM tl2 INDEX sy-tabix.
          CATCH cx_uuid_error INTO DATA(e_text_tls).
        ENDTRY.
      ENDLOOP.

      LOOP AT lt_ess INTO DATA(es2).
        TRY.
            DO.
              DATA: l_uuid_x16_es TYPE sysuuid_x16.
              l_uuid_x16_es = cl_system_uuid=>create_uuid_x16_static( ).
              SELECT SINGLE es_id FROM z00sap_es INTO @DATA(existing_uuid_es)
                  WHERE es_id = @l_uuid_x16_es.
              IF sy-subrc <> 0.
                EXIT. " Exit the loop
              ENDIF.
            ENDDO.
            "assign new es_id to ets
            LOOP AT lt_ets INTO DATA(ets2).
              IF ets2-es_id = es2-es_id.
                ets2-es_id = l_uuid_x16_es.
                MODIFY lt_ets FROM ets2 INDEX sy-tabix.
              ENDIF.
            ENDLOOP.
            "change to new uuid
            es2-es_id = l_uuid_x16_es.
            es2-projectid = l_projectid.
            es2-version = l_version.
            MODIFY lt_ess FROM es2 INDEX sy-tabix.
          CATCH cx_uuid_error INTO DATA(existing_uuid).
        ENDTRY.
      ENDLOOP.

      INSERT z00sap_projects FROM TABLE @lt_existing_projects.
      INSERT z00sap_tl FROM TABLE @lt_tls.
      INSERT z00sap_es FROM TABLE @lt_ess.
      INSERT z00sap_et FROM TABLE @lt_ets.
      INSERT z00sap_tbb FROM TABLE @lt_tbbs.

    ENDLOOP.



  ENDMETHOD.

  METHOD deleteProject.
    READ ENTITIES OF Z00SAP_ProjectOverview_I IN LOCAL MODE
        ENTITY Z00SAP_ProjectOverview_I
        FIELDS ( Projectid )
        WITH CORRESPONDING #( keys )
        RESULT DATA(projects).
    LOOP AT projects INTO DATA(project).
      DATA lt_existing_projects TYPE TABLE OF z00sap_projects.
      SELECT * FROM z00sap_projects
      INTO TABLE lt_existing_projects
      WHERE projectid = project-Projectid AND version = project-Version.

      "find related TLs
      DATA lt_tls TYPE TABLE OF z00sap_tl.
      SELECT * FROM z00sap_tl
        INTO TABLE lt_tls
        WHERE projectid = project-Projectid AND version = project-Version.

      "find related ESs
      DATA lt_ess TYPE TABLE OF z00sap_es.
      LOOP AT lt_tls INTO DATA(tl).
        SELECT * FROM z00sap_es
          APPENDING TABLE lt_ess
          WHERE tierid = tl-tierid.
      ENDLOOP.

      "find related ETs
      DATA lt_ets TYPE TABLE OF z00sap_et.
      LOOP AT lt_ess INTO DATA(es).
        SELECT * FROM z00sap_et
          APPENDING TABLE lt_ets
          WHERE es_id = es-es_id.
      ENDLOOP.
*
      "find related TBBs
      DATA lt_tbbs TYPE TABLE OF z00sap_tbb.
      LOOP AT lt_ets INTO DATA(et).
        SELECT * FROM z00sap_tbb
          APPENDING TABLE lt_tbbs
          WHERE et_id = et-et_id.
      ENDLOOP.

      "delete project from database
      LOOP AT lt_existing_projects INTO DATA(lt_project).
        DELETE FROM z00sap_projects WHERE projectid = lt_project-projectid AND version = lt_project-version.
*        UPDATE  z00sap_projects SET archived = abap_true WHERE projectid = lt_project-projectid.
      ENDLOOP.

      LOOP AT lt_tls INTO DATA(lt_tl).
        DELETE FROM z00sap_tl WHERE tierid = lt_tl-tierid.
      ENDLOOP.

      LOOP AT lt_ess INTO DATA(lt_es).
        DELETE FROM z00sap_es WHERE es_id = lt_es-es_id.
      ENDLOOP.

      LOOP AT lt_ets INTO DATA(lt_et).
        DELETE FROM z00sap_et WHERE et_id = lt_et-et_id.
      ENDLOOP.

      LOOP AT lt_tbbs INTO DATA(lt_tbb).
        DELETE FROM z00sap_tbb WHERE tbb_id = lt_tbb-tbb_id.
      ENDLOOP.

    ENDLOOP.
  ENDMETHOD.



  METHOD uploadExcelData.


** Read the parent instance
    READ ENTITIES OF z00sap_projectoverview_i IN LOCAL MODE
      ENTITY ProjOverFile
      ALL FIELDS WITH
      CORRESPONDING #( keys )
      RESULT DATA(lt_inv).





** Get attachment value from the instance
    DATA(lv_attachment) = lt_inv[ 1 ]-attachment.



** Data declarations
    DATA: rows              TYPE STANDARD TABLE OF string,
          content           TYPE string,
          conv              TYPE REF TO cl_abap_conv_in_ce,
          ls_excel_data_tl  TYPE z00sap_tl,
          ls_excel_data_pr  TYPE z00sap_projects,
          ls_excel_data_es  TYPE z00sap_es,
          ls_excel_data_et  TYPE z00sap_et,
          ls_excel_data_tbb TYPE z00sap_tbb,
          lt_excel_data_pr  TYPE STANDARD TABLE OF z00sap_projects,
          lt_excel_data_tl  TYPE STANDARD TABLE OF z00sap_tl,
          lt_excel_data_es  TYPE STANDARD TABLE OF z00sap_es,
          lt_excel_data_et  TYPE STANDARD TABLE OF z00sap_et,
          lt_excel_data_tbb TYPE STANDARD TABLE OF z00sap_tbb.

**************************************************************************


*The type definition resembling the structure of the rows in the worksheet selection.
    TYPES: BEGIN OF ty_excel,
             tierlayer           TYPE string,
             extensionstyle      TYPE string,
             extensiontask       TYPE string,
             Extensiondomain     TYPE string,
             coreextensiondomain TYPE string,
             buildingblock       TYPE string,
             color               TYPE string,
             reasoning           TYPE string,
             hierarchie          TYPE string,
             link                TYPE string,

           END OF ty_excel,
           tt_row TYPE STANDARD TABLE OF ty_excel.

    DATA lt_rows TYPE tt_row.
*    CLEAR: lt_rows[].

    DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content = lv_attachment )->read_access( ).
    DATA(lo_worksheet) = lo_xlsx->get_workbook( )->worksheet->at_position( 1 ).

    DATA(lo_selection_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to( )->get_pattern( ).

    DATA(lo_execute) = lo_worksheet->select( lo_selection_pattern
      )->row_stream(
      )->operation->write_to( REF #( lt_rows ) ).

    lo_execute->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value
               )->if_xco_xlsx_ra_operation~execute( ).

    DATA old_tierlevel TYPE String.
    DATA old_stylename TYPE String.
    DATA old_taskname TYPE String.
    DATA old_tbb_name TYPE String.
*   Additional saving of current/old uuids to not generate always new ones.
    DATA old_tier_uuid TYPE sysuuid_x16.
    DATA old_style_uuid TYPE sysuuid_x16.
    DATA old_task_uuid TYPE sysuuid_x16.

*    Data basis_project TYPE z00sap_projects.
**********************************************************************


* Three-Tier Architecture Extension Style Extension Task  Extension Domain    Core Extension Domain   Technical Extension Building Block
    READ TABLE lt_rows INTO DATA(wa_rows) INDEX 1.

    GET TIME STAMP FIELD DATA(ts).

    DATA(prid) = keys[ 1 ]-Projectid.
    DATA(prve) = keys[ 1 ]-Version.

    SELECT SINGLE * FROM z00sap_projects INTO  @ls_excel_data_pr
    WHERE projectid = @prid AND version = @prve.


    IF sy-subrc = 0.
      "save old project so file and attachment is not overwritten
*      basis_project = ls_excel_data_pr.

      ls_excel_data_pr-createdby = sy-uname.
      ls_excel_data_pr-createdat = ts.
      ls_excel_data_pr-attachment = lt_inv[ 1 ]-Attachment.
      ls_excel_data_pr-filename = lt_inv[ 1 ]-Filename.

      SPLIT keys[ 1 ]-Version AT '.' INTO  ls_excel_data_pr-version DATA(x) .

      ls_excel_data_pr-version = ls_excel_data_pr-version && '.' && ts.

      INSERT z00sap_projects FROM ls_excel_data_pr.

    ELSE.
      ls_excel_data_pr-Projectid = prid.
      ls_excel_data_pr-Version = prve.
    ENDIF.




" take care that the tl es and tbb are always set
    DELETE lt_rows INDEX 1.
    LOOP AT lt_rows INTO DATA(ls_rows).

      IF ( NOT ls_rows-tierlayer IS INITIAL AND NOT  ls_rows-tierlayer EQ old_tierlevel ) OR sy-tabix = 1.
        old_tier_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      ENDIF.

      IF ls_rows-tierlayer IS INITIAL.
        ls_rows-tierlayer = old_tierlevel.
      ELSE.
        old_tierlevel = ls_rows-tierlayer.
      ENDIF.

      IF ( NOT ls_rows-extensionstyle IS INITIAL AND NOT ls_rows-extensionstyle EQ old_stylename ) OR sy-tabix = 1.
        old_style_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      ENDIF.

      IF ls_rows-extensionstyle IS INITIAL.
        ls_rows-extensionstyle = old_stylename.
      ELSE.
        old_stylename = ls_rows-extensionstyle.
      ENDIF.

      IF ( NOT ls_rows-extensiontask IS INITIAL AND NOT ls_rows-extensiontask EQ old_taskname )  OR sy-tabix = 1.
        old_task_uuid = cl_system_uuid=>create_uuid_x16_static( ).
      ENDIF.

      IF ls_rows-extensiontask IS INITIAL.
        ls_rows-extensiontask = old_taskname.
      ELSE.
        old_taskname = ls_rows-extensiontask.
      ENDIF.


      IF ls_rows-buildingblock IS INITIAL.
        ls_rows-buildingblock = old_tbb_name.
      ELSE.
        old_tbb_name = ls_rows-buildingblock.
      ENDIF.

      ls_excel_data_tl-projectid = ls_excel_data_pr-Projectid.
      ls_excel_data_tl-version      = ls_excel_data_pr-Version.
*     Will be generated in if statements before.
*     ls_excel_data_tl-tierid      = cl_system_uuid=>create_uuid_x16_static( ).
      ls_excel_data_tl-tierid      = old_tier_uuid.
      ls_excel_data_tl-tierlevel = ls_rows-tierlayer.

      INSERT z00sap_tl FROM ls_excel_data_tl.

      ls_excel_data_es-tierid = ls_excel_data_tl-tierid.
      ls_excel_data_es-stylename = ls_rows-extensionstyle.
*     Will be generated in if statements before.
*      ls_excel_data_es-es_id = cl_system_uuid=>create_uuid_x16_static( ).
      ls_excel_data_es-es_id = old_style_uuid.
      ls_excel_data_es-projectid = ls_excel_data_pr-Projectid.
      ls_excel_data_es-version = ls_excel_data_pr-Version.

      INSERT z00sap_es FROM ls_excel_data_es.

      ls_excel_data_et-es_id = ls_excel_data_es-es_id.
      ls_excel_data_et-taskname = ls_rows-extensiontask.
*     Will be generated in if statements before.
*      ls_excel_data_et-et_id = cl_system_uuid=>create_uuid_x16_static( ).
      ls_excel_data_et-et_id = old_task_uuid.
      ls_excel_data_et-projectid = ls_excel_data_pr-Projectid.
      ls_excel_data_et-version = ls_excel_data_pr-Version.

      INSERT z00sap_et FROM ls_excel_data_et.

      ls_excel_data_tbb-et_id = ls_excel_data_et-et_id.
      ls_excel_data_tbb-tbb_name = ls_rows-buildingblock.
      ls_excel_data_tbb-tbb_id = cl_system_uuid=>create_uuid_x16_static( ).
      ls_excel_data_tbb-projectid = ls_excel_data_pr-Projectid.
      ls_excel_data_tbb-version = ls_excel_data_pr-Version.
      ls_excel_data_tbb-color = ls_rows-color.
      ls_excel_data_tbb-reasoning = ls_rows-reasoning.
      ls_excel_data_tbb-hierarchy = ls_rows-hierarchie.
      ls_excel_data_tbb-link = ls_rows-link.
      ls_excel_data_tbb-extensiondomain = ls_rows-extensiondomain.
      ls_excel_data_tbb-coreextensiondomain = ls_rows-coreextensiondomain.


      INSERT z00sap_tbb FROM ls_excel_data_tbb.


      CLEAR: ls_rows, ls_excel_data_tl, ls_excel_data_es, ls_excel_data_et, ls_excel_data_tbb.

    ENDLOOP.

  ENDMETHOD.




  METHOD fields.

    DATA: ls_excel_data_pr TYPE z00sap_projects,
          lt_update        TYPE TABLE FOR UPDATE z00sap_projectoverview_i.


" otherwise called two times
    IF keys[ 1 ]-%is_draft = '00'.
      DATA(prid) = keys[ 1 ]-Projectid.
      DATA(prve) = keys[ 1 ]-Version.
" take care that old filename is not overwritten in storage
      SELECT SINGLE * FROM z00sap_projects INTO  @ls_excel_data_pr
      WHERE projectid = @prid AND version = @prve.

      READ ENTITIES OF z00sap_projectoverview_i IN LOCAL MODE
          ENTITY ProjOverFile
          ALL FIELDS WITH
          CORRESPONDING #( keys )
          RESULT DATA(lt_inv).

      IF lt_inv[ 1 ]-filename EQ ls_excel_data_pr-filename.
        EXIT.
      ENDIF.


      MODIFY ENTITIES OF z00sap_projectoverview_i IN LOCAL MODE
      ENTITY ProjOverFile
      EXECUTE uploadexceldata
      FROM CORRESPONDING #( keys ).

      IF ls_excel_data_pr IS NOT INITIAL."sy-subrc = 0.

        lt_update = VALUE #(
                        (
                            Projectid =  prid
                            Version = prve
                            Attachment = ls_excel_data_pr-attachment
                            Filename = ls_excel_data_pr-filename
                            %control-Attachment = if_abap_behv=>mk-on
                            %control-Filename = if_abap_behv=>mk-on
                        )
                        ).


        MODIFY ENTITIES OF z00sap_projectoverview_i
        ENTITY ProjOverFile
        UPDATE FROM lt_update.


        READ ENTITIES OF z00sap_projectoverview_i IN LOCAL MODE
        ENTITY ProjOverFile
        ALL FIELDS WITH
        CORRESPONDING #( keys )
        RESULT DATA(cache).

        IF sy-subrc = 0.
        ENDIF.


      ENDIF.

    ENDIF.


  ENDMETHOD.



  METHOD excelval.

    READ ENTITIES OF z00sap_projectoverview_i IN LOCAL MODE
      ENTITY ProjOverFile
      ALL FIELDS WITH
      CORRESPONDING #( keys )
      RESULT DATA(lt_inv).

    IF lt_inv[ 1 ]-Filename IS NOT INITIAL.

*    * Get attachment value from the instance
      DATA(lv_attachment) = lt_inv[ 1 ]-attachment.


*    * Data declarations
      DATA: rows              TYPE STANDARD TABLE OF string,
            content           TYPE string,
            conv              TYPE REF TO cl_abap_conv_in_ce,
            ls_excel_data_tl  TYPE z00sap_tl,
            ls_excel_data_es  TYPE z00sap_es,
            ls_excel_data_et  TYPE z00sap_et,
            ls_excel_data_tbb TYPE z00sap_tbb,
            lt_excel_data_tl  TYPE STANDARD TABLE OF z00sap_tl,
            lt_excel_data_es  TYPE STANDARD TABLE OF z00sap_es,
            lt_excel_data_et  TYPE STANDARD TABLE OF z00sap_et,
            lt_excel_data_tbb TYPE STANDARD TABLE OF z00sap_tbb.

*    *************************************************************************


*    The type definition resembling the structure of the rows in the worksheet selection.
      TYPES: BEGIN OF ty_excel,
               tierlayer           TYPE string,
               extensionstyle      TYPE string,
               extensiontask       TYPE string,
               Extensiondomain     TYPE string,
               coreextensiondomain TYPE string,
               buildingblock       TYPE string,
               color               TYPE string,
               reasoning           TYPE string,
               hierarchy           TYPE string,
               link                TYPE string,
             END OF ty_excel,
             tt_row TYPE STANDARD TABLE OF ty_excel.

      DATA lt_rows TYPE tt_row.

      DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content = lv_attachment )->read_access( ).
      DATA(lo_worksheet) = lo_xlsx->get_workbook( )->worksheet->at_position( 1 ).

      DATA(lo_selection_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to( )->get_pattern( ).

      DATA(lo_execute) = lo_worksheet->select( lo_selection_pattern
        )->row_stream(
        )->operation->write_to( REF #( lt_rows ) ).

      lo_execute->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value
                 )->if_xco_xlsx_ra_operation~execute( ).

      DATA old_tierlevel TYPE String.
      DATA old_stylename TYPE String.
      DATA old_taskname TYPE String.
      DATA old_tbb_name TYPE String.


*     Three-Tier Architecture Extension Style Extension Task  Extension Domain    Core Extension Domain   Technical Extension Building Block
      READ TABLE lt_rows INTO DATA(wa_rows) INDEX 1.
      SELECT * FROM z00sap_col_names INTO TABLE @DATA(lt_rows_check) ORDER BY id.


      IF wa_rows-tierlayer NE lt_rows_check[ 1 ]-name "'Three-Tier Architecture'
          OR wa_rows-extensionstyle NE lt_rows_check[ 2 ]-name"'Extension Style'
          OR wa_rows-extensiontask NE lt_rows_check[ 3 ]-name"'Extension Task'
          OR wa_rows-extensiondomain NE lt_rows_check[ 4 ]-name"'Extension Domain'
          OR wa_rows-coreextensiondomain NE lt_rows_check[ 5 ]-name"'Core Extension Domain'
          OR wa_rows-buildingblock NE lt_rows_check[ 6 ]-name"'Technical Extension Building Block'
          OR wa_rows-color NE lt_rows_check[ 7 ]-name"'Color'
          OR wa_rows-reasoning NE lt_rows_check[ 8 ]-name"'Reasoning'
          OR wa_rows-hierarchy NE lt_rows_check[ 9 ]-name"'Hierarchy'
          OR wa_rows-link NE lt_rows_check[ 10 ]-name."'Link'.
        LOOP AT lt_inv ASSIGNING FIELD-SYMBOL(<r>).

          APPEND VALUE #( %key = <r>-%key ) TO failed-projoverfile.
          APPEND VALUE #( %key = <r>-%key
                          %msg = new_message( id = 'Z00SAP_ERROR_MESSAGE'
                                              number = '001'
                                              v1 = <r>-Filename
                                              severity = if_abap_behv_message=>severity-error
                                             )
*                                %element- = if_abap_behv=>mk-on
                        ) TO reported-projoverfile.



        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD exportExcelData.

    CLEAR reported-projoverfile.

    TYPES: BEGIN OF ty_excel,
             tierlevel           TYPE string,
             stylename           TYPE string,
             taskname            TYPE string,
             Extensiondomain     TYPE string,
             coreextensiondomain TYPE string,
             tbb_name            TYPE string,
             color               TYPE string,
             reasoning           TYPE string,
             hierarchy           TYPE string,
             link                TYPE string,

           END OF ty_excel,
           tt_row TYPE STANDARD TABLE OF ty_excel.

    DATA: lt_rows TYPE tt_row,
          ls_row  TYPE ty_excel.

    READ ENTITIES OF z00sap_projectoverview_i IN LOCAL MODE
    ENTITY ProjOverFile
    ALL FIELDS WITH
    CORRESPONDING #( keys )
    RESULT DATA(lt_inv).

    DATA(prid) = keys[ 1 ]-Projectid.
    DATA(prve) = keys[ 1 ]-Version.





    SELECT tierlevel, stylename, taskname, Extensiondomain, coreextensiondomain,
    tbb_name, color, reasoning, hierarchy, link
    INTO CORRESPONDING FIELDS OF TABLE @lt_rows
    FROM z00sap_projects AS pr
    INNER JOIN   z00sap_tl       AS tl      ON  pr~projectid = tl~projectid
                                            AND pr~version   = tl~version
    INNER JOIN   z00sap_es      AS es      ON tl~tierid = es~tierid AND pr~projectid = es~projectid AND pr~version   = es~version
    INNER JOIN   z00sap_et       AS et      ON es~es_id = et~es_id AND pr~projectid = et~projectid AND pr~version   = et~version
    INNER JOIN   z00sap_tbb     AS tbb     ON et~et_id = tbb~et_id AND pr~projectid = tbb~projectid AND pr~version   = tbb~version
    WHERE  pr~projectid = @prid AND pr~version = @prve.


    SELECT * FROM z00sap_col_names INTO TABLE @DATA(lt_rows_check) ORDER BY id.

*    ls_row-tierlevel = lt_rows_check[ 1 ]-name."'Three-Tier Architecture'.
*    ls_row-stylename  = lt_rows_check[ 2 ]-name."'Extension Style'.
*    ls_row-taskname  = lt_rows_check[ 3 ]-name."'Extension Task'.
*    ls_row-extensiondomain  = lt_rows_check[ 4 ]-name."'Extension Domain'.
*    ls_row-coreextensiondomain  = lt_rows_check[ 5 ]-name."'Core Extension Domain'.
*    ls_row-tbb_name  = lt_rows_check[ 6 ]-name."'Technical Extension Building Block'.
*    ls_row-color = lt_rows_check[ 7 ]-name."'Color'.
*    ls_row-reasoning  = lt_rows_check[ 8 ]-name."'Reasoning'.
*    ls_row-hierarchy  = lt_rows_check[ 9 ]-name."'Hierarchy'.
*    ls_row-link  = lt_rows_check[ 10 ]-name."'Link'.



    DATA: lt_xlstab TYPE STANDARD TABLE OF x255.

    DATA: lv_xstring   TYPE xstring,
          lv_xlsx      VALUE 'X',
          lv_binlength TYPE i,
          it_fieldcat  TYPE lvc_t_fcat,
          col_field    LIKE LINE OF it_fieldcat.

" checking with an outsourced method to not have duplicate code
    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Three-Tier Architecture'
                                               col_pos = 1
                                               fieldname = 'TIERLEVEL'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_TL'
                                               ref_field = 'TIERLEVEL'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).

*    col_field-coltext = 'Three-Tier Architecture'.
*    col_field-col_pos = 1.
*    col_field-fieldname = 'TIERLEVEL'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_TL'.
*    col_field-ref_field = 'TIERLEVEL'.
*
*    APPEND col_field TO it_fieldcat.

    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Extension Style'
                                               col_pos = 2
                                               fieldname = 'STYLENAME'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_ES'
                                               ref_field = 'STYLENAME'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).


*
*    col_field-coltext = 'Extension Style'.
*    col_field-col_pos = 2.
*    col_field-fieldname = 'STYLENAME'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_ES'.
*    col_field-ref_field = 'STYLENAME'.
*
*    APPEND col_field TO it_fieldcat.

    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Extension Task'
                                               col_pos = 3
                                               fieldname = 'TASKNAME'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_ET'
                                               ref_field = 'TASKNAME'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).




*
*    col_field-coltext = 'Extension Task'.
*    col_field-col_pos = 3.
*    col_field-fieldname = 'TASKNAME'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_ET'.
*    col_field-ref_field = 'TASKNAME'.
*
*    APPEND col_field TO it_fieldcat.

    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Extension Domain'
                                               col_pos = 4
                                               fieldname = 'EXTENSIONDOMAIN'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_TBB'
                                               ref_field = 'EXTENSIONDOMAIN'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).


*
*    col_field-coltext = 'Extension Domain'.
*    col_field-col_pos = 4.
*    col_field-fieldname = 'EXTENSIONDOMAIN'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_TBB'.
*    col_field-ref_field = 'EXTENSIONDOMAIN'.
*
*    APPEND col_field TO it_fieldcat.

    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Core Extension Domain'
                                               col_pos = 5
                                               fieldname = 'COREEXTENSIONDOMAIN'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_TBB'
                                               ref_field = 'COREEXTENSIONDOMAIN'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).


*
*    col_field-coltext = 'Core Extension Domain'.
*    col_field-col_pos = 5.
*    col_field-fieldname = 'COREEXTENSIONDOMAIN'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_TBB'.
*    col_field-ref_field = 'COREEXTENSIONDOMAIN'.
*
*    APPEND col_field TO it_fieldcat.
*

    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Technical Building Block'
                                               col_pos = 6
                                               fieldname = 'TBB_NAME'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_TBB'
                                               ref_field = 'TBB_NAME'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).

*    col_field-coltext = 'Technical Building Block'.
*    col_field-col_pos = 6.
*    col_field-fieldname = 'TBB_NAME'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_TBB'.
*    col_field-ref_field = 'TBB_NAME'.
*
*    APPEND col_field TO it_fieldcat.

    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Color'
                                               col_pos = 7
                                               fieldname = 'COLOR'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_TBB'
                                               ref_field = 'COLOR'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).

*
*    col_field-coltext = 'Color'.
*    col_field-col_pos = 7.
*    col_field-fieldname = 'COLOR'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_TBB'.
*    col_field-ref_field = 'COLOR'.
*
*    APPEND col_field TO it_fieldcat.
*

    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Reasoning'
                                               col_pos = 8
                                               fieldname = 'REASONING'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_TBB'
                                               ref_field = 'REASONING'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).

*    col_field-coltext = 'Reasoning'.
*    col_field-col_pos = 8.
*    col_field-fieldname = 'REASONING'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_TBB'.
*    col_field-ref_field = 'REASONING'.
*
*    APPEND col_field TO it_fieldcat.

    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Hierarchy'
                                               col_pos = 9
                                               fieldname = 'HIERARCHY'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_TBB'
                                               ref_field = 'HIERARCHY'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).

*
*    col_field-coltext = 'Hierarchy'.
*    col_field-col_pos = 9.
*    col_field-fieldname = 'HIERARCHY'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_TBB'.
*    col_field-ref_field = 'HIERARCHY'.
*
*    APPEND col_field TO it_fieldcat.
*

    lhc_Z00SAP_ProjectOverview_I=>insert_col(  EXPORTING
                                               coltext = 'Link'
                                               col_pos = 10
                                               fieldname = 'LINK'
                                               outputlen = 30
                                               ref_table = 'Z00SAP_TBB'
                                               ref_field = 'LINK'
                                               CHANGING
                                               feldkatalog = it_fieldcat ).

*    col_field-coltext = 'Link'.
*    col_field-col_pos = 10.
*    col_field-fieldname = 'LINK'.
*    col_field-outputlen = 30.
*    col_field-ref_table = 'Z00SAP_TBB'.
*    col_field-ref_field = 'LINK'.
*
*    APPEND col_field TO it_fieldcat.

" creates the bytestring

    TRY.
        edx_util=>create_xls_from_itab(
        EXPORTING
          i_xlsx      =  lv_xlsx            "     allgemeines flag
          it_fieldcat = it_fieldcat
        IMPORTING
          e_xstring   = lv_xstring
          CHANGING
            ct_data     = lt_rows
        ).
      CATCH cx_edx_send_fault.
    ENDTRY.



    SELECT SINGLE * FROM z00sap_projects INTO @DATA(ls_pr) WHERE projectid = @prid AND version = @prve.


" write bytestring to attachment for download
    ls_pr-attachment = lv_xstring.

    MODIFY z00sap_projects FROM ls_pr.


**********************************************************************
" actual method provided by sap, sadly not supported by our system
**********************************************************************

*    DATA(lo_document) = xco_cp_xlsx=>document->empty( )->write_access( ).
*
*    lo_document->get_workbook( )->add_new_sheet( `Made with ABAP` ).
*    DATA(lo_sheet) = lo_document->get_workbook( )->worksheet->at_position( 2 ).
*
*    DATA(lo_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to( )->get_pattern( ).
*
*    lo_sheet->select( lo_pattern
*      )->row_stream(
*      )->operation->write_from( REF #( lt_rows )
*      )->execute( ).

    DATA: warning_line   LIKE LINE OF reported-projoverfile.

    warning_line = VALUE #( %msg = new_message( severity = if_abap_behv_message=>severity-success  id = 'Z00SAP_ERROR_MESSAGE' number = 005 ) ).
    APPEND warning_line TO reported-projoverfile.

  ENDMETHOD.

  METHOD validateHierarchy.
    DATA: help_itab TYPE lt_postitions, itab TYPE lt_postitions.
    DATA: n(2) TYPE n,
          wa   LIKE LINE OF lt_hierarchy,
          BEGIN OF sorted_line,
            group(1),
            position(2) TYPE n,
          END OF sorted_line,
          sorted_lines LIKE TABLE OF sorted_line,
          wa1          LIKE LINE OF sorted_lines,
          pos_res_line TYPE position_reason.

    itab = lt_hierarchy. "Original is not allowed to be changed
    "split a1/b1 format
    LOOP AT itab INTO wa WHERE value CA '/'. "contains any
      SPLIT wa AT '/' INTO TABLE help_itab.
      DELETE TABLE itab FROM wa.
      INSERT LINES OF help_itab INTO itab INDEX 1.
      CLEAR help_itab[].
    ENDLOOP.

    LOOP AT itab INTO wa.
      sorted_line-group = wa(1).
      sorted_line-position = wa+1.
      APPEND sorted_line TO sorted_lines.
    ENDLOOP.

    SORT sorted_lines BY group position. "sorted is not grated

    DATA sorted_group_unique LIKE sorted_lines.
    sorted_group_unique = sorted_lines.

    DELETE ADJACENT DUPLICATES FROM sorted_group_unique COMPARING group.
    " check that first values are there
    LOOP AT sorted_group_unique INTO wa1.
      IF line_exists( sorted_lines[ group = wa1-group position = 1 ] ).
        CONTINUE.
      ELSE.
        pos_res_line-description = 'Missing First Value: ' && wa1-group && '01'.
        pos_res_line-value = wa1-group && '01'.
        APPEND pos_res_line TO error_tab.
      ENDIF.
    ENDLOOP.

    LOOP AT sorted_lines INTO wa1.

      Data(index) = sy-tabix + 1.

      READ TABLE sorted_lines INTO DATA(cache) INDEX index.

      "check before if there is a dublicate
      if Sy-subrc = 0 and cache-group = wa1-group and cache-position = wa1-position.
        pos_res_line-description = 'Dublicate: ' && wa1-group && wa1-position.
        pos_res_line-value = wa1-group && wa1-position.
        APPEND pos_res_line TO error_tab.
        CONTINUE.
      ENDIF.

      n = wa1-position.
      n = n + 1.
      SHIFT n LEFT DELETING LEADING '0'.
      wa-value = wa1-group && n. "searchstring follower

      IF line_exists( itab[ value = wa-value ] ).
        CONTINUE.
      ENDIF.



      " here the follower was not found, if nothing left then ok
      READ TABLE sorted_lines INTO DATA(next) INDEX index.
      "check if possible follower to determine dublicate or missing follower
      IF sy-subrc = 0 AND next-group = wa-value(1). "Anforderung fehlt!
        IF wa1-position EQ next-position.
          pos_res_line-description = 'Dublicate: ' && wa1-group && wa1-position.
          pos_res_line-value = wa1-group && wa1-position.
        ELSE.
          pos_res_line-description = 'Missing follower: ' && wa-value.
          pos_res_line-value = wa-value.
        ENDIF.

        APPEND pos_res_line TO error_tab.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD checkHierarchies.
"checks color and hierarchy
    CLEAR reported-projoverfile.

    READ ENTITIES OF z00sap_projectoverview_i IN LOCAL MODE
    ENTITY ProjOverFile
    ALL FIELDS WITH
    CORRESPONDING #( keys )
    RESULT DATA(lt_inv).

    DATA(prid) = keys[ 1 ]-Projectid.
    DATA(prve) = keys[ 1 ]-Version.



    SELECT taskname, hierarchy, color, tbb_name
    INTO TABLE @DATA(lt_rows)
    FROM z00sap_projects AS pr
    INNER JOIN   z00sap_tl       AS tl      ON  pr~projectid = tl~projectid
                                            AND pr~version   = tl~version
    INNER JOIN   z00sap_es      AS es      ON tl~tierid = es~tierid AND pr~projectid = es~projectid AND pr~version   = es~version
    INNER JOIN   z00sap_et       AS et      ON es~es_id = et~es_id AND pr~projectid = et~projectid AND pr~version   = et~version
    INNER JOIN   z00sap_tbb     AS tbb     ON et~et_id = tbb~et_id AND pr~projectid = tbb~projectid AND pr~version   = tbb~version
    WHERE  pr~projectid = @prid AND pr~version = @prve.

    DATA: old_task_name  TYPE String,
          task_positions TYPE lt_postitions,
          error_tab      TYPE TABLE OF position_reason,
          index          LIKE sy-tabix,
          all_errors     TYPE error_positions,
          one_error_et   TYPE error_pos,
          warning_line   LIKE LINE OF reported-projoverfile.

    SORT lt_rows BY taskname.

    index = 1.
    LOOP AT lt_rows INTO DATA(ls_row).
      CALL FUNCTION 'CHECK_DOMAIN_VALUES'
        EXPORTING
          domname       = 'Z00SAP_COLORS'
          value         = ls_row-color
        EXCEPTIONS
          no_domname    = 1
          wrong_value   = 2
          dom_not_found = 3
          OTHERS        = 4.

      IF sy-subrc <> 0.
        DATA description TYPE string.
        description = 'Only G(reen), R(ed) and Y(ellow) allowed!'.
        warning_line = VALUE #( %msg = new_message( severity = if_abap_behv_message=>severity-warning v1 = ls_row-tbb_name   v2 = description id = 'Z00SAP_ERROR_MESSAGE' number = 004 ) ).
        APPEND warning_line TO reported-projoverfile.
      ENDIF.



      IF old_task_name NE ls_row-taskname.
        IF index > 1.
          error_tab = lhc_Z00SAP_ProjectOverview_I=>validatehierarchy( task_positions ).
          one_error_et-extension_task = old_task_name.
          one_error_et-position_errors = error_tab.
          LOOP AT error_tab INTO DATA(error_line).
            warning_line = VALUE #( %msg = new_message( severity = if_abap_behv_message=>severity-warning v1 = one_error_et-extension_task   v2 = error_line-description id = 'Z00SAP_ERROR_MESSAGE' number = 002 ) ).
            APPEND warning_line TO reported-projoverfile.
          ENDLOOP.

          APPEND one_error_et TO all_errors.
          CLEAR: error_tab[], one_error_et, task_positions[].
          index = 1.
        ENDIF.
        old_task_name = ls_row-taskname.
      ENDIF.
      APPEND ls_row-hierarchy TO task_positions.
      index = index + 1.
    ENDLOOP.


    IF Lines( reported-projoverfile ) = 0.
      warning_line = VALUE #( %msg = new_message( severity = if_abap_behv_message=>severity-success v1 = 'Successful Check!'   v2 = 'Correct hierarchy and coloring of project.' id = 'Z00SAP_ERROR_MESSAGE' number = 003 ) ).
      APPEND warning_line TO reported-projoverfile.
    ENDIF.


  ENDMETHOD.

  METHOD get_global_authorizations.

    " Check if CREATE operation is requested
    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      IF is_create_allowed( ) = abap_true.
        result-%create = if_abap_behv=>auth-allowed.
      ELSE.
        result-%create = if_abap_behv=>auth-unauthorized.
      ENDIF.
    ENDIF.

    " Check if UPDATE operation is requested
    IF requested_authorizations-%update = if_abap_behv=>mk-on OR
        requested_authorizations-%action-Edit   = if_abap_behv=>mk-on.
      IF is_update_allowed( ) = abap_true.
        result-%update = if_abap_behv=>auth-allowed.
        result-%action-Edit = if_abap_behv=>auth-allowed.
      ELSE.
        result-%update = if_abap_behv=>auth-unauthorized.
        result-%action-Edit = if_abap_behv=>auth-unauthorized.
      ENDIF.
    ENDIF.


*    IF requested_authorizations-%action-prepare = if_abap_behv=>mk-on.
*      IF is_update_allowed( ) = abap_true.
*        result-%action-Prepare = if_abap_behv=>auth-allowed.
*      ELSE.
*        result-%action-Prepare = if_abap_behv=>auth-allowed.
*      ENDIF.
*    ENDIF.

    " Check if DELETE operation is requested
    IF requested_authorizations-%delete = if_abap_behv=>mk-on.
      IF is_delete_allowed( ) = abap_true.
        result-%delete = if_abap_behv=>auth-allowed.
      ELSE.
        result-%delete = if_abap_behv=>auth-unauthorized.
      ENDIF.
    ENDIF.

    " Check if DELETEPROJECT action is requested
    IF requested_authorizations-%action-deleteProject = if_abap_behv=>mk-on.
      IF is_deleteProject_allowed( ) = abap_true.
        result-%action-deleteProject = if_abap_behv=>auth-allowed.
      ELSE.
        result-%action-deleteProject = if_abap_behv=>auth-unauthorized.
      ENDIF.
    ENDIF.

    " Check if DUPLICATEPROJECT action is requested
    IF requested_authorizations-%action-duplicateProject = if_abap_behv=>mk-on.
      IF is_duplicateproject_allowed( ) = abap_true.
        result-%action-duplicateProject = if_abap_behv=>auth-allowed.
      ELSE.
        result-%action-duplicateProject = if_abap_behv=>auth-unauthorized.
      ENDIF.
    ENDIF.

    " Check if UPLOADEXCELDATA action is requested
    IF requested_authorizations-%action-uploadExcelData = if_abap_behv=>mk-on.
      IF is_uploadExcelData_allowed( ) = abap_true.
        result-%action-uploadExcelData = if_abap_behv=>auth-allowed.
      ELSE.
        result-%action-uploadExcelData = if_abap_behv=>auth-unauthorized.
      ENDIF.
    ENDIF.

    " Check if EXPORTEXCELDATA action is requested
    IF requested_authorizations-%action-exportExcelData = if_abap_behv=>mk-on.
      IF is_exportExcelData_allowed( ) = abap_true.
        result-%action-exportExcelData = if_abap_behv=>auth-allowed.
      ELSE.
        result-%action-exportExcelData = if_abap_behv=>auth-unauthorized.
      ENDIF.
    ENDIF.

    " Check if CHECKHIERARCHIES action is requested
    IF requested_authorizations-%action-checkHierarchies = if_abap_behv=>mk-on.
      IF is_checkHierarchies_allowed( ) = abap_true.
        result-%action-checkHierarchies = if_abap_behv=>auth-allowed.
      ELSE.
        result-%action-checkHierarchies = if_abap_behv=>auth-unauthorized.
      ENDIF.
    ENDIF.

  ENDMETHOD.
  METHOD is_create_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
     ID 'ACTVT' FIELD '01'.
    create_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*     create_allowed = abap_true.
  ENDMETHOD.

  METHOD is_update_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '02'.
    update_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*    update_allowed = abap_true.
  ENDMETHOD.

  METHOD is_delete_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
       ID 'ACTVT' FIELD '06'.
    delete_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*    delete_allowed = abap_false.

  ENDMETHOD.

  METHOD is_deleteproject_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '06'.
    deleteproject_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*      deleteproject_allowed = abap_false.
  ENDMETHOD.

  METHOD is_duplicateProject_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '02'.
    duplicateproject_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*     DUPLICATEPROJECT_ALLOWED = abap_true.
  ENDMETHOD.

  METHOD is_uploadExcelData_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '02'.
    uploadexceldata_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*     UPLOADEXCELDATA_ALLOWED = abap_true.
  ENDMETHOD.

  METHOD is_exportExcelData_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '02'.
    exportexceldata_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*     EXPORTEXCELDATA_ALLOWED = abap_true.
  ENDMETHOD.

  METHOD is_checkHierarchies_allowed.
    AUTHORITY-CHECK OBJECT 'Z_A_24'
    ID 'ACTVT' FIELD '02'.
    checkhierarchies_allowed = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
*     CHECKHIERARCHIES_ALLOWED = abap_true.
  ENDMETHOD.


  METHOD createUrls.

    READ ENTITIES OF z00sap_projectoverview_i IN LOCAL MODE
    ENTITY ProjOverFile
    ALL FIELDS WITH
    CORRESPONDING #( keys )
    RESULT DATA(lt_inv).

    DATA(prid) = keys[ 1 ]-Projectid.
    DATA(prve) = keys[ 1 ]-Version.
**********************************************************************
* Subject of change
    DATA preURL(256).
    preURL = 'https://s40lp1.ucc.cit.tum.de:8100/sap/bc/ui5_ui5/sap/z_graphapp_00/index.html?sap-client=300#/TaskDetails'.
**********************************************************************
    preURL = preURL && '/' && prid. "&& '/' && prve && '/'.

* Iterate over all versions of one project and regenerate links
    SELECT * FROM z00sap_et INTO TABLE @DATA(it_et) WHERE projectid = @prid.

    LOOP AT it_et INTO DATA(ls_et).
* Always according version has to be taken of ls_et and not general
      ls_et-url = preurl && '/' && ls_et-version && '/' && ls_et-et_id.
      ls_et-name = 'Chart'.

      MODIFY z00sap_et FROM ls_et.
    ENDLOOP.


  ENDMETHOD.

  METHOD insert_col.

    DATA: col_field LIKE LINE OF feldkatalog.

    col_field-coltext = coltext.
    col_field-col_pos = col_pos.
    col_field-fieldname = fieldname.
    col_field-outputlen = outputlen.
    col_field-ref_table = ref_table.
    col_field-ref_field = ref_field.

    APPEND col_field TO feldkatalog.
  ENDMETHOD.

  METHOD validateProjectNameFilled.
  " check that project name is given because in overview its grouped by name
    READ ENTITIES OF z00sap_projectoverview_i
        IN LOCAL MODE
        ENTITY ProjOverFile
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_read_results)
        FAILED DATA(lt_failed).

    LOOP AT lt_read_results ASSIGNING FIELD-SYMBOL(<ls_result>).
      IF <ls_result>-ProjectName IS INITIAL.
        APPEND VALUE #( %is_draft = <ls_result>-%is_draft
                        Projectid = <ls_result>-Projectid
                        Version = <ls_result>-Version
                      ) TO failed-projoverfile.
        APPEND VALUE #(
                        %is_draft = <ls_result>-%is_draft
                        Projectid = <ls_result>-Projectid
                        Version = <ls_result>-Version
                        %msg = new_message( severity = if_abap_behv_message=>severity-error v1 = 'No Project Name specified!' id = 'Z00SAP_ERROR_MESSAGE' number = 006 ) ) TO  reported-projoverfile.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
