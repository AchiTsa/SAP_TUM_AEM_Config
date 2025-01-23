@EndUserText.label: 'Consumption View for Column Names'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@Metadata.ignorePropagatedAnnotations: true

@UI: {
 headerInfo: {
 title.label: 'Column Names Overview',
 typeName: 'Column Names Overview',
 typeNamePlural: 'Column Names Overviews'
 }
}

define root view entity Z00SAP_COL_NAMES_C
  provider contract transactional_query
  as projection on Z00SAP_COL_NAMES_I
{
    @UI.facet: [

              { id:'HeaderFacet',
              purpose: #HEADER,
              type: #FIELDGROUP_REFERENCE,
            targetQualifier: 'Fieldgroup:HeaderItems',
            position: 10
            },
              {
                label: 'Overview',
                id: 'TechDoc',
                position: 10,
                purpose: #STANDARD,
               type: #IDENTIFICATION_REFERENCE
              }]
        
        


      @UI.lineItem: [{position: 10, type: #STANDARD, label: 'ID' }]
      @UI.identification: [{position: 10, type: #STANDARD, label: 'ID' }]
      @UI.selectionField: [{position: 10}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 10, label: 'ID' }]
  key Id,
      @UI.lineItem: [{position: 20, type: #STANDARD, label: 'Name' }]
      @UI.identification: [{position: 20, type: #STANDARD, label: 'Name' }]
      @UI.selectionField: [{position: 20}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 20, label: 'Name' }]
      Name
}
