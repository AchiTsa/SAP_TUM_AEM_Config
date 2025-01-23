//@AbapCatalog.sqlViewName: ''
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Test for I view for managed scenario'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z00SAP_I_LESS_TEST as select from z00sap_projects
/*associations*/
association [0..*] to  Z00SAP_TL_I as tl on $projection.Projectid=tl.Projectid and $projection.Version = tl.Version
association [0..*] to Z00SAP_ET_I as et on $projection.Projectid=et.projectid and $projection.Version = et.version
association [0..*] to Z00SAP_ES_I as es on $projection.Projectid=es.projectid and $projection.Version = es.version
association [0..*] to Z00SAP_TBB_I as tbb on $projection.Projectid=tbb.projectid and $projection.Version = tbb.version
{
    key projectid          as Projectid,
  key version            as Version,
      sapversion         as SapVersion,
      author             as Author,
      lastchanged        as LastChanged,
      projectname        as ProjectName,
      @Semantics.user.createdBy: true
      createdby          as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      createdat          as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      locallastchangedby as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat      as LastChangedAt,
      archived           as Archived
      //,  
}
