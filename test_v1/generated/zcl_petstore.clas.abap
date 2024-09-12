CLASS zcl_petstore DEFINITION PUBLIC.
* Generated by abap-openapi-client
* Swagger Petstore - OpenAPI 3.0, 1.0.19
  PUBLIC SECTION.
    INTERFACES zif_petstore.
    METHODS constructor IMPORTING ii_client TYPE REF TO if_http_client.
  PROTECTED SECTION.
    DATA mi_client TYPE REF TO if_http_client.
    DATA mo_json TYPE REF TO zcl_oapi_json.
    METHODS send_receive RETURNING VALUE(rv_code) TYPE i.
    METHODS parse_get_inventory
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(response_get_inventory) TYPE zif_petstore=>response_get_inventory
      RAISING cx_static_check.
    METHODS parse_tag
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(tag) TYPE zif_petstore=>tag
      RAISING cx_static_check.
    METHODS parse_category
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(category) TYPE zif_petstore=>category
      RAISING cx_static_check.
    METHODS parse_pet
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(pet) TYPE zif_petstore=>pet
      RAISING cx_static_check.
    METHODS parse_find_pets_by_tags
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(response_find_pets_by_tags) TYPE zif_petstore=>response_find_pets_by_tags
      RAISING cx_static_check.
    METHODS parse_find_pets_by_status
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(response_find_pets_by_status) TYPE zif_petstore=>response_find_pets_by_status
      RAISING cx_static_check.
    METHODS parse_user
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(user) TYPE zif_petstore=>user
      RAISING cx_static_check.
    METHODS json_create_users_with_list_
      IMPORTING data TYPE zif_petstore=>bodycreate_users_with_list_i
      RETURNING VALUE(json) TYPE string
      RAISING cx_static_check.
    METHODS parse_api_response
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(api_response) TYPE zif_petstore=>api_response
      RAISING cx_static_check.
    METHODS parse_address
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(address) TYPE zif_petstore=>address
      RAISING cx_static_check.
    METHODS parse_customer
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(customer) TYPE zif_petstore=>customer
      RAISING cx_static_check.
    METHODS parse_order
      IMPORTING iv_prefix TYPE string
      RETURNING VALUE(order) TYPE zif_petstore=>order
      RAISING cx_static_check.
ENDCLASS.

CLASS zcl_petstore IMPLEMENTATION.
  METHOD constructor.
    mi_client = ii_client.
  ENDMETHOD.

  METHOD send_receive.
    mi_client->send( ).
    mi_client->receive( ).
    mi_client->response->get_status( IMPORTING code = rv_code ).
  ENDMETHOD.

  METHOD parse_get_inventory.
  ENDMETHOD.

  METHOD parse_tag.
    tag-id = mo_json->value_string( iv_prefix && '/id' ).
    tag-name = mo_json->value_string( iv_prefix && '/name' ).
  ENDMETHOD.

  METHOD parse_category.
    category-id = mo_json->value_string( iv_prefix && '/id' ).
    category-name = mo_json->value_string( iv_prefix && '/name' ).
  ENDMETHOD.

  METHOD parse_pet.
    pet-id = mo_json->value_string( iv_prefix && '/id' ).
    pet-name = mo_json->value_string( iv_prefix && '/name' ).
    pet-category = parse_category( iv_prefix && '/category' ).
* todo, array, photo_urls
* todo, array, tags
    pet-status = mo_json->value_string( iv_prefix && '/status' ).
  ENDMETHOD.

  METHOD parse_find_pets_by_tags.
    DATA lt_members TYPE string_table.
    DATA lv_member LIKE LINE OF lt_members.
    DATA pet TYPE zif_petstore=>pet.
    lt_members = mo_json->members( iv_prefix && '/' ).
    LOOP AT lt_members INTO lv_member.
      CLEAR pet.
      pet = parse_pet( iv_prefix && '/' && lv_member ).
      APPEND pet TO response_find_pets_by_tags.
    ENDLOOP.
  ENDMETHOD.

  METHOD parse_find_pets_by_status.
    DATA lt_members TYPE string_table.
    DATA lv_member LIKE LINE OF lt_members.
    DATA pet TYPE zif_petstore=>pet.
    lt_members = mo_json->members( iv_prefix && '/' ).
    LOOP AT lt_members INTO lv_member.
      CLEAR pet.
      pet = parse_pet( iv_prefix && '/' && lv_member ).
      APPEND pet TO response_find_pets_by_status.
    ENDLOOP.
  ENDMETHOD.

  METHOD parse_user.
    user-id = mo_json->value_string( iv_prefix && '/id' ).
    user-username = mo_json->value_string( iv_prefix && '/username' ).
    user-first_name = mo_json->value_string( iv_prefix && '/firstName' ).
    user-last_name = mo_json->value_string( iv_prefix && '/lastName' ).
    user-email = mo_json->value_string( iv_prefix && '/email' ).
    user-password = mo_json->value_string( iv_prefix && '/password' ).
    user-phone = mo_json->value_string( iv_prefix && '/phone' ).
    user-user_status = mo_json->value_string( iv_prefix && '/userStatus' ).
  ENDMETHOD.

  METHOD parse_api_response.
    api_response-code = mo_json->value_string( iv_prefix && '/code' ).
    api_response-type = mo_json->value_string( iv_prefix && '/type' ).
    api_response-message = mo_json->value_string( iv_prefix && '/message' ).
  ENDMETHOD.

  METHOD parse_address.
    address-street = mo_json->value_string( iv_prefix && '/street' ).
    address-city = mo_json->value_string( iv_prefix && '/city' ).
    address-state = mo_json->value_string( iv_prefix && '/state' ).
    address-zip = mo_json->value_string( iv_prefix && '/zip' ).
  ENDMETHOD.

  METHOD parse_customer.
    customer-id = mo_json->value_string( iv_prefix && '/id' ).
    customer-username = mo_json->value_string( iv_prefix && '/username' ).
