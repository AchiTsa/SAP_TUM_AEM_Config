
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'C view for Projects'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define  root view entity Z00SAP_PROJECTS_C  
provider contract transactional_query 
as projection on Z00SAP_Projects_I
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
    LastChangedAt,
    Archived,
    /* Associations */
    tl: redirected to composition child Z00SAP_TL_C
}
