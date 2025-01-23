@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for col names'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z00SAP_COL_NAMES_I as select from z00sap_col_names
{
    key id as Id,
    name as Name
}
