@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for projects'
@Metadata.ignorePropagatedAnnotations: true
//@AbapCatalog.preserveKey: true
//@AbapCatalog.sqlViewName: 'Z00SAP_PRO_I_SQL'




define  root view 
entity 

 Z00SAP_Projects_I
  as select from z00sap_projects as pro
  
  composition [0..*] of Z00SAP_TL_I as tl
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
      ,
      /* Associations */
      tl
      
}
