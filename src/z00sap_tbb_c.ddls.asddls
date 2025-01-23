@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Extension Task Building Block View'
@Metadata.ignorePropagatedAnnotations: true

@UI: {
 headerInfo: {
 title.label: 'Extension Task Building Block details',
 title: {type: #WITH_NAVIGATION_PATH, value: 'TBBId'},
 typeName: 'Project Extension Task Building Block',
 typeNamePlural: 'Project Extension Task Building Block'
 }
}
define  view entity Z00SAP_TBB_C
  as projection on Z00SAP_TBB_I

{     @UI.lineItem: [{position: 10,type: #STANDARD,label: 'TBBid' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 10,type: #STANDARD,label: 'TBBid' }]
      @UI.selectionField: [{position: 10}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 10, label: 'TBBid'        }]
    key TbbId,
      @UI.lineItem: [{position: 20,type: #STANDARD,label: 'ETid' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 20,type: #STANDARD,label: 'ETid' }]
      @UI.selectionField: [{position: 20}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 20, label: 'ETid'        }]
    EtId,
      @UI.lineItem: [{position: 30,type: #STANDARD,label: 'TBBName' }, 
      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED}, 
      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
      @UI.identification: [{position: 30,type: #STANDARD,label: 'TBBName' }]
      @UI.selectionField: [{position: 30}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 30, label: 'TBBName'        }]
    TbbName,
    projectid,
    version,
    @UI.identification: [{position: 40,type: #STANDARD,label: 'Color' }]
    @UI.selectionField: [{position: 40}]
    @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 40, label: 'Color'        }]
    color,
    @UI.identification: [{position: 50,type: #STANDARD,label: 'Reasoning' }]
    @UI.selectionField: [{position: 50}]
    @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 50, label: 'Reasoning'        }]
    reasoning,
    @UI.identification: [{position: 60,type: #STANDARD,label: 'Hierarchy' }]
    @UI.selectionField: [{position: 60}]
    @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 60, label: 'Hierarchy'        }]
    hierarchy,
    @UI.identification: [{position: 70,type: #STANDARD,label: 'Link' }]
    @UI.selectionField: [{position: 70}]
    @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 70, label: 'Link'        }]
    link,
    @UI.identification: [{position: 80,type: #STANDARD,label: 'Extension Domain' }]
    @UI.selectionField: [{position: 80}]
    @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 80, label: 'Extension Domain'        }]
    extensiondomain,
    @UI.identification: [{position: 90,type: #STANDARD,label: 'Core Extension Domain' }]
    @UI.selectionField: [{position: 90}]
    @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 90, label: 'Core Extension Domain'        }]
    coreextensiondomain,

    /* Associations */
    //cova : redirected to composition child Z00SAP_COVALS_C,
    et: redirected to parent Z00SAP_ET_C,
    pro: redirected to Z00SAP_PROJECTS_C
    //,
    //struct : redirected to composition child Z00SAP_STRUCT_C
}
