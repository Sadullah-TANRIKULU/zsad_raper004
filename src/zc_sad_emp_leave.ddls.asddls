@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_SAD_EMP_LEAVE
  provider contract TRANSACTIONAL_QUERY
  as projection on ZI_SAD_EMP_LEAVE
{
  key EmpId,
  key LeaveId,
  Startdate,
  Enddate,
  Leavetype,
  Status,
  Remainingleave,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt
  
}
