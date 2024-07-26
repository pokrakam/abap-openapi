CLASS zcl_icf_serv013 DEFINITION PUBLIC.
* Auto generated by https://github.com/abap-openapi/abap-openapi
* Title: two path parameters
* Version: 1
  PUBLIC SECTION.
    INTERFACES if_http_extension.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_icf_serv013 IMPLEMENTATION.
  METHOD if_http_extension~handle_request.
    DATA li_handler      TYPE REF TO zif_interface013.
    DATA lv_method       TYPE string.
    DATA lv_path         TYPE string.
    CREATE OBJECT li_handler TYPE zcl_icf_impl013.
    lv_path = server->request->get_header_field( '~path' ).
    REPLACE FIRST OCCURRENCE OF zif_interface013=>base_path IN lv_path WITH ''.
    lv_method = server->request->get_method( ).

    TRY.
        IF lv_path = '/foo/{param}/{another}' AND lv_method = 'POST'.
          li_handler->_foo_param_another(
            param = 'path-todo'
            another = 'path-todo' ).
          RETURN.
        ENDIF.
      CATCH cx_static_check.
        server->response->set_content_type( 'text/plain' ).
        server->response->set_cdata( 'exception' ).
        server->response->set_status( code = 500 reason = 'Error' ).
    ENDTRY.

    server->response->set_content_type( 'text/plain' ).
    server->response->set_cdata( 'no handler found' ).
    server->response->set_status( code = 500 reason = 'Error' ).
  ENDMETHOD.
ENDCLASS.