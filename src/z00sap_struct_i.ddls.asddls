@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for Struct'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z00SAP_STRUCT_I as select from z00sap_struct
association to parent Z00SAP_TBB_I as tbb on $projection.Tbbid = tbb.TbbId
association to  Z00SAP_Projects_I as pro on $projection.projectid = pro.Projectid and $projection.version = pro.Version

{
    key struct_id as StructId,
    path_name as Pathname,
    tbb_id as Tbbid,
    projectid as projectid,
    version as version,
    
    //Association
    tbb,
    pro
}
