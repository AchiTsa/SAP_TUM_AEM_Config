@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for Columns'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z00SAP_Col_I 
as select from z00sap_columns
//composition [0..*] of Z00SAP_CoVals_I     as cova
{
    key z00sap_columns.column_key as ColumnKey,
    z00sap_columns.columns as Columns,
    z00sap_columns.column_description as ColumnDescription,
    z00sap_columns.data_type as DataType,
    z00sap_columns.col_width as ColWidth,
    z00sap_columns.col_order as ColOrder,
    z00sap_columns.created_by as CreatedBy,
    z00sap_columns.created_at as CreatedAt,
    z00sap_columns.local_last_changed_by as LocalLastChangedBy,
    z00sap_columns.local_last_changed_at as LocalLastChangedAt,
    z00sap_columns.last_changed_at as LastChangedAt //,
    //cova // Make association public
}
