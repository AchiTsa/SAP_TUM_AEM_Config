@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for project overview'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z00SAP_ProjectOverview_I
  as select from z00sap_projects as pro
  association [0..*] to Z00SAP_ProjectDetails_I as tbbview on  pro.projectid = tbbview.Projectid
                                                           and pro.version   = tbbview.Version
  //Question
  //A entry in projectoverview table is one version of Project or a general project?
  
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
      archived           as Archived,
      @Semantics.largeObject:
      { mimeType: 'MimeType',
      fileName: 'Filename',
      acceptableMimeTypes: [ 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
      contentDispositionPreference: #INLINE } // This will store the File into our table
      attachment         as Attachment,
      @Semantics.mimeType: true
      mimetype           as MimeType,
      filename           as Filename,
      alreadyimported    as AlreadyImported,
      tbbview // Make association public
}
where
  archived != 'X';
