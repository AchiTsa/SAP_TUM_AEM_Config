@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Technician Cons View'
@Metadata.ignorePropagatedAnnotations: true

@UI: {
 headerInfo: {
 title: {
      type: #STANDARD,
      label: 'Project overview'
  },
 typeName: 'ProjectDetail',
 typeNamePlural: 'ProjectDetails'
 }
}
define root view entity Z00SAP_Projectdetails_C
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
      @UI.lineItem: [{position: 10, type: #STANDARD, label: 'Projectid' }]
      @UI.identification: [{position: 10, type: #STANDARD, label: 'Projectid' }]
      @UI.selectionField: [{position: 10}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 10, label: 'Projectid' }]
  key Projectid,

      @UI.lineItem: [{position: 20, type: #STANDARD, label: 'Version' }]
      @UI.identification: [{position: 20, type: #STANDARD, label: 'Version' }]
      @UI.selectionField: [{position: 20}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 20, label: 'Version' }]
  key Version,
        @UI.lineItem: [{position: 220, type: #STANDARD, label: 'tbbid' }]
      @UI.identification: [{position: 220, type: #STANDARD, label: 'tbbid' }]
      @UI.selectionField: [{position: 220}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 220, label: 'tbbid' }]
      key 
      tbbid,
      @UI.hidden: true
      @UI.lineItem: [{position: 30, type: #STANDARD, label: 'SapVersion' }]
      @UI.identification: [{position: 30, type: #STANDARD, label: 'SapVersion' }]
      @UI.selectionField: [{position: 30}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 30, label: 'SapVersion' }]
      SapVersion,
      

      @UI.lineItem: [{position: 40, type: #STANDARD, label: 'Author' }]
      @UI.identification: [{position: 40, type: #STANDARD, label: 'Author' }]
      @UI.selectionField: [{position: 40}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 40, label: 'Author' }]
      Author,

      @UI.lineItem: [{position: 50, type: #STANDARD, label: 'LastChanged' }]
      @UI.identification: [{position: 50, type: #STANDARD, label: 'LastChanged' }]
      @UI.selectionField: [{position: 50}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 50, label: 'LastChanged' }]
      LastChanged,

      @UI.lineItem: [{position: 60, type: #STANDARD, label: 'ProjectName' }]
      @UI.identification: [{position: 60, type: #STANDARD, label: 'ProjectName' }]
      @UI.selectionField: [{position: 60}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 60, label: 'ProjectName' }]
      ProjectName,

      @UI.lineItem: [{position: 70, type: #STANDARD, label: 'CreatedBy' }]
      @UI.identification: [{position: 70, type: #STANDARD, label: 'CreatedBy' }]
      @UI.selectionField: [{position: 70}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 70, label: 'CreatedBy' }]
      CreatedBy,

      @UI.lineItem: [{position: 80, type: #STANDARD, label: 'CreatedAt' }]
      @UI.identification: [{position: 80, type: #STANDARD, label: 'CreatedAt' }]
      @UI.selectionField: [{position: 80}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 80, label: 'CreatedAt' }]
      CreatedAt,

      @UI.lineItem: [{position: 90, type: #STANDARD, label: 'LocalLastChangedBy' }]
      @UI.identification: [{position: 90, type: #STANDARD, label: 'LocalLastChangedBy' }]
      @UI.selectionField: [{position: 90}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 90, label: 'LocalLastChangedBy' }]
      LocalLastChangedBy,

      @UI.lineItem: [{position: 100, type: #STANDARD, label: 'LocalLastChangedAt' }]
      @UI.identification: [{position: 100, type: #STANDARD, label: 'LocalLastChangedAt' }]
      @UI.selectionField: [{position: 100}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 100, label: 'LocalLastChangedAt' }]
      LocalLastChangedAt,

      @UI.lineItem: [{position: 110, type: #STANDARD, label: 'LastChangedAt' }]
      @UI.identification: [{position: 110, type: #STANDARD, label: 'LastChangedAt' }]
      @UI.selectionField: [{position: 110}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 110, label: 'LastChangedAt' }]
      LastChangedAt,

      @UI.lineItem: [{position: 120, type: #STANDARD, label: 'Tierid' }]
      @UI.identification: [{position: 120, type: #STANDARD, label: 'Tierid' }]
      @UI.selectionField: [{position: 120}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 120, label: 'Tierid' }]
      Tierid,



      @UI.lineItem: [{position: 130, type: #STANDARD, label: 'TierLevel' }]
      @UI.identification: [{position: 130, type: #STANDARD, label: 'TierLevel' }]
      @UI.selectionField: [{position: 130}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 130, label: 'TierLevel' }]
      TierLevel,

      @UI.lineItem: [{position: 140, type: #STANDARD, label: 'TL_Projectid' }]
      @UI.identification: [{position: 140, type: #STANDARD, label: 'TL_Projectid' }]
      @UI.selectionField: [{position: 140}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 140, label: 'TL_Projectid' }]
      TL_Projectid,

      @UI.lineItem: [{position: 150, type: #STANDARD, label: 'TL_Version' }]
      @UI.identification: [{position: 150, type: #STANDARD, label: 'TL_Version' }]
      @UI.selectionField: [{position: 150}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 150, label: 'TL_Version' }]
      TL_Version,

      @UI.lineItem: [{position: 160, type: #STANDARD, label: 'ES_Id' }]
      @UI.identification: [{position: 160, type: #STANDARD, label: 'ES_Id' }]
      @UI.selectionField: [{position: 160}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 160, label: 'ES_Id' }]
      ES_Id,

      @UI.lineItem: [{position: 170, type: #STANDARD, label: 'ES_Tierid' }]
      @UI.identification: [{position: 170, type: #STANDARD, label: 'ES_Tierid' }]
      @UI.selectionField: [{position: 170}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 170, label: 'ES_Tierid' }]
      ES_Tierid,

      @UI.lineItem: [{position: 180, type: #STANDARD, label: 'StyleName' }]
      @UI.identification: [{position: 180, type: #STANDARD, label: 'StyleName' }]
      @UI.selectionField: [{position: 180}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 180, label: 'StyleName' }]
      StyleName,

      @UI.lineItem: [{position: 190, type: #STANDARD, label: 'ET_Id' }]
      @UI.identification: [{position: 190, type: #STANDARD, label: 'ET_Id' }]
      @UI.selectionField: [{position: 190}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 190, label: 'ET_Id' }]
      ET_Id,

      @UI.lineItem: [{position: 200, type: #STANDARD, label: 'ET_ES_Id' }]
      @UI.identification: [{position: 200, type: #STANDARD, label: 'ET_ES_Id' }]
      @UI.selectionField: [{position: 200}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 200, label: 'ET_ES_Id' }]
      ET_ES_Id,

      @UI.lineItem: [{position: 210, type: #STANDARD, label: 'TaskName' }]
      @UI.identification: [{position: 210, type: #STANDARD, label: 'TaskName' }]
      @UI.selectionField: [{position: 210}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 210, label: 'TaskName' }]
      TaskName,



      @UI.lineItem: [{position: 230, type: #STANDARD, label: 'tbbetid' }]
      @UI.identification: [{position: 230, type: #STANDARD, label: 'tbbetid' }]
      @UI.selectionField: [{position: 230}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 230, label: 'tbbetid' }]
      tbbetid,

      @UI.lineItem: [{position: 240, type: #STANDARD, label: 'tbbname' }]
      @UI.identification: [{position: 240, type: #STANDARD, label: 'tbbname' }]
      @UI.selectionField: [{position: 240}]
      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 240, label: 'tbbname' }]
      tbbname //,

//      @UI.lineItem: [{position: 250, type: #STANDARD, label: 'colvalid' }]
//      @UI.f: [{position: 250, type: #STANDARD, label: 'colvalid' }]
//      @UI.selectionField: [{position: 250}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 250, label: 'colvalid' }]
//      colvalid,
//
//      @UI.lineItem: [{position: 260, type: #STANDARD, label: 'colvalscolumnkey' }]
//      @UI.identification: [{position: 260, type: #STANDARD, label: 'colvalscolumnkey' }]
//      @UI.selectionField: [{position: 260}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 260, label: 'colvalscolumnkey' }]
//      colvalscolumnkey,
//
//
//      @UI.lineItem: [{position: 280, type: #STANDARD, label: 'value' }]
//      @UI.identification: [{position: 280, type: #STANDARD, label: 'value' }]
//      @UI.selectionField: [{position: 280}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 280, label: 'value' }]
//      value,
//
//      @UI.lineItem: [{position: 290, type: #STANDARD, label: 'issap' }]
//      @UI.identification: [{position: 290, type: #STANDARD, label: 'issap' }]
//      @UI.selectionField: [{position: 290}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 290, label: 'issap' }]
//      issap,
//
//      @UI.lineItem: [{position: 300, type: #STANDARD, label: 'iseditable' }]
//      @UI.identification: [{position: 300, type: #STANDARD, label: 'iseditable' }]
//      @UI.selectionField: [{position: 300}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 300, label: 'iseditable' }]
//      iseditable,
//
//      @UI.lineItem: [{position: 310, type: #STANDARD, label: 'colvalstbbid' }]
//      @UI.identification: [{position: 310, type: #STANDARD, label: 'colvalstbbid' }]
//      @UI.selectionField: [{position: 310}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 310, label: 'colvalstbbid' }]
//      colvalstbbid,
//
//      @UI.lineItem: [{position: 320, type: #STANDARD, label: 'columnkey' }]
//      @UI.identification: [{position: 320, type: #STANDARD, label: 'columnkey' }]
//      @UI.selectionField: [{position: 320}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 320, label: 'columnkey' }]
//      columnkey,
//
//      @UI.lineItem: [{position: 330, type: #STANDARD, label: 'colcolumn' }]
//      @UI.identification: [{position: 330, type: #STANDARD, label: 'colcolumn' }]
//      @UI.selectionField: [{position: 330}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 330, label: 'colcolumn' }]
//      colcolumn,
//
//      @UI.lineItem: [{position: 340, type: #STANDARD, label: 'columndesc' }]
//      @UI.identification: [{position: 340, type: #STANDARD, label: 'columndesc' }]
//      @UI.selectionField: [{position: 340}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 340, label: 'columndesc' }]
//      columndesc,
//
//      @UI.lineItem: [{position: 350, type: #STANDARD, label: 'columndtype' }]
//      @UI.identification: [{position: 350, type: #STANDARD, label: 'columndtype' }]
//      @UI.selectionField: [{position: 350}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 350, label: 'columndtype' }]
//      columndtype,
//
//      @UI.lineItem: [{position: 360, type: #STANDARD, label: 'columnwidth' }]
//      @UI.identification: [{position: 360, type: #STANDARD, label: 'columnwidth' }]
//      @UI.selectionField: [{position: 360}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 360, label: 'columnwidth' }]
//      columnwidth,
//
//      @UI.lineItem: [{position: 370, type: #STANDARD, label: 'columnorder' }]
//      @UI.identification: [{position: 370, type: #STANDARD, label: 'columnorder' }]
//      @UI.selectionField: [{position: 370}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 370, label: 'columnorder' }]
//      columnorder,
//
//      @UI.lineItem: [{position: 380, type: #STANDARD, label: 'colcreatedby' }]
//      @UI.identification: [{position: 380, type: #STANDARD, label: 'colcreatedby' }]
//      @UI.selectionField: [{position: 380}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 380, label: 'colcreatedby' }]
//      colcreatedby,
//
//      @UI.lineItem: [{position: 390, type: #STANDARD, label: 'colcreatedat' }]
//      @UI.identification: [{position: 390, type: #STANDARD, label: 'colcreatedat' }]
//      @UI.selectionField: [{position: 390}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 390, label: 'colcreatedat' }]
//      colcreatedat,
//
//      @UI.lineItem: [{position: 400, type: #STANDARD, label: 'collocallastchangedby' }]
//      @UI.identification: [{position: 400, type: #STANDARD, label: 'collocallastchangedby' }]
//      @UI.selectionField: [{position: 400}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 400, label: 'collocallastchangedby' }]
//      collocallastchangedby,
//
//      @UI.lineItem: [{position: 410, type: #STANDARD, label: 'collocallastchangedat' }]
//      @UI.identification: [{position: 410, type: #STANDARD, label: 'collocallastchangedat' }]
//      @UI.selectionField: [{position: 410}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 410, label: 'collocallastchangedat' }]
//      collocallastchangedat,
//
//      @UI.lineItem: [{position: 420, type: #STANDARD, label: 'collastchangedat' }]
//      @UI.identification: [{position: 420, type: #STANDARD, label: 'collastchangedat' }]
//      @UI.selectionField: [{position: 420}]
//      @UI.fieldGroup: [{qualifier: 'Fieldgroup:HeaderItems', position: 420, label: 'collastchangedat' }]
//      collastchangedat

}
