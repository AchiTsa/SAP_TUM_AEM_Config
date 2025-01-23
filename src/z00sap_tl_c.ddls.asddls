@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Tier ID View'
@Metadata.ignorePropagatedAnnotations: true

@UI: {
 headerInfo: {
 title.label: 'Tier Details',
 title: {type: #WITH_NAVIGATION_PATH, value: 'Tierid'},
 typeName: 'Project Tier',
 typeNamePlural: 'Project Tier'
 }
}
define view entity Z00SAP_TL_C
  as projection on Z00SAP_TL_I

{         @UI.lineItem: [{position: 10,type: #STANDARD,label: 'Tierid' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 10,type: #STANDARD,label: 'Tierid' }]
      @UI.selectionField: [{position: 10}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 10, label: 'Tierid'        }]
    key Tierid,
     @UI.lineItem: [{position: 20,type: #STANDARD,label: 'Projectid' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 20,type: #STANDARD,label: 'Projectid' }]
      @UI.selectionField: [{position: 20}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 20, label: 'Projectid'        }]
    Projectid,
        @UI.lineItem: [{position: 30,type: #STANDARD,label: 'Version' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 30,type: #STANDARD,label: 'Version' }]
      @UI.selectionField: [{position: 30}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 30, label: 'Version'        }]
    
    Version,
            @UI.lineItem: [{position: 30,type: #STANDARD,label: 'Tierlevel' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 30,type: #STANDARD,label: 'Tierlevel' }]
      @UI.selectionField: [{position: 30}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 30, label: 'Tierlevel'        }]
    Tierlevel,
    /* Associations */
    es: redirected to composition child Z00SAP_ES_C,

    pro : redirected to parent Z00SAP_PROJECTS_C
}
