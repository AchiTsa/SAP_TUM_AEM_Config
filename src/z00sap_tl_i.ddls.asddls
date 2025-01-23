@AccessControl.authorizationCheck: #NOT_REQUIRED
//@Metadata.ignorePropagatedAnnotations:true
@EndUserText.label: 'I view for Tier Layer'



define view entity Z00SAP_TL_I
  as select from z00sap_tl as tl
  association to parent Z00SAP_Projects_I as pro on $projection.Projectid = pro.Projectid and $projection.Version = pro.Version
  
  
  composition [0..*] of Z00SAP_ES_I     as es
{
  key tierid    as Tierid,
      projectid as Projectid,
      version   as Version,
      tierlevel as Tierlevel
      ,

      /* Associations */
      pro,
      es
      
}


