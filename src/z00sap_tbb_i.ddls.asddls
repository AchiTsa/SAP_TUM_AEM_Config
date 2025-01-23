@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'IView Technical Extension Building Block'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z00SAP_TBB_I 
as select from z00sap_tbb
association to parent  Z00SAP_ET_I as et    on  $projection.EtId    = et.EtId
association to   Z00SAP_Projects_I as pro    on  $projection.projectid    = pro.Projectid and $projection.version    = pro.Version

//composition [0..*] of Z00SAP_CoVals_I     as cova
//composition [0..*] of Z00SAP_STRUCT_I as struct
{
    key z00sap_tbb.tbb_id as TbbId,
    z00sap_tbb.et_id as EtId,
    z00sap_tbb.tbb_name as TbbName,
        projectid as projectid,
    version as version,
    color as color,
    reasoning as reasoning,
    hierarchy as hierarchy,
    link as link,
    extensiondomain as extensiondomain,
    coreextensiondomain as coreextensiondomain,
    
    /* Associations */
    et ,
   // cova,
    pro
   // struct // Make association public
  
    
}
