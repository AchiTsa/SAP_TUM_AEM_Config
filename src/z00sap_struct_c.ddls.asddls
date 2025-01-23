@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'C View for Struct'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z00SAP_STRUCT_C as projection on Z00SAP_STRUCT_I
{
    key StructId,
    Pathname,
    Tbbid,
    projectid,
    version,
    /* Associations */
    pro: redirected to Z00SAP_PROJECTS_C,
    tbb: redirected to parent Z00SAP_TBB_C
}
