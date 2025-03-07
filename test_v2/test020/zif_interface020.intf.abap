INTERFACE zif_interface020 PUBLIC.
* Auto generated by https://github.com/abap-openapi/abap-openapi
* Title: any table body
* Version: 1

  CONSTANTS base_path TYPE string VALUE ''.

  TYPES: BEGIN OF r_send,
           code          TYPE i,
           reason        TYPE string,
         END OF r_send.
  METHODS send
    IMPORTING
      body TYPE any
    RETURNING
      VALUE(return) TYPE r_send
    RAISING
      cx_static_check.
ENDINTERFACE.
