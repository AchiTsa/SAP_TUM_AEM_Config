@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Extension Task View'
@Metadata.ignorePropagatedAnnotations: true

@UI: {
 headerInfo: {
 title.label: 'Extension Task Details',
 title: {type: #WITH_NAVIGATION_PATH, value: 'ETId'},
 typeName: 'Project Extension Task',
 typeNamePlural: 'Project Extension Task'
 }
}
define  view entity Z00SAP_ET_C
  as projection on Z00SAP_ET_I

{    @UI.lineItem: [{position: 10,type: #STANDARD,label: 'ETid' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 10,type: #STANDARD,label: 'ETid' }]
      @UI.selectionField: [{position: 10}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 10, label: 'ETid'        }]
    key EtId,
     @UI.lineItem: [{position: 20,type: #STANDARD,label: 'Esid' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 20,type: #STANDARD,label: 'ExtensionStyleid' }]
      @UI.selectionField: [{position: 20}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 20, label: 'ExtensionStyleid'        }]
    EsId,
     @UI.lineItem: [{position: 30,type: #STANDARD,label: 'Taskname' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 30,type: #STANDARD,label: 'Taskname' }]
      @UI.selectionField: [{position: 30}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 30, label: 'Taskname'        }]
    Taskname,
    projectid,
    version,
    /* Associations */
    es: redirected to parent Z00SAP_ES_C,
    tbb: redirected to composition child Z00SAP_TBB_C,
    pro: redirected to Z00SAP_PROJECTS_C
}
