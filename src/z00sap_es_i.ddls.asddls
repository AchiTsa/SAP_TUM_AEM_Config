@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for extension style'
@Metadata.ignorePropagatedAnnotations: true

define view entity Z00SAP_ES_I 
as select from z00sap_es
association        to parent  Z00SAP_TL_I as tl     on  $projection.Tierid    = tl.Tierid
association        to   Z00SAP_Projects_I as pro    on  $projection.projectid    = pro.Projectid and $projection.version    = pro.Version

composition [0..*] of Z00SAP_ET_I     as et

{
    
    key es_id as EsId,
    tierid as Tierid,
    projectid as projectid,
    version as version,
    
    stylename as Stylename,
    
    /* Associations */
    tl,
    et,
    pro
    
}
