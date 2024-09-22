@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZI_SAD_EMP_LEAVE
  as select from ZSAD_EMP_LEAVE as EmpLeave
{
  key emp_id as EmpId,
  key leave_id as LeaveId,
  startdate as Startdate,
  enddate as Enddate,
  leavetype as Leavetype,
  status as Status,
  remainingleave as Remainingleave,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
  
}
