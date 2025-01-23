//@AccessControl.authorizationCheck: #NOT_REQUIRED
//
//@EndUserText.label: 'Technician Cons View'
//@Metadata.ignorePropagatedAnnotations: true
//
//@UI: {
// headerInfo: {
// title.label: 'ProjectOverview',
// title: {type: #WITH_NAVIGATION_PATH, value: 'ProjectName'},
// typeName: 'ProjectOverview',
// typeNamePlural: 'ProjectOverviews'
// }
//}
//define root view entity Z00SAP_ProjectOverview_C
//  provider contract transactional_query
//  as projection on Z00SAP_ProjectOverview_I
//{
//      @UI.facet: [
//
//      //        { id:'HeaderFacet',
//      //        purpose: #HEADER,
//      //        type: #FIELDGROUP_REFERENCE,
//      //        targetQualifier: 'Fieldgroup:HeaderItems',
//      //        position: 10
//      //        },
////              {
////                label: 'Overview',
////                id: 'TechDoc',
////                position: 10,
////                purpose: #STANDARD,
////                type: #IDENTIFICATION_REFERENCE
////              },
//        
////        {
////          label: 'Technical Extension Building Block',
////          id: 'tbb',
////          position: 20,
////          purpose: #STANDARD,
////          type: #LINEITEM_REFERENCE,
////          targetElement: 'tbbview'
////        },
////        { label: 'File Information',
////          id: 'Attachment',
////          type: #COLLECTION,
////          position: 30
////        },
////       {  id: 'Upload',
////          type: #FIELDGROUP_REFERENCE,
////          position: 20  ,
////          targetQualifier: 'Upload',
////          parentId: 'Attachment',
////          purpose: #STANDARD
////       },
////       {  id: 'Upload',
////          type: #FIELDGROUP_REFERENCE,
////          position: 50  ,
////          targetQualifier: 'Upload',
////          parentId: 'TechDoc',
////          purpose: #STANDARD
////         }
//      { label: 'File Information',   
//      id: 'Attachment',     
//      type: #COLLECTION,               
//      position: 10                                                                        
//      },
//      
//      
//      {
//      id: 'Upload',         
//      type: #FIELDGROUP_REFERENCE,
//      position: 20  ,
//      targetQualifier: 'Upload', 
//      parentId: 'Attachment',  
//      purpose: #STANDARD }
//
//      ]
//
//
//      @UI.lineItem: [{position: 10,type: #STANDARD,label: 'Projectid' },
//      {type:#FOR_ACTION, label: 'Duplicate Projects', dataAction: 'duplicateProject', invocationGrouping: #ISOLATED},
//      {type:#FOR_ACTION, label: 'Import Project', dataAction: 'importExcelProject'},
//      {type:#FOR_ACTION, label: 'Delete Projects', dataAction: 'deleteProject', invocationGrouping: #ISOLATED}]
////      @UI.identification: [{position: 10,type: #STANDARD,label: 'Projectid' }]
////      @UI.selectionField: [{position: 10}]
////      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 10, label: 'Projectid'        }]
//  key Projectid,
//      @UI.lineItem: [{position: 20,type: #STANDARD,label: 'Version' }]
////      @UI.identification: [{position: 20,type: #STANDARD,label: 'Version' }]
////      @UI.selectionField: [{position: 20}]
////      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 20, label: 'Version'        }]
//  key Version,
////      @UI.lineItem: [{position: 30,type: #STANDARD,label: 'SapVersion' }]
////      @UI.identification: [{position: 30,type: #STANDARD,label: 'SapVersion' }]
////      @UI.selectionField: [{position: 30}]
////      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 30, label: 'SapVersion'        }]
//      @UI.hidden: true
//      SapVersion,
////      @UI.lineItem: [{position: 40,type: #STANDARD,label: 'Author' }]
////      @UI.identification: [{position: 40,type: #STANDARD,label: 'Author' }]
////      @UI.selectionField: [{position: 40}]
////      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 40, label: 'Author'        }]
//      @UI.hidden: true
//      Author,
////      @UI.lineItem: [{position: 50,type: #STANDARD,label: 'LastChanged' }]
////      @UI.identification: [{position: 50,type: #STANDARD,label: 'LastChanged' }]
////      @UI.selectionField: [{position: 50}]
////      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 50, label: 'LastChanged'        }]
//      @UI.hidden: true
//      LastChanged,
////      @UI.lineItem: [{position: 60,type: #STANDARD,label: 'ProjectName' }]
////      @UI.identification: [{position: 60,type: #STANDARD,label: 'ProjectName' }]
////      @UI.selectionField: [{position: 60}]
////      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 60, label: 'ProjectName'        }]
//      @UI.hidden: true
//      ProjectName,
//
//      @UI.fieldGroup:    [ { position: 70, qualifier: 'Upload' , label: 'Attachment'} ]
//      @UI.identification: [ { position: 70 , label: 'File' } ]
//      Attachment,
//
//      @UI.hidden: true
//      MimeType,
//
//      @UI.hidden: true
//      Filename,
//
//      /* Associations */
//      tbbview : redirected to Z00SAP_Projectdetails_C_Less
//
//
//}

@EndUserText.label: 'Consumption View for File'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity Z00SAP_ProjectOverview_C
  provider contract transactional_query
  as projection on Z00SAP_ProjectOverview_I
{
    
    key Projectid,
    key Version,
    SapVersion,
    Author,
    LastChanged,
    ProjectName,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    @EndUserText.label: 'Last Action On'
    LastChangedAt,
    Archived,
    Attachment,
    MimeType,
    Filename,
    AlreadyImported,
    /* Associations */
    tbbview : redirected to Z00SAP_Projectdetails_C_Less
}
