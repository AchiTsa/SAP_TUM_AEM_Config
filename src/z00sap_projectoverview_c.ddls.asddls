@EndUserText.label: 'Consumption View for File'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity Z00SAP_ProjectOverview_C
  provider contract transactional_query
  as projection on Z00SAP_ProjectOverview_I
{
    
    key Projectid,
    key Version,
    SapVersion,
    Author,
    LastChanged,
    ProjectName,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    @EndUserText.label: 'Last Action On'
    LastChangedAt,
    Archived,
    Attachment,
    MimeType,
    Filename,
    AlreadyImported,
    /* Associations */
    tbbview : redirected to Z00SAP_Projectdetails_C_Less
}
