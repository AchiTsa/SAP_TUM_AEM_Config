@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for extension tasks'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z00SAP_ET_I 
as select from z00sap_et
association        to parent  Z00SAP_ES_I as es    on  $projection.EsId    = es.EsId

association        to   Z00SAP_Projects_I as pro    on  $projection.projectid    = pro.Projectid and $projection.version    = pro.Version

composition [0..*] of Z00SAP_TBB_I     as tbb
{
    key z00sap_et.et_id as EtId,
    z00sap_et.es_id as EsId,
    z00sap_et.taskname as Taskname,
    projectid as projectid,
    version as version,
    
    
    /* Associations */
    es,
    tbb,
    pro
 
}
