INTERFACE zif_interface015 PUBLIC.
* Auto generated by https://github.com/abap-openapi/abap-openapi
* Title: return structured array
* Version: 1

  CONSTANTS base_path TYPE string VALUE ''.

* arrsubsomething
  TYPES: BEGIN OF arrsubsomething,
           key TYPE string,
           name TYPE string,
         END OF arrsubsomething.
* Something
  TYPES: BEGIN OF something,
           subsomething TYPE STANDARD TABLE OF arrsubsomething WITH DEFAULT KEY,
         END OF something.

  TYPES: BEGIN OF r__array,
           code          TYPE i,
           reason        TYPE string,
           _200_app_json TYPE something,
         END OF r__array.
  METHODS _array
    RETURNING
      VALUE(return) TYPE r__array
    RAISING
      cx_static_check.
ENDINTERFACE.
