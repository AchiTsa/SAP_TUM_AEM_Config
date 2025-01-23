@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Extension Style View'
@Metadata.ignorePropagatedAnnotations: true

@UI: {
 headerInfo: {
 title.label: 'Extension Style Details',
 title: {type: #WITH_NAVIGATION_PATH, value: 'ESId'},
 typeName: 'Project Extension Style',
 typeNamePlural: 'Project Extension Style'
 }
}
define  view entity Z00SAP_ES_C
  as projection on Z00SAP_ES_I


{   @UI.lineItem: [{position: 10,type: #STANDARD,label: 'Esid' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 10,type: #STANDARD,label: 'ExtensionStyleid' }]
      @UI.selectionField: [{position: 10}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 10, label: 'ExtensionStyleid'        }]
    key EsId,
    @UI.lineItem: [{position: 20,type: #STANDARD,label: 'Tierid' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 20,type: #STANDARD,label: 'Tierid' }]
      @UI.selectionField: [{position: 20}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 20, label: 'Tierid'        }]
    Tierid,
    @UI.lineItem: [{position: 30,type: #STANDARD,label: 'Style Name' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 30,type: #STANDARD,label: 'Style Name' }]
      @UI.selectionField: [{position: 30}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 30, label: 'Style Name'        }]
    Stylename,
    
    projectid,
    version,
    /* Associations */
    et: redirected to composition child Z00SAP_ET_C,
    tl: redirected to parent Z00SAP_TL_C,
    pro: redirected to Z00SAP_PROJECTS_C
}
