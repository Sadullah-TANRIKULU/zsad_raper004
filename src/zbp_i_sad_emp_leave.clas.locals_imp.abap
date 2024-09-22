CLASS lhc_zi_sad_emp_leave DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR EmpLeave
        RESULT result,
      SetToApproveLeave FOR MODIFY
        IMPORTING keys FOR ACTION EmpLeave~SetToApproveLeave RESULT result,
      SetToRejectLeave FOR MODIFY
        IMPORTING keys FOR ACTION EmpLeave~SetToRejectLeave RESULT result,
      calcRemainingLeave FOR DETERMINE ON MODIFY
        IMPORTING keys FOR EmpLeave~calcRemainingLeave.
ENDCLASS.

CLASS lhc_zi_sad_emp_leave IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD SetToApproveLeave.

    MODIFY ENTITIES OF zi_sad_emp_leave IN LOCAL MODE
    ENTITY EmpLeave
    UPDATE
    FIELDS ( Status )
      WITH VALUE #(
              FOR key IN keys (  %tky = key-%tky Status = 'APPROVED' ) )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF zi_sad_emp_leave IN LOCAL MODE
    ENTITY EmpLeave
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(empleaves).

    result = VALUE #( FOR empleave IN empleaves
                             ( %tky = empleave-%tky %param = empleave )
     ).

  ENDMETHOD.
  METHOD SetToRejectLeave.

    MODIFY ENTITIES OF zi_sad_emp_leave IN LOCAL MODE
      ENTITY EmpLeave
      UPDATE
      FIELDS ( Status )
        WITH VALUE #(
                FOR key IN keys (  %tky = key-%tky Status = 'REJECTED' ) )
        FAILED failed
        REPORTED reported.

    READ ENTITIES OF zi_sad_emp_leave IN LOCAL MODE
    ENTITY EmpLeave
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(empleaves).

    result = VALUE #( FOR empleave IN empleaves
                             ( %tky = empleave-%tky %param = empleave )
     ).

  ENDMETHOD.
  METHOD calcRemainingLeave.

    DATA: lv_current_date TYPE datum.

    lv_current_date = cl_abap_context_info=>get_system_date( ).

    READ ENTITIES OF zi_sad_emp_leave IN LOCAL MODE
    ENTITY EmpLeave
    FIELDS ( Enddate Startdate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(dates).

    LOOP AT dates INTO DATA(date).

      IF lv_current_date > date-Startdate.

        DATA(diff) = date-Enddate - date-Startdate.

        MODIFY ENTITIES OF zi_sad_emp_leave IN LOCAL MODE
        ENTITY EmpLeave
        UPDATE
        FIELDS ( Remainingleave )
        WITH VALUE #(
        ( %tky = date-%tky Remainingleave = diff )
         ).


      ENDIF.

    ENDLOOP.












    "
  ENDMETHOD.

ENDCLASS.
