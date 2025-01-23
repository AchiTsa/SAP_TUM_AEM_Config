@AbapCatalog.sqlViewName: 'Z00SAP_CVAS_I_SQ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view Values in a Column'
@Metadata.ignorePropagatedAnnotations: true
define view Z00SAP_CoVals_I as select from z00sap_col_vals
//association to parent  Z00SAP_TBB_I as tbb    on  $projection.TbbId    = tbb.TbbId
//association to Z00SAP_Col_I as col on $projection.ColumnKey = col.ColumnKey
//association        to   Z00SAP_Projects_I as pro    on  $projection.projectid    = pro.Projectid and $projection.version    = pro.Version

{
key z00sap_col_vals.val_id as ValId,
z00sap_col_vals.column_key as ColumnKey,
z00sap_col_vals.value as Value,
z00sap_col_vals.is_sap as IsSap,
z00sap_col_vals.is_editable as IsEditable,
z00sap_col_vals.tbb_id as TbbId,
projectid as projectid,
version as version
//,
//tbb,
//col,
//pro
    
}
