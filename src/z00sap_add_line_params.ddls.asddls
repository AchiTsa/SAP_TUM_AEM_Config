@EndUserText.label: 'Parameters for adding a new tbb block'
define abstract entity Z00SAP_ADD_LINE_PARAMS
{
  tier_level : z00sap_tltype_datel;
  extension_task_name : abap.string(256);
  extension_style_name : abap.string(256);
  Tech_Extension_Building_Block : abap.string(256);
  extensiondomain     : abap.string(256);
  coreextensiondomain : abap.string(256);
  color               : z00sap_colors;
  reasoning           : abap.string(256);
  hierarchy           : abap.string(256);
  link                : abap.string(256);
  
  
}
