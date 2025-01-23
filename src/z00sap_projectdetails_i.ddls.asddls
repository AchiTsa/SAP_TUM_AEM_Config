@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for project details'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z00SAP_ProjectDetails_I
  as select from z00sap_projects as pr
    inner join   z00sap_tl       as tl      on  pr.projectid = tl.projectid
                                            and pr.version   = tl.version
    inner join   z00sap_es      as es      on tl.tierid = es.tierid and pr.projectid = es.projectid and pr.version   = es.version
    inner join   z00sap_et       as et      on es.es_id = et.es_id and pr.projectid = et.projectid and pr.version   = et.version
    inner join   z00sap_tbb     as tbb     on et.et_id = tbb.et_id and pr.projectid = tbb.projectid and pr.version   = tbb.version
    
//    inner join   z00sap_col_vals as colvals on tbb.tbb_id = colvals.tbb_id
//    inner join   z00sap_columns  as cols    on colvals.column_key = cols.column_key
{
  key pr.projectid               as Projectid,
  key pr.version                 as Version,
  key    tbb.tbb_id                 as tbbid,
      pr.sapversion              as SapVersion,
      pr.author                  as Author,
      pr.lastchanged             as LastChanged,
      pr.projectname             as ProjectName,
      @Semantics.user.createdBy: true
      pr.createdby               as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      pr.createdat               as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      pr.locallastchangedby      as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      pr.locallastchangedat      as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      pr.lastchangedat           as LastChangedAt,

      // Additional columns from z00sap_tl
      tl.tierid                  as Tierid, // not necessary as key since we have project id and version
      tl.tierlevel               as TierLevel,
      tl.projectid               as TL_Projectid,
      tl.version                 as TL_Version,

      // Additional columns from z00sap_es
      es.es_id                   as ES_Id, // not necessary as key since we have project id and version
      es.tierid                  as ES_Tierid,
      es.stylename               as StyleName,
      es.projectid               as ES_Projectid,
      es.version                 as ES_Version,

      // Additional columns from z00sap_et
      et.et_id                   as ET_Id, // not necessary as key since we have project id and version
      et.es_id                   as ET_ES_Id,
      et.taskname                as TaskName,
      et.url                     as Url,
      et.name                    as Name,
     
      et.projectid               as ET_Projectid,
      et.version                 as ET_Version,

      // Additional Columns from z00sap_tbb

  
      tbb.et_id                  as tbbetid,
      tbb.tbb_name               as tbbname,
      tbb.color as Color,
      case tbb.color
        when 'R' then 1 //red
        when 'Y' then 2 //yellow
        when 'G' then 3 //grün
        else 0 //grau
        end as StatusColor,
      tbb.reasoning as Reasoning,
      tbb.hierarchy as Hierachy,
      tbb.link as Link,
      tbb.projectid               as TBB_Projectid,
      tbb.version                 as TBB_Version,
      tbb.extensiondomain as Extension_Domain,
      tbb.coreextensiondomain as Core_Extension_Domain
      
      
       // ,
      //_TL,
      

      // Additional Columns from z00sap_col_vals

//      colvals.val_id             as colvalid,
//
//      colvals.column_key         as colvalscolumnkey,
//
//      colvals.value              as value,
//      colvals.is_sap             as issap,
//      colvals.is_editable        as iseditable,
//
//      colvals.tbb_id             as colvalstbbid,
//
//      // Additional Columns from z00sap_columns
//
//      cols.column_key            as columnkey,
//      cols.columns               as colcolumn,
//      cols.column_description    as columndesc,
//      cols.data_type             as columndtype,
//
//      cols.col_width             as columnwidth,
//      cols.col_order             as columnorder,
//      cols.created_by            as colcreatedby,
//      cols.created_at            as colcreatedat,
//      cols.local_last_changed_by as collocallastchangedby,
//      cols.local_last_changed_at as collocallastchangedat,
//      cols.last_changed_at       as collastchangedat




}
