@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Technician Cons View'
@Metadata.ignorePropagatedAnnotations: true

@UI: {
 headerInfo: {
title: {
      type: #STANDARD,
      label: 'Project overview'
  }, typeName: 'Project Detail',
 typeNamePlural: 'Project Details'
 }
}
define root view entity Z00SAP_Projectdetails_C_Less
  provider contract transactional_query
  as projection on Z00SAP_ProjectDetails_I
{
      @UI.facet: [

              { id:'HeaderFacet',
              purpose: #HEADER,
              type: #FIELDGROUP_REFERENCE,
              targetQualifier: 'Fieldgroup:HeaderItems',
              position: 10
              }
              ]
      @UI.lineItem: [
      //{position: 1, type: #STANDARD, label: 'Project ID' },
      {type:#FOR_ACTION, label: 'Add line', dataAction: 'add_line', invocationGrouping: #ISOLATED}]
//      @UI.identification: [{position: 1, type: #STANDARD, label: 'Project ID' }]
//      @UI.selectionField: [{position: 1}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 1, label: 'Project ID' }]
  @UI.hidden: true
  key Projectid,

      @UI.hidden: true
  key Version,
        @UI.hidden: true
    key  
    
    tbbid,
      @UI.hidden: true
      SapVersion,

      @UI.hidden: true
      Author,

      @UI.hidden: true
      LastChanged,

      @UI.hidden: true
      ProjectName,

      @UI.hidden: true
      CreatedBy,

      @UI.hidden: true
      CreatedAt,

      @UI.hidden: true
      LocalLastChangedBy,

      @UI.hidden: true
      LocalLastChangedAt,

      @UI.hidden: true
      LastChangedAt,

      @UI.hidden: true
      Tierid,



      @UI.lineItem: [{position: 130, type: #STANDARD, label: 'Tier Level' }]
      @UI.identification: [{position: 130, type: #STANDARD, label: 'Tier Level' }]
      @UI.selectionField: [{position: 130}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 130, label: 'Tier Level' }]
      TierLevel,

      @UI.hidden: true
      TL_Projectid,

      @UI.hidden: true
      TL_Version,

      @UI.hidden: true
      ES_Id,

      @UI.hidden: true
      ES_Tierid,

      @UI.lineItem: [{position: 170, type: #STANDARD, label: 'Extension Style' }]
      @UI.identification: [{position: 170, type: #STANDARD, label: 'Extension Style' }]
      @UI.selectionField: [{position: 170}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 170, label: 'Extension Style' }]
      StyleName,

      @UI.hidden: true
      ET_Id,

      @UI.hidden: true
      ET_ES_Id,

      @UI.lineItem: [{position: 210, type: #STANDARD, label: 'Extension Task' }]
      @UI.identification: [{position: 210, type: #STANDARD, label: 'Extension Task' }]
      @UI.selectionField: [{position: 210}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 210, label: 'Extension Task' }]
      TaskName,
      
      @UI.hidden: true
      Url,
      
      @UI.lineItem  : [ {
      label: 'Link to Chart',
      position      : 220,
      type          : #WITH_URL,
      url           : 'Url'   -- Reference to element
      } ]
      @UI.identification: [{position: 220, type: #STANDARD, label: 'Link to Chart' }]
      @UI.selectionField: [{position: 220}]
      
      Name,



      @UI.hidden: true
      tbbetid,

      @UI.lineItem: [{position: 240, type: #STANDARD, label: 'Technical Extension Building Block' }]
      @UI.identification: [{position: 240, type: #STANDARD, label: 'Technical Extension Building Block' }]
      @UI.selectionField: [{position: 240}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 240, label: 'Technical Extension Building Block' }]
      tbbname,
      
//      @UI.lineItem: [{position: 250, type: #STANDARD, label: 'Color' }]
//      @UI.identification: [{position: 250, type: #STANDARD, label: 'Color' }]
//      @UI.selectionField: [{position: 250}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 250, label: 'Color' }]
      @UI.lineItem: [{position: 245, type: #STANDARD, label: 'Color'}]
      @UI.identification: [{position: 245, type: #STANDARD, label: 'Color' }]
      @UI.selectionField: [{position: 245}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 245, label: 'Color' }]
      Color,
      @UI.hidden: true
//      @UI.lineItem: [{position: 260, type: #STANDARD, label: 'Reasoning' }]
//      @UI.identification: [{position: 260, type: #STANDARD, label: 'Reasoning' }]
//      @UI.selectionField: [{position: 260}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 260, label: 'Reasoning' }]
      StatusColor,
      @UI.lineItem: [{position: 265, type: #STANDARD, label: 'Reasoning'}]
      @UI.identification: [{position: 265, type: #STANDARD, label: 'Reasoning' }]
      @UI.selectionField: [{position: 265}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 265, label: 'Reasoning' }]
      Reasoning,
      @UI.lineItem: [{position: 270, type: #STANDARD, label: 'Hierachy', criticality: 'StatusColor' }]
      @UI.identification: [{position: 270, type: #STANDARD, label: 'Hierachy' }]
      @UI.selectionField: [{position: 270}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 270, label: 'Hierachy' }]
      Hierachy,
      @UI.lineItem: [{position: 280, type: #WITH_URL, label: 'Link', url: 'Link' }]
      @UI.identification: [{position: 280, type: #STANDARD, label: 'Link' }]
      @UI.selectionField: [{position: 280}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 280, label: 'Link' }]
      @Semantics.url.mimeType: 'url'
      Link,
      @UI.lineItem: [{position: 290, type: #STANDARD, label: 'Extension Domain'}]
      @UI.identification: [{position: 290, type: #STANDARD, label: 'Extension Domain' }]
      @UI.selectionField: [{position: 290}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 290, label: 'Extension Domain' }]
      Extension_Domain,
      @UI.lineItem: [{position: 300, type: #STANDARD, label: 'Core Extension Domain' }]
      @UI.identification: [{position: 300, type: #STANDARD, label: 'Core Extension Domain' }]
      @UI.selectionField: [{position: 300}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 300, label: 'Core Extension Domain' }]
      Core_Extension_Domain

//      @UI.hidden: true
//      colvalid,
//
//      @UI.hidden: true
//      colvalscolumnkey,
//
//
//      @UI.hidden: true
//      value,
//
//      @UI.hidden: true
//      issap,
//
//      @UI.hidden: true
//      iseditable,
//
//      @UI.hidden: true
//      colvalstbbid,
//
//      @UI.hidden: true
//      columnkey,
//
//      @UI.hidden: true
//      colcolumn,
//
//      @UI.hidden: true
//      columndesc,
//
//      @UI.hidden: true
//      columndtype,
//
//      @UI.hidden: true
//      columnwidth,
//
//      @UI.hidden: true
//      columnorder,
//
//      @UI.hidden: true
//      colcreatedby,
//
//      @UI.hidden: true
//      colcreatedat,
//
//      @UI.hidden: true
//      collocallastchangedby,
//
//      @UI.hidden: true
//      collocallastchangedat,
//
//      @UI.hidden: true
//      collastchangedat

}