* todo, array, address
  ENDMETHOD.

  METHOD parse_order.
    order-id = mo_json->value_string( iv_prefix && '/id' ).
    order-pet_id = mo_json->value_string( iv_prefix && '/petId' ).
    order-quantity = mo_json->value_string( iv_prefix && '/quantity' ).
    order-ship_date = mo_json->value_string( iv_prefix && '/shipDate' ).
    order-status = mo_json->value_string( iv_prefix && '/status' ).
    order-complete = mo_json->value_boolean( iv_prefix && '/complete' ).
  ENDMETHOD.

  METHOD json_create_users_with_list_.
    json = json && '['.
* todo, array
    json = json && ']'.
  ENDMETHOD.

  METHOD zif_petstore~update_pet.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/pet'.
    mi_client->request->set_method( 'PUT' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
* todo, set body, #/components/schemas/Pet
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " Successful operation
" application/json,#/components/schemas/Pet
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_pet( '' ).
      WHEN 400. " Invalid ID supplied
" todo, raise
      WHEN 404. " Pet not found
" todo, raise
      WHEN 405. " Validation exception
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~add_pet.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/pet'.
    mi_client->request->set_method( 'POST' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
* todo, set body, #/components/schemas/Pet
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " Successful operation
" application/json,#/components/schemas/Pet
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_pet( '' ).
      WHEN 405. " Invalid input
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~find_pets_by_status.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/pet/findByStatus'.
    IF status IS SUPPLIED.
      mi_client->request->set_form_field( name = 'status' value = status ).
    ENDIF.
    mi_client->request->set_method( 'GET' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " successful operation
" application/json,#/components/schemas/response_find_pets_by_status
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_find_pets_by_status( '' ).
      WHEN 400. " Invalid status value
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~find_pets_by_tags.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/pet/findByTags'.
    lv_temp = tags.
    CONDENSE lv_temp.
    IF tags IS SUPPLIED.
      mi_client->request->set_form_field( name = 'tags' value = lv_temp ).
    ENDIF.
    mi_client->request->set_method( 'GET' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " successful operation
" application/json,#/components/schemas/response_find_pets_by_tags
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_find_pets_by_tags( '' ).
      WHEN 400. " Invalid tag value
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~get_pet_by_id.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/pet/{petId}'.
    lv_temp = pet_id.
    lv_temp = cl_http_utility=>escape_url( condense( lv_temp ) ).
    REPLACE ALL OCCURRENCES OF '{petId}' IN lv_uri WITH lv_temp.
    mi_client->request->set_method( 'GET' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " successful operation
" application/json,#/components/schemas/Pet
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_pet( '' ).
      WHEN 400. " Invalid ID supplied
" todo, raise
      WHEN 404. " Pet not found
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~update_pet_with_form.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/pet/{petId}'.
    lv_temp = pet_id.
    lv_temp = cl_http_utility=>escape_url( condense( lv_temp ) ).
    REPLACE ALL OCCURRENCES OF '{petId}' IN lv_uri WITH lv_temp.
    IF name IS SUPPLIED.
      mi_client->request->set_form_field( name = 'name' value = name ).
    ENDIF.
    IF status IS SUPPLIED.
      mi_client->request->set_form_field( name = 'status' value = status ).
    ENDIF.
    mi_client->request->set_method( 'POST' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 405. " Invalid input
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~delete_pet.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/pet/{petId}'.
    lv_temp = pet_id.
    lv_temp = cl_http_utility=>escape_url( condense( lv_temp ) ).
    REPLACE ALL OCCURRENCES OF '{petId}' IN lv_uri WITH lv_temp.
    mi_client->request->set_method( 'DELETE' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    mi_client->request->set_header_field( name = 'api_key' value = api_key ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 400. " Invalid pet value
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~upload_file.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/pet/{petId}/uploadImage'.
    lv_temp = pet_id.
    lv_temp = cl_http_utility=>escape_url( condense( lv_temp ) ).
    REPLACE ALL OCCURRENCES OF '{petId}' IN lv_uri WITH lv_temp.
    IF additional_metadata IS SUPPLIED.
      mi_client->request->set_form_field( name = 'additionalMetadata' value = additional_metadata ).
    ENDIF.
    mi_client->request->set_method( 'POST' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " successful operation
" application/json,#/components/schemas/ApiResponse
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_api_response( '' ).
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~get_inventory.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/store/inventory'.
    mi_client->request->set_method( 'GET' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " successful operation
" application/json,#/components/schemas/response_get_inventory
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_get_inventory( '' ).
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~place_order.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/store/order'.
    mi_client->request->set_method( 'POST' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
* todo, set body, #/components/schemas/Order
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " successful operation
" application/json,#/components/schemas/Order
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_order( '' ).
      WHEN 405. " Invalid input
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~get_order_by_id.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/store/order/{orderId}'.
    lv_temp = order_id.
    lv_temp = cl_http_utility=>escape_url( condense( lv_temp ) ).
    REPLACE ALL OCCURRENCES OF '{orderId}' IN lv_uri WITH lv_temp.
    mi_client->request->set_method( 'GET' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " successful operation
" application/json,#/components/schemas/Order
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_order( '' ).
      WHEN 400. " Invalid ID supplied
" todo, raise
      WHEN 404. " Order not found
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~delete_order.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/store/order/{orderId}'.
    lv_temp = order_id.
    lv_temp = cl_http_utility=>escape_url( condense( lv_temp ) ).
    REPLACE ALL OCCURRENCES OF '{orderId}' IN lv_uri WITH lv_temp.
    mi_client->request->set_method( 'DELETE' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 400. " Invalid ID supplied
" todo, raise
      WHEN 404. " Order not found
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~create_user.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/user'.
    mi_client->request->set_method( 'POST' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
* todo, set body, #/components/schemas/User
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~create_users_with_list_input.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/user/createWithList'.
    mi_client->request->set_method( 'POST' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    mi_client->request->set_cdata( json_create_users_with_list_( body ) ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " Successful operation
" application/json,#/components/schemas/User
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_user( '' ).
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~login_user.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/user/login'.
    IF username IS SUPPLIED.
      mi_client->request->set_form_field( name = 'username' value = username ).
    ENDIF.
    IF password IS SUPPLIED.
      mi_client->request->set_form_field( name = 'password' value = password ).
    ENDIF.
    mi_client->request->set_method( 'GET' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " successful operation
" application/json,
      WHEN 400. " Invalid username/password supplied
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~logout_user.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/user/logout'.
    mi_client->request->set_method( 'GET' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~get_user_by_name.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/user/{username}'.
    lv_temp = username.
    lv_temp = cl_http_utility=>escape_url( condense( lv_temp ) ).
    REPLACE ALL OCCURRENCES OF '{username}' IN lv_uri WITH lv_temp.
    mi_client->request->set_method( 'GET' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 200. " successful operation
" application/json,#/components/schemas/User
        CREATE OBJECT mo_json EXPORTING iv_json = mi_client->response->get_cdata( ).
        return_data = parse_user( '' ).
      WHEN 400. " Invalid username supplied
" todo, raise
      WHEN 404. " User not found
" todo, raise
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~update_user.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/user/{username}'.
    lv_temp = username.
    lv_temp = cl_http_utility=>escape_url( condense( lv_temp ) ).
    REPLACE ALL OCCURRENCES OF '{username}' IN lv_uri WITH lv_temp.
    mi_client->request->set_method( 'PUT' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
* todo, set body, #/components/schemas/User
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD zif_petstore~delete_user.
    DATA lv_code TYPE i.
    DATA lv_temp TYPE string.
    DATA lv_uri TYPE string VALUE '/api/v3/user/{username}'.
    lv_temp = username.
    lv_temp = cl_http_utility=>escape_url( condense( lv_temp ) ).
    REPLACE ALL OCCURRENCES OF '{username}' IN lv_uri WITH lv_temp.
    mi_client->request->set_method( 'DELETE' ).
    mi_client->request->set_header_field( name = '~request_uri' value = lv_uri ).
    lv_code = send_receive( ).
    WRITE / lv_code.
    CASE lv_code.
      WHEN 400. " Invalid username supplied
" todo, raise
      WHEN 404. " User not found
" todo, raise
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
