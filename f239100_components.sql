prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.6'
,p_default_workspace_id=>27534538223393061751
,p_default_application_id=>239100
,p_default_id_offset=>0
,p_default_owner=>'WKSP_APEXPRACTICE702'
);
end;
/
 
prompt APPLICATION 239100 - Rice Mill Inventory & Order Tracking System
--
-- Application Export:
--   Application:     239100
--   Name:            Rice Mill Inventory & Order Tracking System
--   Date and Time:   18:54 Thursday June 19, 2025
--   Exported By:     T.GOVIND.RAJESH@ACCENTURE.COM
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     APP_STATIC_FILE: 54650446133403145826
--     APP_STATIC_FILE: 54650446401837145827
--     APP_STATIC_FILE: 54650446701823145827
--     APP_STATIC_FILE: 54650445837577145824
--     APP_STATIC_FILE: 54650447002303145828
--     AUTHORIZATION: 56607582649192024198
--     AUTHORIZATION: 56607530477376018758
--     AUTHORIZATION: 56607148908871296420
--     BREADCRUMB: 54650443071322145818
--     BREADCRUMB_ENTRY: 56979283873918407606
--     BREADCRUMB_ENTRY: 56963656513654951946
--     BREADCRUMB_ENTRY: 56798232116562993567
--     BREADCRUMB_ENTRY: 56790772961169752894
--     BREADCRUMB_ENTRY: 56789935664783994529
--     BREADCRUMB_ENTRY: 55576474039753239617
--     BREADCRUMB_ENTRY: 55573650951376119077
--     BREADCRUMB_ENTRY: 55466986915235064047
--     BREADCRUMB_ENTRY: 55433296998954705491
--     BREADCRUMB_ENTRY: 55011568938902288972
--     BREADCRUMB_ENTRY: 54811255125277917749
--     EMAIL_TEMPLATE: 56439106151850131464
--     LIST: 54650443519290145819
--     LIST: 56795196079055896616
--     LOV: 56979287334266407610
--     LOV: 56979285850626407608
--     LOV: 56962106835412943431
--     LOV: 56962113758316943436
--     LOV: 56962111033140943434
--     LOV: 56962111792545943435
--     LOV: 56962109982449943434
--     LOV: 55496392553173615724
--     LOV: 55012128661792032458
--     PAGE: 24
--     PAGE: 14
--     PAGE: 5
--     PAGE: 12
--     PAGE: 13
--     PAGE: 11
--     PAGE: 7
--     PAGE: 2
--     PAGE: 9
--     PAGE: 10
--     PAGE: 8
--     PAGE: 6
--     PAGE: 4
--     PAGE: 3
--     TASK_DEFINITION: 56957782524842824458
--     TASK_DEFINITION: 56957818818136829932
--     TASK_DEFINITION: 56439100547904131431
--     WORKFLOW: 56441781020431500131
--   Manifest End
--   Version:         24.2.6
--   Instance ID:     63113759365424
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/workflow/task_definitions/laptop_approval
begin
wwv_flow_imp_shared.create_task_def(
 p_id=>wwv_flow_imp.id(56439100547904131431)
,p_name=>'Laptop Approval'
,p_static_id=>'LAPTOP_APPROVAL'
,p_subject=>'&LAPTOP_TYPE. Laptop Request for &ENAME.'
,p_task_type=>'APPROVAL'
,p_priority=>3
,p_due_on_interval=>'FREQ=MINUTELY;INTERVAL=2'
,p_expiration_policy=>'RENEW'
,p_max_renewal_count=>2
,p_due_on_type=>'SCHEDULER_EXPRESSION'
,p_actions_sql_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ename,',
'       case laptop_type when ''MAC'' then ''MacBook Pro'' when ''WIN'' then ''Lenovo T490'' end as laptop_type,',
'       apex_app_setting.get_value(''DEMO_NOTIFICATION_EMAIL'') as demo_notification_email ',
'from eba_demo_appr_laptop_requests lr',
'left outer join eba_demo_appr_emp e on e.empno = lr.empno',
'where lr.id = :APEX$TASK_PK'))
,p_initiator_can_complete=>false
);
wwv_flow_imp_shared.create_task_def_action(
 p_id=>wwv_flow_imp.id(56439101689349131435)
,p_task_def_id=>wwv_flow_imp.id(56439100547904131431)
,p_name=>'Before Expire: Send Reminder Email to Approver'
,p_execution_sequence=>30
,p_on_event=>'BEFORE_EXPIRE'
,p_action_type=>'NATIVE_SEND_EMAIL'
,p_attribute_01=>'&APP_EMAIL.'
,p_attribute_02=>'&DEMO_NOTIFICATION_EMAIL.'
,p_attribute_06=>'Laptop Request for &ENAME. Requires Your Review'
,p_attribute_07=>'Hi &APEX$TASK_OWNER., please check your "My Approvals" inbox. The laptop request for &ENAME. requires your review and will expire shortly and be assigned to a colleague if you are unable to review it in a timely manner. Thanks for your kind attention'
||' to this matter.'
,p_attribute_08=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Hi &APEX$TASK_OWNER., please check your "My Approvals" inbox. The laptop request for &ENAME. requires your review ',
'    and will expire shortly and be assigned to a colleague if you are unable to review it in a',
'    timely manner. Thanks for your kind attention to this matter.</p>'))
,p_attribute_10=>'N'
,p_attribute_14=>'HTML'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>'apex_app_setting.get_value(''DEMO_NOTIFICATION_EMAIL'') is not null'
,p_condition_expr2=>'PLSQL'
);
wwv_flow_imp_shared.create_task_def_action(
 p_id=>wwv_flow_imp.id(56439102061868131436)
,p_task_def_id=>wwv_flow_imp.id(56439100547904131431)
,p_name=>'Push Email Queue for Sample'
,p_execution_sequence=>40
,p_on_event=>'BEFORE_EXPIRE'
,p_action_type=>'NATIVE_PLSQL'
,p_action_clob=>'apex_mail.push_queue;'
,p_action_clob_language=>'PLSQL'
,p_location=>'LOCAL'
,p_stop_execution_on_error=>true
,p_condition_type=>'ITEM_IS_NOT_NULL'
,p_condition_expr1=>'DEMO_NOTIFICATION_EMAIL'
);
wwv_flow_imp_shared.create_task_def_participant(
 p_id=>wwv_flow_imp.id(56439100859047131432)
,p_task_def_id=>wwv_flow_imp.id(56439100547904131431)
,p_participant_type=>'BUSINESS_ADMIN'
,p_identity_type=>'USER'
,p_value_type=>'STATIC'
,p_value=>'PAT'
);
wwv_flow_imp_shared.create_task_def_participant(
 p_id=>wwv_flow_imp.id(56439101201068131433)
,p_task_def_id=>wwv_flow_imp.id(56439100547904131431)
,p_participant_type=>'POTENTIAL_OWNER'
,p_identity_type=>'USER'
,p_value_type=>'EXPRESSION'
,p_value_language=>'PLSQL'
,p_value=>'eba_demo_appr.get_laptop_approver(:APEX$TASK_RENEWAL_COUNT)'
);
end;
/
prompt --application/shared_components/workflow/task_definitions/order_approval
begin
wwv_flow_imp_shared.create_task_def(
 p_id=>wwv_flow_imp.id(56957782524842824458)
,p_name=>'Order Approval'
,p_static_id=>'ORDER_APPROVAL'
,p_subject=>'Approve the Customer Order by the Agent'
,p_task_type=>'APPROVAL'
,p_priority=>3
,p_expiration_policy=>'NONE'
,p_max_renewal_count=>3
,p_details_link_target=>'14'
,p_initiator_can_complete=>false
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(56959679439856857353)
,p_task_def_id=>wwv_flow_imp.id(56957782524842824458)
,p_label=>'Id'
,p_static_id=>'ID'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(56975244109202276254)
,p_task_def_id=>wwv_flow_imp.id(56957782524842824458)
,p_label=>'Customer Id'
,p_static_id=>'Customer_ID'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_participant(
 p_id=>wwv_flow_imp.id(56959679176573857350)
,p_task_def_id=>wwv_flow_imp.id(56957782524842824458)
,p_participant_type=>'POTENTIAL_OWNER'
,p_identity_type=>'USER'
,p_value_type=>'STATIC'
,p_value=>'Agent'
);
end;
/
prompt --application/shared_components/workflow/task_definitions/order_approval_by_shopkeeper
begin
wwv_flow_imp_shared.create_task_def(
 p_id=>wwv_flow_imp.id(56957818818136829932)
,p_name=>'Order Approval By Shopkeeper'
,p_static_id=>'ORDER_APPROVAL_BY_SHOPKEEPER'
,p_subject=>'Order Should be approved by the Shopkeeper'
,p_task_type=>'APPROVAL'
,p_priority=>3
,p_expiration_policy=>'NONE'
,p_max_renewal_count=>3
,p_initiator_can_complete=>false
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(56975742715768249386)
,p_task_def_id=>wwv_flow_imp.id(56957818818136829932)
,p_label=>'Customer Id'
,p_static_id=>'Customer_ID'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(56975743072834249387)
,p_task_def_id=>wwv_flow_imp.id(56957818818136829932)
,p_label=>'Id'
,p_static_id=>'ID'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_participant(
 p_id=>wwv_flow_imp.id(56976184253815294350)
,p_task_def_id=>wwv_flow_imp.id(56957818818136829932)
,p_participant_type=>'POTENTIAL_OWNER'
,p_identity_type=>'USER'
,p_value_type=>'STATIC'
,p_value=>'Shopkeeper'
);
end;
/
prompt --application/shared_components/workflow/workflows/order_approval_request
begin
wwv_flow_imp_shared.create_workflow(
 p_id=>wwv_flow_imp.id(56441781020431500131)
,p_name=>'Order Approval Request'
,p_static_id=>'New'
,p_title=>'Order Aprroval from &customer_id'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(56976629122208315201)
,p_workflow_id=>wwv_flow_imp.id(56441781020431500131)
,p_label=>'ID'
,p_static_id=>'ID'
,p_direction=>'IN'
,p_data_type=>'NUMBER'
,p_is_required=>false
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(56976629225329315202)
,p_workflow_id=>wwv_flow_imp.id(56441781020431500131)
,p_label=>'Customer_id'
,p_static_id=>'CUSTOMER_ID'
,p_direction=>'IN'
,p_data_type=>'NUMBER'
,p_is_required=>false
);
wwv_flow_imp_shared.create_workflow_version(
 p_id=>wwv_flow_imp.id(56441781179240500132)
,p_workflow_id=>wwv_flow_imp.id(56441781020431500131)
,p_version=>'New'
,p_state=>'DEVELOPMENT'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(56441781745383500138)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_label=>'Approver'
,p_static_id=>'APPROVER'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(56441781888428500139)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_label=>'TaskOutcome'
,p_static_id=>'TASK_OUTCOME'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56441781290452500133)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'Request placed '
,p_static_id=>'New'
,p_display_sequence=>10
,p_activity_type=>'NATIVE_WORKFLOW_START'
,p_diagram=>'{"position":{"x":700,"y":970},"z":1}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56441781345603500134)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'Approval'
,p_static_id=>'New_1'
,p_display_sequence=>20
,p_activity_type=>'NATIVE_CREATE_TASK'
,p_attribute_01=>wwv_flow_imp.id(56957782524842824458)
,p_attribute_05=>'ID'
,p_diagram=>'{"position":{"x":840,"y":970},"z":2}'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(56657630316168239038)
,p_workflow_activity_id=>wwv_flow_imp.id(56441781345603500134)
,p_task_def_param_id=>wwv_flow_imp.id(56959679439856857353)
,p_value_type=>'ITEM'
,p_value=>'ID'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(56975244571228276255)
,p_workflow_activity_id=>wwv_flow_imp.id(56441781345603500134)
,p_task_def_param_id=>wwv_flow_imp.id(56975244109202276254)
,p_value_type=>'ITEM'
,p_value=>'CUSTOMER_ID'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56441782094770500141)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'Approved Or Not'
,p_static_id=>'New_3'
,p_display_sequence=>40
,p_activity_type=>'NATIVE_WORKFLOW_SWITCH'
,p_attribute_01=>'TRUE_FALSE_CHECK'
,p_attribute_03=>'ROWS_RETURNED'
,p_attribute_04=>'select * from customer_orders where customer_id = :customer_id and status=''Approved'''
,p_diagram=>'{"position":{"x":1120,"y":970},"z":6}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56441782253116500143)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'Rejected Email'
,p_static_id=>'New_4'
,p_display_sequence=>50
,p_activity_type=>'NATIVE_SEND_EMAIL'
,p_attribute_01=>'&APP_EMAIL.'
,p_attribute_02=>'t.govind.rajesh@accenture.com'
,p_attribute_06=>'Order Status'
,p_attribute_07=>'Your Order Has Been Rejected'
,p_attribute_10=>'N'
,p_diagram=>'{"position":{"x":1400,"y":970},"z":8}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56441782428519500145)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'Approval by ShopKeeper'
,p_static_id=>'New_5'
,p_display_sequence=>60
,p_activity_type=>'NATIVE_CREATE_TASK'
,p_attribute_01=>wwv_flow_imp.id(56957818818136829932)
,p_attribute_05=>'ID'
,p_attribute_08=>'APPROVED'
,p_diagram=>'{"position":{"x":1120,"y":1110},"z":10}'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(56975743445053249388)
,p_workflow_activity_id=>wwv_flow_imp.id(56441782428519500145)
,p_task_def_param_id=>wwv_flow_imp.id(56975743072834249387)
,p_value_type=>'STATIC'
,p_value=>'#PLEASE_CHANGE#'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(56975743698509249388)
,p_workflow_activity_id=>wwv_flow_imp.id(56441782428519500145)
,p_task_def_param_id=>wwv_flow_imp.id(56975742715768249386)
,p_value_type=>'STATIC'
,p_value=>'#PLEASE_CHANGE#'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56441782625186500147)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'Approval or Rejected '
,p_static_id=>'New_6'
,p_display_sequence=>70
,p_activity_type=>'NATIVE_WORKFLOW_SWITCH'
,p_attribute_01=>'TRUE_FALSE_CHECK'
,p_attribute_03=>'ROWS_RETURNED'
,p_attribute_04=>'select * from customer_orders where customer_id =:customer_id and status =''Dispatched'''
,p_diagram=>'{"position":{"x":1120,"y":1240},"z":12}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56441782880574500149)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'Rejected By Shopkeeper'
,p_static_id=>'New_7'
,p_display_sequence=>80
,p_activity_type=>'NATIVE_SEND_EMAIL'
,p_attribute_01=>'&APP_EMAIL.'
,p_attribute_02=>'t.govind.rajesh@accenture.com'
,p_attribute_06=>'Order Status'
,p_attribute_07=>'Your Order Has Been Rejected'
,p_attribute_10=>'N'
,p_diagram=>'{"position":{"x":1410,"y":1240},"z":14}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56657626646572239001)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'Accepted by Shopkeeper'
,p_static_id=>'New_8'
,p_display_sequence=>90
,p_activity_type=>'NATIVE_SEND_EMAIL'
,p_attribute_01=>'&APP_EMAIL.'
,p_attribute_02=>'t.govind.rajesh@accenture.com'
,p_attribute_06=>'Order Status'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Hi,',
'',
'Your Order has Been Accepted and It is Ready to Dispatched ',
'',
'Thanks For Ordering'))
,p_attribute_10=>'N'
,p_diagram=>'{"position":{"x":1100,"y":1490},"z":16}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56657626891435239003)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'Stock Deduction'
,p_static_id=>'New_9'
,p_display_sequence=>100
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'UPDATE RICE_ITEM',
'SET AVAILABLE_STOCK_KG = AVAILABLE_STOCK_KG - :P7_TOTAL_KG_ORDERED',
'WHERE RICE_TYPE = :P7_RICE_TYPE;',
''))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":1120,"y":1380},"z":18}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56657627137682239006)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'New_1'
,p_static_id=>'New_10'
,p_display_sequence=>110
,p_activity_type=>'NATIVE_WORKFLOW_END'
,p_attribute_01=>'COMPLETED'
,p_diagram=>'{"position":{"x":1430,"y":1490},"z":21}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56657627491516239009)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'New_2'
,p_static_id=>'New_11'
,p_display_sequence=>120
,p_activity_type=>'NATIVE_WORKFLOW_END'
,p_attribute_01=>'COMPLETED'
,p_diagram=>'{"position":{"x":1700,"y":1240},"z":23}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(56657627617073239011)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_name=>'New_3'
,p_static_id=>'New_12'
,p_display_sequence=>130
,p_activity_type=>'NATIVE_WORKFLOW_END'
,p_attribute_01=>'COMPLETED'
,p_diagram=>'{"position":{"x":1700,"y":970},"z":25}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56441781541673500136)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(56441781290452500133)
,p_to_activity_id=>wwv_flow_imp.id(56441781345603500134)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":4,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56441781962150500140)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(56441781345603500134)
,p_to_activity_id=>wwv_flow_imp.id(56441782094770500141)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":5,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56441782121737500142)
,p_name=>'False'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(56441782094770500141)
,p_to_activity_id=>wwv_flow_imp.id(56441782253116500143)
,p_condition_expr1=>'FALSE'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":7,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56441782309530500144)
,p_name=>'true'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(56441782094770500141)
,p_to_activity_id=>wwv_flow_imp.id(56441782428519500145)
,p_condition_expr1=>'TRUE'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":9,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56657627541573239010)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(56441782253116500143)
,p_to_activity_id=>wwv_flow_imp.id(56657627617073239011)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":24,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56441782522367500146)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(56441782428519500145)
,p_to_activity_id=>wwv_flow_imp.id(56441782625186500147)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":11,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56441782720244500148)
,p_name=>'false'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(56441782625186500147)
,p_to_activity_id=>wwv_flow_imp.id(56441782880574500149)
,p_condition_expr1=>'FALSE'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":13,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56657627970782239014)
,p_name=>'True'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(56441782625186500147)
,p_to_activity_id=>wwv_flow_imp.id(56657626891435239003)
,p_condition_expr1=>'TRUE'
,p_diagram=>'{"source":{},"target":{"pos":{"x":1230,"y":1460}},"vertices":[],"z":26,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56657627283910239007)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(56441782880574500149)
,p_to_activity_id=>wwv_flow_imp.id(56657627491516239009)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":22,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56657627027879239005)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(56657626646572239001)
,p_to_activity_id=>wwv_flow_imp.id(56657627137682239006)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":20,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(56657626919514239004)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(56657626891435239003)
,p_to_activity_id=>wwv_flow_imp.id(56657626646572239001)
,p_diagram=>'{"source":{"name":"bottom","args":{"dx":0,"dy":-10}},"target":{"name":"topLeft","args":{"dx":"59.091%","dy":"0%","rotate":true}},"vertices":[],"z":19,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_participant(
 p_id=>wwv_flow_imp.id(56976629907257315209)
,p_workflow_version_id=>wwv_flow_imp.id(56441781179240500132)
,p_participant_type=>'OWNER'
,p_name=>'New'
,p_identity_type=>'USER'
,p_value_type=>'STATIC'
,p_value=>'Agent'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_menu
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(54650443519290145819)
,p_name=>'Navigation Menu'
,p_list_status=>'PUBLIC'
,p_version_scn=>15633432614044
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(54650455463313145838)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Home'
,p_list_item_link_target=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-home'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(54811254244501917747)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Form'
,p_list_item_link_target=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-forms'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'2'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(55011568093454288971)
,p_list_item_display_sequence=>50
,p_list_item_link_text=>'Customers'
,p_list_item_link_target=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-forms'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'4'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(55433296083196705489)
,p_list_item_display_sequence=>80
,p_list_item_link_text=>'Producer Report'
,p_list_item_link_target=>'f?p=&APP_ID.:3:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'3'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(55466986048749064045)
,p_list_item_display_sequence=>90
,p_list_item_link_text=>'Purchase_Request'
,p_list_item_link_target=>'f?p=&APP_ID.:5:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-forms'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'5'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(55573650020555119075)
,p_list_item_display_sequence=>100
,p_list_item_link_text=>'Procurement'
,p_list_item_link_target=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-forms'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'7'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(55576473131612239616)
,p_list_item_display_sequence=>110
,p_list_item_link_text=>'Add a New Rice Type'
,p_list_item_link_target=>'f?p=&APP_ID.:8:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-forms'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'8'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(56789934725353994527)
,p_list_item_display_sequence=>120
,p_list_item_link_text=>'Approval Request'
,p_list_item_link_target=>'f?p=&APP_ID.:6:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table-pointer'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'6'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(56790772012751752892)
,p_list_item_display_sequence=>130
,p_list_item_link_text=>'ShopKeeper Approval'
,p_list_item_link_target=>'f?p=&APP_ID.:9:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table-pointer'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'9'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(56798231289664993565)
,p_list_item_display_sequence=>140
,p_list_item_link_text=>'cutomer orders'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-table'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'10'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(56963654630313951944)
,p_list_item_display_sequence=>150
,p_list_item_link_text=>'Pending Approval'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-tasks'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'11'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(56979282959037407605)
,p_list_item_display_sequence=>160
,p_list_item_link_text=>'Order DashBoard'
,p_list_item_link_target=>'f?p=&APP_ID.:12:&APP_SESSION.::&DEBUG.:::'
,p_list_item_icon=>'fa-workflow'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'12'
);
end;
/
prompt --application/shared_components/navigation/lists/access
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(56795196079055896616)
,p_name=>'Access'
,p_list_status=>'PUBLIC'
,p_version_scn=>15633297521449
);
end;
/
prompt --application/shared_components/files/icons_app_icon_32_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7AF4000000017352474200AECE1CE90000024B494441545847ED955F6BD35018C69FD32D59EAD60569ED5F51EB90767345C626AB75E0907D04EF142FBC9820828EA1888837';
wwv_flow_imp.g_varchar2_table(2) := 'BB90214310111C28F845C4B96A298ED1EA6C3B1DD469696C5DEDB2ADB669DA4572D48B8217696D1021E7E64D724ECEF3CBC37B9E90DCD9330AFEE1200680E180E1C07FED40FE577ED8FF22475ACE810200C76808840042E4256CEA450BA325801DB906F3';
wwv_flow_imp.g_varchar2_table(3) := 'D030BA6D562A59DAD84025B68CEECECEA6119A0650733B5D9160F57A1BC4BEA5D3F0725DFA038855199E9BB761F6F7378895130908B333B0304C53104D3BF095E330F0601E8A2421FDE82115F35EBC04C2B0485C9EC4BEAAA42FC0F7C0311CBC320D59C8';
wwv_flow_imp.g_varchar2_table(4) := 'A2B0F08C8A59C727C0389D58BF77177BDEBDD517401E9F80FBDC792A22865F8010137A4F8ED1FBECD32760169FEB0B2085C6B0FFC2E41F453E3F9E071709EB075094AAA81EF26270E60E15A98B22AD1D3C4FEBCAAD1B60D73F626F17AB19427313AA679F';
wwv_flow_imp.g_varchar2_table(5) := 'E91FC04EB108FFEC1C152827135093889E885D05A9EB53B0D8ACA82693E861B465826680424F2F3C2323103319F0A74EC37222D400B0F52A8CADC505F01E0F32D1286CE592261734036CBADC70FAFC507615AC2DBDC6D0DC7D54D6DE5307B8C37D885DBB';
wwv_flow_imp.g_varchar2_table(6) := '8ABEE1E32026825C2A09FE8BD05E00D1E586C3E7FFD9EDF138F8D120F8A3010AB0198F617B7909AE4080CEE75653E0856CFB01EC477C1056DEC09CCF4354004B300828C07634029E1054EC0E380703C87F586D3FC0A70E066A5BD96409ACC944BFAE54AB';
wwv_flow_imp.g_varchar2_table(7) := 'D1FAFB2724D5EB28B01CD4A707EA727B1DD0B45B0B8B3437610B7B6B7AC500301C301CF801BC9F071019CF769E0000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(54650445837577145824)
,p_file_name=>'icons/app-icon-32.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_144_rounded_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000090000000900806000000E746E2B8000000017352474200AECE1CE90000132449444154785EED9D797C94D5B9C77FE79D4C92C92413B24E128804D90342590C202001D1222ADE928C05126DB48ACBBD576F';
wwv_flow_imp.g_varchar2_table(2) := 'ABBDEAC75AABB7F7A3ADD78DDBF6B6682DD2845093E00ED4052210218845202C0946F68409D926C924B3BEE7F68C0C65C964DE79DF77921938EFBF739EF33CEFEF7CE72CEFD908F8C31550A0005160CB4DB902E00071081429C00152241F37E600710614';
wwv_flow_imp.g_varchar2_table(3) := '29C00152241F37E60071061429C00152241F37E60071061429C00152241F37E60071061429C00152241F37E60071061429C00152241F370E4980CEDCB3288E8A517A4A053DDC8E5840A307889EBAC5E82BA1C88846B001D40AB8ADD0447611225A8960B7';
wwv_flow_imp.g_varchar2_table(4) := 'A6BCF97E67A8BDFF80024401D2B2346FB428601A25984629C921C00400DA50132A44E27152602F01AA09E84E4144755269452D01E840C5D7AF00359A4C29240A3304914EA384E400F45A00F103F5F297895F0B40BE2410AB4511D54E9750955956D6DA5F';
wwv_flow_imp.g_varchar2_table(5) := 'EFD66F00B1DAC6BC2C7F1121F84F00D7F5D70B5E597E4815057DC15852FE517FD54A4107882E5FAE355B5B8A08C5632064D49555A003F6B6B59492178DB109ABC9CA95CE60461154809AEF320D76B9E97B049812CC97E079F7AE00A5D8459D64617A59D9';
wwv_flow_imp.g_varchar2_table(6) := '9960691434801A0B4CD902E8C70006072B789EAF040508AD17DDB83DBDB462BF84D40127090A404D4B4DB3A8403FE41DE480CB235806164124B7A794967DAEB603D5013A5BF37C092046ED60797E8A14E816459AA3764DA42A400DCB6F8BD158A3183CD9';
wwv_flow_imp.g_varchar2_table(7) := '8A5E951B074B81FD6EBD3D2763E507DD6A395015207341FE2A003F522B389E4F501478CB58525EA456CEAA01D4B4CC544409FDB35A81F17C82A700A1E4EED43565ECCFAEF85105A01326932E32929E0290A038229E417F28D0EAD6DB33D568CA5401C85C';
wwv_flow_imp.g_varchar2_table(8) := '90F70040FEAF3FDE9CFB504B01FAA0B1A4E20F4A73530C109BA2682AC83F0860B4D260B87DFF2940400FA694548C533AE5A118A0A642D3024AE986FE7B75EE492D05082137A716976D54929F6280CC05A68D00FDBE9220B8ED402940FE662C295BA0C4BB';
wwv_flow_imp.g_varchar2_table(9) := '22808E141545C738BBAC0004254170DB0153407438486C6659598FDC081401D458989F2B506C96EB9CDB0DBC0222C1DCF4E2F24AB9912802A8A9C0F404057D5EAE736E37F00A109027534BCA5E901B892280CC05F9EF02B85DAE736E17120ABC672C29FF';
wwv_flow_imp.g_varchar2_table(10) := '17B991C806E8ECF09DAD334992EB9CDB858402666349799ADC486403D454644AA34EDA28D731B70B1D05741A77B261F53B2D7222920D50CBD2BC712E81D4C871CA6D424B8108918E4F92B9E04C36408D058BAF1520EC0C2D29783472141021E6A497AC63';
wwv_flow_imp.g_varchar2_table(11) := 'CB70027EE403B4D4344710A8ECE15FC0917283A029208A24375DE66A45D900F1298CA09567BF67AC01E62797947F26C7B16C80CCCBF21783A0428E536E135A0A289913930DD099C2FC0291A238B4A4E0D1C8528022CFB8A67C9D1C5BD9005D092B104FF7';
wwv_flow_imp.g_varchar2_table(12) := '7C374594A6D3C9D1366C6C0482C294E2F2123901CB06C85C90570890BFC8711A0E36C7BBAC6873383CA1264446E2AA587D38842D2B460E902CD97C1B1DEDEA82C5E14492D1E849D4623663506424865EA61071805404E8DBCE2E743A9D884F4CC4A859D7';
wwv_flow_imp.g_varchar2_table(13) := '7B72AEABDA0A4B4B0B0C5A2D86C5C5AAE82D34B2E200A9540E27AC56B4DA1D8835C463CC9C5C68B4119E9CDD4E176AB754A2D3624162542432F5975773C6015201A033361B1ABA7BA08F3360EC9C39D044465E90ABCBEEC081CACDE8B17661704C0C92A3';
wwv_flow_imp.g_varchar2_table(14) := 'A354F01A1A597080149603EBEFB07E4FB42E06E3E6CE454474EF27E9B96D36D46CDE045B4F0FAE8E8B459CF6F238488D03A4002017A538D46E811BC0F76EB8115186B83E73B3B5B763EFE6CDD0B06D28830C8820B207B20AA256D79403A4404F6FA7396B';
wwv_flow_imp.g_varchar2_table(15) := '6C368C63C74ACAA9F1C0011C3F7410F1915A64C5867FA79A0324A9D82F4DD46AB7E384B5DBD369CE9E77038820AD36A122C5814D9FA2ABA3C333B46743FC707E3840324ACFDB748900264A68BA2E7661B37460CFA64F11018231830CD0847153C6019201';
wwv_flow_imp.g_varchar2_table(16) := 'D0296B379AED760C1D370E69A3C7C8C801301F3C88A3070F20253A1A1931E13BDDC1010AB0F86D6E376A2D1D888C8AC6C869D34064DE3D4CA988BAEA1D703A1CC81E140FAD109EDBE33840010274A4B30B1D4E750F2F0DE7F9320E500000D9DD6E1CB274';
wwv_flow_imp.g_varchar2_table(17) := '20296B183266CE0AC0D277D286AA6D68397A246C6B210E50001878FB3E531FF92906CD991B80A5EFA4ED959BB06BC52B30EAA2C372E9070748220622A5D8DF6E01341198BBBA1444A5E9086AB361F35DCBA011DD9E5A28DC1E0E90C412F37EF719367B0E';
wwv_flow_imp.g_varchar2_table(18) := '86FFE4318956D2921D7EE9D73856B5CDF361917D600CA7870324B1B4BC9DE7E94F3D83D829537D5A893D3D68FAE87D741E3DEA4963C81A86945B6E83D0C7CAC4CE9D3B50FDC27F87E56C3D07480240ACF9AA69B32032568FD9AB4B7D5A388E1FC357CF3D';
wwv_flow_imp.g_varchar2_table(19) := '036BEB851B35F5894998F2CC7F213233D3A7ED96C22560F08D4B08AF668C03240120EF8CFBA885B7E2AA7BEFEFD582BA45EC7EF461B4373460CCC25B6118311C1045747C7B0487D67F88842143F0BD175F05D1F4FEBDE7D81F7F8FC37FDB80918638C444';
wwv_flow_imp.g_varchar2_table(20) := '7CB796281C1E0E9084526AE8EEC6199B1DB39E7F11D13EBE3C77D7ECC517BF780A23AEBF1EA953A75D90AB795735EAB76CC1CC5FFD1ABAECDECF51EFD95F83AAA79F44BA4E87545DF85CAEC8019200507D4727BA5C2ECC5FF781CFD4CD1F7D80AFFFB412';
wwv_flow_imp.g_varchar2_table(21) := '1316E72136EBEA0BD239443776BDFA32262F7F08890B6EEEBD067338F0D992BCB05B84CF019200D0FE360BB47106CC5CE57B2349C7B6ADD8F9F26F306EE12D881F73612DD37EE8000EACFF08393F7B028619337D7ADC7AE71208361B46C51B2444151A49';
wwv_flow_imp.g_varchar2_table(22) := '38407ECAC1298A38D06EF17C7D9EF4F20A9FA95D4D4DA87CE0C748CC1A86D18BF3CECD915150D45594A3F5D831E4BEFE6768927C1F89F4D5C30FA1FDE4495C933848E60C5BFF43C501F2A379B7CB85C31D9D183C792AC6FEFC993E539F7EBB14356BD720';
wwv_flow_imp.g_varchar2_table(23) := '2621012999999EDB6C9B4F9C40775B1BAE29B80BC63C539FF6079E7D1A0D7BBE0EAB690D0E901F80D8361DB6F270C4FC9B90F5D0BFF79D5AA438F3E17BD857BC1AA2EBBB09574D8416E3EFFC11526E5904F85974F6ED8A57F06DE5268C3218A08B600B5F';
wwv_flow_imp.g_varchar2_table(24) := '43FFE100F929A3768703C7BAACC8CEBF0319CBEE945CA28E63C73C43F688D43410895F974FAD5E8583EF5684D5A27B0E901F24BC531893963F88A4050B2503242761F387EFE3EB375F0FABA5AE1C20A900DD7B3F9216DE2A870BC936CDEB3FC0D76FACC4';
wwv_flow_imp.g_varchar2_table(25) := '557A3D12A2C263AD3407486A13967707320AA4376192A9392FE1A9E2B770705D39AF81FC89174EA773B0D5876C2275F8BCF918F66F8FF87B3545BF7B3BD1E1B4F190D7401287F119932623FBE9671501E2CFD83B8CE7A3303F4A85530DC446606C249638';
wwv_flow_imp.g_varchar2_table(26) := '340B935FF95F7F0C28FA9D7D486C3B7922ACA633780DD447917BE16149A2630D98B55AFA415CDD35FB3C5F9375E3AF910CD596823BE0387BB259B82CB4E700F9285EEF4151C6C143E0164534373660EEEBABFA9C8A383FAB1DCBEFF1EC569DF6873F4902';
wwv_flow_imp.g_varchar2_table(27) := 'C875E60C2AEFBF07C91919D01001E65327C3E2602A0ED045C5CBA61F8E9EDDBA93949E81E1D3A6A3FDF831D4FDFD2B4C7DF82718943B4F1210DBEFBB1BAC0A9AB152DA65D46D9F7D82AF7EB702A3A64CC1A0CCA1A8AFDE8196C606CF12D7A1B1B1213B37';
wwv_flow_imp.g_varchar2_table(28) := 'C601BA08877347D4A5A561C4F4EB3CD30FAE1E1BBEDAF01186CD998BE18FFC34280079D7454FB9E53644B06F4022C5E1ED5568359B43FA20060ED0793834F5D8D0D8D38384E4148C98390BC279AB07F77FF6299C6E3766BF55EAA959FC3D01D540A288CF';
wwv_flow_imp.g_varchar2_table(29) := '0B7F085DB40E63E7FDB386135D6ED4556D83A5A53964179A7180CE92C0B62CD7593A1115A3C3F81B6E3C77449D1794C6FDFB71BCF61066FFCFAB88BA7AB83F7E100840B6C375D8F6F8A3183A361B69171D13C38EC8DBF7C9C770D86C181D1F87284D684D';
wwv_flow_imp.g_varchar2_table(30) := 'B2728000CFB28B3A4B071844E3AFCF853EF9D2353BDDADADD857B91913EE2C42EA0FF25405C85CFE36F6ADF90B26CC9D075D42C22579779ACD3850B50D3A8D0623E30D522A40BFF1A995800304A0CBE9427D6727E2131231666EEF3B4E2905767FF83EF4';
wwv_flow_imp.g_varchar2_table(31) := 'A9464C7DEDF77E976648AD81D862FC9DFF7A1F6C6D6D987CDB229FE5CA9AD02E8B05230C71D087D0A27B0E1000EF8CFB9051A330B88FEF368D3535385E578B9C471F87C1CFDE78A90059B654E2CB575FC25563B2919EEDFB94B3937BF7E2D43787436EA2';
wwv_flow_imp.g_varchar2_table(32) := '950304A0B1BB074D361BC65E37138634DF3738BA9D4EECDEB01E71C634BFB5902480448A9D0FDD879EB6564C5CB0F0927ED7F9D591A5A10187766C0FB93DF41C200027ADDD68B1DB3171DE7C44FBD99FDE545B8B23FB6B30ED674F226EC6753E9B1C2900';
wwv_flow_imp.g_varchar2_table(33) := '75546DC5CE977E8361D74C40EAC8917D764B6CED16CFA966C9515118AC8F51AB0BA3381F0E508000B1A1F59E8D1B10979181492FADF039A4F70B9048F1E5C30FC1D6DA8209DF5F70C12783DE4AD50B5052541486708042EBB295406A2056B8CDF5F5A8DF';
wwv_flow_imp.g_varchar2_table(34) := 'F335A63FF173C4E65CB889D05BF8FE00EADCFE05AA5F7C1E23274FF6ECE4F0F77080CE5328D466E30305889DB4BA77E37A44C4C621E7E515107A39AEB72F8044AB153B1E7E10D46EC735372D9074C22B07E832024874B950B7752B2C6DADC8983809D9BF';
wwv_flow_imp.g_varchar2_table(35) := '78EE92A6CC2740EC98DFE79E46C3DE3D672F65990D41C2B09CF7812E13805C763BEAB66DF55C9EC28EE77553DAEB9E2F5F009D7E7B2D6AD6969CB38D8B8FC7A859B31111D5F7FD191CA0CB00207B67276AABB6A1A7BBDB73964F7A4C0C0E5B3AE0A01433';
wwv_flow_imp.g_varchar2_table(36) := '7FF5027463FFB9A5B93780D81AA12F9E790A918478BE283776777B6EF8D1C5C460ECACEBA1EDE34E31DE84853940D6E6161CDA5E0597D3E939CB909D69C81EEFCE55B6E06CC62B2BCEAD17DA7E6F11400866BCFEDD720EB6F579FB638FC0DED575C1C641';
wwv_flow_imp.g_varchar2_table(37) := '738F0DEC7A4CAD568B31B3667B76B5F6350AE3C37800E1D689661FF16AAB778052DAEB8E092F043A433CB2E6DF88089D0EB5EBCA3D1C8C5E9C0F574F0F8E7CF2316C9D1DBDCEAA7B372F1241C0E89C6988CFC8B88421DE8485690DD474F81B1CD9B7C7D3';
wwv_flow_imp.g_varchar2_table(38) := '6761370EFA9A8762B50803A9AFA7AF9358AD2E9767F707EB530D9F3811C9C3475C90156FC2C210A0537BF6E064FD37881404CF76637F4B2958E1B3197D36F1CAD653B3875DA8C2B6C4335B7F7762B073A8EB3BBBC04E04C91C31021913269E538DD74061';
wwv_flow_imp.g_varchar2_table(39) := '0490DBE1C0D15DBBD07CBA11311A0D8619E202BEDB8B1D09C39E408FEE65F0B025B5DD6E3792D3339035652A34915A7080C200A08B9B1F36D26257540A326ED3910B108B811DEAC93E6E7AAF0E3F3F2EDE890EC14E749BDDE159D2C11E060B6BB2E22323';
wwv_flow_imp.g_varchar2_table(40) := '117BF6E25C7FD30CBDFDCE4EB5678F92894F76B44C87C309BB287A3AF0EC498A8E0AA93BC60666327559FE621054C829186E13620A50E419D794AF93139584A5E5BD67DB54685A4029DD20C729B7092D05082137A716976D9413956C801A979AE60802AD';
wwv_flow_imp.g_varchar2_table(41) := '94E394DB849602A24872D34BCB3E9713957C800A165F2B40D829C729B7092D05448839E925EBBE9413956C805A96E68D7309A4468E536E135A0A4488747C5269C57E3951C906C8BC6CF1D52042BD1CA7DC26C414A0E270E39A75DFCA894A36404D45A634';
wwv_flow_imp.g_varchar2_table(42) := 'EAA48D729C729BD0528068497AEAAAB2D372A2920DD0AEE5CBB599D6D60E766A8A1CC7DC266414B09DD0271AA6AE5C29EB1259D900B1D73F5D985F4928E6848C143C908015A0049FA71597E7066C78D6401140E6C2FC5F82A2EFA3DFE546C6EDFA470182';
wwv_flow_imp.g_varchar2_table(43) := '678DC5E5BF94EB4C11408D85F9B902C566B9CEB9DDC02B2012CC4D2F2E97FD3D4F1140478A8AA2639C5D6DBC1F34F020C88CC0D6AD8D4D18B66A55DF8BA0FAC85C11409E7E5041DE5A02F243992FC0CD0650010AFAD7B4928A254A425001A0C5D30984ED';
wwv_flow_imp.g_varchar2_table(44) := '4A82E0B603A300853823AD64DD0E25DE1503C49C9B0BF25910BD6FEF54121DB70DA602D5C692F2E94A1DA802D0E965F94B0881EFAB909546C9ED555780522C4D5B53BE5669C6AA00447373239A06271F0130446940DCBE5F1438957AAA398B5456BA947A';
wwv_flow_imp.g_varchar2_table(45) := '5305204F677A59FEED84E05DA50171FBE02B4045BA28ADB4C2F7EDC30184A01A40CC67D3B2BC572921C1BDCD248097E3492F558050FA5AEA9A8AFF504B1B5501A2CB976BCF58DBAA28E8B56A05C8F3514F010254A6E8136F2232E7BD7A8B4455809883C6';
wwv_flow_imp.g_varchar2_table(46) := '254BB2048D6B378041EABD3ACF490505CC10B5138DA5A56615F23A9785EA00799AB2257993A806EB0092A566B03C2FD90A1C0371DF6E2C7E678FEC1C7C18060520E6EBE45D3F48D2BA23D60274BEDA41F3FC025080629333C27DC790D5EFB40460253969';
wwv_flow_imp.g_varchar2_table(47) := 'D0006211509349D314497FFB8F41DA039223E209D554E0A55407799C9495B9D5CCF4FCBC820A90D791B920EF0180BC06203C6EA10D96DAFD976F0F05B93BADA4ECAFC176D92F00B19768BECB34D8EDC68F29C47B094866B05FEC0ACDFF2428DED0449037';
wwv_flow_imp.g_varchar2_table(48) := '9257979DEA0F0DFA0D20EFCB7CD7AC81DD07703F406F82A47B73FA438AB0F5E12684AC27C01F93EDD818CCE6AA3785FA1DA0F383683599E25D5AF74451D04C22944E02301900BB2B20226C8B33B881B3A98783A0D84D09766B44B21B3AFBDF53DE7CBF33';
wwv_flow_imp.g_varchar2_table(49) := 'B86E7DE73EA000F90AEBCC3D8BE2A818A5A754D0C3ED8805347A80E8A95BBC2216F0138D6003A815705BA189EC2244B412C16E1D48507C955548023450FF26EE3770053840816BC62DCE538003C47150A4000748917CDC9803C41950A4000748917CDC98';
wwv_flow_imp.g_varchar2_table(50) := '03C41950A4000748917CDC9803C41950A4000748917CDC9803C41950A4000748917CDC9803C41950A4000748917CDCF8FF0139B10B09B51722D60000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(54650446133403145826)
,p_file_name=>'icons/app-icon-144-rounded.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_192_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000C0000000C0080600000052DC6C07000000017352474200AECE1CE90000173849444154785EED5D79585C5596FF1554411555C59A00D980844080244076B391CD1E352EDD63FBB57E636B6BBBC5718F3A2E';
wwv_flow_imp.g_varchar2_table(2) := 'AD8E76EBD7B127FA69B75B1CDB6EDBD6711C5BC7658C9A186376B31908904048022410B2B0154B51541535DFBDAFAA7810A0DEAB5745F2F2CEFD4749DD73EF3DBF737EEFDD7BDFBDE7E84E5E7F8D075408018D22A0230268D4F2A436478008408EA06904';
wwv_flow_imp.g_varchar2_table(3) := '88009A363F294F04201FD0340244004D9B9F942702900F681A012280A6CD4FCA1301C807348D001140D3E627E58900E4039A468008A069F393F24400F2014D234004D0B4F949792200F980A611200268DAFCA43C11807C40D3081001346D7E529E08403E';
wwv_flow_imp.g_varchar2_table(4) := 'A0690488009A363F294F04201FD0340244004D9B9F942702900F681A012280A6CD4FCA1301C807348D001140D3E627E58900E4039A468008A069F393F24400F2014D234004D0B4F949792200F980A611200268DAFCA43C11807C40D3081001346D7E529E';
wwv_flow_imp.g_varchar2_table(5) := '08403EA0690488009A363F294F04201FD0340244004D9B9F942702900F681A012280A6CD4FCA1301C807348D001140D3E627E58900E4039A468008A069F393F24400F2014D234004D0B4F949792200F980A611200268DAFCA43C11E01CF980B3A707B5ED';
wwv_flow_imp.g_varchar2_table(6) := '1DBCF7348B198688887334126D774B043807F6EFEEE94195AD0D8C04AC30E79F186B45149160D8AD41041866C81D6E37AA6CED707904E7F715BD8E91C082E8C8C8611E91B6BB23020CA3FD3B5D2E1C696B87DBE3E1BD9ACC66FE5F7B8730158AD4E99069';
wwv_flow_imp.g_varchar2_table(7) := 'B5C2A427120C97598800C3847487D7F97B7CCE1F6346DEA2C5BCF7F2EF37C2DED94B8209560B62F4FA611A99B6BB21020C83FDDB9D2E1C6E6BF3F764325B9057B4087A9391FF9BCBDE85F24DDFC3DED1CEFF8ED0E9C04860261284DD3A44803043CC16BC';
wwv_flow_imp.g_varchar2_table(8) := '95AD36FFB4C76C8D454E5111F4D1D17D7A76391C28DFB8D14F02361DCA8E8BA5857198ED43040823C06CAECF9C9F918015A3C984C94B979DE5FCBE21B03741E9771BE0E8B20BF52323F9EE10230395F0204004080FAE60CBDC23B636B4BB5CBC07BDC180';
wwv_flow_imp.g_varchar2_table(9) := 'FC25CB60B0080BDFC18AC36643D9C6EFE0F4CA59F47A64C65AC3344A6A960810261F38D6D1812647B7774E1F81C9458B10939428A9B7CEA626947DFF3D7ABC5BA5238DD1181D132349962AC9438008200F2F49B5CF743950D7D9E9AF9B73D15CC48D1E2D';
wwv_flow_imp.g_varchar2_table(10) := '49D657C9565F8F033BB6FB65C6996390D86FDD20AB41AA3C20024480103B86DDE546A5CDE66F75FCD47C24676505D5CBC98A4A5497EDE7B23AB045B195AF0BA8840E012240E8B004DBE3AF6C6D83A3C7CD5B4D1A351A13E7CE55D4C3E11DDB71A6BE9EB7';
wwv_flow_imp.g_varchar2_table(11) := 'C19C9FED0CD1925811A47D848900A1C312F59D9D38DDE5109CD568C4949F5C824883B20F5AEE6E274ABF5D872EBBB033946C3462548C2984A3D67653448010D9BFFFC7AEA98B96485EF4061A42C79946946EDAE8AF96156BA52FC5814093F83B11402250';
wwv_flow_imp.g_varchar2_table(12) := '435563FBFD15AD36FFE9CE8CDC3CA4E4E686A0E5DE264E9496A2B6B282FF4374049B0A59F917632ACA10200228C38F4B8BB73CD997DE29CB2E66E71942D0B2A8891E0F4AD67DE3FF523C223A1A63CCB435AA146422804204FBEFFA4C5DBC043189D2F6FB';
wwv_flow_imp.g_varchar2_table(13) := 'E576DD7F2A34292E967685E482D8AF3E11402180EC620B3BE9C9CAA8F474A4CD98A9B0C5A1C56B76EF46436D0DAF146B3060BCD512D6FE2EF4C689000A2CDCDAED4475BB7082931D7528BCE452444645296831B0283B3457FCCDD770399DBC323B2B44A7';
wwv_flow_imp.g_varchar2_table(14) := '4603E336580D224090D8B1B33EECA05B975BD8F3CF9A361D89E3C707D99A3CB1C6234750B5EF472E14131989ACB858790D506D3F024480209DA1D1E1C0F18EDEE30E41361312B1748B19F1617EF38464A0E761234480208CC2BEF81E68B19D75AF3788A6';
wwv_flow_imp.g_varchar2_table(15) := '4222C22ED3E7C6C785A42DAD35420408C2E2E7D3D3DF377C7A0B04614876C6EAE4F5D70837B4A94846E0608BCD7FDE67F6838F2076FE02C9B2A1AC68DBB2193B5FFC036F922D84D982988A3C048800F2F0429BD3C9233BB062B4C662FEDBEF4217796E82';
wwv_flow_imp.g_varchar2_table(16) := '5A79DC3DD876CB8DB0DB5AF978B2636329A2844C7B1201640276B4AD1D36EF16E494EBAE47EA2FAE93D94268AB9FF8E03D947DF8016F34313A0AE3BCA15642DBCB85DB1A1140866DD9DDDE032DC2D356A7D361F1DBEF2232EEDC2E3EDD8D8DD878FBCDF0';
wwv_flow_imp.g_varchar2_table(17) := '783CFCCE405E421CF4744648B255890092A102EA3BED38DDD5C52532161661E2030FCB900E5FD543AB57A166DB56DEC1289309C9DE702BE1EBF1C269990820C396E52DADFE139FF39F7B1EA6DC3C19D2E1ABDA59BA1FDB9E7A9C77401FC6E4E14C049088';
wwv_flow_imp.g_varchar2_table(18) := '97F8D05B4CE208CC7BEB2F1225FB56733735A1E18B4FD15A538DE6C347F88F09991310973E1EA9575C85C8200FD26DBDE906D86D2DBCBDC909F1340D92681D228044A04EDABBD0E0BD95957DE972A4DD7EA744C9DE6AED7B76E3C79756C3E18D05DABF81';
wwv_flow_imp.g_varchar2_table(19) := '68B319D3EE7F0896200ED455BFF62754ADFF86374917E8A59B86082011AB43B636B0E0B6AC5CF4D893B0CC9A2D5152A876E6CBCFB1EFAD3725C94CBB6D05922EBB5C525D5FA5B6EDDBF0C37FFC9EFF1917654086854E894A01900820012597C783B26661';
wwv_flow_imp.g_varchar2_table(20) := '7A1111118925EF7F089D8CB337DDC76AB165E57DE8710B041A312113E366CD8271CC58FE7757DD71D4EEDA85C62387F9DF917A0316BCF40A0C3242A9F4D8EDD8F0CB6B018F87DF149B92104F97E725D896082001A46647376ABDD396D185D390F7D46F25';
wwv_flow_imp.g_varchar2_table(21) := '480955D8C7AA1F1FBC174DDE33FC630B0A91B6EC2703CAD7AC5F87BA927D02493227A260D50BB23EB2953EF5381A4A85302A2CB8AED560903C4EAD56240248B03C3BF5C9CEFFB05278EBED18B1FC4A09524215FB81726CFDCD23FCFFD91C7FFA1D77F2FD';
wwv_flow_imp.g_varchar2_table(22) := 'FA818A071EEC5DF3BA7F8DB0E0F91760CCCA96DCD7E94F3F41F13B6FF3FA292623524D143D221078448040080110CFFF17FEE145444F941EE8AA75D346EC7AE905DECB988242A40FF2F4F70DA37AFD3AD47BDF0272CF1975551CC496C7846F13B40E9060';
wwv_flow_imp.g_varchar2_table(23) := '583A0C270DA492A616B0A7332BCBDEFF083A63DFD0E643B572FAF34F51FC97B77895CCF90B9132E7A2213B6DD8B91D47B66C11DE36B7DC8E11974B7FDBF4747460C30DC2D10C163922279E2ECA04B230BD010220243EFE6019311217BD294C31A416B6F5';
wwv_flow_imp.g_varchar2_table(24) := 'B9E3B967827A03CC7DF21998A74D97DA15AFB7F5D737C2DED2CCFF3F3F318116C201D023020400487CEF77CCF499C87DE2DF6539243BABF3DD6D377119A3D9826977AC18720DB0E78DD7D1ED4D97B4E4CF7F43644282ACFECA9F7912F5C5C2429A026805';
wwv_flow_imp.g_varchar2_table(25) := '868E08100023F107B0DC9F5D8D3137DE1C18D57E352A7EFF2C8EEDFA41780BE41722FDE2417681BEFD1A75C525BCDED899B390F3F853B2FB3AF6F65BA8F8E2532E97663623213ABC97F4650FF03C1320020430084B66DDDC2DC4F99F79CFFD885FB24CB6';
wwv_flow_imp.g_varchar2_table(26) := '09D95B60F3DD2BE0720807E9922664224DF41DC0515787DADD3B71E6B0F01D401F6DC4C257D704752CA279FDD7D8F3DA2BBC9D91462346531CD121ED450408E0CEECF20BBB04C3CADCA77F07737EA16C023081A6AFD662EF9BAF49929DBEE22E24FED3A5';
wwv_flow_imp.g_varchar2_table(27) := '92EAF6AF245E73D0FD80C0101201026024DE0295BB2F3F907386EB2C90AF2FF17707DA0A2502044620400D16FBC7EE8DFD53F4F26B881A374E519BFC34E8FF7D86D6A347D078B88A1F7B884F4F47FC848948597E4550D31EF180BAAB8F62D3CA7BF93FD1';
wwv_flow_imp.g_varchar2_table(28) := '3DE1C0A6A23740008CD80D305F96C725FFF9574426250546F51CD6709D3C898D77DECA4760F226D43887C339EFBB260204305169738B3FC7EFD2773F40C4797EE7B6C766C3869BAEE75A1922229047F1826811ACE43154DC247C5462E5E28F3E0B7DD873';
wwv_flow_imp.g_varchar2_table(29) := '25831B40D6D3EDC4B7D75DCD7F61A742A726C487B8870BAB397A0304B0679F63101F7E029D5E59CAA370BB8FC7E9C2B7D7FE33EF861DBACB4F24020C853911208047EE6F6EE1C9EF5859FACEFB88B09EDFC1A77ADADAB0E157FFC2C7CB32CCB37B015406';
wwv_flow_imp.g_varchar2_table(30) := '47800810C03BCA9A5BFD314017AF791BFA9123CF6B7F729D3A858D2B6EA13580442B11010200250E8358F4D22B884A4B9708EDB9A9D65D5D8D4D2BEFE19DB3B4AA2C8B0C157A0304ED03E20C300B56AD86317B52D06D0D87A0F8439845AF4726C50B1D12';
wwv_flow_imp.g_varchar2_table(31) := '767A0304F04A9601869D086565CEA3BF8175F6D0E7F987C3C987EA437C399EE50C6051A3A9D01B20681F109F052AB8F9568CBCF2A741B7351C82A7FFF76314FF4D88594439C402234E6F80213012DF0566D5B22FBB1C69B7AD088CEA39AC51FDC6ABA8FA';
wwv_flow_imp.g_varchar2_table(32) := 'E62BFF0892A2A33196D2A90E6A1122C020D08873FFFAAAC88D08712E7850F6F413385152DCA76B22014D8164F962FF27BF4FD89A9C82396F08F77B9516777333CA56AFE2CD4C7EE851D937BF06EB7FC7EDBF46FB99D367FD4C89B507468CDE00FD70E9EF';
wwv_flow_imp.g_varchar2_table(33) := 'FC2963C7E1E4F163FE5A177FFCB952DFE7F2E248717243AD0C3580F557F75EA24F1E3B0EA7446327129C8D1C11408449FF694F6A9A90F8BA72F326B4789FAA452FFE115119CAD3A19EFCC787D8FFDEBBBCF7A9D7DF80949FFF4231B11C87ABB0F9E10778';
wwv_flow_imp.g_varchar2_table(34) := '3BF12347227B41116AF7F426D666FF4E9764FAC24C04F0E2D1DFF9476564206DFA0CFEEB89F272D41E3CC0FF7FDAAD772069F9158A9D351C0410876049CBC9C3A8BC5C3ECEDABD7B70A2BADA3F662241AFF9880000FA3BFF980999185BD87BF5B1EDE449';
wwv_flow_imp.g_varchar2_table(35) := '946F1562F5A4CF9D87AC871F3B2F0950B1EA591CDB295CBE9FBC60212CC9C9FE711209680D302002FDE7FCE3266661747E7E9FBA3D2E17767D26445A888A8941D1DFFFFBFC23408F079B6EB816DD2C84BB4E8759575E85887E2757EBF6EDC3716F005EA6';
wwv_flow_imp.g_varchar2_table(36) := '00AD09349E2695A53B62698F7C252D7B12464D9932A073976FF8166D2D4284E8509C090AF514487C06282E2111394B960CA8477D49098E551DF2FFC6A246B0E8115A2D9A9D02B14C8F2CE3A3AF8C9B9483D193270FEA07E27540C18D3763E4CF844B27C1';
wwv_flow_imp.g_varchar2_table(37) := '965013E0D4C71FA1E4EFEFF0E164E4E521254798FF0F54EA4BF7E35865A5FF272D4792D62401D8F9FE032D36FF31E7D4F474A407C8CAE2B0B5619F37034B52C6784C7BF18FC1FA3E970B350176DD75075A4FD4F3B6675CBA1CFA00F1806A76F7EE0EE975';
wwv_flow_imp.g_varchar2_table(38) := '11C88D8FE537C8B45634490071B4376B5C1CF2965D2CC9EEA5EBD6A1A3CDC6EB2E7EFD2DE8535224C90D54299404E8AEADC1A6FBEFE6DD58E3E391B7545AF0AEB2F5EBD06E13F4D16A76494D12409CED316FDE7C5853532539F2A98A0A1C2D2BE5759526';
wwv_flow_imp.g_varchar2_table(39) := 'C90E2501C4C9B2C74FCD477296B4F0EDADF5F538B8633BD747AB17E83547800E970BEC8C3F2B46A31105CBA5E7E272767462EFD76BB9AC39311173DFFC6BD097E4434500968166C71D37A3A3A94998FE5C7639F432F20417AFFD125DBEE47FB1B130E923';
wwv_flow_imp.g_varchar2_table(40) := '253D0C2E944A9A238038D9F5D8EC6C8C993255962D0F6CD8009B37FCF89C7F7B0CD68BE6C992F7550E15016CDBB660E7EAE779B3B18949C85DBC58D678EA4A4A70DCBB2B946C346294C662896A8E00E21B5EF98B97C294282FFC78534D0D0EEDD9CD9D2C';
wwv_flow_imp.g_varchar2_table(41) := '39370FF9CF09CE27B7848A00C50F3F80D387AB78F7393367232E4D5EE4BA8E338D28DDB491CB6BF10699E60820BEE33BEBAA9F9EF5B12890237B7A3CD8B7762DBA1DC2F783A217FF84A88C8C406267FD1E0A02741DAAC496471E14A6732613F22FB90CBA';
wwv_flow_imp.g_varchar2_table(42) := '08793B39EE6E27767FF199D08606EF106B8E00E2383F73AEFEB96CC76502A70E1DC2D1FD421CFF098B9762C2BDC201343925140438FCD20B38EA7D7A671614F0CC92724B8FBB07BB3EFD848B69318C8AE608208EF4162C01DC4E177EFCEA4BB89D4EE822';
wwv_flow_imp.g_varchar2_table(43) := '2250F4CA1A1824EE24F91C5429019C7575F8FEDE3B795E604354140A2F5D8E882017B03F7CFC0F3F6F0A644E09E512EE7CAB4F0408D2220D6565A8A938C8A5C7CD9E83498F3E21AB25A50410DFFC4ACFCB43EA105F7E030D8C081008A10BE8F750BC0118';
wwv_flow_imp.g_varchar2_table(44) := '1C6CEE5CFCCD57707AB3C7CC7FF67998F2F22423A584009D25C5D8F6B4403883C180C2CBD8D33FF8908D4400C966537FC550118021D174F4280EFDB89783C28F47AC7E59F27781A009E001F6AEBC074D35C2F9FEEC193390902E7F112EB6241140FD7E2D';
wwv_flow_imp.g_varchar2_table(45) := '5983501280752AFE2E30F3BE95885F34F029CCFE030C96002D1BD663F72B2FF3E6E41C7B180A20228064F7517FC55013C0DEDC8C92EF367060A22D56CC7F758DA400BAC110C0DDD2826DF7FE2B1CEDC297ECFC25CB600A41F05B2280FAFD5AB206A12600';
wwv_flow_imp.g_varchar2_table(46) := 'EBB886DDBBADA9E163909ADE3418028817BEE22B9B92951FA422114029822A920F07014E9496A2B6B2C28FC28CBBEF43C2D2A14F98CA2540D3D76BB1774D6F96C9A12EEFC8350711402E622AAE1F4A02B0AFC2ECAE6D43ADF0F4F7157D743416BCFC1AF4';
wwv_flow_imp.g_varchar2_table(47) := 'A23BB94AD600CE1327B0E5BEBBE07609314A7D8547AD983E43F6D7DFFE632102A8D8A1E50E3D540460DBA0553F6C47CBE9DE2054EC4BAADB9B4C83ED0A15AE5A0D5DD4C099DAA5BE013C5D0EEC7D64259A8FD57255C57DB0BF59F8938973E62232CA2017';
wwv_flow_imp.g_varchar2_table(48) := '0A7F7D2240D0D0A94F3014047075DA51BE7913EC1DBD572A59F8C1D41813585A55674F0F07267DDE02643DF4C8802049228007E0911E7609911ED899FDECB8583474DAD1E870F8DB35992DC85B5814F016D860D62202A8CF8F831EB15202743636E1E0F6';
wwv_flow_imp.g_varchar2_table(49) := 'ADFE0F606C2063626230C218CDC7D4C9EF1BB4C30321AD52FE2F7F85E4ABAF396BBC5208D0F03F1FA0F4BFDEF3CB66C55A11E3FDE075A6CB81BACE4EFF6FEC3844EEFC053025C83BDDCA1A200204ED4EEA1354428096E375A8DCF5033CDE690EBB43CBE2';
wwv_flow_imp.g_varchar2_table(50) := 'EFB330E4E2D2C739753ACC7DEAB73017F4C61962750311A07DCF6EEC78EE197FB303456F6017FB6BDA3BFC39CC743A1D26CD9E83B8316364198608200B2E75570E96000D070FA0A6BCBCF7891B1101164D811D211EA888136BB0DF5944B9F8F90B111917';
wwv_flow_imp.g_varchar2_table(51) := 'C7AB0F4600B6D7DFBC7533F6FDF94D7FB371510664582C03F66377B971B4BDDD3FED6295D2274F46EAA41CC986220248864AFD15E51280EDF41CDDBD13A78F1FF72BCF32B08FB75AF89C7CB0C216C36C3DE0CB321F2C725111113CCFD750111BD89A8385';
wwv_flow_imp.g_varchar2_table(52) := '78B1BBDDFE6EE4EC10110182B58E0AE5E410C0DDDD8D43DBB7A3B5F18C5F5336DD61D31E292144986356B777F0754130C5ACD7F3BE86229AAF5D16EA85F5D5E6ECDD2A8D4B1A81ACB9F302EE10110182B18E4A65A412A0BBBD1D07B76C81BDB3C3AF298B';
wwv_flow_imp.g_varchar2_table(53) := 'A0C6E6E2720B8B40D7EE74F127B46F8768B03698B3B3378CC5A00F2A625B7D67274E77F5DD21CA993F1F51834CA1D8388800722DAAE2FA5208C0EEC956B09D1EEFD394655C1F6B3621315AD8E9094569B0DBC1E213B192623222D5249F58838DA3C9E1C0';
wwv_flow_imp.g_varchar2_table(54) := 'B10ED10E91C1809C790B10939438A0081120141655491B8108C02E981F29EE4D31C4A63A191633ACFD767A94AA1B4E02B0B1B1A9109B12F9B2DCB37FCB2C28C488CCCCB3864E04506A4D15C90F440047AB8DA715AAAB3A047B47EF94872D40D94E4FF420';
wwv_flow_imp.g_varchar2_table(55) := '3B3D4AD40E3701D8D8BADC6EBE38162FC4632C568C9E381196A41188F626D1260228B1A4CA64C504186AE86C019A61B5401FA67899C34100A69FCBE3E12490BA10A73BC12A7368B9C3DDDFDCD2675AD05F9E3DF559702896643A9CE594BD0B27BC11D986';
wwv_flow_imp.g_varchar2_table(56) := '232E275B8837D8BB86D49D4DF7A686E07E4138710B75DB9ABB145FD7D18933A273340CD098C848980D7A98F506B08F4EC351D8F48425E16665A80F6AA11C0B9B0AB1AFD4AC6F87DB7DD6370A2D26CCD01C0142E950D496FA112002A8DF86A48102048800';
wwv_flow_imp.g_varchar2_table(57) := '0AC02351F523400450BF0D490305081001148047A2EA478008A07E1B92060A10200228008F44D58F001140FD36240D1420400450001E89AA1F012280FA6D481A28408008A0003C12553F024400F5DB90345080001140017824AA7E048800EAB72169A000';
wwv_flow_imp.g_varchar2_table(58) := '01228002F04854FD081001D46F43D2400102440005E091A8FA112002A8DF86A481020488000AC02351F523400450BF0D490305081001148047A2EA478008A07E1B92060A10200228008F44D58F001140FD36240D1420400450001E89AA1F012280FA6D48';
wwv_flow_imp.g_varchar2_table(59) := '1A28408008A0003C12553F024400F5DB90345080001140017824AA7E048800EAB72169A00001228002F04854FD081001D46F43D2400102440005E091A8FA112002A8DF86A481020488000AC02351F523400450BF0D490305081001148047A2EA478008A0';
wwv_flow_imp.g_varchar2_table(60) := '7E1B92060A10200228008F44D58F001140FD36240D1420400450001E89AA1F012280FA6D481A28408008A0003C12553F024400F5DB90345080001140017824AA7E048800EAB72169A00001228002F04854FD081001D46F43D2400102FF0FD6F0E78840D1';
wwv_flow_imp.g_varchar2_table(61) := '60220000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(54650446401837145827)
,p_file_name=>'icons/app-icon-192.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_256_rounded_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000001000000010008060000005C72A866000000017352474200AECE1CE90000200049444154785EED9D796054D5D9C69F3333D93321409209842540D8239B0B9B08281645A908494112DC3EAB62B5B57EAD55BB';
wwv_flow_imp.g_varchar2_table(2) := '48ADADDADADA6ABF5AD75649109B202275ABCA22600441D9D7B02FC92440C89E4966EEF97AEE2493494CC8DC59EEDC3BF39E7F20336779DFDF39F79973CFCA4081081081B025C0C2D673729C081001900050232002614C8004208C2B9F5C27022400D406';
wwv_flow_imp.g_varchar2_table(3) := '88401813200108E3CA27D789000900B5012210C6044800C2B8F2C975224002406D8008843101128030AE7C729D089000501B2002614C8004208C2B9F5C27022400D40688401813200108E3CA27D789000900B5012210C6044800C2B8F2C975224002406D';
wwv_flow_imp.g_varchar2_table(4) := '8008843101128030AE7C729D089000501B2002614C8004208C2B9F5C27022400D40688401813200108E3CA27D789000900B5012210C6044800C2B8F2C975224002406D800884310112807695CF1FB83EEA4275544C1322A28DCC1861B43B4C8D0EC9E460';
wwv_flow_imp.g_varchar2_table(5) := '86088324990C466E8264246E5A7C680C0E2E39985D3218EC462E35451A0D7687C96877704753049A1A12CDB67AF6C287362D9A1E2C9BC2B2215BE7CF1F04A36334181F0DB0D100FA034801D03B581541E5AA4AE00C803200C701BE039CED00A4ED9665EF';
wwv_flow_imp.g_varchar2_table(6) := '1C51D50A0D1416160250B6307B0C37F0D9E06C06C02F0510A701F66482F608D47286AD90F0293338565BF256EED09E89FEB5282405604F767664728434831B7023E7B89181F5F52F36CA2D4C081C659CBF2731B6FA5C23DB30B2A0A031D4FC0E290128CB';
wwv_flow_imp.g_varchar2_table(7) := 'CDCE9038BF9301B702480BB5CA227F824AE034E3780306F68F94BC82E2A05AE2C7C2752F0065D9D9F18894BEC719BB031C57FA910D6545043A23B08171F63A9A5098525050A3674CBA16006B4EF6CD00FF0D80917AAE04B25D9F0438B08D71FE73CBB215';
wwv_flow_imp.g_varchar2_table(8) := '1FEBD303E8F376E092DCAC6906CE9E02F804BD8227BB438900FB5262FCD15E7985EBF4E695AE7A0072773F8ABFC23916E80D34D91B1604F258235BACA7D702DD088035376B123896021818164D899CD42701C60F1B24C3FCE46505DBF4E0802E04C09A9B';
wwv_flow_imp.g_varchar2_table(9) := '752B385E0110A907A86463D8136804C3F72D79856F6A9D84A6058003AC7C61D6939CE131AD8324FB88407B020C783225BFF0975A26A35901108B799222F95B00E66A1920D946042E4A80E3CDB34DECFB5A5D44A44901E0D3A699CAD3925672E0466A5E44';
wwv_flow_imp.g_varchar2_table(10) := '200408BC9772FAEC3CB66E9D5D6BBE685200AC3959CB00DCA23558640F11F081409E25BF70910FE9039254730260CDCD7A1A1C3F0B88B794291108260186672C79858F04D3840EC629B4634E694ED6830C784E3B16912544C0BF0438F0E3D4FCC23FFB37';
wwv_flow_imp.g_varchar2_table(11) := '57EF73D34C0FC09A33773260F81C80C17B77282511D03C010793D8B494B70A366AC1524D08803CE21F25ED056783B400856C20020126507CB6918DD4C2CC80260480DEFB03DCDC287BED11D0C87840D005A074D1CD994C326E0760D45E2D914544206004';
wwv_flow_imp.g_varchar2_table(12) := '1C1C6C6C6A7EC1AE8095E041C64117006B4ED6BB006EF2C0568A4204428DC02A4B7EE19C603A15540168DEE0B3299800A86C22104C024C6253823920185C01C8C9120FFFA4605600954D0482498033AC4FCD2B9C162C1B822600D6DC7973C0D9CA60394E';
wwv_flow_imp.g_varchar2_table(13) := 'E51201AD10608C5D9F9257F05130EC099A0094E666AD631C5383E134954904B4442098BD80A008C0998573FB1B99E128747A2499961A0FD91212043837B041A94B0BC433A16A088A005873B39680E371553DA5C28880960930FCDA9257B8446D13551700';
wwv_flow_imp.g_varchar2_table(14) := '71C847594E96503A711D17052240049C048EA6E4170E6200571388EA02509A33770283A1484D27A92C22A007021CD2C4D4FC77BE54D356D5058096FDAA59BD5496AE0804E135407D01C8C9DE0E885B7929100122D08EC0664B7EA1AA775DA82A00E50B16';
wwv_flow_imp.g_varchar2_table(15) := 'F4968CF65334FA4F0D9F087448804734B2EE3D0A0A2AD5E2A3AA00942DCCBE9D33FE0FB59CA3728880DE08708E5B5297152E57CB6E5505C09A93F57700F7A8E51C9543047448E0254B7EE1BD6AD9ADB6008811CEF16A3947E510011D1250751C403501E0';
wwv_flow_imp.g_varchar2_table(16) := '4B9618CA0EED165729C7E8B052C86422A01681BA94C19966B66489A44681AA0940D9C2EC319CF16FD4708ACA20027A266094F8F0A4B756EC57C307D504C09A33EF5E80BDA88653540611D033013507025514001A00D473A324DB5524A0E279812A0A40F6';
wwv_flow_imp.g_varchar2_table(17) := '47009FA922462A8A08E895806A4785A92900B40250AFCD91EC569900DB61C92F18A346A12A0A405629008B1A4E51194440E704AC96FCC254357C504500962C5962587C68B70D80490DA7A80C22A073024D298333A3D5980A544500CAEFFCAE59B24556E9';
wwv_flow_imp.g_varchar2_table(18) := 'BC52C87C22A01A0147952DAEF7EAD575812E501501A8B87D4E626393A922D0CE50FE442054084446D8BB77FFE7BB1702ED8F2A0250BAE8E6142619AD817686F22702A142801B1C96D4A52BCB02ED8F2A02509E3BB797C40D6702ED0CE54F044285808149';
wwv_flow_imp.g_varchar2_table(19) := 'BD93F3DE2909B43FAA08C0E90537F53519234E04DA19CA9F08840A01BBA3A95FDAF2552703ED8F2A0250B2604EBAC16852FDC8E340C3A3FC8940A008480EFB805ECBDF3D16A8FC5BF2554500ACB7CD1F04BBA338D0CE50FE44206408988C199637DE3E1C';
wwv_flow_imp.g_varchar2_table(20) := '687F541180B38BE60F77488EBD817686F25746C0C19D27501B992ACD409971611EDB60340E4D7EF3ED8381C6A04ACD9F59347FB8910420D075A928FF0B8D8D3859EB9C66EE1B178BC4C84845E929726009380C8E11BD97AEDC17D85254BA9A8B0420D0D5';
wwv_flow_imp.g_varchar2_table(21) := 'A82C7FF1F09FA8A9FBEFE54CCE1E000343FFF838748B8C509611C50E1801128080A10DEF8CC5C37FBCA6F65B108408F48BA79E80565A070980566A2284ECA8B035E2446DEBC31F1317277B57EFF659BFB838748FA2D78160573B0940B06B20C4CA3F6FB3';
wwv_flow_imp.g_varchar2_table(22) := 'B9DEF9856B31B1711831759AECE5DECFD7910868ACBE49003456217A36E79CCD8653CD037EF2C31F178F11574D8529265A76CB5EDF807D1B3E475D4DB5CB4D3130D8232A4ACF6EEBDA7612005D579F768CAF6A6AC2D16A7118B333C4991330ECAAAB606A';
wwv_flow_imp.g_varchar2_table(23) := 'F770DB6D36EC5BBFBE8D080C30C7232182060683519B2400C1A01E6265D6DB1D28AEAE86D43CDF2F1EFEE153A7C2D8C9949F1081031B36A0A6CA79339581310C4E3023DA680C3132DA77870440FB75A4690B9B2409072BAB61E7CEE3E56362633162FAD5';
wwv_flow_imp.g_varchar2_table(24) := 'DFFAE56FEF8410813D9F7D8A868606F9AB0883411601F12F05F5089000A8C73AE44A12BFF887AAAAD1E070C8BE194D268C9A7E0D22CDF11EF96AABAAC2AE756BE1B0DB9DE261342223C12CF70828A8438004401DCE21578A58DA23DEF9AB9B9A9CBE3186';
wwv_flow_imp.g_varchar2_table(25) := 'CC2BA7202E395991AFD5562BF67EB109687E7D106301624C80823A044800D4E11C72A59CA9AB437983387ED119068FBB143DD2D3BDF2F3DCE12328DED17A99534A74347AC5D2CD6E5EC1549888044021308A0EF957FF88DB887FEFF474F41D77A94F688E';
wwv_flow_imp.g_varchar2_table(26) := '6FDD8AD213C75D790C329B111F4167BBFA04D583C424001E40A228AD04ECFFBD4FEAC0852AD7A05F6CBC1923AFBE0606936F23F892DD81DD9F7DE25A2824060387764BA01D84016E7C240001061C6AD98B5FFE96F77E033360F4B5D72232DE3FEFEC0D95';
wwv_flow_imp.g_varchar2_table(27) := '55D8B5E63348CD330A62E7A0D83C44217004480002C736E4726EBFD22F63EC38F41C30C0AF7EB61F0F1002405B88FD8AB84D66240081631B5239374A120E5456B916FBF44CED858C499302E263715111CE9538CF761587888857015A1F1010D42001080C';
wwv_flow_imp.g_varchar2_table(28) := 'D790CB55CCF7D735CFD71B23223076E6759DAEF4F3D579BBAD11DBFFF3111CCD538CF126130625987DCD96D277408004809A459704DAEFED0F44D7BFBD11ED5F0568BF4097D5E455041200AFB0854F22B1E067FF854A88570011CC89891871F535010720';
wwv_flow_imp.g_varchar2_table(29) := 'D605EDFDEC53D77E01B14F40BC0A50F02F011200FFF20CB9DCCE36D870BAAEF5EAB8D157CF4074623755FCAC3F5F819DEBD6B8CAA24344FC8F9D04C0FF4C432647B1D67F9FDB9CBF3F16FC2885E3BE4028D260C0B0C46EA09D024A29761E9F04C07F2C43';
wwv_flow_imp.g_varchar2_table(30) := '2E276B7D034AEBEB5D7E99BB25C2A4F2A9BEF6A646545F68BDBB322D361649D1748088BF1A1B0980BF4886583E62C5DFBE0B95AE693FADB86762060C4F4CA01D837EAA1012003F810CB56C4AEAEA51D6BC575F6BBEF58E8D4172B4F398310ABE112001F0';
wwv_flow_imp.g_varchar2_table(31) := '8D5FC8A6DE5351E95AEFDFE7B22BD07DE8D0A0FA5A71603F4E6DFD4AB6418C050C57692032A84EAB503809800A90F556449B63BD19C3F457FE09638F1E4175C371EE1CD6DE7D87EBDC005A17E09FEA2001F00FC790CAE5506515EA9A4FF9E9376122863C';
wwv_flow_imp.g_varchar2_table(32) := 'FC9826FC3BF0F49338B965B36C8B39220203E9E0109FEB8504C06784A1958158EE2B96FDB684494FFC16B199A334E164EDCEED285AF24B972DE23540BC0E50F09E000980F7EC4232E5899A5A543436CABE75EBD51B97FFF525956E76F4002707362FFE1F';
wwv_flow_imp.g_varchar2_table(33) := '549795C99193A3A3D03B36D6838414A533022400D4365C04C435DEBB2B5AE7DCC7DD731F7ACCBC5E5384CE7DF06F7CF3EA4BB24D62A76066F7444DD9A737634800F4566301B4D77DD34F447434AE7A3D0FCC0F8B6E9A4E9F92AD8E48EBE3B3F5527D3DD6';
wwv_flow_imp.g_varchar2_table(34) := 'DF712B1C8DCEE3C4C53880180FA0E01D011200EFB885642AF7EEFFC0A9D331F0470F79EDE7F98F3FC4D10FDFC7851327DA5C0F9ED8AF1F06CCBA113DBE739DD77917FFF1F738B66903BD06784DB0352109801F20864A16A2FB2F5E0344B8FCA19FA2DB95';
wwv_flow_imp.g_varchar2_table(35) := '5729768DDB6C38F2B7177074C3FA8BA61D30652A06FEE087605E2C2DBEB06E0DB63EFF9C9C7F94C1886189B44B50714535272001F0965C88A5ABB5DB51EC36FA7FF51BCB60302B3F8463C7CFFE17E5870E7A442779C8508C7EFA598FE2BA47725CB880B5';
wwv_flow_imp.g_varchar2_table(36) := '772E727D44B3018A11BA12900078CF2EA452BA2FFD4D1E3C14A39F51FE6096FE6B39762FCF777149193A1C7DC78D4364AF5EF2678D252538F9F5D7283BB0CF15E792858B60C9FA9E6296DFFCE4419C3B72584E471B8414E32301F01E5968A63C585985FA';
wwv_flow_imp.g_varchar2_table(37) := 'E6C53F990B73919A355F91A3B66347B1F17F7F04DEFC0AD17FE224A44D9CDC611EA78B36E178D117F277E264E12B9F7B1E91FDFA2B2AAF64793EF6FC6BB99C8616052942D72632F500BC67173229C5CEBF3D6ED37F537EFF2744650C56E4DFB1175F40F1';
wwv_flow_imp.g_varchar2_table(38) := '27FF91D324F6ED8FE1D9D9609DECDCE7E0D85BF02F549E3C21C71F72DD2CF4BB7BB1A2F21A0EECC7C6477FEA4A33BA477745E929B293000900B5843637FD30C6704DC12AF1D3AC888CFBBBFFF059B3D07DD8C88BA6AFD8BF07FB3EF8408E93327C0446FD';
wwv_flow_imp.g_varchar2_table(39) := 'F61945E571BB1D6BE6CF75F538C4716174BDB822842400CA7185668AF286069CA9731EFCD1337D00C6FEE979C58EAEBF251B4D36E7DCFCD845B72226D972D13CEACBADF866E99B729CC8D8385C95E7ECCE2B09DB7EF4035434F722E8FE0025E45AE3520F';
wwv_flow_imp.g_varchar2_table(40) := 'C03B6E2195EA646D2DCEDB9CCB7F074C9D8E415ECCFF7F75FF62549E712EF8199DBB087129A91765545766C5F63CA70024A6F5C1652FBCA898E9E1E79E754D37D285A28AF1510FC03B64A197CA7D0070D4A2DB9172F33CC54EBA3F8C03274F41EAF80917';
wwv_flow_imp.g_varchar2_table(41) := 'CDA36473118E6EDAE893E85857146057BE5344E85A71C5554602E01DB2D04BB5F3FC05D76ABD098FFD0AF1975DAED8C9B277DFC1CE37FF21A733454563DC9D77C114D3F115DFF6FA3A6C7BED35D772DED177DC85E4D937292EB3FAABCDD8FCD493723A3A';
wwv_flow_imp.g_varchar2_table(42) := '2444313E1200EF908556AA068743BEF2AB254C7BF115982C17EFBE7744C05151814D0F2C46635DADFC75F75EBD9031671E22DA8940535D1D0EAE7A0795252572BCA8783326FFDF4B5E2D3A6A2A29C1FA1FDCED32E792EE897456A0C2E64963000A81855A';
wwv_flow_imp.g_varchar2_table(43) := 'F4AAA6261CADAE71B93563C56AAFB7FF56156DC2963F3CDD0651DA25A3109B92227F56632D43C9EE9D6DBE9FF0F3C7117FE9655E61E58D8DF86C41EBEB0ACD0428C74802A09C5948A570DF0128BAEED3DE2AF0C9BFD36FBC8E7DAB567A94C788ACF9E8BD';
wwv_flow_imp.g_varchar2_table(44) := '30D7A3B89D45FA74EE6CD757190966C4994C3EE5176E894900C2ADC6DBF97BDE66C3C95AE7CD3FF149C998F0F2EB3E13A9DBBD0B3BFEFC2C6ACF9FEF30AFB8A4248CFEE14388CDBCC4E7B28AEEBA1DB5E7CFC9F9A4C7C7A35B246D0D560295044009AD10';
wwv_flow_imp.g_varchar2_table(45) := '8CEB7EF5578FFEE918F7DC0B7EF152AAAD45EDAE1DA83B750AD5278E81194D88EFD307B17DFA226ED418183A1920545AF8B61FDE878A5327E564747598527AB4125039B1104BE17EFB4F6AE628643EF15B5D79B8F3178FA06CEF1ED966DA14A4BCEAA807';
wwv_flow_imp.g_varchar2_table(46) := 'A09C5948A570DF052836F00CFEE9A3BAF2EFC0534FE2E457CE93825363626089A10B439454200980125A2118F7746D1DCEDA6CB26719D77E07E98B1FD09597475EF8338EACFD4CB659DC16246E0DA2E039011200CF598564CCB6023013E98BEFD7959FC7';
wwv_flow_imp.g_varchar2_table(47) := 'FEF6028A3F75EE424C8A8A425A1C9D12ACA402490094D00AC1B8621390D80C2442FA94AB90F1E3D62DB67A70F7D0B3CFE0F817CE25C5D403505E632400CA9985540AF73180B4719761F82F1ED7957F7B9FF815CE6CFF46B659BCFF8B71000A9E132001F0';
wwv_flow_imp.g_varchar2_table(48) := '9C5548C62CAB6F4049BD732BB037FBF2830D65C7CF7E82F243076433E8D660E5B54102A09C5948A5705F08E4ED5900C104E2BE0E80CE04505E132400CA9985540AF7BD00E694148CFFFB6BBAF2CF7D25205D12A2BCEA480094330BA914EE97811A0C465C';
wwv_flow_imp.g_varchar2_table(49) := '5DF8AE7EFC9324ACF9DE5C489243B679484202624C46FDD8AF014B4900345009C134E1784D2DC486A09630EDA5D7614A4E0EA6491E976D2F2DC5BAFBBEEF8A9F181909F11A40C1730224009EB30AA998E2FE9FE33535A86C6C6AE39796AE03EF0A78EDF6';
wwv_flow_imp.g_varchar2_table(50) := 'AF51F444DB590BB119A87F7C7C27E711779563F87D4F02107E752E7BDCFE97BF05C3B87B7FE0D3BD7D1DE1AC6D9EA68B1B33D6AFB4DD6F0A76CF987A029E632601F09C55C8C46CFFF01B4D2638EC76D9BFE137DD8CB4DBEEF49BAF559B3660CB1F7F2FE7';
wwv_flow_imp.g_varchar2_table(51) := '37FEA78FC23C7192DFF23EF9DACB38F0FE6A393F771FC4DF24029E612601F08C53C8C43AD6AEDB6FE9D317E6A4241437FF4AA7665E82CC277EE7377F4FBEFA320E7CE07C4887DE301B7DFFA7F5082F5F0BD9F9D8C328DBEFBC662C63EC38549797C3DABC';
wwv_flow_imp.g_varchar2_table(52) := '359844C033BA24009E71D27D2CF1CE7FACBA0662DAAF25A4A4A521FD8A09B0555561C7679FC81F1B4C1198BEAC00CC4FA3E9275E7D09073FF8B79CF79059B3D1EF2EFF08006F6CC29A9C6CF0E6EBCCC6CCB81691E6041CDBF225CA4E9F76F9284E0B4E37';
wwv_flow_imp.g_varchar2_table(53) := 'D39840670D980440F78F76D70E74FAF05F3E1E4CDC00C4816DFF7E0FF66671B8F2993F227AF090AE33F62046A004A07EFF3E6C7AEC6167F73F220297CDFEAEFC7F2E711CFEB208E74A9D878E8A4022D07945910078D088F51CA5A387BF676A2F0C9A30D1';
wwv_flow_imp.g_varchar2_table(54) := 'F9F03787C34545385B7246FECBDB63BA3BE2142801703F863CA9771A064D68BD878044C0F3164B02E0392B5DC66CFFCE9F6449C5203110D7EEEEBFB24387707497F3C4DE7E132662C8C38FF9C55F7701183A6B36FAFAE915E0C0EF7E83935BB7C8360E1A';
wwv_flow_imp.g_varchar2_table(55) := '351A4919196DED95388A8BBEC0396BA9EB73314528CE0DA4D04A800420845BC399BA3A9437380FFB10A1478A457EF80D46C3B7BCAE3B771EBBD6AF953F8F4948C4E47F2EF50B9980F400248ECF6F5D80C63AE761A6A3A65F8D98EEDFBE1D58724838F4C5';
wwv_flow_imp.g_varchar2_table(56) := '465C282F77F9425B86DB562B09805F9AB9F63271DFE423ACEB9694842193AE84E122837B5FAF7E0F4DCDE30053FEF01CA206B5FB55F5C2CD40F4001A0E1EC0C6477E225B1319158DB137DCD0A96592DD81835F6C44E5D9B3AE38747828F500BC68CAFA49';
wwv_flow_imp.g_varchar2_table(57) := 'D22449D877A1CA75DD576C5C3C465C3303C62E46F64F6EDF8E33470ECB8E0E9F331769B7DEE1B3D381E8019CFAC7ABD8BF7A956C5B5AC660F41935EAA2763A1A9BB067ED1AD4D73A2F4031308661DD121061F8764FC86787759601F5007456619E98EB7E';
wwv_flow_imp.g_varchar2_table(58) := 'DBAF1821175DE4480FDE7D6BCBCF62F786F57211713D7A60E22B6F787D4B508B9D7EEF017060E36D3968A8715E6776C9D4E988EDD9A34B2C8D3535D8B9E633D782A79E5151E843C7878104A0CBA6A3AF08368703FBDDEEFA1B9879099287783EA5B7FD83';
wwv_flow_imp.g_varchar2_table(59) := '0F606B701E1032F9C967103362844F00FCDD03A8DFB31B9B7EE93CB938322A06636F98E5B17D65070EE0E89EDD727C0686A1DDCC883286F7EE4112008F9B8F3E22BA0FFC45C7C460D4CCEBC0147475CFECDA8993870EC9CE0E997523FADD758F4F8EFB5B';
wwv_flow_imp.g_varchar2_table(60) := '004EBCFC220E7EF4816C53BF2143D12B33D363FBC478C08E8F3F46A3CD2970342048178378DC78F412F1606515EA9B57C7A58F1801CBB0E18A4CAFAFA8C0CEB56B9CBFB0B1B198F2EA1B60D1DE9FB5EF4F01E00D0DD870D76DAED1FFD157CF4074623745';
wwv_flow_imp.g_varchar2_table(61) := 'FE95EEDD8BE3CDCB87638D460CEE96A0287DA845A61E4008D5A89D73ECA9B8E0F2E89269D311DBA3EBF7E3F608F6AEF90CD5179CF98CBDEB1EF49C75A3D794FC290067DF5F8DEDAFBD2CDB12DFAD1B465E3343B15DB567CF61F7E7EB5CE932BB27C2C85A';
wwv_flow_imp.g_varchar2_table(62) := '174429CE50E7094800745E81EEE6573735E188DB55DF57CC99DB66B59FA7AE569E3A85FD5B9CB7ED98935330FEC557BFB570C8D3BCFC2500DC2161F3E2BB5073D639A73F6CFC04744B4BF3D40C573C87DD81ADEFB59E7A34C86C467C44F8DE284C02A0B8';
wwv_flow_imp.g_varchar2_table(63) := '09693781FB55DF919151187BA377BFDC6229EDCEFF7C8486E68536E31F7E14E609DE6DE3F59700547DB1115B9E7D46861F13178751DFB9CEEB198AADEFAD72CD0684FB8DC22400DA7D9E155BE6BEF8C7DCAD9B3CF7EF6D3877F8308A776C979327670CC6';
wwv_flow_imp.g_varchar2_table(64) := 'E8DFFFC9ABACFC350DB8FD270FE26CF31A85C163C7A1C780015ED92312EDFEE413D4563BA711C37D51100980D7CD487B09CFD96C3855EB5C1EDBAD7B770C9B7EB5D7468A11F3ED1F7D80A6E6F30227FEEA097873A28F3F7A00355BBFC297BF7B42F62522';
wwv_flow_imp.g_varchar2_table(65) := '32126367DDE8D5AB4D0B8CFD6BD7A2B2E2BCFC67DFB858F4888AF29A93DE139200E8BD06DDECF7A700886CADFBF7E1D8DEBD4E41E9DD07973FFF7F8082294591CE5701E07607B6DC7F37AACBCA643BD2475E02CB50CFD7357454BD2400AD54480048003A';
wwv_flow_imp.g_varchar2_table(66) := '252006CC76B8F5022E5D7C3FBA5F3B5311315F05E0DC87EFE39B57FE2E9729D6FD8F9E391306936F8376240024008A1AB15E22FBBB0720FC3E7FEC280E7DFDB58C202ADE8CC92FBD068382FBF77C1100A9B6161BEFB9D335EF3FF4D2CB90D8BFBFCFD541';
wwv_flow_imp.g_varchar2_table(67) := '024002E07323D26206811000CEC5A0D97F5057532DBB3CE4FA1BD0EFFBF77AECBE2F0270ECC5BFA2F8938FE5B2E213123072C6B51E977BB188240024007E69485ACB241002207CAC292FC79E0D9FBBDC9DFCE4D3881931D223F7BD1580BA5D3BF1C5E33F';
wwv_flow_imp.g_varchar2_table(68) := '7795E1EDA2261A03B87835D1188047CD581F91022500C2FBE2A2229C6B3E322C2E2909E3FFF2378F5E05BC1100D1F52FBA7F31EA2B2B64F0C969691838BEF5C82F5F6B837A00D403F0B50D6932BDFB3A005FA701DB3B5879FA34F66FFED2F571C68CEF20';
wwv_flow_imp.g_varchar2_table(69) := 'FDBE07BAE4E0CD3A8023CF3F8723EB9CFB1144F076D55F67C69100900074D970F51821503D80EA9252ECFFB2081297DA6099B8E437881B35E6A2A894F6006AB66DC597BFFD759B3C8D4623865E3101E65EA97EA91612001200BF3424AD65120801B01E3C';
wwv_flow_imp.g_varchar2_table(70) := '8863BB7775E86AB4390113FFF43C8C3D7B768A428900D8CBCB50F4D00F61ABADED303FA5671B500FA0EB164A63005D33D24D0CBF0A80C471FCEB6D283D71DCE5BF38424BDCBE2BAE1613C78E89D073C0408C79EA0F6091911D72F2540078830D5FFFEC21';
wwv_flow_imp.g_varchar2_table(71) := '549C3C21E7D35159E2F35EE9E9E837669CD79B93441ED403A01E806E1E6A2586FA4B00C4197AC59B8BDA9CA61B6D3462A0395E7E306BED76145739A7054548BF720A321E725ED2D13E7824001C38F0F49338F9957307A208190966C4994CB2D0881D8E0D';
wwv_flow_imp.g_varchar2_table(72) := 'CD671C88EF129393913161128C5EEEE22301200150F25CE926AE3F0601ED75F5D8BBE173D7019AC2797384B8723BAECDBEF9D2FA7A58EB1B5C6C46E5DE8694B959171580CEEE05282D7C1BBB97E5B9D2A6C6C4C012D37A08898373B9D721B63BB7843873';
wwv_flow_imp.g_varchar2_table(73) := '02864DBE12A6D818C5F543024002A0B8D1E82181AF0220EE06D85FB4C9B50148F8DC232A127DE3E23A745FFC32BB3F9497FDE821244E9DDE266EDB59801BD1B7DD1163156B3EC5B6BFFEC59546888DE8697414DC0F3B15DF8B8D414204623BB813E062F5';
wwv_flow_imp.g_varchar2_table(74) := '45024002A087E759B18DBE088098E63BB06533B858FAD71C7AC5C420C5ED97B8BD41E297F95065356C92C3F555CA8891481A91096394734CA074F397282F769E3128B615A736CFE73B6C369CDDBD1B65FB9D9B8D4488328823BACC173DA1A7ACBE0125F5';
wwv_flow_imp.g_varchar2_table(75) := 'CE33FD44608C61E815E3151D0E42024002A0F8E1D243026F05C07DD75F8B9FA2CB9FD8C9C09E3B0BF16E7EB8AA06F67653844A799998011909F11E9DD2EB7EF0494B390346662265E8508F8A25012001F0A8A1E82D92D2414071F2CFD1AD5B507EEA94CB';
wwv_flow_imp.g_varchar2_table(76) := '55713EDE0073BC3C00E769100375C76A6A5167B77B9AA44D3C7138A7B8C25BC9451D6220F268750D442FA425A4F6EB8F7EE32EEDF2AC0012001200AF1AAAD61329E901381A1B71A8A80895E75AAFCC8A3418E4F76F6FCFCAAF6C6C924540F40AA4E607D3';
wwv_flow_imp.g_varchar2_table(77) := '2649AE2943F18047359F27206EE711330BB12613C4A59DDE047107821887686C9E92147924F64C42C6C449305E244F120012006FDA9BE6D378DA0310B7E4ECDFB811F575AD0B6E62C4345F8219263F9F902B4E281276891088DB7844EF43F4045A8E4217';
wwv_flow_imp.g_varchar2_table(78) := 'E5C488ABD0A65CD5E90C0109000980E61F666F0CF4A4075055528AE2AD5B5C97808A72129AA7F9C4AFB2BF83BB00244545212D00D77189DE867805719F91103304832FBF02668BE55B2E91009000F8BB9D6B22BFCE04C06EB3A1A9AE0ED6E262589B57DA';
wwv_flow_imp.g_varchar2_table(79) := 'B5181CA887B2257F3504A0A3B25A3EB3F4ED074B4606226263616A3EFB6FDF9A35A8BAE0DC694867023A46F45EBA725FA01BB0FF7F5A3AB0F8CCA2F9C38D92A3755E29D05E692C7FF757004F4CEB1D1B235F8F15C810E85780F6B6B79F26ECCA37120012';
wwv_flow_imp.g_varchar2_table(80) := '80AEDA886EBEEF687AAC23E3C5FBBEE88A2B19E9F71682FB5D856ADDC527660884F0B82F1FEECC7E4FA73BBDF55FEBE9683390D66B48817D6240EC4065559BA931F7E462BAAD7B541492A2D53B06BBA6C98EC3D5CE7D032DEBFB15B8E453D4F286065CB0';
wwv_flow_imp.g_varchar2_table(81) := '35A2CE6D1F817B8662EDC1D0C404BF0F7CFA64B4CA89490054061EE8E2C480589DBD75659E18D713D37B4AE6D8FD6DA3B8B350BC0306F30E3E218E62BAD06DD940585F09D652C7212500E5B7CE1F22391C07FCDD80293F2210B2044CC60CCB1B6F1F0EB4';
wwv_flow_imp.g_varchar2_table(82) := '7FAA0C025A6F9B3F08764771A09DA1FC8940A810901CF601BD96BF7B2CD0FEA82200250BE6A41B8CA6A3817686F22702A142C0EE68EA97B67CD5C940FBA38A009C5E70535F9331C279A40C05224004BA24606052EFE4BC774ABA8CE863045504A03C776E';
wwv_flow_imp.g_varchar2_table(83) := '2F891BCEF8682B2527026143801B1C96D4A52B9D172F0630A8220015B7CF496C6C3239977851200244A04B029111633994720000069849444154F6EEDDFFF9EE852E23FA18411501E0D9D9916591DCB9F384021120025D1248696451ACA0A0B1CB883E46';
wwv_flow_imp.g_varchar2_table(84) := '504500848DD6DCAC0670A8B7D2C54730949C08048D0083CD925718D8B5E0CDCEA927003959624AC3F72B6483562B543011508DC0714B7E61BA1AA5A92900E2FEAAF16A38456510013D13E00CEB53F30AA7A9E1839A02F02E809BD4708ACA20027A26C0C1';
wwv_flow_imp.g_varchar2_table(85) := 'DF4ECD5FB1400D1FD41380DCACA7C1F133359CA2328880AE09303C63C92B7C440D1F541380D285590BFE7B52F45B6A38456510013D13E01CB7A42E2B5CAE860FAA09C0D95BE60D731858C04F3851031A9541040249C028F1E1496FADD81FC8325AF2564D';
wwv_flow_imp.g_varchar2_table(86) := '00F8922586B243BBC51D5206351CA33288804E09D4A50CCE34B3254BDADEF91E206754130061BF35274BA89A67B74404C861CA9608689CC0664B7EE104B56C5455004A73E62D6760F3D5728ECA21023A24F09225BFF05EB5EC565500AC39F3EE05D88B6A';
wwv_flow_imp.g_varchar2_table(87) := '3947E51001FD11E08B2DF92BFEAE96DDAA0AC0B99CB97DEC30886DC1AA96AB164C2A8708F848801B1CA63EC9CB97ABB67356F507D19A93BD1DE0A37D0445C989400812603B2CF90563D4744C7D01A005416AD62F95A527022A2E006AC1A2BA0094E4664D';
wwv_flow_imp.g_varchar2_table(88) := '3370ACD553BD90AD44400D021CD2C4D4FC77C49E19D582EA02C0EFBE3BA2ACF6FC21DA19A85A1D5341FA207022E5F4D9416CDD3AEFEE72F7D247D50540D869CDCD5A028EC7BDB499921181D023C0F06B4B5EE112B51D0B8A009C5938B7BF9119C429C141';
wwv_flow_imp.g_varchar2_table(89) := '295F6DC8541E11E88280DD6160837A2F2D50FDE0DCA03D80D69CEC8F003E939A061120025865C92F9C130C0E4113001A0C0C467553995A2420314CEF9557B82E18B6054D00E4B100EA0504A3CEA94C4D11601F5BF20BAE0B9649C11580DC9B47831BB707';
wwv_flow_imp.g_varchar2_table(90) := 'CB792A9708049B00071B959A5FB02B58760455009CBD802C3A2A2C58B54FE5069B40D0DEFD5B1C0FBA0094E5666770CEBF01101FECDAA0F289808A046A61378EB6BC1DF81B802FE653D0054018579A93F520039E53113E154504824C40DD5D7F9D39AB09';
wwv_flow_imp.g_varchar2_table(91) := '01E0D9D9C6B228BE0E1C5706B956A87822A00201B6C9925FA089B6AE090110C4E955408576474568818026BAFE9A190370AF116BEEBC79E0EC5F746EA016DA29D910000212C0B22CF9052B0390B757596AA607D0627D594EF6231CFC29AFBCA1444440C3';
wwv_flow_imp.g_varchar2_table(92) := '0438F0E3D4FCC23F6BC944CD09803C28B830EB75C670879640912D44C017028CF3BFA42C5BF1A02F790422AD260540DE325C73FE7D305C1B08A7294F22A0328195298333B3D43AEA5B896F9A1400E1C099BB67C71A6BA3960298ABC4218A4B0434466095';
wwv_flow_imp.g_varchar2_table(93) := '23CEB6B0F7CBABEB3466976C8E66054018C701569E93F504077EA14578641311B818010E3C65C92FFC39939BB23683A605A005993537EB5670BC0EC0A84D8C6415116843A0111C775A9615E66B9D8B2E0440402C5D346F3C93D81B74B390D69B54D8DBB7';
wwv_flow_imp.g_varchar2_table(94) := 'CB60E077262F5DB1550F2474230002E6D1DB6F8F8EB5D73C028EC70044E80130D91836049AC0F1744A7C8FDFB0975F167760EA22E84A005A8896DF3A7F0897A46739E7B37541998C0C6502E2FD7E0563ECD194BC8262BD39AA4B01708D0DE4CC9D0C189F';
wwv_flow_imp.g_varchar2_table(95) := '01F864BD81277BF54F8001EBE0E00FA52C5F2176B3EA32E85A005A8897E6CC9DC0C0EE0363DF0347942E6B828CD60701061B804270E9454BFE3B9BF46174E756868400B4B877E6965B928CACE97618F8BDE06C90DE2B87ECD7148123005E724811AFF77E';
wwv_flow_imp.g_varchar2_table(96) := 'EBADB39AB2CC0763424A00DC395817CE9B09C6BECBC16733B0BE3E30A2A4614A80839F640CFF060C2B2D79059F8422869015803662907BF3682E196733C6AE05F8A500E242B132C9279F09D4026C1B18FF94496C75CAB282903FAF322C04A07DB3B02E9C';
wwv_flow_imp.g_varchar2_table(97) := '3B10308C0113B714337153717F0029007AFBDC8428033D1010D76F9701380EF01DE06C071CC61DC13E9E2B18E0C252002E069A3F707DD485EAA8982644441B9931C26877981A1D92C9C10C11064932198CDC04C948DC82D15ABB2AD3E0E09283D92583C1';
wwv_flow_imp.g_varchar2_table(98) := '6EE45253A4D16077988C7607773445A0A921D16CAB672F7C2806F1283413A0864C4D8108843101128030AE7C729D089000501B2002614C8004208C2B9F5C27022400D40688401813200108E3CA27D789000900B5012210C6044800C2B8F2C97522400240';
wwv_flow_imp.g_varchar2_table(99) := '6D8008843101128030AE7C729D089000501B2002614C8004208C2B9F5C27022400D40688401813200108E3CA27D789000900B5012210C6044800C2B8F2C975224002406D8008843101128030AE7C729D089000501B2002614C8004208C2B9F5C27022400';
wwv_flow_imp.g_varchar2_table(100) := 'D40688401813200108E3CA27D789000900B5012210C6044800C2B8F2C975224002406D8008843181FF07E8895EF19EDCFE7E0000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(54650446701823145827)
,p_file_name=>'icons/app-icon-256-rounded.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_512_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000200000002000806000000F478D4FA000000017352474200AECE1CE90000200049444154785EEDDD07781C67813EF0777B5F155B92AD625B927B8BEDB8C6761287D0EF282104484880400E482E24810412D2';
wwv_flow_imp.g_varchar2_table(2) := '0884743A1CE5802310CAD1E10E08218D14F7DEE4264BB26C59966559D2F6FE7FBE4DFC3FC7D1ECCC4ABB33B33BEFDCC3937B1ECF7CE5F78DBDEFCE7EF37DA613575D9E010F0A50800214A000050C2560620030D478B3B314A00005284081AC0003006F04';
wwv_flow_imp.g_varchar2_table(3) := '0A50800214A080010518000C38E8EC32052840010A50800180F700052840010A50C080020C00061C7476990214A0000528C000C07B800214A00005286040010600030E3ABB4C010A508002146000E03D40010A5080021430A000038001079D5DA6000528';
wwv_flow_imp.g_varchar2_table(4) := '40010A3000F01EA000052840010A18508001C08083CE2E53800214A000051800780F50800214A000050C28C00060C04167972940010A5080020C00BC072840010A5080020614600030E0A0B3CB14A000052840010600DE0314A00005284001030A300018';
wwv_flow_imp.g_varchar2_table(5) := '70D0D9650A50800214A0000300EF010A50800214A080010518000C38E8EC32052840010A50800180F700052840010A50C080020C00061C7476990214A0000528C000C07B800214A00005286040010600030E3ABB4C010A508002146000E03D40010A5080';
wwv_flow_imp.g_varchar2_table(6) := '021430A000038001079D5DA600052840010A3000F01EA000052840010A18508001C08083CE2E53800214A000051800780F50800214A000050C28C00060C04167972940010A5080020C00BC072840010A5080020614600030E0A0B3CB14A0000528400106';
wwv_flow_imp.g_varchar2_table(7) := '00DE0314A00005284001030A30001870D0D9650A50800214A0000300EF010A50800214A080010518000C38E8EC32052840010A50800180F700052840010A50C080020C00061C7476990214A0000528C000C07B800214A00005286040010600030E3ABB4C';
wwv_flow_imp.g_varchar2_table(8) := '010A508002146000E03D40010A5080021430A000038001079D5DA600052840010A3000F01EA000052840010A18508001C08083CE2E53800214A000051800780F50800214A000050C28C00060C04167972940010A5080020C00BC072840010A5080020614';
wwv_flow_imp.g_varchar2_table(9) := '600030E0A0B3CB14A000052840010600DE0314A00005284001030A30001870D0D9650A50800214A0000300EF010A50800214A080010518000C38E8EC32052840010A50800180F700052840010A50C080020C00061C7476990214A0000528C000C07B8002';
wwv_flow_imp.g_varchar2_table(10) := '14A00005286040010600030E3ABB4C010A508002146000E03D40010A5080021430A000038001079D5DA600052840010A3000F01EA000052840010A18508001C08083CE2E53800214A000051800780F50800214A000050C28C00060C04167972940010A50';
wwv_flow_imp.g_varchar2_table(11) := '80020C00BC072840010A5080020614600030E0A0B3CB14A000052840010600DE0314A00005284001030A30001870D0D9650A50800214A0000300EF010A50800214A080010518000C38E8EC32052840010A50800180F700052840010A50C080020C00061C';
wwv_flow_imp.g_varchar2_table(12) := '7476990214A0000528C000C07B800214A00005286040010600030E3ABB4C010A508002146000E03D40010A5080021430A000038001079D5DA600052840010A3000F01EA000052840010A18508001C08083CE2E53800214A000051800780F50800214A000';
wwv_flow_imp.g_varchar2_table(13) := '050C28C00060C04167972940010A5080020C00BC072840010A5080020614600030E0A0B3CB14A000052840010600DE0314A00005284001030A30001870D0D9650A50800214A0000300EF010A50800214A080010518000C38E8EC32052840010A50800180';
wwv_flow_imp.g_varchar2_table(14) := 'F700052840010A50C080020C00061C7476990214A0000528C000C07B800214A00005286040010600030E3ABB4C010A508002146000E03D40010A5080021430A000038001079D5DA600052840010A3000F01EA000052840010A18508001C08083CE2E5380';
wwv_flow_imp.g_varchar2_table(15) := '0214A000051800780F50800214A000050C28C00060C04167972940010A5080020C00BC072840010A5080020614600030E0A0B3CB14A000052840010600DE0314A00005284001030A30001870D0D9650A50800214A0000300EF010A50800214A080010518';
wwv_flow_imp.g_varchar2_table(16) := '000C38E8EC32052840010A50800180F700052840010A50C080020C00061C7476990214A0000528C000C07B800214A00005286040010600030E3ABB4C010A508002146000E03D40010A5080021430A000038001079D5DA600052840010A3000F01EA00005';
wwv_flow_imp.g_varchar2_table(17) := '2840010A18508001C08083CE2E53800214A000051800780F50800214A000050C28C00060C04167972940010A5080020C00BC072840010A5080020614600030E0A0B3CB14A000052840010600DE0314A00005284001030A30001870D0D9650A50800214A0';
wwv_flow_imp.g_varchar2_table(18) := '000300EF010A50800214A080010518000C38E8EC32052840010A50800180F700052840010A50C080020C00061C7476990214A0000528C000C07B800214A00005286040010600030E3ABB4C010A508002146000E03D40010A5080021430A000038001079D';
wwv_flow_imp.g_varchar2_table(19) := '5DA600052840010A3000F01EA000052840010A18508001C08083CE2E53800214A000051800780F50800214A000050C28C00060C04167972940010A5080020C00BC072840010A5080020614600030E0A0B3CB143823900160220705286048010600430E3B';
wwv_flow_imp.g_varchar2_table(20) := '3B6D648174268393D118828904D2002AED3654DAEDB099CD466661DF296038010600C30D393B6C6481483285CE6010F1B4F8E8FFBFC36E36638AD70B97D562641EF69D028612600030D470B3B34616188CC7713C1C79DD87FF1913ABC98C068F2BFB3480';
wwv_flow_imp.g_varchar2_table(21) := '07052850FE020C00E53FC6EC2105104824D0150C219511BFFA4B1FE2678006B71B15761BD52840813217600028F30166F72830108BE1583802F1DBBF92C304139A3C6E5439F824408917CFA140A90A300094EAC8B1DD145020D01F8DA1371291FDE67F6E';
wwv_flow_imp.g_varchar2_table(22) := '51669309754E276A5D4E05B5F0140A50A0140518004A71D4D8660AC80888EFFAFDD1287AC29131594D70B950C7103026435E4C01BD0A3000E87564D82E0A8C41A0271CCEBEEA578863BCC381068FBB1045B10C0A504047020C003A1A0C368502631510BF';
wwv_flow_imp.g_varchar2_table(23) := 'F3F746A238198D8EB5A8D75C3FCEE140234340414D591805B4166000D07A04583F050A28201EF92BFDF0B7BADC30C76388A7528A5A50E374A2DEED52742E4FA20005F42FC000A0FF31620B29202B207EF33F160AE3544CD963FFEAF135A83F7F31ACB118';
wwv_flow_imp.g_varchar2_table(24) := 'BAF7EFC3A9E33DB275881318021431F1240A9484000340490C131B49016901F1D8FF44248A3E858FFD2BC7D7A075E932589D8E6CA1F148145D9B3761E0649F22E65AA71313F9244091154FA2809E051800F43C3A6C1B056404F2FDE65F356102A62E5B01';
wwv_flow_imp.g_varchar2_table(25) := 'B3E5B5EBFEA75369B46F588F81DEE38ACCC59B01E20D011E14A040E90A300094EED8B1E5061710DFFC8F85C31888C515498C9B588F294B96C22AB1DE7F321AC5915D3B71B2BB5B5179D50E3B9A3C1E45E7F2240A50407F020C00FA1B13B68802B202E29B';
wwv_flow_imp.g_varchar2_table(26) := 'BF58D75FE9843FF1E1DFBC74192CE77CF33FB7A2642C8EAE6D5BD1DF734CB60DE204CE0950C4C49328A04B0106005D0E0B1B4581DC02F9CCF6AF696CC4E4C54B6051B8DD6F3A9D46E7C68D38A9300470B120DEAD14284D010680D21C37B6DAC002626DFF';
wwv_flow_imp.g_varchar2_table(27) := 'A3A10832905FDB7F7C4323A6880F7F996FFEAF7B12108FE3E8AE9D38D1D5252B2D960D9EE87261FCAB930A652FE00914A0802E04180074310C6C04059409885DFD3A0221651FFEF50D6859BA0C26B34959E1E79C958A277078EB160C2878122036106AF1';
wwv_flow_imp.g_varchar2_table(28) := '79E1B5594755172FA20005D417600050DF9C3552605402C389048E86C248A4D3B2D74F9C32050D0B162A7EEC2F5560269D41D7D62D387144FE4980D564C664AF8721407674780205F421C000A08F71602B28905320964AE1702088B8820FFF9AFA7A4C16';
wwv_flow_imp.g_varchar2_table(29) := '13FE14FEE62F479F4A24D1BD73074E7475CA9D0AB7C582495E0F1C168BECB93C810214D0568001405B7FD64E015901F18DFFD07040D1877F556D2DA65DB06AD48FFD259F04C4E338B0610306152C16E4B258D0EAF7C1621ADD4F0FB2203C810214288800';
wwv_flow_imp.g_varchar2_table(30) := '034041185908058A2390CA64D0190822984CCA56E0F35760DAEA0B6173D865CF1DCD0989581C079F7F16815048F6F24ABB5823C00D314190070528A04F0106007D8E0B5B4581ACC0916008A7E3F20BFD581C0ECCB9F062B87CDEA2CA85FB4FE1E0E68D88';
wwv_flow_imp.g_varchar2_table(31) := '86C3B2F58837036A5D4ED9F378020528A08D00038036EEAC9502B202FDD15876A53FB9C36C7360E6D225F0D5D5C99D5A903F0FF6F460DFA68D4829D845503C05A876BCB2E7000F0A50405F020C00FA1A0FB686025981A17802DDA110C44F00B90E93C984';
wwv_flow_imp.g_varchar2_table(32) := '694B96A2AAB15155B9535D5DD95704C572C439DB0713A6F97D70492C3FAC6AA359190528F01A010600DE1014D0998098F4D73E1C442C9D926D59EBC24518DFDC2C7B5E314E38D1D686CEB6BDB2458B3703A6F8BCB015E8AD04D90A79020528A048800140';
wwv_flow_imp.g_varchar2_table(33) := '11134FA2803A02E21BBF78DD2FAC60D25FC3D469689C371FD0689E9DF8EE7F74DB36F4741C96C5F1DB6CD910A0515365DBC713286044010600238E3AFBAC4B817C36F811EFFA4F59BA1CE651AEF2572800B150D0A18D1B14AD16C83D030AA5CE72285018';
wwv_flow_imp.g_varchar2_table(34) := '010680C238B2140A8C5940E9A43FFFF8F1982E16FA71EA63867D2A95C6C1975EC0D0A953B206CD3E2FC4D3001E14A080F6020C00DA8F015B40014453A9EC623F7293FE3C1E0F66AC5A0D9BC7A32BB564388CB6756B111E1ACAD92E8759CC07F0C0C99502';
wwv_flow_imp.g_varchar2_table(35) := '75357E6C8C310518008C39EEECB58E04C4A43FB1D84F58E6B53A9BC58A99175D0C7765858E5AFF7F4D099D3A85FDEBD721118BE56C9FD76ACDAE14C8830214D0568001405B7FD64E011C0B85D12FF3A1099309B3962C855FE5D7FDF21D9ED3C77B7160DD';
wwv_flow_imp.g_varchar2_table(36) := 'CBB297713E802C114FA040D10518008A4ECC0A28202D3010138BFD4464DFA7AF9F390B8DB3668B1CA0EB434C0AECDEB10DC73B3A72B6536C1F3CC9EB86583298070528A08D00038036EEAC9502D9CD7D0E0E0590CCE4DEDED75751917DF46FB65A4B422D';
wwv_flow_imp.g_varchar2_table(37) := '954CA2EDB9E7100A0CE76CAF980FD0EAE7FA002531A86C64590A300094E5B0B2537A1750BAC98FC566C3DC8B2E86D3EFD77B975ED3BEF0C069B4BDFC22928944CE7657D86D98E22DEEFE052505C7C652404501060015B1591505CE081C0F47D0178DE606';
wwv_flow_imp.g_varchar2_table(38) := '3199307DFE7C54B54E2D49B8535D477068CB26D9B64FF67AF85380AC124FA040E10518000A6FCA12299053209048A023104206B9D7D1AF6B6EC694858B4A56536C13D0B9611DFA7A7A72F6C16A32677F0AE0AB81253BD46C78890A300094E8C0B1D9A529';
wwv_flow_imp.g_varchar2_table(39) := '205EF93B381C80F86FAEC3E7F562FA9A37C06A2B8DDFFDA5FA928A27D0F6E23F1192591F40EC1730ADA2B47EE628CD3B90ADA6C0FF093000F06EA0808A023DE1304E4673BF272F26FBCD5CB91ABE71D52AB6AC78550D9F3881839B3622198FE7ACA4C1ED';
wwv_flow_imp.g_varchar2_table(40) := 'C67827B70E2EDE48B0640ABC568001807704055412105BFC7605E51FFD4F993D07753367AAD42A75AAE93D74085D3B77E4AC4CBC1AC8AD83D5190FD6420121C000C0FB80022A08A433191C180AC86EF13BBEBE012D4B96C26431ABD02AF5AA486580F6B5';
wwv_flow_imp.g_varchar2_table(41) := '2FE3F489DE9C958A7D0226793DB0E87DC103F5E85813058A26C00050345A164C815704C454BF1E05ABFD399D4ECC5C7D211CBEF25C2637118962EF8B2F221ACCBD3E409DCB09B152200F0A50A0B8020C00C5F565E914C0603C9E7DF49FFBF9B709B3965F';
wwv_flow_imp.g_varchar2_table(42) := '00FFC409652D367CF428F66DD98C4C8E7D0FC44F01332A7C7070C3A0B2BE17D839ED051800B41F03B6A08C05946EF433714A339A162D82CE57FA1DF34889A5828F6EDB8A9EAECE9C65F96C3688AD83CBDD63CCA02C80026310600018031E2FA5809C8092';
wwv_flow_imp.g_varchar2_table(43) := '59FF2EAF177356AD86C5ED962BAE2CFE3C110A63E7D34F2129B3FB618BCF0B110478508002C5116000288E2B4BA500A2A95476E29FDC823F33162E426573B3A1C4FA0F1D42BBCC5B012E8B052D7E1FAC9C1068A87B839D554F8001403D6BD664200131EB';
wwv_flow_imp.g_varchar2_table(44) := 'FF482804F1EA5FAEA3A6B616CD17AC84C95C5EB3FE65873A031C7CE19F1838D59FF3D46A871D4D1E8F6C713C810214C85F8001207F335E410159012513FFCC660BCEBB780DEC9515B2E595E30991BE3EECDDB05E76C3A0E97E3F5C564B3912B04F14D054';
wwv_flow_imp.g_varchar2_table(45) := '800140537E565E8E02E2DB7FFB70006199DFB81BA64C41E3A2F3CB9140719F8EEFD98D23FBF7E73CBFCA6E47A3C70D337F0A50ECCA1329A0448001408912CFA1401E024A76FAF379BC98B1DA3813FFA4F8C45E01BBFEF177C462B99747E68E8179DC803C';
wwv_flow_imp.g_varchar2_table(46) := '95020A0518001442F1340A281188A7D3D83F340CF11420D7317BF90AF8EAEB951459F6E70C767661FFD6CD39FB69379B31A3C2CFA700657F37B0836A0A3000A8A9CDBACA5A407CE41F57B0D94F4DDD0434AF5861BC897F12A32FD606E87AE9059CE8CF3D';
wwv_flow_imp.g_varchar2_table(47) := '2150AC0E285609E441010A14468001A0308E2C8502082692E80806737EFB17ABDC2DBCF452D8FCDCFAF6EC5B26D6DF8FDDEBD6E69C1028E600CCA9ACE05300FE5DA340810418000A04C962282026FE0593C99C108D2DAD6858B08058E70888A72727DBDA';
wwv_flow_imp.g_varchar2_table(48) := 'D0D1B637A70DF709E0AD4381C209300014CE9225195820944CA27D389873D11F4F45255A97AF80CB638C15FFF2B91D44008887C2687BF105C4C2D2FB26D8CC66347BBD7C2D301F5C9E4B0109010600DE1A142880C041F1DA9FCCB7FF09336660E2CC39B0';
wwv_flow_imp.g_varchar2_table(49) := '7081FB11C5D3E9348EEF6BC3F18307801C93286B9C0ED41B64D9E402DC9A2C820292020C00BC3928304601258BFE9CA9C262B1C0EE7022BBCB4DEE1705C6D8AAD2BA3C0D20198B2225B37682E895C524760BF4433C0DE041010A8C5E800160F476BC9202';
wwv_flow_imp.g_varchar2_table(50) := 'D9097F1D81A0EC6FFFA42AACC03887030D1E37770B2C2C2B4B3398000380C1069CDD2DACC0E9581CDDA1B0EC863F85AD95A589B729A657F8E0B4708960DE0D1418AD0003C068E5781D0580ECA23F62D73F1EEA0B88A7006289601E14A0C0E804180046E7';
wwv_flow_imp.g_varchar2_table(51) := 'C6AB2890DDE9AF3318A4844602622EC014AF175E9B55A316B05A0A94B6000340698F1F5BAF91402A93C1E1405076E6BF46CD334CB595763BC43E013C284081FC051800F237E3151480F8EDFF4848FA7D7512A9232056079CC93702D4C1662D6527C00050';
wwv_flow_imp.g_varchar2_table(52) := '7643CA0E155B40BCBD7768685876BB5F97C7039BC75BECE69475F9F17018D16020671FB9474059DF02EC5C110518008A88CBA2CB53209010BFFD8772AEF93FF5CD6FC594EB3E0998B9EACF58EE824C3C81F61FFF009D4F3D29598CD829B0D5EF83F82F0F';
wwv_flow_imp.g_varchar2_table(53) := '0A5040B9000380722B9E4981AC8078EF7F389190D4B07A3C587EC7DD70CE9E43B10208C43A3BB1E1AEDB11CFB144309F0214009A45184E8001C07043CE0E8F4520964A61DFD070CE22EACF5B805977DC0393DD3696AA78EDAB0299781C07BEFE18BAD7AF';
wwv_flow_imp.g_varchar2_table(54) := 'CBF91440AC0E28E604F0A00005940930002873E25914C80A1C0F47D0178D4A6A986D362CB9F116F856ADA6580105829B3662FD835FCA59A2581340AC0DC08302145026C000A0CC89675120BBE08FD8F12F99112BD78F7CF81A1AB1E44B0FC25C5949B102';
wwv_flow_imp.g_varchar2_table(55) := '0AA403016CBBE74E9CEEEA902C55AC0A38BDC2CFE5810BE8CEA2CA5B8001A0BCC797BD2BA0C0C968143DE18874892613E67EE0839870F91505AC95456505D2699CFCE3EFB1E389C773824CF3FBE0B6726120DE35145022C000A04489E75040BCFA371C40';
wwv_flow_imp.g_varchar2_table(56) := '28C796BFDEF1355874E7BDB04F9E4CAF2208A40606B0FED33721323C28597AADD389896E57116A679114283F010680F21B53F6A8080291640A8702819CAFFE4DBBE4524CFEF79B8A503B8B140299640A9DFFF95DB4FFE3EF92202E8B05537C5EBE12C85B';
wwv_flow_imp.g_varchar2_table(57) := '86020A0418001420F1140A1C0D85712A1693843059ADB8E0F377C3B56011B18A28103978002F7FEE33D2E300139A3C6E5439EC456C058BA6407908300094C738B217451448A4D3D95DFFC4FAFF5247EDCC5998FBF97B60F672E5BF220E05D29108DABE74';
wwv_flow_imp.g_varchar2_table(58) := '2F8EEF6B93ACC66FB3A1D9C77128E638B0ECF2106000288F71642F8A2830188FA32B987BDDFFC5377C0A956F7863115BC1A2B302196078ED8BD8F895472441B83F00EF150A2813600050E6C4B30C2C203EFC4508903A2A1B2761E15DF7C0525B676025F5';
wwv_flow_imp.g_varchar2_table(59) := 'BA2E5E095C7BD3F5880E4A4F06AC77BB50E374AAD728D644811214600028C1416393D51310B3FE4500103F03481DB32FBF02F5575EAD5EA38C5E533A839E5FFE0C7B7FF71B4909311950EC0F60E1CA8046BF5BD8FF1C020C00BC3D289043E044248ADE88';
wwv_flow_imp.g_varchar2_table(60) := 'F4BBFFAEAA6A2CBEE32E38A64EA3A38A02C913BD78F953372091907E3233DDEF87CB6A51B155AC8A02A525C000505AE3C5D6AA2C705066DBDF968B2F41CBA76E51B955AC0EA9340E3CF6108E6C90DE1F801B04F13EA1406E010600DE21149010108FFDDB';
wwv_flow_imp.g_varchar2_table(61) := '0687911133CF248EA5B7DD0EFF8A95A567984A2323163532996012DF924B702BDDC0E64DD8F0C01725ED3D566BF66D00FE0C507AB7275BAC8E0003803ACEACA504050662317487C2D21F300D4D5872E7DDB04E98A8EBDEA5070791E83E82A1ED5B113C76';
wwv_flow_imp.g_varchar2_table(62) := '0CF1441C89581CF15412994C060E9B0D76A71376BB03BEE66678A7CF80BD6932CC5555BAEE576A78182F7DE2A348486CCE64359931C9EB86CFC65D19753D906C9C66020C009AD1B3623D0BA4331974048208E658FAB7E9C28B31E366E9456934ED5F3A83';
wwv_flow_imp.g_varchar2_table(63) := 'C4F163E87FF1059CDCBE1503DDDD4846A4C3CCD96D35994CA899361DB54B9662DCB215B0353669DA15A9CAC5CA8007BEF628BAD7BD2CD9BE1AA703F56EB72EDBCF4651406B010600AD4780F5EB5220FEEAE23F2208481D0B3E7103C6BFE92DBA6BBF9820';
wwv_flow_imp.g_varchar2_table(64) := '77F29FCFA1FDC9BFE67C554E49C3DDB5756879E39B5073D11A58C6D728B944D573069E7E0A5BFFE35B92758A1D026754F8556D132BA340A908300094CA48B19DAA0A88657FC5F2BF5287D56AC58A871E83A3A555D576E5AC2C9D4660C776ECFAD10F10EE';
wwv_flow_imp.g_varchar2_table(65) := '3956D076791B9B30F3BDEF43E5EA8B0A5AEE580B4B9CE8C53FAFFF374022A89960C2CC4A3FF706182B34AF2F4B010680B21C56766AAC02728BFF4C5CB010B36EB90D669F6FAC5515E4FA4C348ADE27FF8ABD4F3C8E4C8E350BC65299C5E1C0ACF75F89BA';
wwv_flow_imp.g_varchar2_table(66) := 'B7BF0362EF033D1CE267800D9FBA1EC1DE1EC9E6347ADC18E770E8A1B96C03057425C000A0ABE16063F4202066FFB70F07114BA7249B33F7831FC284CB2ED74373910E85D0F1AB9FA3E32FFFA34A7B5ADEF62F68FEE08760D2C34A7B19A0FB173FC3FEDF';
wwv_flow_imp.g_varchar2_table(67) := 'FD5AB2EF95767B768320B144300F0A50E0FF041800783750E01C81D3B1388E86C339B7FEBDE08147E09E394B73BB4C2C868E9FFF1487FFF7CFAAB6A5F55FDE81E66BAF53B54EA9CAC2FBDAB0EECEDB91C98CBC5AA3780D709ADF0787858B02E962C0D808';
wwv_flow_imp.g_varchar2_table(68) := 'DD083000E86628D810BD08C83DFEAF6A69C5799FFB3CAC35B5DA36399DC189BFFF15BBFEF37BAAB743BC2930F79A8FA0EE9DEF56BDEE732B143B046EF8C447110A0424DB32C5EB45859DAF036A3E586C80AE04180074351C6C8C1E04DA068720DE02903A';
wwv_flow_imp.g_varchar2_table(69) := 'A6BDE5AD987CDDF580C64F94437B7663FD7D77BFB2A08F82C35D5383BA193351D1D8087B55352C2E57F6AA542482F8E9010C1D3D8ADEFDFB103979524169809813B0E4739F8777C12245E717EDA4740687BEFA083AD7BE2459055F072C9A3E0B2E610106';
wwv_flow_imp.g_varchar2_table(70) := '80121E3C36BDF0028A56FFBBE556F8359E0D9F1A18C0E62F7F11818E7659046F4D0D265FB00AFED6568859F1B90EB1EAE170FB2174BEFC3242FDF241C03FA5198BEF7F08668DDFB51F7CE1796CFEFA5724BB2656059CEAD7C7844DD901E3091450498001';
wwv_flow_imp.g_varchar2_table(71) := '40256856531A0243F1043A8341C9C63AABC761D97D5F86ADA141D30EF53DF957EC148FFE73AC53201A587FDE024C7EC3A5B21FFCE776460481AE679E46CF8EEDB2FD9CFF918FA1F65FDF297B5E314F480E0CE09F1FBF1699D4C813376D66335A7D5ECE03';
wwv_flow_imp.g_varchar2_table(72) := '28E620B0EC9213600028B92163838B29702C14467F2C265945FDD2659875CB676172D88BD98C9C65274FF661E37DF7C8BEEBDFB2622526ACB8604CEDEC5DF7320EAF5B9BB30C4775352E78F4EBB068B9747006D87AEB4D18E8383C625BC5938F468F0BD5';
wwv_flow_imp.g_varchar2_table(73) := '7C1D704CF7032F2E2F010680F21A4FF6660C02E277FFCE401011896F91A2E8791FBA56F3896F279F7A123BBEF79D9C3D6D5AB8104D6B2E1D83C6FF5DDAFDECD3E8DEBE2D675973AFBA1A13DE734541EA1B6D21C77FF573ECF9F5AF242F17AF034EF67A46';
wwv_flow_imp.g_varchar2_table(74) := '5B3CAFA340D909300094DD90B243A3150824C4E3FF90E4EB7FE275B20BBEFA4D38264F196D1563BE2E1D0862D7230FE0E49E5D926555D4D662CE073F34E6BACE2E60D7CF1E47E0649F6499D5CDAD58F495AF17B4CE7C0B8BB51FC2CB9FBB156989F51BEC';
wwv_flow_imp.g_varchar2_table(75) := '6633665656683D7733DF6EF17C0A144D8001A068B42CB8D404FAA3311C0B4B2FFF2B36C899FBB93B61A9AED6AC6BB18307B0E1C1FB111F3C2DD986F9EFBA0CDE022F511C387C08BBFEF807C93AC51B05AB1EF92A6C0D8D9AD9881510D75EFB2144860725';
wwv_flow_imp.g_varchar2_table(76) := 'DB30BBB202623E000F0A50006000E05D40815705E47EFF9FF6B6B763D2D51F8149C3DF91FBFFF6176CCFF1DEBFA7A616E75D5DD86FFF676E90ED3F7B1C6189A700268B05F3AFF9086AB49C0C9801767FF11EF4EE90FEB9422C08E4D6C932C6FC8B4701AD';
wwv_flow_imp.g_varchar2_table(77) := '051800B41E01D6AF1B81F6E140CEED7FF530DBFDF077BE81C3CF3C2D69D6BA6A35EA962E2F8A69EFC6F538FCD28B9265375FB406AD377DBA28752B2DB4FB899F62FF1F7E2BF976845812981301956AF2BC7217600028F71166FF1409886D7F0F0C0572AE';
wwv_flow_imp.g_varchar2_table(78) := 'FFBFFCCE7BE03D7F89A2F28A75D2BEAF3C82A32F4B7F082FFAC095704E2CCE2B8A919E63D8F6AB5F4876AD6ED66CCCFBF2C3C5EABAA272075E781EDBBFFD0DA4251647AA713A51EF7E6501241E1430BA000380D1EF00F63F2B104E26D111082129B19EBC';
wwv_flow_imp.g_varchar2_table(79) := '38E7C2AF7D1BF6C9933515DB75FF7D38B175B3641B965F7F03CC4E7751DA988E86B1FE3FA4DF3EA86C6CC4E26F7EB728752B2D3476EC18D6DF7A131212AF72FA6CB6ECC6409C07A05494E795B3000340398F2EFBA658404C00EC09472016C019E9B03A5D';
wwv_flow_imp.g_varchar2_table(80) := '58F5F56FC35AABDDFAFF62EBDB2DF7DE89C1B63D92FDBAE0D3B729EEF3684E5CFBD547252F738F1B8F15DFFD214C56ED36DD4947635877ED358844479ECC29DE0410AF02721EC068469FD7949B000340B98D28FB332A8123C1104EC7E392D7D6CE3B0F73';
wwv_flow_imp.g_varchar2_table(81) := '3FF35998FDFE51955F908BD2696CB9E74E9CDEBB5BB2B8159FBE35EF55FF94B64D84A3755F7D4CF27467551556FDF0A7DAEE919001B6DF743DFA8F764BB67392C7832A0D177252EACDF328506C010680620BB37CDD0B88DFFF0F0D07722E0034FD1DEF46';
wwv_flow_imp.g_varchar2_table(82) := 'D3073EA8E90A800272F7FDF7A137C74F00CB3E79032CAEE2FC04908C84B1F1BBFAFE094018B53FFC003A36AC93BCEFEA5C4E4C78752324DDDF9C6C20058A28C00050445C165D1A02A94C06620740F15FA963E1C76FC0B837BF45F30EEDFFCA23E8CE3109';
wwv_flow_imp.g_varchar2_table(83) := '70C1FB3F00777D71DEC50F1E3B8A9DFFFD4B498309B36663AEC6930045E34EFCF72FB1EBBFA5272B724540CD6F63528E0DB10000200049444154364027020C003A190836433B01B103E0DEC121C906984D262CFFE20370CF99AB5D235FADF9F077BE89C3';
wwv_flow_imp.g_varchar2_table(84) := 'CFFC43B21DC57C0DF0F8C675E878497ACBDD292B5662EA6DB76B6E1458F732367DE3AB484BFCA4237EFF17EB01F0A080D10518008C7E07B0FF082593D99F00A40EB104F0AA6F7D0FB6FA7ACDB5FA7EFF5BEC7CE271C976F86BEB30F783D714A59DBB9EF8';
wwv_flow_imp.g_varchar2_table(85) := '09027DD25B04CFBFF283A8BDFC7D45A93B9F4213BDBD78E9D33722158D8E7899C36CC18C4A3F9704CE0795E796A5000340590E2B3B958FC0603C8EAE6048F2125F4D2D163FF8A8A64B009F695C74D74EBC7CDFDD10CBDE4A1D0BDE7D19DCCDADF910C89E';
wwv_flow_imp.g_varchar2_table(86) := '1B3C7C083B732C056CB6DBB1EA4B0FC23E6DBA6C59C53E219348E0C5EB3E82F8F0C84F75C42B80D32BFCB09A4CC56E0ACBA780AE051800743D3C6C9C1A0227A3D1EC2B805247FD92659879E3CD307BBD6A3427671DE9C141EC7CF801F4EF6F937E0A5053';
wwv_flow_imp.g_varchar2_table(87) := '8BB9055C0E58CCFEDFF5D39F20D8DF2F5967D5A4C938FF6BDFD6F60D80B35AB7E5D39FC2E9CE8E11DB2B9EE84CF5FBE0B468F7BAA2E637121B4001702F00DE0414404F388C93D198A4C48C775F8EA6027EA08E95FCC41F7F8F5D3FFDAF9CC514723BE023';
wwv_flow_imp.g_varchar2_table(88) := 'CF3C8DA339D6D787C984D9EF7D1FEADF7FD558BB56B0EB0F3EF630BAD68E3C5F41CCE9108B0189C9803C286064013E0130F2E8B3EF5981CE601043F184A4C6A21B6F46F59A37E8462BD1D3830DF7DD8D688EED7945635B56ACC48415178CA9DDBD6B5FC2';
wwv_flow_imp.g_varchar2_table(89) := 'E1F5D2AFD489C2ED959558F9D56FC1525939A6BA0A79F189DFFE1ABB7FF1C4880B3B9960C2049713B52E6721AB6459142839010680921B3236B8900291640A474321845329C962573EF415B8A66BFFDBF6D90DECFDC3EFB0FB673F91A5A83F6F0126BFE1';
wwv_flow_imp.g_varchar2_table(90) := 'D2BC1707128FFD3B9F7E1AC7776ECF5D87F8F6FF9EF7A2FECAAB65DBA2E609C1CD9BB0E5AB8F20213111B0DA6147A3C7C389806A0E0AEBD29D000380EE86840D5253209048E068288CB8C4A43A8BD98C55DFFB216CE36BD46C966C5DA953A7B0F9BEBB11';
wwv_flow_imp.g_varchar2_table(91) := 'C8B1E2DD99427C35356859B51A1E851303C5843FB1EB5FAEDFFCCF94EDAD6FC0B2C7BE0E93535FDFA69327FBB0E1D69B11098CFC7687C76A45B3CF0B311F8007058C2AC00060D49167BFB302E20D8023C1B0E41E007E7F05CEFFDAB760A9AAD29DD8E03F';
wwv_flow_imp.g_varchar2_table(92) := '9EC4E61C2BF39DDBE0AABA0918377D3A7C0D0DB05555C3F2EA6A78A94804F18101047B8EE2D4C10338DD7B42515FCD7607CEFFE40DA8B8688DA2F3D53C49EC9BB0F113D72230303062B5E255C056BF979B02A93928AC4B77020C00BA1B1236484D01B109';
wwv_flow_imp.g_varchar2_table(93) := 'D0B1F0C81BC78876D4353661F6171FD0D5EFDB677C3289247A7EF933B4FDF1F76A9265EB32994C98F9AFEF44C3873EAA9B99FFE7226CBEFE3A0CF6F68E6823BEF9CFA8F03300A87EE7B0423D093000E86934D816D5057A23119C888CBC608C684CE3F419';
wwv_flow_imp.g_varchar2_table(94) := '987EC73D305768B809500E954C3C8EC33FF9313A9EFC8BAA768DCB5660E6ADB70316B3AAF5E653D9F69B6E407FF791112F1113016754F8E0E0AB80F990F2DC3213600028B3016577F21338160AA35F62EF785152F392A568FEF79B61F6E977E9D84C3C81';
wwv_flow_imp.g_varchar2_table(95) := '43DFFB36BA9E7F36BFCE8FE26CF1CD7FE2A2F331EBB63B60D2F96B74BB6FBF15BD07F64BF672BADF0F97865B178F829F9750A0A0020C0005E56461A526D01D0A612026BD0DF08CB7FD0B1ADE7F952E1601CA652B9E04F4FCEED7D8F7FBDF2293E38D86B1';
wwv_flow_imp.g_varchar2_table(96) := '8C8F9833305D3CF6BFE2038059BFDFFCCFF4B1EDBEBB716C87F45B0C623F00B12F000F0A18558001C0A823CF7E6705E4D60098FDAECB507FD58774FDA8FBECA13CFDFCB3D8FDD39F203678BA70236C32C155538739575E85CA0B2F2E5CB9452EE9D0A30F';
wwv_flow_imp.g_varchar2_table(97) := 'A173DDCB92B5B4F8BCF0D96C456E058BA7807E051800F43B366C990A02621320B11990D431FFCAAB517BF9152AB4A470558885827AFEF2671C7EE619A4E2D2F31B94D468F7F931E5C28BD070F9FB60A9A85072896ECEE9FAF63770F0D9A725DB33D9EBE1';
wwv_flow_imp.g_varchar2_table(98) := '6A80BA192D36440B0106002DD459A76E040E0C0D2392E391F9A28F7D1CD56FFB17DDB4379F8624BA3A71FC6F7FC1D10DEB118BC7B2DBE3CAFD3C60B25860B65AE1AE1E07B18850DD1BDF0C7B734B3ED5EAE6DCEE1F7C17FB9FFCAB647B1A3D6E8C733874';
wwv_flow_imp.g_varchar2_table(99) := 'D35E3684026A0B3000A82DCEFA7425B06F7018B1B4F42A804B3E750B2A2EBE44576DCEBB3119207AF81006B76FC5E9F6434804434884C388048660B6D9E170BB6177BB61F3785139751AAA172F85BDA929EF6AF476C1F19FFF147B7EF71BC9664D74B9B8';
wwv_flow_imp.g_varchar2_table(100) := '1CB0DE068DED5155800140556E56A63781FD43C388E67802B0FC739F8777D90ABD359BED5120D0F787DF61678EE592EB5C4E4C7875312405C5F1140A949D000340D90D293B948F805C005871D7BDF02C5A9C4F913C572702A7FEFE37EC7AE2712443A111';
wwv_flow_imp.g_varchar2_table(101) := '5B54E374A2DEEDD2496BD90C0AA82FC000A0BE396BD489400680980390EB09C0CA2F3F0CD7ACD93A69319B918FC0D04B2F60FB0FBE874470E4FD00C63B1C68F0B8F32992E752A0AC041800CA6A38D9997C044400D82F330760F557BE094773733EC5F25C';
wwv_flow_imp.g_varchar2_table(102) := '9D08440E1DC4C6FBBF80C4F0F0882D121300C544401E1430AA00038051479EFD86920070D177BE0FDBC47A6A95A040B4AB0B1BEEBD1389E1A1115B5F65B76392D753823D6393295018010680C238B2941214900D002613D6FCE0BF601937AE047BC72627';
wwv_flow_imp.g_varchar2_table(103) := 'FAFAB0EEF6CF203E3838224685DD86295E2FA1286058010600C30E3D3B2E1700C4BAF717330094EC8D921C1AC6DA4FDF88F8E991B704F6DB6C68F6310094EC00B3E1631660001833210B285501B90060B1D9B1FA3BDF8775FCF852EDA2A1DB9D8E44B1EE';
wwv_flow_imp.g_varchar2_table(104) := 'E67F47E4E489111DC432C06239601E1430AA00038051479EFD969D0360B1DA5E09003535D42A418154388CF5B77C2A6700104F004C25D83736990285106000288422CB284901B9D700F91340490EEBFF6F74727010EB6FBD19D181537C0250DA43C9D617';
wwv_flow_imp.g_varchar2_table(105) := '498001A048B02CB63404E41602127300F81340698CE5B9AD8CF7F662FD1DB7223E34F25B009C03509AE3CA56174E8001A070962CA90405E402C045DFFE3E6CF57C0DB0048716B1EE23587FF7E7255F03E45B00A538AA6C73210518000AA9C9B24A4E406E';
wwv_flow_imp.g_varchar2_table(106) := '37C0D58F7D1D8E96D692EB171B0C04776CC796AF3D2AB91050A5DD0EB125300F0A18558001C0A823CF7E6705E402C0CA2F3D08D79CB9D42A4181C1179EC78E1FFE407229E06A871D4D1E0680121C5A36B940020C0005826431A52970706818E11CBB01AE';
wwv_flow_imp.g_varchar2_table(107) := 'F8FC3DF02C5E529A9D3378AB4F3DF9176CFBC1F72415B814B0C16F10761F0C00BC090C2D7070388070322969B0F496DBE05F7DA1A18D4AB5F3277EF71BECFAF94F259BCFCD804A7564D9EE42093000144A92E594A440FB7000C11C0160F1F537A2F2D237';
wwv_flow_imp.g_varchar2_table(108) := '9564DF8CDEE89E9FFE047BFFF83B0600A3DF08ECBFA40003006F0E430B740482184E24240D167DF43A54BFFD1D86362AD5CE77FFF0FBD8FFD7FF956C7E9DCB89092E57A9768FEDA6C098051800C64CC8024A59E0483084D3F1B86417E6BFFF2AD45EF1FE';
wwv_flow_imp.g_varchar2_table(109) := '52EEA261DBDEF9ADAFE3D073CF48F6BFDEED428DD369581F769C020C00BC070C2D702C14467F2C266930FB1DEF46FD87AF35B451A976FEE0C30FA06BC33AC9E63779DCA876384AB57B6C3705C62CC0003066421650CA02272251F44622925D98FE8637A2';
wwv_flow_imp.g_varchar2_table(110) := 'F19A6B61E6A6312537CC6DF7DE8563BB7648B65B6C052C1603E24101A30A30001875E4D9EFACC0402C86EE5058FA4362E122B4DC7C2BCC3E1FC54A4C60E7AD37A3EF70BB64ABA7FA7DF058AD25D62B36970285136000289C254B2A4181C1781C5DC19064';
wwv_flow_imp.g_varchar2_table(111) := 'CBC7D7D562FEC35F83D9EF2FC1DE19B8C91960F3F51FC3E08991B7021632D3FD7EB8AC160323B1EB4617600030FA1D60F0FE071349B40702920A5E87138BC596C0D5D506972AADEEA743216CBCE1E3080E8FBC11900926CCA8F0C161610028AD91656B0B';
wwv_flow_imp.g_varchar2_table(112) := '29C00050484D9655720291640A870201A4336273E0D71F0EB305CBBEF91FB07343A0921ADB78670736DE7D07A2A1919FEE584C2200F861339B4BAA5F6C2C050A29C00050484D965572027D91288EE79804283AB4FCEEFBE05DB8A8E4FA66E406075E781E';
wwv_flow_imp.g_varchar2_table(113) := 'DBBEF71DC4A3514906BE0668E43B847D17020C00BC0F0C2B20960016BFFFC7D3E99C060B3F7E3DC6BDF9AD86752AC58EF7FDF209ECFEEDAF259FEC883ED9CD66347ADCF0D9F82640298E31DB3C76010680B11BB2841214082412E80C86727E409CE9D6EC';
wwv_flow_imp.g_varchar2_table(114) := 'CB2EC7C4F7BE1F26BE335E3223DDF1D8C3685FFB926C7BC54F01E27540AF8D6F03C862F184B213600028BB216587E40486E209F484C3B2DFFCCF943369D9724CBDFE26AE052007ABA33FDFFDB9CFA0F7E001452DB29ACC68F2BAE1E79300455E3CA97C04';
wwv_flow_imp.g_varchar2_table(115) := '1800CA672CD9130502E2B17F4720846426F763FFB38BF2575563F1635F87B9AA4A410D3C456B814C3A8D0DD75E8DE0F0B0E2A688C980933C1E3E09502CC613CB418001A01C46917D50242036FDE90E86F3FAF01705BBEC762CFFD6F760A9A951540F4FD2';
wwv_flow_imp.g_varchar2_table(116) := '5620353484976FF837C4C3D20B3C8DD44273F6E7000FE704683B7CAC5D4501060015B159957602E27DFFEE90FC84BF915A28BE1DAEFCE67FC05ADFA05D078A51733A03F17FA6327B152EDED589976FBF15A91C7B3C48718A89810D1EFE1C508CDB8D65EA';
wwv_flow_imp.g_varchar2_table(117) := '4F8001407F63C216155860348FFDCF6E829828B6FC8EBBE15ABCA4C02DD3A6B8E89EDDE8F9F31F71EA703BD22633C63737A3F13DEF8563FA0C6D1A54E05A03FF7C0E9BBEFB6DA473ECF298AB4A3127608ACFC365820B3C2E2C4E7F020C00FA1B13B6A880';
wwv_flow_imp.g_varchar2_table(118) := '02E2B1BFD8F14FEE55BF5C558A47C3E77FFC7A54BCE92D056C99364545F6ECC2867BEF46329D7A4D031C1E0F96DE792F1C336769D3B002D67AF289C7B1F34F7F4026F5DA3EE65385087D93F973403E643CB7040518004A70D0D86465024ADFF3972B4D2C';
wwv_flow_imp.g_varchar2_table(119) := '1B3BE79DEF46DD5557C354E29BC71CBCEF1E74EDD8366297A75D7229267DF246982CA5BD3A5EF7230F60FF7AE96D80E5C6FBCC9FF3E700A5523CAF540518004A75E4D8EE9C02A1EC6CFF2052124BFC9E7DB1F80DDC6632219EE31B63F3E2C568BEF1D3A5';
wwv_flow_imp.g_varchar2_table(120) := 'BD2B603A8D8D1FF9208625F63EA8993113733EFD59584B7CB2E3BE5B6EC4D1AE4EC9FBC3E6F620190E67E73FC81DE24940B3CFCB9F03E4A0F8E72529C0005092C3C646E712108FFD7B4211C4CE79CC3DD2352EA71B13172C40E6F4003A0F1C4046E2F540';
wwv_flow_imp.g_varchar2_table(121) := '8FC38925DFF80EACB5B5258B9F8927B0F163D720100C8ED807A7C78BA50F3C0C7BD3A492ED633A10C4F61BAEC380441F4DE29DFF050BE14925D1D97E081189BD02CE061073022679B96260C9DE146CB8A40003006F8EB212C8E7B1BFCDE5C28C45E7C35D';
wwv_flow_imp.g_varchar2_table(122) := '5B87543080BD1BD62322F1EEB89807B0E2AE7BE15A787EC97A6562316CBAEE23180E8EBCFBA1D5E1C48A071F8563CA9492ED6378F3266C7FEC21842526007ADD1E4C5D73091C361B0227FBD0BE65336239F60B38032136851221C05DE23F0195ECC0B2E1';
wwv_flow_imp.g_varchar2_table(123) := '45116000280A2B0BD542402CEF7B44E17BFE0E87033356AC84ABFAD5C57DD2691CDAB205A7BA8F48367DF1351F41E5BB2ED3A26B05A9D30801E0C48FFE137BFEFA3F924B3CD7D5D7A369D90A584CAF90460607D1F6E28B4824E2B2C6E24940B3CFC31020';
wwv_flow_imp.g_varchar2_table(124) := '2BC5134A458001A054468AEDCC29203EFC8F297DECEF76A375D97278CE59D9AFAFFD303A2426C889CA67AC5C8D868F5F0FB3D75B92A3618400B0EFD69B70F4F061C9F199367B0EAA67CE7CCD9F074F9EC4E12D9B1151B070907812203610E2DE0125F957';
wwv_flow_imp.g_varchar2_table(125) := '808D3E47800180B744C90BE4F39EBF9800366BE952B8AAAB5FD7EFC0E9D3D8FBDCB3921EE3FC1598FFC85760A9AD2B49B3720F009948041BAFFB3002393EC8E75FB012AE09135E377EC1BE3E1CDCB419F15844766CC5DB0162032197D5227B2E4FA0809E';
wwv_flow_imp.g_varchar2_table(126) := '051800F43C3A6C9BAC403EEFF93B5D2E4C5B7E01DC559523961B4F24B0E7C9BF41FC77A443FCFE7BFE17EE8763F61CD976E9F184720F00F13DBBB1EEDEBB909098FC69F7F9200280C5E319717822A707B17FED4B88295841908B05E9F10E679BF2156000';
wwv_flow_imp.g_varchar2_table(127) := 'C8578CE7EB4640BCEA27D6F65732DBDFE17263DA052BE1A9F04BB63F95CEA0E3C57FE2D4A953239E23FED13FEFDA8FA1EAEDFFAA1B837C1A52D60120030CFEF657D8F2CB5F48BEDE575DDF80A98B97C094E39B7B68E0340E6FDE84B0C444C9B3BD9D160B';
wwv_flow_imp.g_varchar2_table(128) := '1ADCFC39209F7B90E7EA4B8001405FE3C1D62814108FFD0F2B7CCF5FAC723773C93238CF4CF8CB5147EFAE5DE8CAB18DECF4356F40D3C73E0193CBA9B0A5FA39ADAC03403A83CE2FDE85433B774A824F9A3B0F13A74F971D90F0A953D8BF6913E2E190EC';
wwv_flow_imp.g_varchar2_table(129) := 'B92214B6FABD10618007054A4D8001A0D4468CED455EEFF97B3C685DB6029ECA0A4572A1DE5EEC59BF0E624BD9918E71E3C763FE971F29C99D01CB390064A2516CFFF8B53825B1C891788D73C6EA0BE11F3F5ED17D101D1EC6FE175F4054C1CF01DC4A58';
wwv_flow_imp.g_varchar2_table(130) := '11294FD2A10003800E07854D9216C8EB3D7FB7073357AE82DBA77CD67E2A9EC0F67F3C85642C3A6223C404B0150F3C025B096E9C53CE0120DED981F5B7DD22B99AA3D36AC39C37BD0956A7F2273741F173C0964D8848848AB36F10F1764093D7CD1503F9';
wwv_flow_imp.g_varchar2_table(131) := '8F574909300094D47019BBB1F9CCF677F9FC98BE74199C397EF397D2DCFBFCF3080C8C3C0F40EC0BB0FCDF3F05CF259796DC60946D00C800437FFD1F6CFAD10F24C7A4A2AA1A332FBA08C873EB63F173C0C1CD9B110D8DBC7AE2D9158A6583A7FA7DFC39';
wwv_flow_imp.g_varchar2_table(132) := 'A0E4FE6618B7C10C00C61DFB92EA792C95C291600861053BBC797C3EB42C5D0EF7283EFC05CA91EDDB71FC70BBA4CFBCB7BE1D75D77DA2A4FC4463CB3600A4D3E87EF401ECDFB041724C9AA6CF40FD9CB9C0AB0B00E53378A1C1411C5AB716D188FC2B82';
wwv_flow_imp.g_varchar2_table(133) := '6E8B5831D00307E704E443CC7335126000D0089ED52A17105BB6B40F072066FDCB1D0EF19EFFEA0BE1F0B8E54E95FCF3535D5D68DFB245723679D38C1998FA99DB6151F87BF2A81B52E00BCB350088DFFF77DDF06FE83B7D7A443193C98499CB57C03F71';
wwv_flow_imp.g_varchar2_table(134) := 'E2A845450868DFBC4972A9E8B30BAEB0DB30C9E3819877C083027A166000D0F3E8B06DD9FDDA8E86421888C92FD5EAF15560EAB26570FA7D63928B0C0C60FF4B2F22261138B2EB01DCF34538E6CE1B533D6A5F5CAE0120BEAF0D9BEFBE43F2E990D56EC7';
wwv_flow_imp.g_varchar2_table(135) := 'BC37BE1976877D4CE491530338B86D8BA2105065B7A3C9EB19CD038731B5911753201F0106807CB478AEEA02BD91084E44469E90777663DC3E3F5A972E1BF563FFB3CBCAC4E238B47103064EF649F677E1E55760DC9557ABEE31960ACB32006480BE9FFC';
wwv_flow_imp.g_varchar2_table(136) := '10BBFFF7CF92EBFF57545460DA2597FEFFF5FFC762183A3D88F6F5EB108984658B116B048C773A64CFE30914D04A8001402B79D62B2B30188FA32B28FF2EB6C3E3C3EC356B60B7DB64CB5474420638DED68623FBF64A9E3E79D66CB47CE673B08CB0A4B0';
wwv_flow_imp.g_varchar2_table(137) := 'A23A3438A91C0380E8D3AE4F7D027D27FBA5C76AEA344C983FBF60E2E215C17DEBD621263331504C18153B0856DAC7F6E4A1600D6741143847800180B7842E05C4A4BF03C301C96F75671AED727B306DE52AB8F278D54F4987C38343D8F5ECD392A77AEC';
wwv_flow_imp.g_varchar2_table(138) := '769C7FD717602FA19F01CA3100C4DBF662DDDD772021B16E83D96AC3FCE5CBE1A8AD5532EC8ACF51FA7680786D54BC1920D60AE04101BD093000E86D44D89EECEFFEC742619C925984C56CB562C692A5639ADC25C59D4E67D0F68FA71094F896275EF99A';
wwv_flow_imp.g_varchar2_table(139) := '7FD9E51877D535253362651700D2190C3CFE236CFD9F3F498E8158F867E605AB722EFF3BDA011CECEDC5C1F5EB9096081F67CA154F00C49B019C12385A695E572C01068062C9B2DC510B8895FEC4A3FF74464401E963DAD2A5A86E6C1A753D72179ED8B3';
wwv_flow_imp.g_varchar2_table(140) := '079DFBF7499E3669D62CB47EFA73B08C1B2757942EFEBCDC0280E84FDB2D37A2A7F7B8A4EF94397351376346D1FCFB3BBBD0BE75B36CF9E22980C76A953D8F2750404D01060035B5599722818343C3B2EFFB37CE9C858659B347F55EB7A24600880F0D63';
wwv_flow_imp.g_varchar2_table(141) := 'C7F3CF219D1AF9F543A7DD812577DE03C7BCC2FDBEACB46DA339AFDC0240AC6D0FB6DC73A7F4EC7F9319B32FB904AE0A65CB408FCA34031CD9B903BDED87725ECE570347A3CB6B8A2DC000506C61969F978092897FE3264C44CBF2E530ABF0BBEA9E679E';
wwv_flow_imp.g_varchar2_table(142) := '41706850B20FE75F7639AA3EF8A1BCFAA8D5C9651500D2699C7CFCC7D891E3F1FFB871E3D0BAFA42988A7C9FA493291CDAB411A78FF7E41CDA268F1BD50EBE15A0D5FDCF7A5F2FC000C0BB423702A94C0607868611CFF19BAAD5E5C1BC55AB602FF0A43F';
wwv_flow_imp.g_varchar2_table(143) := '2984E3FBF6E1C8DE3D9246CDB3E760CACD9F81657C8D6E1CA51A524E01402CFED376DB2DE8397654D27DEAC28518D7DCA2CAB888550277FFE329A4722C56252602CEACF0738120554684952811600050A2C473541138198DA2279C7BB9D5C973E763C2F4';
wwv_flow_imp.g_varchar2_table(144) := '69AAB4475412168B02AD5D8B783C36629D3EB71BE77DE673702E5CA45A9B465B51390580F8DE3DD874EF9D88482C0D6D11B3FFDFF826D855DCB6B9B7AD0D5D6DD2AF8E8A71E3DA00A3BD7B795D310418008AA1CA32F31688A652381C084ABECE250A747A';
wwv_flow_imp.g_varchar2_table(145) := '3C9873F125B08E7145B77C1A276678776CD8807E89C7BB62B9D7B96F792B6AAFFB643EC56A726ED90400F1F8FF67FF855D7FFE93E444D1AAF1359876E185AACEBC17DFFE77FCFDEF4848EC2429065D3C0598C6D70235B9FF59E9EB0518007857E842E078';
wwv_flow_imp.g_varchar2_table(146) := '3882BE68EE15FFA62F5D8EAAC606D5DB3BD0711807B76D93AC77D28C9968BDED0EDD2F0A542E0120130E63CF676F416F8FF46FEE53E7CDC7B869EA3D293A7373F4B51F42C78E1D39EFD1092E17EA547C32A1FA5F18565832020C00253354E5DDD0FD43C3';
wwv_flow_imp.g_varchar2_table(147) := '104F01A40E7F6515A6AFB9A420CBB9E62B190F85B1EDA9270189D7123D1E0F16DD721B1C8BCECFB76855CF2F970010DBBD0BEBEEBD0BC94C7A443FBBDB8DB92B57C1E61BDB9E10A3199C742C8E03EBD66248623B6951A6D76A45EB18F7AB184DDB780D05';
wwv_flow_imp.g_varchar2_table(148) := 'CE156000E03DA1B98058C56DEFE090643BC46E6E33162F414553F1DEF9CF85203EF70FBCF402064F9E1CF134B1E4EB9C356B30E1FA9B008B7E577CCB2492D8F4D16B301C0C8CD80FABC389150F3E0AC794299ADF13520DC82493E8FBD1F7B1EBEF4F4AB6';
wwv_flow_imp.g_varchar2_table(149) := 'B166D264B42C5EAC591F06BB8E60FF964D92F53BCC16B4F8BD10AB04F2A08096020C005AEAB3EEACC0503C81CE605052C359518979AB56C3ACE26FFFE73666A0AB0B07B7482FF8525D538BF977DC05EB9466DD8E6A261EC7A68F7DB8A40340AAEF04B6DD';
wwv_flow_imp.g_varchar2_table(150) := '74030673AC12396DC9325437356A360EC97802BBFFF177C424DA28E68D34BADDA8D2F07ED60C8715EB4A80014057C361BCC688B5FE8E87C338191D7996BD1099D8DC82490B176A8A23FE51DFF58FA710CF31C16BC9FBAF44C5151FD0B49D399F64C462D8';
wwv_flow_imp.g_varchar2_table(151) := '74DD474A3A000CFCEED7D8F6F32790C92E18FDFA432CCE34F39237C0E17669360EE289D1D12D1BD173A45BB20D62BB60B13C300F0A6829C000A0A53EEBCECEFAEF0C0473AEFC377DC9525469F4F8FFEC216ADFB01EFDC78E498E5A634B0BA6DFFD25982B';
wwv_flow_imp.g_varchar2_table(152) := 'FCBA1CD9529F03900E85B0FBCECFA2EFC81149DF89CDCD685AB008268D17DE0F1C3D8ABD9B364ACE1B118FFF675656A8FA96822E6F4A364A530106004DF95979289944FB7050F21B9DDD62C1AC4B2E8553A5857F728DC8604F0F0E6CDC808CC442450EBB';
wwv_flow_imp.g_varchar2_table(153) := '1D0B3EFC51F8DEF2365D0E6CA90780F00BCF63E337BE2639F94FA0CFBD680D3CE3AA35F74FC662D8F1F7279194581848CC1B995D5501ABD64945732936404B0106002DF55937E496FE15EF734F5DBE0266BB4D732DF13380780A3078B24FB22D53E6CE45';
wwv_flow_imp.g_varchar2_table(154) := 'EB5D5F844907ED3DB791A51C00D2A130BA1EFD32DA77EE94B4F7545763CEC56B74F3AD7ACFB3CF203828BD8CF474BF1F2EAB45F3FB9A0D30AE00038071C75E173DEF8FC6702C1C966CCBA499B33071E62CC0ACF133DD575B3870F4180E6E5C2FD95EA7DB';
wwv_flow_imp.g_varchar2_table(155) := '8D2537DF0AC7E225BAF03DBB11A51C00229B3662D3C35F965C265ABC29D2BA7011C6E9E80D868E8D1BD177547A1E408BCF0B9F4DFB60ABBB1B950D524D800140356A563492406F248213118905804C264C5BBA0CD50DEA2FFE23355AC9640A3B9E7A12C9';
wwv_flow_imp.g_varchar2_table(156) := '1C8B16CD5E7101EA6FBDA3A83B158EE66E2AD50020D6FD3FFEDD6F61EF8B2F4876DB3F6E3C66AE5C05938EBE51F7ECDD8BEE7D6D926D9EECF5A0D26E1FCD50F21A0A14448001A0208C2C64B402C74261F44BBC2E25BED5CD5CB91AFE5A7D6DB4D37BF010';
wwv_flow_imp.g_varchar2_table(157) := 'BA7649AFF656595189F99FBD0376B15DB18E8E520D00F1FDFBB0E5EE3B20E68B481DAD8B1663FC94C93AD2064E1C3880CEDDBB24DBD4E871631C7707D4D59819AD310C00461B719DF5B72B18CACE0318E910DBB8CEBE680DBC5595BA6A75329144DB334F';
wwv_flow_imp.g_varchar2_table(158) := '231C0E49B66BFE5BDFA6BBFD014A35009CFCE97F61D79FFE20B9EEBFCBE3C1AC8BD6C0E6D4D756BBFD1D1D68DFB655F21EA9753A3151C3D71575F5978A8DD1448001401376567A46A02310C47022211900E6BDE18D70E9E00D80731BD8B3670FBAF7EF93';
wwv_flow_imp.g_varchar2_table(159) := '1CC809132662E69DF7C0DAA0DD8234E736AE140340B2E71876DDFF059CEAED95B46E9E371FB51AACFB2FF7B778F0D831ECDF203D5FA4DA614793876B01C839F2CF8B27C000503C5B96AC40E0D07040F2D1AEC962C18237BF15769D7DB313DD8A0D0D63CF';
wwv_flow_imp.g_varchar2_table(160) := 'BA97919098C028767D5B201606BAFC7D0A14D439A5140340E0CF7FC0869FFC5812C862B363E15BDE0A8BCDAA0E621EB504FBFA7068F366C4A2236F712D26003679DCD91D027950400B0106002DD459675640ACE526024058E2B75D8BC50AF128DDAEC357';
wwv_flow_imp.g_varchar2_table(161) := 'EA44FB8FEFDB8F237B774B8E66FDA44998F5D05760723A7531E2A51600C4B2BF871E7D08DDED87A49FB434B760B2C6AB444A352E746A005D3BB62120F12AA0C76A859807E0B4F055405DFC0531602318000C38E87AE9723A9341BB580550220058ED76CC';
wwv_flow_imp.g_varchar2_table(162) := '134F0074F8ED4E188AC55EB6FEF52FC848EC1268359B71FE55D7C0F7EEF7E882BCD402C0F09FFF882D8FFF1829095FBBC38559AB56C1A9D3951763C301746CDB82A153A7461C7F97C5920D006EABFE9E5EE8E28665238A2EC00050746256202550EA0140';
wwv_flow_imp.g_varchar2_table(163) := 'F4AB63F366F41DE9927E0AD0D08019777E0196091334BF114A2900248F1DC5DE87EE475F8EA59727E8F8DBBF18EC543C91DD1A78F854FF88636F3199D0ECF3423C09E041012D041800B450679D5981720800A1A121B43DF72C5212CB038B9DDFE6FDEB3B';
wwv_flow_imp.g_varchar2_table(164) := '51F3E18F6A3EEAA514004EFDE267D8F1BBDF48CEFC179873565F086F8DBE5E113D7B90D3C9140EAC7D1943FDD2DB488BC580BC3A7DC2A5F90DCB06145D8001A0E8C4ACA09C9F0088790CED2FBC805312FFC88BBE57F82BB0F0DE2FC1DAACED56C1A51200';
wwv_flow_imp.g_varchar2_table(165) := '12870E62C7C35FC6A0C4A373615AD3D080E6254B215E15D5EBC100A0D79161BBCE083000F05ED04CA01C9E0008BCE0B11EECE1F7083100001BC649444154D9B04ED231BBF1CB9A4B30F1C69B35B31615974200C8C4E3E8FBD1F7B35B2FE73AE65E78313C';
wwv_flow_imp.g_varchar2_table(166) := 'E3C769EA29573903809C10FF5C6B010600AD47C0C0F5974B00C88847BD1B3760B0F7B8E468BA6D362CBEF74BB0CF9EA3D98897420088EEDC816D0F7E092189D521B34F54AAC761E64517EB6EA9E57307960140B35B9D152B1460005008C5D30A2F502E01';
wwv_flow_imp.g_varchar2_table(167) := '40C8844F9CC0AEB52F4BEEFF2ECE99BE681126DD755FE1211596A8F70090098771E45B5FC3C11C8BE7586D364C5FBE023E1DFFF67F6638180014DE983C4D33010600CDE85971390500A433E8DCBA052772BC11205EF75A78EBED702D5DA6C9E0EB3D0044';
wwv_flow_imp.g_varchar2_table(168) := 'D6AFC5E6AF3C8A584A7ACDFFC6D6A9A83FEF3CDD6CF99B6B20190034B9CD59691E020C007960F1D4C20A94550000100F87B1F7D9671093D8DB40E84D9E361DD31E7C4C93ED8DF51C00D243433878FF17722EFA63733A3177D56AD8FDFEC2DE88452A8D01';
wwv_flow_imp.g_varchar2_table(169) := 'A048B02CB660020C0005A36441F90A945B0010FDEFDFD786F6BD7B2529C46B81CB3EF9EFF05CFAA67CB9C67CBE9E0340F0D9A7B1F13BDF423A9396EC67CB8285A8696919B3835A053000A825CD7A462BC000305A395E376681720C00A9781C6D2FBC80D0';
wwv_flow_imp.g_varchar2_table(170) := 'F090A44F5D6D1DE67EEDDB30B9D45D2258AF01402CF9BBFFFE2FA0E7E85149337F652566AD7983EE27FE9DDD01068031FF13C1028A2CC000506460162F2D508E0140F476B8B717FBD6AE4526BBDBC1C8C7D20F5E03FF65EF55F5F6D06B0018F8CDAFB0E3';
wwv_flow_imp.g_varchar2_table(171) := 'BF7F29BD9892D98259CB97C3AB83D514F3193006807CB478AE16020C005AA8B3CEAC40B90600F1B9DFB575337ABBA49708AEF4B8B1F0D1AFC33261A26A77831E038058F467EBFDF72190E389C9C4C626342D5D5A1213FFF80440B5DB991515408001A000';
wwv_flow_imp.g_varchar2_table(172) := '882C627402651B0000444321ECF9C753484A2C112CC49AE7CE47EB17EE576D42A0DE02403A1446E7C3F7E3F0EE5D923790D8EE77FEC56B60F7794777936978159F006888CFAA150930002862E249C51028E70020BC7A77EE44D7A18392746285C0A51FFD';
wwv_flow_imp.g_varchar2_table(173) := '187C6F7F4731785F57A6DE02C0C06FFE1BDB7FF58B9C13FFA6CC9B87BA69D355F12974250C00851665798516600028B428CB532C50EE01201D8962EF4B2F2114909E1058E976E3BC2F3F02DBE4C98ADD467BA29E0240BC6D2FB63FFC0086733CFAF7BADD';
wwv_flow_imp.g_varchar2_table(174) := '9879C9A5B0D86DA3EDB2A6D7310068CACFCA150830002840E229C51128F70020D44E7775E1E0962D3927044E9D371F93EFFC024C45FEA0D34B00C844A33870DF5DE8DEBF5FFAC632993063F11254363515E7E653A1540600159059C598041800C6C4C78B';
wwv_flow_imp.g_varchar2_table(175) := 'C722608400904924D1B579134E1CEF91A412FBC22FBCE6C3A87CE76563E194BD562F01E0D42F9FC0B6DFFE3AE7B2C9131A1AD0B46429CC3ADEED4F0E9C01404E887FAEB5000380D62360E0FA8D1000C4F0F67774A07DDBD69C236DB758B0FC8147602FE2';
wwv_flow_imp.g_varchar2_table(176) := 'EFDD7A0800B1DDBBB0FDD107110804727A4C3BEF3C54B74E2DE9BF1D0C00253D7C86683C03802186599F9D344C0038D28DF6CD1B650761D2ECD998F6F97B6172BB65CF1DCD095A07804C248A7D777D0EC73A0ECB36BFD456FD1BA9430C00B2C3CC133416';
wwv_flow_imp.g_varchar2_table(177) := '6000D078008C5C7DB90780740638D6B6173DFBF7E57CDC7DE61E10CB049F77F58730EE9DEF29CA8A775A0780BEC77F8CDDFFF327A473BC1A79C6C26432A17EFA0C34CC9A0D93D954927F4D18004A72D80CD5680600430DB7BE3A5BCE0120954AE3C88EED';
wwv_flow_imp.g_varchar2_table(178) := 'E8EBEA54F4E17F66645C562B967CE941D867CC2CF860691900627BF760E3FDF721168D28EF97C984BA965634CD9A5D926F023000281F6A9EA98D00038036EEACB58C57024C269238B47103864EF48E6A9C9BE6CEC3B4DB3E0F738117BFD12A008847FFBB';
wwv_flow_imp.g_varchar2_table(179) := '6EBB197D3DC746E5513161225ACF5F0C9BC33EAAEBB5BA8801402B79D6AB54800140A914CF2BB840393E01089D1EC4A1CD9B100D0C8FC96BDE15EF47DD1557167495404D02403A83633FFA3EDAFEF6973179B82B2AD0BA7829DC15A5B115B0E82C03C098';
wwv_flow_imp.g_varchar2_table(180) := '869C17AB20C000A00232AB1859A0DC024070600007376E443C1C1AF3908B570317DF722B7CAB2E1C7359670AD022000C3FF5376CFDE10F904C26C7DC0FBBDB8DD645E7C35F5B3BE6B2D4288001400D65D63116010680B1E8F1DA3109945300E8EF3E8AC3';
wwv_flow_imp.g_varchar2_table(181) := '5B3723934A8DC9E4EC8B9D3E3F167FF67638E7CC2B48996A0780D88103D874DF5D8846F2F8DD5FA6A7668B15CD8B97607C437D414C8A5908034031755976210418000AA1C8324625500E01209301FAF6B7A16BDF3E6414CC6E1750E31C0ED8CC66445249';
wwv_flow_imp.g_varchar2_table(182) := '0CC51339ED6A264FC1ECDBEE80AD7EEC1F786A0680D4E02076DEFE199CEAEBCBD93FABC98CF14E0762A9144EC7E38AEE23B18742D3EC39A89D3E1D161DBF21C000A06838799286020C001AE21BBDEA520F00E94412DD7BF7E0C4E1766444129039C40757';
wwv_flow_imp.g_varchar2_table(183) := '8DD381896E57F6CC443A8D0343012433E99C57B6AE5C8DC9FFF649987D3EB92A72FEB95A01404CFA3BF0D017D1BD4B7A973FD15011825A7C5E382D96ECD6D07DD1284E44A28AFB3871EA34D4CF9E0DABD5AAF81A354F640050539B758D46800160346ABC';
wwv_flow_imp.g_varchar2_table(184) := 'A62002A51C00629128BA766CC7698533DBC53BFE4D1E372AEDAF9DC93E188FA33B14CE7E004A1D2238CCB9EC72D4BDFF4A98C6F061A74A0048A5D1F393FFC4DEBFFCAFEC3D32C5EB45C539FB1F28F138BBE0CA89F56859BC04369BFE42000380EC2DC013';
wwv_flow_imp.g_varchar2_table(185) := '34166000D078008C5C7DA90680483088C31BD6233824BDCBDFD9E36A379BD1E871C3671B7957BBE3E148F6DB6FAE23BB75F0CD9F81EFC28B467DCB143D006480C1E79EC696EF7C0B1999A71A354E27EA5F7D12726E878613097405433943D1D9D778AAAA';
wwv_flow_imp.g_varchar2_table(186) := 'D1B26811C49B027A3A1800F4341A6CCB48020C00BC2F341328C50030DCDF8F03EBD723158F2972138FB7A7783D70582C92E78BEFFE1D81200289DCF3015C7E3FCEBFF57638E78E6E5260B10340B46D2F367CF11E2462B96DDC160BA656F8916B7D3F3127';
wwv_flow_imp.g_varchar2_table(187) := 'A02310422CAD6C52A5DDE7C3D4F316C0A7A33704180014FD15E1491A0A300068886FF4AA4B2D009C3CD683CE4D1B9156F8A124BEF14FF67A205EE9933BC47C80F6E1A0EC075E556313CEFBECE7616D6C942BF2757F5ECC00903A7D1A9B6FBB0581815339';
wwv_flow_imp.g_varchar2_table(188) := 'DB2526FD35FB3C702BF82943981C0B8765274A9EA9D06CB365170CAA2EC084C9BC7147B88001A0108A2CA398020C00C5D465D939054A2500889FE78F1FD89F9DF0070593FD44A7C56FDB93BDDE9CDF72CFC551FAFBF7A4A5CB30F5939F8239CF45718A15';
wwv_flow_imp.g_varchar2_table(189) := '00D2E1300E3C743F8EEECE3DE94FF4573CF6178FFF951EA94C06C74261C56F08C06442CBDC79A899364D6915453B8F01A068B42CB840020C0005826431F90B944200488999FE6D7B71E2D041C51D9CE872A1D6A5FC43EEEC82FB22511C57F0DEFCAC77BC';
wwv_flow_imp.g_varchar2_table(190) := '0BF5575E0DD339930A733532138F63D3C73E8CE1E0C85BF15A1D4EAC78F05138A64C51DC5751E6B1271EC7BEFFFDB3EC35E2F54731176234C7C96814C7C3516420FFB6850801139A9BD138FF3C58CCE6D15457906B18000AC2C8428A28C00050445C169D';
wwv_flow_imp.g_varchar2_table(191) := '5B40EF0120118FA363FB369C3E7A54D1508AC7DB13DCCEEC7BFEA33D84496730243B1F404C0A9C7DC5FB30E15DEF8149E137EA4C22898D1FBD06811C01E082871E857DB2B200908944D0F7A7DF63F76F7E2D3BE9CF63B5A2D5EFCBEB89C8484F488E8522';
wwv_flow_imp.g_varchar2_table(192) := 'B2AF4D9EB96E5CD3244C5AB010768DDE10600018EDDF025EA7960003805AD2ACE775027A0E00D1601007D6AF436458D99AFEE2C3BFC9EB865F62A67F3EC39FCC6470606838BB4E80DCD17CC12A4CBEEA6A58EB26CAEE1B9049A6B0F69A2B118986472C56';
wwv_flow_imp.g_varchar2_table(193) := '3C0158F9E857616B6C92496E69A48686D0F19FDF45E7FA75724D84C36CC9FEEE9F6B22A46C21AF9E104C24713414969D2B71A63C6F4515A62E5B0687D7A3B48A829DC70050304A16542401068022C1B2587901BD0680A11327D0B1633B62C1A07C270088';
wwv_flow_imp.g_varchar2_table(194) := '6FB793BC1E88D7FD0A75880FBA8E6050D1AB700E9F0F2D6F791B3C539AE198580F5B55F56B5625145310C583738BBF02CFBDF75D928FD1C524BA650F7F15CE9A1AA4CF59952F934C20393C8C58EF710C1F3C80AE7F3E87B882D720C5930AB1D88FB780DF';
wwv_flow_imp.g_varchar2_table(195) := 'C2E5EE9B73C7C0E1F164D70AF08F1B57A8E151540E038022269EA4A100038086F846AF5AEE1F72ABDD8E796F7EAB6A8F70C587E4604F4FF6B17F42E6BDFC33635765B76757F613ABDA15FA1888C5B28B048DEA18E9CD03851318B3F59D7B7D3ED79ED5E0';
wwv_flow_imp.g_varchar2_table(196) := 'B1CC87C8D56F3139B03B1452FC8680D56643F3F94B50553F714C3F43E433160C00F968F15C2D041800B450679D59013D0500F1E17FE2C001742998C97E66F8C46FFD0D1E77513F503A8341C51F727ABBADC4AA87E235C8621EE20D817E997507FE7FFD26';
wwv_flow_imp.g_varchar2_table(197) := '1326CF9D87BA69D38A3A6667EA630028E6C8B3EC42083000144291658C4A402F012099CEE0C8B6AD38D9D5A9A81FE2B1F624EFEB97F55574719E2789F90047F3F8A69B67F1453B5DAC8120963E2EC69391731B2DF60FE855F0E6C42B0F364CA86E6E41EB';
wwv_flow_imp.g_varchar2_table(198) := 'BC7930E5589CA910300C0085506419C514600028A62ECBCE29A08700104FA47064CB269C1AE39AFEC51CEA783A9D9DF826B7526031DB904FD962911FB1FAA11A1FFE67DA2502403E1B09554F9A8C96F9F361C9E335CA7C0CB24FB892291C58FB3286FA4F';
wwv_flow_imp.g_varchar2_table(199) := '8E786931E647E4DB469E6F6C010600638FBFA6BDD73A008835FD0FAE5F8FC8B0B235FDC58A7ECD3E6F76D29FDA87B03A52024F02C49C08F1B38892D50F0B6D184A2671241882084C4A0E77651566AC5801BBEB95DD190B7D3000145A94E5155A8001A0D0';
wwv_flow_imp.g_varchar2_table(200) := 'A22C4FB180960160F8E449B46FDB86B8C43BF1E77642ACE93FC9E381CB2ABDA6BFE28E8FF244E1752A16CB7ED31593E0F47488D720C556C7E39D0E889D0FB53AA2A9147AC211C54F4B1C4E17A62F5B0EF7B8EA82379901A0E0A42CB0C0020C0005066571';
wwv_flow_imp.g_varchar2_table(201) := 'CA05B40A0003C77BD1B1750B9231657BCF8B77FBC56B7E5A7CAB1D4953BC22783C1C4638A56CA31CE52332BA33C51391092E57415FF51B5D4B5EB94AAC9F20DE9E50FA9389C5EEC4D4C5E7A372C284B154FBBA6B19000ACAC9C28A20C00050045416A94C';
wwv_flow_imp.g_varchar2_table(202) := '408B00D0DB7E084776EE4446E137E85AA713752EA7A6DF6AA534C5B7DD703289483285482A85582A9D7D32A068B95C6543F49AB3C46FD656B309E26988C36CCE3E0D111FFE8558E06714CDC97989783ED2AB609BE5B30B99B260216A9B5B5EF706E468DB';
wwv_flow_imp.g_varchar2_table(203) := 'C600305A395EA7960003805AD2ACE7F5DF903219B40782D90FB1918E42AE0320FE313EB67B178E771C56F4E12F1E638B0F7FB1A6BF760FB495DD342248890FFEB3FF7776BE114F2ED2C860389EC0402C9E33208C773830CEE9C87E8B4E9FF52B8378AA6F';
wwv_flow_imp.g_varchar2_table(204) := '7E350088F2C4FFB47CD4AF4446345FACA520960F561A8A1A66CCC0841933612DC03C0F060025A3C473B4146000D052DFE075ABF50420198BA17DC7760C2A5CD35F7CB835B8DDA872D8CB6A84C487FAE14010E2C9C14887F8409F59E15775F6BE1AC04A77';
wwv_flow_imp.g_varchar2_table(205) := '593CD39671539A3165EE3C58EDB631358F01604C7CBC5805010600159059C5C8026A048070388CCE0D1B11389D7B9FFA332D14EBD68BC56BB49CEC57ACFB453C21100140EA898B0800D3FCBEEC23FE723BC4CF24625125A56F0878C78D47EBD265708E72';
wwv_flow_imp.g_varchar2_table(206) := '5747E1C700506E7751F9F58701A0FCC6B4647A54CC00201EFF06FBFBD1BE613D620A578AF35AAD682AF09AFE7A1A0CE12D0280785D4EEA0940ABCF0BF11E7F391EB1540A5DC15076BE8492C3E5F363F2FCF9A8A8AB5372FAEBCE610018151B2F52518001';
wwv_flow_imp.g_varchar2_table(207) := '40456C56F55A81620580543A8DBEEE2338BA7327D28984227631D35FBCE35FCE87D10380185BB9A720E78EBFD9EE40E38C19A86B6985D992DF7E0F0C00E5FCB7A93CFAC600501EE35892BD900D00361BCE7BEBDB144FC84A6580E0E06974EFDC89D0A97E';
wwv_flow_imp.g_varchar2_table(208) := 'C526354E27EADDC5590C46712354389101E01564B1BC727730846185E1505CE3ABA945C39CB9F05655C1A27056683291C4C1B52F6358E25EE44A802ADCF4AC22A70003006F10CD04E40280C56CC679FFF20ED86416DF11B3D5C34383E83D7000A78E76E7';
wwv_flow_imp.g_varchar2_table(209) := 'D51FF1C12F0280110E0680D78EB25850A92F1A55B4E5B2B8D264B5627C6313EAA64E83DBEF937D3B241A8EE0F0FAB5080C0E8E787B310018E16F9DBEFBC800A0EFF129EBD6C90500F10FE4D4A54BE1AFA880F8FF4DD95DED8144328568228E482894FD5F';
wwv_flow_imp.g_varchar2_table(210) := '281C46A4FF24D20AB7F015658875EA1B3D6E8847FF463918005E3FD2E22980583E389F9515AD6E371C1595F0F82BE0F1BAE170B8E0763A60B1DA804C1A305B90B1D970BAB30347F6EF472211670030CA5FB212EB270340890D583935572E0088BE9A4D66';
wwv_flow_imp.g_varchar2_table(211) := '386D569C99972EAE49A452D9C7B8E2FF1FCDE1B65850EF716BB2A6FF68DA5BA86B18004696149322C5B6C24A27079E5B8A787BC26A32C166B5E2CC2C01611D492673DEA37C0250A83B9BE58C56800160B472BC6ECC024A02C0982B39A7002D76AA2B741F';
wwv_flow_imp.g_varchar2_table(212) := '465B1E0380B49C7843403C09507379650680D1DEC9BCAE50020C0085926439790BA81900CEACEC2736ACD1FB0A7679432ABC8001203794F011F302FA63B1513F5D523814D9D31800F2D1E2B9C510600028862ACB5424201EE01F1A1A2EFAB72EB1B08D58';
wwv_flow_imp.g_varchar2_table(213) := 'D9CF6B2BCFF7DB156103D91914EDC301C97500C48E7E2D3E6F592E82A4D4489C27560EEC0D47114B2B5B2F209FB2CF3E577837FB3C65BBEEC2685D789D7A020C00EA59B3A673048A1D00C4372CF18D5FAF9BF96871431CCA11005C160BA6F8BCB09BF37B';
wwv_flow_imp.g_varchar2_table(214) := 'DF5D8B7E14BB4E31C7A42F12417F34F7DE09636987D84849EC3249EFB128F2DAB10830008C458FD78E5940FCEE7A3A3EF22CE9D1162E66F88F73BCB237BD5EB6F01D6D5F0A7D9D580E77283EF2E248D50E3B1A3D1ED9D7DB0ADD263D9727F64FE88B4431';
wwv_flow_imp.g_varchar2_table(215) := '184F202966F817F010DEE2C994517F922A20258B1AA50003C028E178596104C487D1915068CCBFB98A6FFB0E8B193E9B0D5576BBE11F634B8D8E78BC2D96C33DF7101F42537D3EBA49C08937054EC7E2D9C58392E9C26CB9DCEAF319FE67A9C2FC2BC252';
wwv_flow_imp.g_varchar2_table(216) := '462BC000305A395E573001110286E271849329459BB5984DC87EB3178F4EC5EFFB7ADE97BE6048052C488480402281682A8D543A93F5134F4C8C3E474209B1F8D92A9E4A21984C426C30247656144F09C44F06726FA58A2D956D2673D65BEC3469A43528';
wwv_flow_imp.g_varchar2_table(217) := '94D8F21CF5051800D437678D14A00005284001CD051800341F0236800214A0000528A0BE000380FAE6AC910214A0000528A0B9000380E643C00650800214A00005D417600050DF9C3552800214A0000534176000D07C08D8000A50800214A080FA020C00';
wwv_flow_imp.g_varchar2_table(218) := 'EA9BB3460A50800214A080E6020C009A0F011B40010A50800214505F8001407D73D648010A50800214D05C800140F32160032840010A508002EA0B3000A86FCE1A2940010A5080029A0B3000683E046C00052840010A50407D010600F5CD592305284001';
wwv_flow_imp.g_varchar2_table(219) := '0A504073010600CD87800DA000052840010AA82FC000A0BE396BA400052840010A682EC000A0F910B00114A00005284001F5051800D437678D14A00005284001CD051800341F0236800214A0000528A0BE000380FAE6AC910214A0000528A0B9000380E6';
wwv_flow_imp.g_varchar2_table(220) := '43C00650800214A00005D417600050DF9C3552800214A0000534176000D07C08D8000A50800214A080FA020C00EA9BB3460A50800214A080E6020C009A0F011B40010A50800214505F8001407D73D648010A50800214D05C800140F32160032840010A50';
wwv_flow_imp.g_varchar2_table(221) := '8002EA0B3000A86FCE1A2940010A5080029A0B3000683E046C00052840010A50407D010600F5CD5923052840010A504073010600CD87800DA000052840010AA82FC000A0BE396BA400052840010A682EC000A0F910B00114A00005284001F5051800D437';
wwv_flow_imp.g_varchar2_table(222) := '678D14A00005284001CD051800341F0236800214A0000528A0BE000380FAE6AC910214A0000528A0B9000380E643C00650800214A00005D417600050DF9C3552800214A0000534176000D07C08D8000A50800214A080FA020C00EA9BB3460A50800214A0';
wwv_flow_imp.g_varchar2_table(223) := '80E6020C009A0F011B40010A50800214505F8001407D73D648010A50800214D05C800140F32160032840010A508002EA0B3000A86FCE1A2940010A5080029A0B3000683E046C00052840010A50407D010600F5CD5923052840010A504073010600CD8780';
wwv_flow_imp.g_varchar2_table(224) := '0DA000052840010AA82FC000A0BE396BA400052840010A682EC000A0F910B00114A00005284001F5051800D437678D14A00005284001CD051800341F0236800214A0000528A0BE000380FAE6AC910214A0000528A0B9000380E643C00650800214A00005';
wwv_flow_imp.g_varchar2_table(225) := 'D417600050DF9C3552800214A0000534176000D07C08D8000A50800214A080FA020C00EA9BB3460A50800214A080E6020C009A0F011B40010A50800214505F8001407D73D648010A50800214D05C800140F32160032840010A508002EA0B3000A86FCE1A';
wwv_flow_imp.g_varchar2_table(226) := '2940010A5080029A0B3000683E046C00052840010A50407D010600F5CD5923052840010A504073010600CD87800DA000052840010AA82FC000A0BE396BA400052840010A682EC000A0F910B00114A00005284001F5051800D437678D14A00005284001CD';
wwv_flow_imp.g_varchar2_table(227) := '051800341F0236800214A0000528A0BE000380FAE6AC910214A0000528A0B9000380E643C00650800214A00005D417600050DF9C3552800214A0000534176000D07C08D8000A50800214A080FA020C00EA9BB3460A50800214A080E6020C009A0F011B40';
wwv_flow_imp.g_varchar2_table(228) := '010A50800214505F8001407D73D648010A50800214D05C800140F32160032840010A508002EA0B3000A86FCE1A2940010A5080029A0B3000683E046C00052840010A50407D010600F5CD5923052840010A504073010600CD87800DA000052840010AA82F';
wwv_flow_imp.g_varchar2_table(229) := 'C000A0BE396BA400052840010A682EC000A0F910B00114A00005284001F5051800D437678D14A00005284001CD051800341F0236800214A0000528A0BE000380FAE6AC910214A0000528A0B9000380E643C00650800214A00005D417600050DF9C355280';
wwv_flow_imp.g_varchar2_table(230) := '0214A0000534176000D07C08D8000A50800214A080FA020C00EA9BB3460A50800214A080E6020C009A0F011B40010A50800214505F8001407D73D648010A50800214D05C800140F32160032840010A508002EA0B3000A86FCE1A2940010A5080029A0B30';
wwv_flow_imp.g_varchar2_table(231) := '00683E046C00052840010A50407D010600F5CD5923052840010A504073010600CD87800DA000052840010AA82FC000A0BE396BA400052840010A682EC000A0F910B00114A00005284001F5051800D437678D14A00005284001CD051800341F0236800214';
wwv_flow_imp.g_varchar2_table(232) := 'A0000528A0BE000380FAE6AC910214A0000528A0B9000380E643C00650800214A00005D417600050DF9C3552800214A0000534176000D07C08D8000A50800214A080FA020C00EA9BB3460A50800214A080E6020C009A0F011B40010A50800214505F8001';
wwv_flow_imp.g_varchar2_table(233) := '407D73D648010A50800214D05C800140F32160032840010A508002EA0B3000A86FCE1A2940010A5080029A0B3000683E046C00052840010A50407D010600F5CD5923052840010A504073010600CD87800DA000052840010AA82FC000A0BE396BA4000528';
wwv_flow_imp.g_varchar2_table(234) := '40010A682EC000A0F910B00114A00005284001F5051800D437678D14A00005284001CD051800341F0236800214A0000528A0BE000380FAE6AC910214A0000528A0B9000380E643C00650800214A00005D417600050DF9C3552800214A0000534176000D0';
wwv_flow_imp.g_varchar2_table(235) := '7C08D8000A50800214A080FA020C00EA9BB3460A50800214A080E6020C009A0F011B40010A50800214505F8001407D73D648010A50800214D05C800140F32160032840010A508002EA0B3000A86FCE1A2940010A5080029A0B3000683E046C0005284001';
wwv_flow_imp.g_varchar2_table(236) := '0A50407D010600F5CD5923052840010A504073010600CD87800DA000052840010AA82FC000A0BE396BA400052840010A682EC000A0F910B00114A00005284001F505FE1F22ECD8F0989CF8FA0000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(54650447002303145828)
,p_file_name=>'icons/app-icon-512.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/security/authorizations/is_agent
begin
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(56607148908871296420)
,p_name=>'Is Agent'
,p_scheme_type=>'NATIVE_IS_IN_GROUP'
,p_attribute_01=>'agent'
,p_attribute_02=>'A'
,p_version_scn=>15633177534405
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
prompt --application/shared_components/security/authorizations/is_customer
begin
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(56607530477376018758)
,p_name=>'Is Customer'
,p_scheme_type=>'NATIVE_IS_IN_GROUP'
,p_attribute_01=>'Customer'
,p_attribute_02=>'A'
,p_version_scn=>15633177559312
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
prompt --application/shared_components/security/authorizations/is_shopkeeper
begin
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(56607582649192024198)
,p_name=>'Is Shopkeeper'
,p_scheme_type=>'NATIVE_IS_IN_GROUP'
,p_attribute_01=>'Shopkeeper'
,p_attribute_02=>'A'
,p_version_scn=>15633177577364
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
end;
/
prompt --application/shared_components/user_interface/lovs/customers_customer_name
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(55012128661792032458)
,p_lov_name=>'CUSTOMERS.CUSTOMER_NAME'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'CUSTOMERS'
,p_return_column_name=>'ID'
,p_display_column_name=>'CUSTOMER_NAME'
,p_default_sort_column_name=>'CUSTOMER_NAME'
,p_default_sort_direction=>'ASC'
,p_version_scn=>15631752754903
);
end;
/
prompt --application/shared_components/user_interface/lovs/farmers_name
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(55496392553173615724)
,p_lov_name=>'FARMERS.NAME'
,p_source_type=>'TABLE'
,p_location=>'LOCAL'
,p_query_table=>'FARMERS'
,p_return_column_name=>'ID'
,p_display_column_name=>'NAME'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
,p_version_scn=>15632220926509
);
end;
/
prompt --application/shared_components/user_interface/lovs/unified_task_list_lov_due
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(56962106835412943431)
,p_lov_name=>'UNIFIED_TASK_LIST.LOV.DUE'
,p_lov_query=>'.'||wwv_flow_imp.id(56962106835412943431)||'.'
,p_location=>'STATIC'
,p_version_scn=>15633419340568
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962107198626943431)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Overdue'
,p_lov_return_value=>'|0'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962107510228943431)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Next hour'
,p_lov_return_value=>'0|1'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962107982978943432)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'Next 24 hours'
,p_lov_return_value=>'1|24'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962108308005943432)
,p_lov_disp_sequence=>4
,p_lov_disp_value=>'Next 7 days'
,p_lov_return_value=>'24|168'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962108738604943432)
,p_lov_disp_sequence=>5
,p_lov_disp_value=>'Next 30 days'
,p_lov_return_value=>'168|720'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962109138125943433)
,p_lov_disp_sequence=>6
,p_lov_disp_value=>'More than 30 days'
,p_lov_return_value=>'720|'
);
end;
/
prompt --application/shared_components/user_interface/lovs/unified_task_list_lov_initiated
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(56962113758316943436)
,p_lov_name=>'UNIFIED_TASK_LIST.LOV.INITIATED'
,p_lov_query=>'.'||wwv_flow_imp.id(56962113758316943436)||'.'
,p_location=>'STATIC'
,p_version_scn=>15633419340627
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962114071620943436)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Last hour'
,p_lov_return_value=>'|1'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962114436974943437)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Last 24 hours'
,p_lov_return_value=>'1|24'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962114817748943437)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'Last 7 days'
,p_lov_return_value=>'24|168'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962115276988943437)
,p_lov_disp_sequence=>4
,p_lov_disp_value=>'Last 30 days'
,p_lov_return_value=>'168|720'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56962115640116943437)
,p_lov_disp_sequence=>5
,p_lov_disp_value=>'Older than 30 days'
,p_lov_return_value=>'720|'
);
end;
/
prompt --application/shared_components/user_interface/lovs/unified_task_list_lov_priority
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(56962111033140943434)
,p_lov_name=>'UNIFIED_TASK_LIST.LOV.PRIORITY'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_human_task.get_lov_priority )',
' order by insert_order'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_return_column_name=>'VAL'
,p_display_column_name=>'DISP'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
,p_version_scn=>15633419340601
);
end;
/
prompt --application/shared_components/user_interface/lovs/unified_task_list_lov_state
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(56962111792545943435)
,p_lov_name=>'UNIFIED_TASK_LIST.LOV.STATE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_human_task.get_lov_state )',
' order by insert_order'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_return_column_name=>'VAL'
,p_display_column_name=>'DISP'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
,p_version_scn=>15633419340604
);
end;
/
prompt --application/shared_components/user_interface/lovs/unified_task_list_lov_type
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(56962109982449943434)
,p_lov_name=>'UNIFIED_TASK_LIST.LOV.TYPE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_human_task.get_lov_type )',
' order by insert_order'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_return_column_name=>'VAL'
,p_display_column_name=>'DISP'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
,p_version_scn=>15633419340593
);
end;
/
prompt --application/shared_components/user_interface/lovs/workflow_console_lov_initiated
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(56979287334266407610)
,p_lov_name=>'WORKFLOW_CONSOLE.LOV.INITIATED'
,p_lov_query=>'.'||wwv_flow_imp.id(56979287334266407610)||'.'
,p_location=>'STATIC'
,p_version_scn=>15633432614106
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56979287604355407610)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'Last hour'
,p_lov_return_value=>'|1'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56979288030083407610)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'Last 24 hours'
,p_lov_return_value=>'1|24'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56979288425301407610)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'Last 7 days'
,p_lov_return_value=>'24|168'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56979288837415407611)
,p_lov_disp_sequence=>4
,p_lov_disp_value=>'Last 30 days'
,p_lov_return_value=>'168|720'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(56979289292960407611)
,p_lov_disp_sequence=>5
,p_lov_disp_value=>'Older than 30 days'
,p_lov_return_value=>'720|'
);
end;
/
prompt --application/shared_components/user_interface/lovs/workflow_console_lov_workflow_state
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(56979285850626407608)
,p_lov_name=>'WORKFLOW_CONSOLE.LOV.WORKFLOW_STATE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_workflow.get_lov_workflow_state )',
' order by insert_order'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_return_column_name=>'VAL'
,p_display_column_name=>'DISP'
,p_group_sort_direction=>'ASC'
,p_default_sort_direction=>'ASC'
,p_version_scn=>15633432614078
);
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_imp_shared.create_menu(
 p_id=>wwv_flow_imp.id(54650443071322145818)
,p_name=>'Breadcrumb'
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(54650443272658145818)
,p_short_name=>'Home'
,p_link=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>1
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(54811255125277917749)
,p_short_name=>'Form'
,p_link=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>2
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55011568938902288972)
,p_short_name=>'Customers'
,p_link=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>4
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55433296998954705491)
,p_short_name=>'Producer Report'
,p_link=>'f?p=&APP_ID.:3:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>3
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55466986915235064047)
,p_short_name=>'Purchase_Request'
,p_link=>'f?p=&APP_ID.:5:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>5
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55573650951376119077)
,p_short_name=>'Procurement'
,p_link=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>7
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55576474039753239617)
,p_short_name=>'Add a New Rice Type'
,p_link=>'f?p=&APP_ID.:8:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>8
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56789935664783994529)
,p_short_name=>'Approval Request'
,p_link=>'f?p=&APP_ID.:6:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>6
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56790772961169752894)
,p_short_name=>'ShopKeeper Approval'
,p_link=>'f?p=&APP_ID.:9:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>9
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56798232116562993567)
,p_short_name=>'cutomer orders'
,p_link=>'f?p=&APP_ID.:10:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56963656513654951946)
,p_short_name=>'Pending Approval'
,p_link=>'f?p=&APP_ID.:11:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>11
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56979283873918407606)
,p_short_name=>'Order DashBoard'
,p_link=>'f?p=&APP_ID.:12:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>12
);
end;
/
prompt --application/shared_components/navigation/breadcrumbentry
begin
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(54811255125277917749)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'Form'
,p_link=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>2
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55011568938902288972)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'Customers'
,p_link=>'f?p=&APP_ID.:4:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>4
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55433296998954705491)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'Producer Report'
,p_link=>'f?p=&APP_ID.:3:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>3
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55466986915235064047)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'Purchase_Request'
,p_link=>'f?p=&APP_ID.:5:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>5
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55573650951376119077)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'Procurement'
,p_link=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>7
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55576474039753239617)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'Add a New Rice Type'
,p_link=>'f?p=&APP_ID.:8:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>8
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56789935664783994529)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'Approval Request'
,p_link=>'f?p=&APP_ID.:6:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>6
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56790772961169752894)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'ShopKeeper Approval'
,p_link=>'f?p=&APP_ID.:9:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>9
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56798232116562993567)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'cutomer orders'
,p_link=>'f?p=&APP_ID.:10:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56963656513654951946)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'Pending Approval'
,p_link=>'f?p=&APP_ID.:11:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>11
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(56979283873918407606)
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_option_sequence=>10
,p_short_name=>'Order DashBoard'
,p_link=>'f?p=&APP_ID.:12:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>12
);
end;
/
prompt --application/shared_components/email/templates/laptop_delivered_notification
begin
wwv_flow_imp_shared.create_email_template(
 p_id=>wwv_flow_imp.id(56439106151850131464)
,p_name=>'Laptop Delivered Notification'
,p_static_id=>'LAPTOP_DELIVERED_NOTIFICATION'
,p_version_number=>2
,p_subject=>'#P_LAPTOP_TYPE# Laptop for #P_ENAME# Completed'
,p_html_body=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Dear &P_ENAME.,<br><br>',
'',
'Congratulations, your new #P_LAPTOP_TYPE# laptop has been delivered. <br><br>',
'',
'{if P_DELIVERED_FROM_STOCK/}We used stock on hand to get it to you more quickly.<br><br>{endif/}',
'',
'Best Regards,',
'  The backoffice team'))
,p_html_header=>'<b style="font-size: 24px;">Sample Workflow, Approvals, and Tasks</b>'
,p_version_scn=>15633025860537
);
end;
/
prompt --application/pages/delete_00002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_imp_page.create_page(
 p_id=>2
,p_name=>'Producer Form'
,p_alias=>'FORM'
,p_step_title=>'Form'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(54811254619942917748)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(54811255579956917937)
,p_plug_name=>'Form'
,p_title=>'Producers Form'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'FARMERS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_required_role=>wwv_flow_imp.id(56607582649192024198)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(54811265210903917949)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
,p_button_condition=>'P2_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(54811264277328917948)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:2:&APP_SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(54811265658214917949)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'CREATE'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(54811264848193917948)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P2_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(54811265917737917949)
,p_branch_name=>'Go To Page 2'
,p_branch_action=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51923977384719029247)
,p_name=>'P2_AADHAAR_NO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_prompt=>'Aadhaar No'
,p_source=>'AADHAAR_NO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51923977420065029248)
,p_name=>'P2_GENDER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_prompt=>'Gender'
,p_source=>'GENDER'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Male;Male,Female;Female'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811255837432917938)
,p_name=>'P2_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Id'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811256268177917938)
,p_name=>'P2_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_prompt=>'Name'
,p_source=>'NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811256664964917939)
,p_name=>'P2_AGE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_prompt=>'Age'
,p_source=>'AGE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811257040550917939)
,p_name=>'P2_PHONE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_prompt=>'Phone'
,p_source=>'PHONE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811257470420917940)
,p_name=>'P2_ADDRESS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_prompt=>'Address'
,p_source=>'ADDRESS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>2
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811258274637917941)
,p_name=>'P2_CREATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811258676046917941)
,p_name=>'P2_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811259067941917942)
,p_name=>'P2_UPDATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811259498369917942)
,p_name=>'P2_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(54811259866474917942)
,p_name=>'P2_VILLAGE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_item_source_plug_id=>wwv_flow_imp.id(54811255579956917937)
,p_prompt=>'Village'
,p_source=>'VILLAGE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(51923975560280029229)
,p_validation_name=>'Valid Name'
,p_validation_sequence=>10
,p_validation=>'P2_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Name of the Producer is Required '
,p_associated_item=>wwv_flow_imp.id(54811256268177917938)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(51923975639012029230)
,p_validation_name=>'New'
,p_validation_sequence=>20
,p_validation=>':AGE BETWEEN 18 AND 100'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Age should be valid '
,p_associated_item=>wwv_flow_imp.id(54811256664964917939)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(51923975835578029232)
,p_validation_name=>'New_2'
,p_validation_sequence=>40
,p_validation=>'REGEXP_LIKE(:PHONE, ''^\d{10}$'')'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'The Phone Number Should Not Exceed the 10 Digits '
,p_associated_item=>wwv_flow_imp.id(54811257040550917939)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56657630024277239035)
,p_validation_name=>'Validate Aadhaar Number'
,p_validation_sequence=>50
,p_validation=>'REGEXP_LIKE(:P7_AADHAAR_NO, ''^\d{12}$'')'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'It is a Not Valid Aadhaar Number'
,p_associated_item=>wwv_flow_imp.id(51923977384719029247)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(54811266812076917950)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(54811255579956917937)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Form'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_required_patch=>wwv_flow_imp.id(54650442436467145814)
,p_internal_uid=>54811266812076917950
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51923975230317029226)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Begin',
'farmer_pkg.insert_farmer(',
'    farmer_seq_id.NEXTVAL,',
'    :P2_NAME,',
'    :P2_AGE,',
'    :P2_PHONE,',
'    :P2_ADDRESS,',
'    :P2_AADHAAR_NO,',
'    :P2_VILLAGE,',
'    :P2_GENDER',
');',
'end;',
'',
''))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Row is not Insert'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(54811265658214917949)
,p_process_success_message=>'Row is Insert'
,p_internal_uid=>51923975230317029226
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51923975391756029227)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Begin',
'farmer_pkg.update_farmer(',
'    :P2_ID,',
'    :P2_NAME,',
'    :P2_AGE,',
'    :P2_PHONE,',
'    :P2_ADDRESS,',
'    :P2_AADHAAR_NO,',
'    :P2_VILLAGE,',
'    :P2_GENDER',
');',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(54811265210903917949)
,p_internal_uid=>51923975391756029227
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51923975408094029228)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'farmer_pkg.delete_farmer(',
'    :P2_ID',
');',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(54811264848193917948)
,p_internal_uid=>51923975408094029228
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(54811266499879917950)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(54811255579956917937)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Form'
,p_internal_uid=>54811266499879917950
);
end;
/
prompt --application/pages/delete_00003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_imp_page.create_page(
 p_id=>3
,p_name=>'Producer Report'
,p_alias=>'PRODUCER-REPORT'
,p_step_title=>'Producer Report'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(56607582649192024198)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55433296487455705489)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55433297171645705491)
,p_plug_name=>'Producer Report'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'FARMERS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Producer Report'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(55433297277227705491)
,p_name=>'Producer Report'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.::P2_ID:#ID#'
,p_detail_link_text=>'<img src="#APEX_FILES#app_ui/img/icons/apex-edit-pencil-alt.png" class="apex-edit-pencil-alt" alt="">'
,p_owner=>'T.GOVIND.RAJESH@ACCENTURE.COM'
,p_internal_uid=>55433297277227705491
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433298301449705735)
,p_db_column_name=>'ID'
,p_display_order=>0
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433298788407705735)
,p_db_column_name=>'NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433299183803705735)
,p_db_column_name=>'AGE'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Age'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433299569573705736)
,p_db_column_name=>'PHONE'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Phone'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433299969418705736)
,p_db_column_name=>'ADDRESS'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Address'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433301939043705737)
,p_db_column_name=>'VILLAGE'
,p_display_order=>15
,p_column_identifier=>'J'
,p_column_label=>'Village'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433302319848705738)
,p_db_column_name=>'AADHAAR_NO'
,p_display_order=>25
,p_column_identifier=>'K'
,p_column_label=>'Aadhaar No'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433302713081705738)
,p_db_column_name=>'GENDER'
,p_display_order=>35
,p_column_identifier=>'L'
,p_column_label=>'Gender'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433300384959705736)
,p_db_column_name=>'CREATED'
,p_display_order=>45
,p_column_identifier=>'F'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433300778754705736)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>55
,p_column_identifier=>'G'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433301151044705737)
,p_db_column_name=>'UPDATED'
,p_display_order=>65
,p_column_identifier=>'H'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(55433301568892705737)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>75
,p_column_identifier=>'I'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(55433504968939993694)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'554335050'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:NAME:AGE:PHONE:ADDRESS:VILLAGE:AADHAAR_NO:GENDER:CREATED:CREATED_BY:UPDATED:UPDATED_BY'
);
end;
/
prompt --application/pages/delete_00004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>4);
end;
/
prompt --application/pages/page_00004
begin
wwv_flow_imp_page.create_page(
 p_id=>4
,p_name=>'Customers'
,p_alias=>'CUSTOMERS'
,p_step_title=>'Customers'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(56607530477376018758)
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55011568418011288971)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55011569364443289142)
,p_plug_name=>'Customers'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'CUSTOMERS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55011576985083289149)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P4_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55011575928286289148)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55011577369344289149)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P4_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55011576585465289148)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P4_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(55011577640696289149)
,p_branch_name=>'Go To Page 4'
,p_branch_action=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(55011577369344289149)
,p_branch_sequence=>1
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55011569600636289142)
,p_name=>'P4_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_item_source_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Id'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55011570091545289143)
,p_name=>'P4_CUSTOMER_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_item_source_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_prompt=>'Customer Name'
,p_source=>'CUSTOMER_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55011570432661289143)
,p_name=>'P4_EMAIL_ID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_item_source_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_prompt=>'Email Id'
,p_source=>'EMAIL_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55011570800784289144)
,p_name=>'P4_PHONE_NO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_item_source_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_prompt=>'Phone No'
,p_source=>'PHONE_NO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>60
,p_cMaxlength=>4000
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55011571254710289144)
,p_name=>'P4_ADDRESS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_item_source_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_prompt=>'Address'
,p_source=>'ADDRESS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>2
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55011571614612289144)
,p_name=>'P4_CREATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_item_source_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55011572091417289145)
,p_name=>'P4_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_item_source_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55011572483765289145)
,p_name=>'P4_UPDATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_item_source_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55011572882310289146)
,p_name=>'P4_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_item_source_plug_id=>wwv_flow_imp.id(55011569364443289142)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(51923976609985029240)
,p_validation_name=>'New'
,p_validation_sequence=>10
,p_validation=>'REGEXP_LIKE(:P2_FIRST_NAME, ''^[A-Za-z ]+$'')'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Enter a Valid Name '
,p_associated_item=>wwv_flow_imp.id(55011570091545289143)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(51923976767899029241)
,p_validation_name=>'New_1'
,p_validation_sequence=>20
,p_validation=>'REGEXP_LIKE(:P2_EMAIL, ''^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'')'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Enter a Valid Email Id'
,p_associated_item=>wwv_flow_imp.id(55011570432661289143)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(51923976815303029242)
,p_validation_name=>'New_2'
,p_validation_sequence=>30
,p_validation=>'P4_PHONE_NO'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Phone Number Cannot be a Null Value'
,p_associated_item=>wwv_flow_imp.id(55011570800784289144)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55011578580804289151)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(55011569364443289142)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Customers'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_required_patch=>wwv_flow_imp.id(54650442436467145814)
,p_internal_uid=>55011578580804289151
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51923976073345029234)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  customer_pkg.insert_customer(',
'    customer_seq_id.NEXTVAL,',
'    :P4_CUSTOMER_NAME,',
'    :P4_EMAIL_ID,',
'    :P4_PHONE_NO,',
'    :P4_ADDRESS',
'  );',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(55011577369344289149)
,p_internal_uid=>51923976073345029234
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51923976474416029238)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  customer_pkg.update_customer(',
'    p_id     => :P4_CUSTOMER_ID,',
'    p_name   => :P4_CUSTOMER_NAME,',
'    p_email  => :P4_EMAIL_ID,',
'    p_phone  => :P4_PHONE_NO,',
'    p_address => :P4_ADDRESS',
'  );',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(55011576985083289149)
,p_internal_uid=>51923976474416029238
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51923976591539029239)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  customer_pkg.delete_customer(',
'    p_id => :P4_CUSTOMER_ID',
'  );',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(55011576585465289148)
,p_internal_uid=>51923976591539029239
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55011578133357289150)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(55011569364443289142)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Customers'
,p_internal_uid=>55011578133357289150
);
end;
/
prompt --application/pages/delete_00005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>5);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_imp_page.create_page(
 p_id=>5
,p_name=>'Purchase_Request'
,p_alias=>'PURCHASE-REQUEST'
,p_step_title=>'Purchase_Request'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(56607530477376018758)
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55466986438881064046)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55466988669715064258)
,p_plug_name=>'Purchase_Request'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'CUSTOMER_ORDERS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55466998548354064268)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P5_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55466997411016064267)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:5:&APP_SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55466998964569064269)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P5_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55466998050606064268)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P5_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(55466999238112064269)
,p_branch_action=>'f?p=&APP_ID.:5:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466988900533064259)
,p_name=>'P5_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Id'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466989317369064260)
,p_name=>'P5_ORDER_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_prompt=>'Order Date'
,p_source=>'ORDER_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466989706648064260)
,p_name=>'P5_STATUS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_source=>'STATUS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466990185997064261)
,p_name=>'P5_TOTAL_KG_ORDERED'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_prompt=>'Total Kg Ordered'
,p_source=>'TOTAL_KG_ORDERED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466990557656064261)
,p_name=>'P5_CREATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466990954083064262)
,p_name=>'P5_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466991353285064262)
,p_name=>'P5_UPDATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466991776182064263)
,p_name=>'P5_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466992171434064263)
,p_name=>'P5_RICE_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_prompt=>'Rice Type'
,p_source=>'RICE_TYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select rice_type as r , rice_type as d from rice_item;'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466992534943064264)
,p_name=>'P5_SHOP_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_prompt=>'Shop Name'
,p_source=>'SHOP_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466992971063064264)
,p_name=>'P5_SHOP_LOCATION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_prompt=>'Shop Location'
,p_source=>'SHOP_LOCATION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55466993398018064265)
,p_name=>'P5_CUSTOMER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_item_source_plug_id=>wwv_flow_imp.id(55466988669715064258)
,p_prompt=>'Customer Id'
,p_source=>'CUSTOMER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select customer_code as d , customer_code as r from customers;'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55467000174258064271)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(55466988669715064258)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Purchase_Request'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_required_patch=>wwv_flow_imp.id(54650442436467145814)
,p_internal_uid=>55467000174258064271
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51923977557471029249)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  customer_order_pkg.insert_order(',
'    p_customer_id       => :P5_CUSTOMER_ID,',
'    p_order_date        => :P5_ORDER_DATE,',
'    p_total_kg_ordered  => :P5_TOTAL_KG_ORDERED,',
'    p_rice_type         => :P5_RICE_TYPE,',
'    p_shop_name         => :P5_SHOP_NAME,',
'    p_shop_location     => :P5_SHOP_LOCATION',
'  );',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(55466998964569064269)
,p_internal_uid=>51923977557471029249
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(51923977637706029250)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'customer_order_pkg.update_order',
'(',
'    :P5_ID,',
'    :P5_CUSTOMER_ID,',
'    :P5_ORDER_DATE,',
'    :P5_TOTAL_KG_ORDERED,',
'    :P5_RICE_TYPE,',
'    :P5_SHOP_NAME,',
'    :P5_SHOP_LOCATION',
');',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(55466998548354064268)
,p_internal_uid=>51923977637706029250
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55469771322483436501)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'customer_order_pkg.delete_order',
'(',
'   :P5_ID',
');',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(55466998050606064268)
,p_internal_uid=>55469771322483436501
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56976629389280315203)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'New'
,p_attribute_01=>'START'
,p_attribute_02=>wwv_flow_imp.id(56441781020431500131)
,p_attribute_03=>'P5_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>56976629389280315203
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(56976629484078315204)
,p_page_process_id=>wwv_flow_imp.id(56976629389280315203)
,p_workflow_variable_id=>wwv_flow_imp.id(56976629225329315202)
,p_page_id=>5
,p_value_type=>'ITEM'
,p_value=>'P5_CUSTOMER_ID'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(56976629546099315205)
,p_page_process_id=>wwv_flow_imp.id(56976629389280315203)
,p_workflow_variable_id=>wwv_flow_imp.id(56976629122208315201)
,p_page_id=>5
,p_value_type=>'ITEM'
,p_value=>'P5_ID'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55466999747282064270)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(55466988669715064258)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Purchase_Request'
,p_internal_uid=>55466999747282064270
);
end;
/
prompt --application/pages/delete_00006
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>6);
end;
/
prompt --application/pages/page_00006
begin
wwv_flow_imp_page.create_page(
 p_id=>6
,p_name=>'Approval Request'
,p_alias=>'APPROVAL-REQUEST'
,p_step_title=>'Approval Request'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(56607148908871296420)
,p_protection_level=>'C'
,p_page_component_map=>'21'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56789935122535994528)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56789935986618994530)
,p_plug_name=>'Approval Request'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>'select * from customer_orders where status =''Pending'''
,p_plug_source_type=>'NATIVE_IG'
,p_prn_page_header=>'Approval Request'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789937230519994531)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'enable_multi_select', 'Y',
  'hide_control', 'N',
  'show_select_all', 'Y')).to_clob
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789937737614994532)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789938885067994534)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_enable_filter=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789939870994994535)
,p_name=>'ORDER_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORDER_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Order Date'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789940853061994536)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789941833066994537)
,p_name=>'TOTAL_KG_ORDERED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_KG_ORDERED'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Total Kg Ordered'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789942947613994538)
,p_name=>'CREATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Created'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789943917033994539)
,p_name=>'CREATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Created By'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>1020
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789944931186994540)
,p_name=>'UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Updated'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789945966151994541)
,p_name=>'UPDATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Updated By'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>1020
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789946906334994542)
,p_name=>'RICE_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RICE_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Rice Type'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789947969554994543)
,p_name=>'SHOP_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SHOP_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Shop Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>120
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789948990204994544)
,p_name=>'SHOP_LOCATION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SHOP_LOCATION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Shop Location'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>130
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56789949971371994545)
,p_name=>'CUSTOMER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CUSTOMER_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Customer Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>140
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(56789936404674994530)
,p_internal_uid=>56789936404674994530
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(56789936835915994531)
,p_interactive_grid_id=>wwv_flow_imp.id(56789936404674994530)
,p_static_id=>'567899369'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(56789937099555994531)
,p_report_id=>wwv_flow_imp.id(56789936835915994531)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789938150572994532)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>0
,p_column_id=>wwv_flow_imp.id(56789937737614994532)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789939228004994534)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(56789938885067994534)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789940219383994535)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(56789939870994994535)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789941279334994536)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(56789940853061994536)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789942224359994537)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(56789941833066994537)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789943306206994539)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(56789942947613994538)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789944338930994540)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(56789943917033994539)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789945370997994541)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(56789944931186994540)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789946382308994542)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(56789945966151994541)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789947364410994543)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(56789946906334994542)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789948390898994544)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(56789947969554994543)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789949301735994545)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(56789948990204994544)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56789950389025994546)
,p_view_id=>wwv_flow_imp.id(56789937099555994531)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(56789949971371994545)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56789950957871994546)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(56789935986618994530)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Approval Request - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>56789950957871994546
);
end;
/
prompt --application/pages/delete_00007
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>7);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_imp_page.create_page(
 p_id=>7
,p_name=>'Procurement'
,p_alias=>'PROCUREMENT'
,p_step_title=>'Procurement'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(56607582649192024198)
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55573650421090119076)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55573651474256119274)
,p_plug_name=>'Procurement'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       FARMER_ID,',
'       UMILLED_QUANTITY_KG,',
'       PURCHASE_DATE,',
'       MILLED_QUANTITY_KG,',
'       CREATED,',
'       CREATED_BY,',
'       UPDATED,',
'       UPDATED_BY,',
'       RICE_TYPE,',
'       PRICE_PER_KG,',
'       TOTAL_PRICE',
'  from PADDY_PROCUREMENTS'))
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55469771567056436503)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_button_name=>'New_type'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--gapTop'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'New Type'
,p_button_redirect_url=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:::'
,p_button_css_classes=>'align-top'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>6
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55573661113055119284)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P7_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55573660100175119284)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55573661579470119285)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P7_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55573660782040119284)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P7_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(55573661815608119285)
,p_branch_action=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573651795012119274)
,p_name=>'P7_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Id'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573652191766119275)
,p_name=>'P7_FARMER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Farmer Id'
,p_source=>'FARMER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'FARMERS.NAME'
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'Y',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573652539220119276)
,p_name=>'P7_UMILLED_QUANTITY_KG'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_prompt=>'Umilled Quantity Kg'
,p_source=>'UMILLED_QUANTITY_KG'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573652902318119276)
,p_name=>'P7_PURCHASE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Purchase Date'
,p_source=>'PURCHASE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573653327469119277)
,p_name=>'P7_MILLED_QUANTITY_KG'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_prompt=>'Milled Quantity Kg'
,p_source=>'MILLED_QUANTITY_KG'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573653763404119278)
,p_name=>'P7_CREATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573654122352119278)
,p_name=>'P7_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573654583160119279)
,p_name=>'P7_UPDATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573654979144119279)
,p_name=>'P7_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573655382782119280)
,p_name=>'P7_RICE_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_prompt=>'Rice Type'
,p_source=>'RICE_TYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'select rice_type as r, rice_type as d from rice_item;'
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'display_as', 'DIALOG',
  'fetch_on_search', 'N',
  'initial_fetch', 'FIRST_ROWSET',
  'manual_entry', 'N',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573655752701119280)
,p_name=>'P7_PRICE_PER_KG'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_prompt=>'Price Per Kg'
,p_source=>'PRICE_PER_KG'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55573656188546119281)
,p_name=>'P7_TOTAL_PRICE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_item_source_plug_id=>wwv_flow_imp.id(55573651474256119274)
,p_prompt=>'Total Price'
,p_source=>'TOTAL_PRICE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>15
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56657630161543239036)
,p_validation_name=>'Validate Unmilled Quantity'
,p_validation_sequence=>10
,p_validation=>':P7_UNMILLED_QUANTITY_KG > 0'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'The Value Should be Greater Than Zero'
,p_associated_item=>wwv_flow_imp.id(55573652539220119276)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56657630279885239037)
,p_validation_name=>'Validate Rice Price'
,p_validation_sequence=>20
,p_validation=>':P7_PRICE_PER_KG>0'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'The Price of the Rice Should be Greater than 0'
,p_associated_item=>wwv_flow_imp.id(55573655752701119280)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55469772019737436508)
,p_name=>'New_1'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_PRICE_PER_KG'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55469772175198436509)
,p_event_id=>wwv_flow_imp.id(55469772019737436508)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_TOTAL_PRICE'
,p_attribute_01=>'PLSQL_EXPRESSION'
,p_attribute_04=>':P7_UMILLED_QUANTITY_KG * :P7_PRICE_PER_KG * 0.8'
,p_attribute_07=>'P7_UMILLED_QUANTITY_KG,P7_PRICE_PER_KG'
,p_attribute_08=>'Y'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(55469772279969436510)
,p_name=>'Generate Value'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_UMILLED_QUANTITY_KG'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(55469772361932436511)
,p_event_id=>wwv_flow_imp.id(55469772279969436510)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_MILLED_QUANTITY_KG'
,p_attribute_01=>'PLSQL_EXPRESSION'
,p_attribute_04=>':P7_UMILLED_QUANTITY_KG * 0.8'
,p_attribute_07=>'P7_UMILLED_QUANTITY_KG'
,p_attribute_08=>'Y'
,p_attribute_09=>'Y'
,p_stop_execution_on_error=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55573662724257119286)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(55573651474256119274)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Procurement'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>55573662724257119286
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55573662395452119286)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(55573651474256119274)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Procurement'
,p_internal_uid=>55573662395452119286
);
end;
/
prompt --application/pages/delete_00008
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>8);
end;
/
prompt --application/pages/page_00008
begin
wwv_flow_imp_page.create_page(
 p_id=>8
,p_name=>'Add a New Rice Type'
,p_alias=>'ADD-A-NEW-RICE-TYPE'
,p_step_title=>'Add a New Rice Type'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(56607582649192024198)
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55576473528234239616)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55576474467588239806)
,p_plug_name=>'Add a New Rice Type'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'RICE_ITEM'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55576477832944239810)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P8_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55576476880515239809)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55576478205426239810)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P8_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(55576477455192239810)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P8_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(55576478575740239811)
,p_branch_action=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55576474726733239807)
,p_name=>'P8_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_item_source_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Id'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55576475199380239807)
,p_name=>'P8_RICE_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_item_source_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Rice Type'
,p_source=>'RICE_TYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(55576475586112239808)
,p_name=>'P8_AVAILABLE_STOCK_KG'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_item_source_plug_id=>wwv_flow_imp.id(55576474467588239806)
,p_source=>'AVAILABLE_STOCK_KG'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55576479422965239812)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(55576474467588239806)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Add a New Rice Type'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>55576479422965239812
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(55576479017332239812)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(55576474467588239806)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Add a New Rice Type'
,p_internal_uid=>55576479017332239812
);
end;
/
prompt --application/pages/delete_00009
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>9);
end;
/
prompt --application/pages/page_00009
begin
wwv_flow_imp_page.create_page(
 p_id=>9
,p_name=>'ShopKeeper Approval'
,p_alias=>'SHOPKEEPER-APPROVAL'
,p_step_title=>'ShopKeeper Approval'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(56607582649192024198)
,p_protection_level=>'C'
,p_page_component_map=>'21'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56790772478505752893)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56790773102724752894)
,p_plug_name=>'ShopKeeper Approval'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>'select * from Customer_orders where status = ''Approved'''
,p_plug_source_type=>'NATIVE_IG'
,p_prn_page_header=>'ShopKeeper Approval'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790774463266752896)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'enable_multi_select', 'Y',
  'hide_control', 'N',
  'show_select_all', 'Y')).to_clob
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790774994595752897)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790775974925752898)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_enable_filter=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790776986363752900)
,p_name=>'ORDER_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORDER_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Order Date'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790777966534752901)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790778965101752901)
,p_name=>'TOTAL_KG_ORDERED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_KG_ORDERED'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Total Kg Ordered'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790779964816752902)
,p_name=>'CREATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Created'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790780959205752903)
,p_name=>'CREATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Created By'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>1020
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790781973813752904)
,p_name=>'UPDATED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Updated'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'appearance_and_behavior', 'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON',
  'days_outside_month', 'VISIBLE',
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_on', 'FOCUS',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790782906226752905)
,p_name=>'UPDATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPDATED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Updated By'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>1020
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790783909978752906)
,p_name=>'RICE_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RICE_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Rice Type'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790784960126752906)
,p_name=>'SHOP_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SHOP_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Shop Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>120
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790785951410752907)
,p_name=>'SHOP_LOCATION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SHOP_LOCATION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Shop Location'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>130
,p_value_alignment=>'LEFT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'send_on_page_submit', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56790786967946752908)
,p_name=>'CUSTOMER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CUSTOMER_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Customer Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>140
,p_value_alignment=>'RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(56790773630472752895)
,p_internal_uid=>56790773630472752895
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(56790774008558752895)
,p_interactive_grid_id=>wwv_flow_imp.id(56790773630472752895)
,p_static_id=>'567907741'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(56790774290258752896)
,p_report_id=>wwv_flow_imp.id(56790774008558752895)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790775303466752897)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>0
,p_column_id=>wwv_flow_imp.id(56790774994595752897)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790776389827752899)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(56790775974925752898)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790777381353752900)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(56790776986363752900)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790778379778752901)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(56790777966534752901)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790779336207752902)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(56790778965101752901)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790780321325752903)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(56790779964816752902)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790781352711752904)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(56790780959205752903)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790782318567752904)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(56790781973813752904)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790783343633752905)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(56790782906226752905)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790784385435752906)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(56790783909978752906)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790785359635752907)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(56790784960126752906)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790786352797752908)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(56790785951410752907)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(56790787383080752908)
,p_view_id=>wwv_flow_imp.id(56790774290258752896)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(56790786967946752908)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56790787912730752909)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(56790773102724752894)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'ShopKeeper Approval - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>56790787912730752909
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56657629998540239034)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Deduct Stock When Dispatched'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :STATUS = ''Dispatched'' THEN',
'    deduct_rice_stock(:ID);',
'  END IF;',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>56657629998540239034
);
end;
/
prompt --application/pages/delete_00010
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_imp_page.create_page(
 p_id=>10
,p_name=>'customer orders'
,p_alias=>'CUSTOMER-ORDERS'
,p_step_title=>'customer orders'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'!'||wwv_flow_imp.id(56607530477376018758)
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56798231635202993566)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56798232307523993567)
,p_plug_name=>'cutomer orders'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--hideHeader js-addHiddenHeadingRoleDesc'
,p_plug_template=>2100526641005906379
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'CUSTOMER_ORDERS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'cutomer orders'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(56798232459915993567)
,p_name=>'cutomer orders'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'T.GOVIND.RAJESH@ACCENTURE.COM'
,p_internal_uid=>56798232459915993567
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798233172009993751)
,p_db_column_name=>'ID'
,p_display_order=>0
,p_is_primary_key=>'Y'
,p_column_identifier=>'A'
,p_column_label=>'ID'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798233572938993751)
,p_db_column_name=>'ORDER_DATE'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Order Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798233920131993752)
,p_db_column_name=>'STATUS'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798234378290993752)
,p_db_column_name=>'TOTAL_KG_ORDERED'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Total Kg Ordered'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798234793770993752)
,p_db_column_name=>'CREATED'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798235128686993753)
,p_db_column_name=>'CREATED_BY'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Created By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798235575571993753)
,p_db_column_name=>'UPDATED'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798235961347993753)
,p_db_column_name=>'UPDATED_BY'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Updated By'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798236334351993753)
,p_db_column_name=>'RICE_TYPE'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Rice Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798236757056993754)
,p_db_column_name=>'SHOP_NAME'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Shop Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798237145245993754)
,p_db_column_name=>'SHOP_LOCATION'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Shop Location'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(56798237506891993754)
,p_db_column_name=>'CUSTOMER_ID'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Customer ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(56798264734948998050)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'567982648'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:ORDER_DATE:STATUS:TOTAL_KG_ORDERED:CREATED:CREATED_BY:UPDATED:UPDATED_BY:RICE_TYPE:SHOP_NAME:SHOP_LOCATION:CUSTOMER_ID'
);
end;
/
prompt --application/pages/delete_00011
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_imp_page.create_page(
 p_id=>11
,p_name=>'Pending Approval'
,p_alias=>'PENDING-APPROVAL'
,p_step_title=>'Pending Approval'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'24'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56963655177244951945)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56963657501089951947)
,p_plug_name=>'Initiated by Me - Smart Filters'
,p_parent_plug_id=>wwv_flow_imp.id(56963655177244951945)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>10
,p_plug_display_point=>'SMART_FILTERS'
,p_plug_source_type=>'NATIVE_SMART_FILTERS'
,p_filtered_region_id=>wwv_flow_imp.id(56963657693331951947)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'compact_numbers_threshold', '10000',
  'maximum_suggestion_chips', '0',
  'more_filters_suggestion_chip', 'N',
  'show_total_row_count', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56963657693331951947)
,p_plug_name=>'Initiated by Me - Report'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2072724515482255512
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_id,',
'       task_type,',
'       task_def_name,',
'       details_app_name,',
'       details_link_target,',
'       subject,',
'       initiator,',
'       actual_owner,',
'       priority,',
'       due_on,',
'       due_in,',
'       due_in_hours,',
'       due_code,',
'       state_code,',
'       is_completed,',
'       outcome,',
'       created_on,',
'       created_ago,',
'       created_ago_hours,',
'       last_updated_on,',
'       badge_text,',
'       badge_state',
'  from table ( apex_human_task.get_tasks (',
'                   p_context            => ''INITIATED_BY_ME'',',
'                   p_show_expired_tasks => :P11_SHOW_EXPIRED',
'                   --, p_application_id => :APP_ID',
'                   ) )'))
,p_query_order_by_type=>'ITEM'
,p_query_order_by=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{',
'    "orderBys": [',
'        {',
'            "key": "CREATED_ON",',
'            "expr": "created_on desc"',
'        },',
'        {',
'            "key": "DUE_ON",',
'            "expr": "priority asc, due_on asc nulls last"',
'        }',
'    ],',
'    "itemName": "P11_SORT_BY"',
'}'))
,p_optimizer_hint=>'APEX$USE_NO_GROUPING_SETS'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P11_SHOW_EXPIRED'
,p_plug_query_num_rows_type=>'SCROLL'
,p_plug_query_no_data_found=>'No Tasks'
,p_no_data_found_icon_classes=>'fa-clipboard-check-alt fa-lg'
,p_show_total_row_count=>false
,p_entity_title_singular=>'task'
,p_entity_title_plural=>'tasks'
,p_landmark_type=>'main'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL', 'State',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_STATE', 'BADGE_STATE',
  'BADGE_VALUE', 'BADGE_TEXT',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '<strong>&TASK_DEF_NAME!HTML.</strong>',
    '{if ACTUAL_OWNER/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &{APEX.TASK.ASSIGNED_TO_USER 0=&ACTUAL_OWNER!HTML.}.',
    '{endif/}',
    '{if !IS_COMPLETED/}',
    '    {case DUE_CODE/}',
    '        {when OVERDUE/}',
    '            <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            <strong class="u-danger-text">&{APEX.TASK.DUE_SINCE 0=&DUE_IN.}.</strong>',
    '        {when NEXT_HOUR/}',
    '            <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            <strong class="u-danger-text">&{APEX.TASK.DUE_SINCE 0=&DUE_IN.}.</strong>',
    '        {when NEXT_24_HOURS/}',
    '            <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            <span class="u-danger-text">&{APEX.TASK.DUE_SINCE 0=&DUE_IN.}.</span>',
    '        {otherwise/}',
    '            {if DUE_IN/}',
    '                <span role="separator" aria-label="&middot;"> &middot; </span>',
    '                &{APEX.TASK.DUE_SINCE 0=&DUE_IN.}.',
    '            {endif/}',
    '    {endcase/}',
    '{endif/}',
    '{if !IS_COMPLETED/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    {case PRIORITY/}',
    '        {when 1/}',
    '            <strong class="u-danger-text">&{APEX.TASK.PRIORITY.1.DESCRIPTION}.</strong>',
    '        {when 2/}',
    '            <span class="u-danger-text">&{APEX.TASK.PRIORITY.2.DESCRIPTION}.</span>',
    '        {when 3/}',
    '            &{APEX.TASK.PRIORITY.3.DESCRIPTION}.',
    '        {when 4/}',
    '            &{APEX.TASK.PRIORITY.4.DESCRIPTION}.',
    '        {when 5/}',
    '            &{APEX.TASK.PRIORITY.5.DESCRIPTION}.',
    '    {endcase/}',
    '{endif/}',
    '{if OUTCOME/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &OUTCOME.',
    '{endif/}',
    '')),
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'Y',
  'HIDE_BORDERS', 'N',
  'REMOVE_PADDING', 'N',
  'TITLE', '&SUBJECT.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963667142821951952)
,p_name=>'TASK_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TASK_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963668322735951952)
,p_name=>'TASK_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TASK_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963669159784951953)
,p_name=>'TASK_DEF_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TASK_DEF_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963669824883951953)
,p_name=>'DETAILS_APP_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETAILS_APP_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963670542307951953)
,p_name=>'DETAILS_LINK_TARGET'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETAILS_LINK_TARGET'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963671024032951954)
,p_name=>'SUBJECT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SUBJECT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963671553583951954)
,p_name=>'INITIATOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963672060959951954)
,p_name=>'ACTUAL_OWNER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTUAL_OWNER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963672534436951955)
,p_name=>'PRIORITY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRIORITY'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963673082666951955)
,p_name=>'DUE_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963673591820951955)
,p_name=>'DUE_IN'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_IN'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963674051839951956)
,p_name=>'DUE_IN_HOURS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_IN_HOURS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963674568754951956)
,p_name=>'DUE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>130
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963675058485951956)
,p_name=>'STATE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>140
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963675506148951957)
,p_name=>'IS_COMPLETED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_COMPLETED'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>150
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963676032130951957)
,p_name=>'OUTCOME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OUTCOME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>160
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963676580487951957)
,p_name=>'CREATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>170
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963677041880951958)
,p_name=>'CREATED_AGO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_AGO'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>180
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963677548968951958)
,p_name=>'CREATED_AGO_HOURS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_AGO_HOURS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>190
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963678064093951958)
,p_name=>'LAST_UPDATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_UPDATED_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>200
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963678578358951959)
,p_name=>'BADGE_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_TEXT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>210
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56963679006083951959)
,p_name=>'BADGE_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>220
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963656759661951946)
,p_name=>'P11_TASK_ID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963658385576951947)
,p_name=>'P11_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Search'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'collapsed_search_field', 'N',
  'search_type', 'ROW')).to_clob
,p_fc_show_chart=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963658884165951948)
,p_name=>'P11_DUE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Due'
,p_source=>'DUE_IN_HOURS'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_RANGE'
,p_named_lov=>'UNIFIED_TASK_LIST.LOV.DUE'
,p_lov=>'.'||wwv_flow_imp.id(56962106835412943431)||'.'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'manual_entry', 'N',
  'select_multiple', 'Y')).to_clob
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963659557412951948)
,p_name=>'P11_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Type'
,p_source=>'TASK_TYPE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'UNIFIED_TASK_LIST.LOV.TYPE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_human_task.get_lov_type )',
' order by insert_order'))
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963660026278951948)
,p_name=>'P11_CATEGORY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Category'
,p_source=>'TASK_DEF_NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963660875938951949)
,p_name=>'P11_PRIORITY'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Priority'
,p_source=>'PRIORITY'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'UNIFIED_TASK_LIST.LOV.PRIORITY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_human_task.get_lov_priority )',
' order by insert_order'))
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963661644039951949)
,p_name=>'P11_STATE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'State'
,p_source=>'STATE_CODE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'UNIFIED_TASK_LIST.LOV.STATE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_human_task.get_lov_state )',
' order by insert_order'))
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963662591846951950)
,p_name=>'P11_OUTCOME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Outcome'
,p_source=>'OUTCOME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963663389755951950)
,p_name=>'P11_APPLICATION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Application'
,p_source=>'DETAILS_APP_NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963664130457951950)
,p_name=>'P11_INITIATOR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Initiator'
,p_source=>'INITIATOR'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963664929631951950)
,p_name=>'P11_INITIATED'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Initiated'
,p_source=>'CREATED_AGO_HOURS'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_RANGE'
,p_named_lov=>'UNIFIED_TASK_LIST.LOV.INITIATED'
,p_lov=>'.'||wwv_flow_imp.id(56962113758316943436)||'.'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'manual_entry', 'N',
  'select_multiple', 'Y')).to_clob
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963665373120951951)
,p_name=>'P11_OWNER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(56963657501089951947)
,p_prompt=>'Owner'
,p_source=>'ACTUAL_OWNER'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963680078839951960)
,p_name=>'P11_SORT_BY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56963657693331951947)
,p_item_display_point=>'ORDER_BY_ITEM'
,p_prompt=>'Sort by'
,p_source=>'DUE_ON'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Create Date;CREATED_ON,Due Date;DUE_ON'
,p_cHeight=>1
,p_tag_css_classes=>'mnw160'
,p_grid_label_column_span=>0
,p_field_template=>2040785906935475274
,p_item_icon_css_classes=>'fa-sort-amount-desc'
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'U'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'N',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56963680425138951960)
,p_name=>'P11_SHOW_EXPIRED'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56963657693331951947)
,p_item_display_point=>'ORDER_BY_ITEM'
,p_prompt=>'Show expired tasks'
,p_source=>'N'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_field_template=>2318601014859922299
,p_item_css_classes=>'u-nowrap'
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'U'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'checked_value', 'Y',
  'unchecked_value', 'N',
  'use_defaults', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56963680827670951961)
,p_name=>'Refresh - Initiated by Me - Report'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(56963657693331951947)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosecanceldialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56963681225074951961)
,p_event_id=>wwv_flow_imp.id(56963680827670951961)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56963657693331951947)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56963681760213951962)
,p_event_id=>wwv_flow_imp.id(56963680827670951961)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56963657501089951947)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56963682227304951962)
,p_name=>'Refresh - Initiated by Me - Report'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_SHOW_EXPIRED'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56963682612807951962)
,p_event_id=>wwv_flow_imp.id(56963682227304951962)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56963657693331951947)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56963683173331951962)
,p_event_id=>wwv_flow_imp.id(56963682227304951962)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56963657501089951947)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(56963679527909951960)
,p_region_id=>wwv_flow_imp.id(56963657693331951947)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'&DETAILS_LINK_TARGET.'
);
end;
/
prompt --application/pages/delete_00012
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>12);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_imp_page.create_page(
 p_id=>12
,p_name=>'Order DashBoard'
,p_alias=>'ORDER-DASHBOARD'
,p_step_title=>'Order DashBoard'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'24'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56979283359646407606)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(54650443071322145818)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56979284460028407607)
,p_plug_name=>'My Workflows - Smart Filters'
,p_parent_plug_id=>wwv_flow_imp.id(56979283359646407606)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>10
,p_plug_display_point=>'SMART_FILTERS'
,p_plug_source_type=>'NATIVE_SMART_FILTERS'
,p_filtered_region_id=>wwv_flow_imp.id(56979284511807407607)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'compact_numbers_threshold', '10000',
  'more_filters_suggestion_chip', 'N',
  'show_total_row_count', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56979284511807407607)
,p_plug_name=>'My Workflows - Report'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2072724515482255512
,p_plug_display_sequence=>20
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select workflow_id,',
'       workflow_def_name,',
'       workflow_def_app_name,',
'       title,',
'       initiator,',
'       state_code,',
'       created_on,',
'       created_ago,',
'       created_ago_hours,',
'       last_updated_on,',
'       badge_text,',
'       badge_state',
'  from table ( apex_workflow.get_workflows (',
'                   p_context => ''MY_WORKFLOWS''',
'                   , p_application_id => :APP_ID',
'                   ) )'))
,p_query_order_by_type=>'ITEM'
,p_query_order_by=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{',
'    "orderBys": [',
'        {',
'            "key": "CREATED_ON",',
'            "expr": "created_on desc"',
'        },',
'        {',
'            "key": "LAST_UPDATED_ON",',
'            "expr": "last_updated_on desc"',
'        }',
'    ],',
'    "itemName": "P12_SORT_BY"',
'}'))
,p_optimizer_hint=>'APEX$USE_NO_GROUPING_SETS'
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_plug_query_num_rows_type=>'SCROLL'
,p_plug_query_no_data_found=>'No Workflows'
,p_no_data_found_icon_classes=>'fa-workflow fa-lg'
,p_show_total_row_count=>false
,p_entity_title_singular=>'workflow'
,p_entity_title_plural=>'workflows'
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL', 'State',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_STATE', 'BADGE_STATE',
  'BADGE_VALUE', 'BADGE_TEXT',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '<strong>&WORKFLOW_DEF_NAME!HTML.</strong>',
    '{if INITIATOR/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &{APEX.WORKFLOW.INITIATED_BY_USER_SINCE 0=&INITIATOR!HTML. 1=&CREATED_AGO.}.',
    '{endif/}')),
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'Y',
  'TITLE', '&TITLE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980290250741407612)
,p_name=>'WORKFLOW_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WORKFLOW_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980290794511407613)
,p_name=>'WORKFLOW_DEF_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WORKFLOW_DEF_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980291252630407613)
,p_name=>'WORKFLOW_DEF_APP_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WORKFLOW_DEF_APP_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980291719016407613)
,p_name=>'TITLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TITLE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980292234756407614)
,p_name=>'INITIATOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980292779783407614)
,p_name=>'STATE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980293268154407615)
,p_name=>'CREATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980293744687407615)
,p_name=>'CREATED_AGO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_AGO'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980294213982407615)
,p_name=>'CREATED_AGO_HOURS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_AGO_HOURS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980294747447407616)
,p_name=>'LAST_UPDATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_UPDATED_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980295226926407616)
,p_name=>'BADGE_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_TEXT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980295773500407616)
,p_name=>'BADGE_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56979284010573407607)
,p_name=>'P12_WORKFLOW_ID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56979284933090407608)
,p_name=>'P12_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56979284460028407607)
,p_prompt=>'Search'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'collapsed_search_field', 'N',
  'search_type', 'ROW')).to_clob
,p_fc_show_chart=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56979285340634407608)
,p_name=>'P12_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56979284460028407607)
,p_prompt=>'Type'
,p_source=>'WORKFLOW_DEF_NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56979285794323407608)
,p_name=>'P12_STATE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(56979284460028407607)
,p_prompt=>'State'
,p_source=>'STATE_CODE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'WORKFLOW_CONSOLE.LOV.WORKFLOW_STATE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_workflow.get_lov_workflow_state )',
' order by insert_order'))
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56979286453495407609)
,p_name=>'P12_APPLICATION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(56979284460028407607)
,p_prompt=>'Application'
,p_source=>'WORKFLOW_DEF_APP_NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56979286847251407609)
,p_name=>'P12_INITIATOR'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(56979284460028407607)
,p_prompt=>'Initiator'
,p_source=>'INITIATOR'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_item_template_options=>'#DEFAULT#'
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56979287231785407610)
,p_name=>'P12_INITIATED'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(56979284460028407607)
,p_prompt=>'Initiated'
,p_source=>'CREATED_AGO_HOURS'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_RANGE'
,p_named_lov=>'WORKFLOW_CONSOLE.LOV.INITIATED'
,p_lov=>'.'||wwv_flow_imp.id(56979287334266407610)||'.'
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'manual_entry', 'N',
  'select_multiple', 'Y')).to_clob
,p_fc_show_label=>true
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_display_as=>'INLINE'
,p_suggestions_type=>'DYNAMIC'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56980297234744407618)
,p_name=>'P12_SORT_BY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56979284511807407607)
,p_item_display_point=>'ORDER_BY_ITEM'
,p_prompt=>'Sort By'
,p_source=>'LAST_UPDATED_ON'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Create Date;CREATED_ON,Last Update;LAST_UPDATED_ON'
,p_cHeight=>1
,p_tag_css_classes=>'mnw160'
,p_grid_label_column_span=>0
,p_field_template=>2040785906935475274
,p_item_icon_css_classes=>'fa-sort-amount-desc'
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'U'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'N',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56980300503508407620)
,p_name=>'Refresh - My Workflows - Report'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(56979284511807407607)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosecanceldialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980301048779407621)
,p_event_id=>wwv_flow_imp.id(56980300503508407620)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56979284511807407607)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980301564285407621)
,p_event_id=>wwv_flow_imp.id(56980300503508407620)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56979284460028407607)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56980297645603407618)
,p_name=>'Terminate'
,p_event_sequence=>30
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'a.terminate'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'body'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980298053669407618)
,p_event_id=>wwv_flow_imp.id(56980297645603407618)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P12_WORKFLOW_ID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'this.triggeringElement.dataset.id'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980298591052407619)
,p_event_id=>wwv_flow_imp.id(56980297645603407618)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.terminate (',
'    p_instance_id => :P12_WORKFLOW_ID );'))
,p_attribute_02=>'P12_WORKFLOW_ID'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980299000709407619)
,p_event_id=>wwv_flow_imp.id(56980297645603407618)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.showPageSuccess(''Workflow terminated'');'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980299505182407619)
,p_event_id=>wwv_flow_imp.id(56980297645603407618)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56979284460028407607)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980300081621407620)
,p_event_id=>wwv_flow_imp.id(56980297645603407618)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56979284511807407607)
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(56980296211413407617)
,p_region_id=>wwv_flow_imp.id(56979284511807407607)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,:P13_WORKFLOW_ID:&WORKFLOW_ID.'
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(56980296740800407617)
,p_region_id=>wwv_flow_imp.id(56979284511807407607)
,p_position_id=>362316004162771045
,p_display_sequence=>40
,p_template_id=>362316605839802174
,p_label=>'Terminate'
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#'
,p_link_attributes=>'data-id="&WORKFLOW_ID."'
,p_button_display_type=>'TEXT_WITH_ICON'
,p_icon_css_classes=>'fa-times u-danger-text'
,p_action_css_classes=>'terminate'
,p_is_hot=>false
,p_show_as_disabled=>false
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>':state_code in (''ACTIVE'',''FAULTED'',''SUSPENDED'')'
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
end;
/
prompt --application/pages/delete_00013
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>13);
end;
/
prompt --application/pages/page_00013
begin
wwv_flow_imp_page.create_page(
 p_id=>13
,p_name=>'Order Detail'
,p_page_mode=>'MODAL'
,p_step_title=>'Order Detail'
,p_allow_duplicate_submissions=>'N'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_protection_level=>'C'
,p_page_component_map=>'27'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56980303923699407623)
,p_plug_name=>'Subject'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>60
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select title,',
'       workflow_def_name,',
'       initiator,',
'       created_ago,',
'       badge_text,',
'       badge_state',
'  from table ( apex_workflow.get_workflows (',
'                   p_context     => ''SINGLE_WORKFLOW'',',
'                   p_workflow_id => :P13_WORKFLOW_ID ) );'))
,p_template_component_type=>'PARTIAL'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'BADGE_COL_WIDTH', 't-ContentRow-badge--auto',
  'BADGE_LABEL', 'State',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_SIZE', 't-Badge--md',
  'BADGE_STATE', 'BADGE_STATE',
  'BADGE_VALUE', 'BADGE_TEXT',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '<strong>&WORKFLOW_DEF_NAME!HTML.</strong>',
    '{if INITIATOR/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &{APEX.WORKFLOW.INITIATED_BY_USER_SINCE 0=&INITIATOR!HTML. 1=&CREATED_AGO.}.',
    '{endif/}')),
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'Y',
  'TITLE', '&TITLE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980304303549407624)
,p_name=>'TITLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TITLE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980304887382407624)
,p_name=>'WORKFLOW_DEF_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WORKFLOW_DEF_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980305358176407625)
,p_name=>'INITIATOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980305855884407625)
,p_name=>'CREATED_AGO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_AGO'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980306392823407626)
,p_name=>'BADGE_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_TEXT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980306835088407626)
,p_name=>'BADGE_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56980307328791407626)
,p_plug_name=>'Activities'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>70
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select activity_id,',
'       type,',
'       name,',
'       state,',
'       error_message,',
'       due_on,',
'       retry_count,',
'       start_time,',
'       end_time,',
'       initcap(state) as badge_text,',
'       case state',
'           when ''WAITING''    then ''danger''',
'           when ''COMPLETED''  then ''success''',
'           when ''TERMINATED'' then ''warning''',
'           when ''FAULTED''    then ''danger''',
'       end as badge_state,',
'       ( select max(workflow_id)',
'           from apex_workflows w',
'          where w.parent_workflow_id = :P13_WORKFLOW_ID',
'            and w.parent_activity_id = a.activity_id ) as invoked_workflow_id',
'  from apex_workflow_activities a',
' where workflow_id = :P13_WORKFLOW_ID',
' order by start_time'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P13_WORKFLOW_ID'
,p_plug_query_num_rows=>10
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'BADGE_COL_WIDTH', 't-ContentRow-badge--md',
  'BADGE_LABEL', 'Status',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_STATE', 'BADGE_STATE',
  'BADGE_STYLE', 't-Badge--outline',
  'BADGE_VALUE', 'BADGE_TEXT',
  'DESCRIPTION', '&ERROR_MESSAGE.',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'Y',
  'MISC', wwv_flow_string.join(wwv_flow_t_varchar2(
    '{case STATE/}',
    '    {when COMPLETED/}',
    '        &{APEX.WORKFLOW.COMPLETED_SINCE 0=&END_TIME.}.',
    '    {otherwise/}',
    '        &{APEX.WORKFLOW.STARTED_SINCE 0=&START_TIME.}.',
    '{endcase/}',
    '{if DUE_ON/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &{APEX.WORKFLOW.DUE_SINCE 0=&DUE_ON.}.',
    '{endif/}',
    '{if RETRY_COUNT/}',
    '    {case RETRY_COUNT/}',
    '        {when 0/}',
    '        {when 1/}',
    '        <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            &{APEX.WORKFLOW.RETRY_COUNT.EQUALS_ONE 0=&RETRY_COUNT.}.',
    '        {otherwise/}',
    '        <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            &{APEX.WORKFLOW.RETRY_COUNT.NOT_EQUALS_ONE 0=&RETRY_COUNT.}.',
    '    {endcase/}',
    '{endif/}')),
  'TITLE', '&NAME.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980307744722407627)
,p_name=>'ACTIVITY_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTIVITY_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980308228113407627)
,p_name=>'TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980308766967407628)
,p_name=>'NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980309283251407628)
,p_name=>'STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980309751975407628)
,p_name=>'ERROR_MESSAGE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ERROR_MESSAGE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980310247780407629)
,p_name=>'DUE_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980310730542407629)
,p_name=>'RETRY_COUNT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RETRY_COUNT'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980311251651407629)
,p_name=>'START_TIME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'START_TIME'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980311788302407630)
,p_name=>'END_TIME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'END_TIME'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980312298521407630)
,p_name=>'BADGE_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_TEXT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980312798334407631)
,p_name=>'BADGE_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980313212860407631)
,p_name=>'INVOKED_WORKFLOW_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INVOKED_WORKFLOW_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56980314799759407632)
,p_plug_name=>'Activity Audit'
,p_parent_plug_id=>wwv_flow_imp.id(56980307328791407626)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>80
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select created_by,',
'       created_on,',
'       action,',
'       display_msg',
'  from apex_workflow_audit',
' where workflow_id         = :P13_WORKFLOW_ID',
'   and current_activity_id = :P13_ACTIVITY_ID',
' order by audit_id'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$COMMENTS'
,p_ajax_items_to_submit=>'P13_WORKFLOW_ID,P13_ACTIVITY_ID'
,p_plug_query_num_rows=>5
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'COMMENT_DATE', 'CREATED_ON',
  'COMMENT_TEXT', 'DISPLAY_MSG',
  'DISPLAY_AVATAR', 'N',
  'STYLE', 't-Comments--basic',
  'USER_NAME', 'CREATED_BY')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980315160269407633)
,p_name=>'CREATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980315691025407633)
,p_name=>'CREATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_ON'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980316126354407633)
,p_name=>'ACTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980316609305407634)
,p_name=>'DISPLAY_MSG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISPLAY_MSG'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56980317522139407635)
,p_plug_name=>'Variables'
,p_region_name=>'VARIABLES'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>90
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select static_id,',
'       label,',
'       display_value',
'  from apex_workflow_variables',
' where workflow_id = :P13_WORKFLOW_ID',
'   and variable_type = ''VARIABLE''',
' order by label'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P13_WORKFLOW_ID'
,p_plug_query_num_rows=>10
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'OVERLINE', '&LABEL.',
  'TITLE', '&DISPLAY_VALUE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980317995558407635)
,p_name=>'STATIC_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATIC_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980318437469407635)
,p_name=>'LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980318981546407636)
,p_name=>'DISPLAY_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISPLAY_VALUE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56980319979288407637)
,p_plug_name=>'Edit Variable'
,p_parent_plug_id=>wwv_flow_imp.id(56980317522139407635)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>100
,p_plug_display_point=>'SUB_REGIONS'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56980322794419407639)
,p_plug_name=>'Parameters'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>110
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select label,',
'       display_value',
'  from apex_workflow_variables',
' where workflow_id = :P13_WORKFLOW_ID',
'   and variable_type = ''PARAMETER''',
' order by label'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P13_WORKFLOW_ID'
,p_plug_query_num_rows=>10
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'Y',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'OVERLINE', '&LABEL.',
  'TITLE', '&DISPLAY_VALUE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980323170381407639)
,p_name=>'LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980323609598407640)
,p_name=>'DISPLAY_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISPLAY_VALUE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56980324177917407640)
,p_plug_name=>'History'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>120
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select display_msg,',
'       created_by,',
'       created_on',
'  from apex_workflow_audit',
' where workflow_id = :P13_WORKFLOW_ID',
'   and current_activity_id is null',
' order by audit_id desc'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$COMMENTS'
,p_ajax_items_to_submit=>'P13_WORKFLOW_ID'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'COMMENT_DATE', 'CREATED_ON',
  'COMMENT_TEXT', 'DISPLAY_MSG',
  'DISPLAY_AVATAR', 'N',
  'STYLE', 't-Comments--basic',
  'USER_NAME', 'CREATED_BY')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980324542630407640)
,p_name=>'DISPLAY_MSG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISPLAY_MSG'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980325085931407641)
,p_name=>'CREATED_BY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_BY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56980325565159407641)
,p_name=>'CREATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_ON'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_format_mask=>'SINCE'
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56980326023376407642)
,p_plug_name=>'Workflow Diagram'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>130
,p_plug_source_type=>'NATIVE_WORKFLOW_DIAGRAM'
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'enable_navigator', 'Y',
  'initial_zoom', '0',
  'workflow_id', 'P13_WORKFLOW_ID')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56980326432481407642)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--stickToBottom:t-ButtonRegion--slimPadding:margin-bottom-none'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>200
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56980303516273407623)
,p_button_sequence=>50
,p_button_name=>'TO_PARENT_WORKFLOW'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'To Parent Workflow'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_WORKFLOW_ID:&P13_PARENT_WORKFLOW_ID.'
,p_button_condition=>'P13_PARENT_WORKFLOW_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-arrow-left-alt'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56980317174676407634)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56980314799759407632)
,p_button_name=>'CANCEL_ACTIVITY_AUDIT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56980321942960407638)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56980319979288407637)
,p_button_name=>'CANCEL_EDIT_VARIABLE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56980326883232407642)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56980326432481407642)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56980327241178407642)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56980326432481407642)
,p_button_name=>'SUSPEND'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Suspend'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.is_allowed (',
'    p_instance_id => :P13_WORKFLOW_ID,',
'    p_operation   => apex_workflow.c_workflow$_op_suspend )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-pause-circle u-warning-text'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56980327656418407643)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56980326432481407642)
,p_button_name=>'RESUME'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Resume'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.is_allowed (',
'    p_instance_id => :P13_WORKFLOW_ID,',
'    p_operation   => apex_workflow.c_workflow$_op_resume )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-play-circle u-success-text'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56980328011093407643)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(56980326432481407642)
,p_button_name=>'TERMINATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Terminate'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.is_allowed (',
'    p_instance_id => :P13_WORKFLOW_ID,',
'    p_operation   => apex_workflow.c_workflow$_op_terminate )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-times u-danger-text'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56980328404894407643)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(56980326432481407642)
,p_button_name=>'RETRY'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Retry'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.is_allowed (',
'    p_instance_id => :P13_WORKFLOW_ID,',
'    p_operation   => apex_workflow.c_workflow$_op_retry )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-redo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56980322357446407639)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56980319979288407637)
,p_button_name=>'UPDATE_VARIABLE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56980302341794407622)
,p_name=>'P13_WORKFLOW_ID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56980302723411407622)
,p_name=>'P13_ACTIVITY_ID'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56980303163765407623)
,p_name=>'P13_PARENT_WORKFLOW_ID'
,p_item_sequence=>30
,p_source=>'select parent_workflow_id from apex_workflows where workflow_id = :P13_WORKFLOW_ID'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56980320348925407637)
,p_name=>'P13_VARIABLE_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56980319979288407637)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56980320738984407637)
,p_name=>'P13_VARIABLE_LABEL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56980319979288407637)
,p_prompt=>'Variable'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56980321197730407638)
,p_name=>'P13_CURRENT_VALUE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56980319979288407637)
,p_prompt=>'Current Value'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56980321575273407638)
,p_name=>'P13_NEW_VALUE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(56980319979288407637)
,p_prompt=>'New Value'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>3
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56980328862064407644)
,p_name=>'Activity Audit'
,p_event_sequence=>10
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'a.audit'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980329209128407644)
,p_event_id=>wwv_flow_imp.id(56980328862064407644)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56980314799759407632)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980329702539407645)
,p_event_id=>wwv_flow_imp.id(56980328862064407644)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P13_ACTIVITY_ID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-id")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980330263531407645)
,p_event_id=>wwv_flow_imp.id(56980328862064407644)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56980314799759407632)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56980330735453407645)
,p_name=>'Cancel Activity Audit'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56980317174676407634)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980331102934407645)
,p_event_id=>wwv_flow_imp.id(56980330735453407645)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56980314799759407632)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56980331607933407646)
,p_name=>'Edit Variable'
,p_event_sequence=>30
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'a.variable'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#VARIABLES'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980332016866407646)
,p_event_id=>wwv_flow_imp.id(56980331607933407646)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56980319979288407637)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980332550149407647)
,p_event_id=>wwv_flow_imp.id(56980331607933407646)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(56980322357446407639)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980333048305407647)
,p_event_id=>wwv_flow_imp.id(56980331607933407646)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P13_VARIABLE_ID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-id")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980333595160407647)
,p_event_id=>wwv_flow_imp.id(56980331607933407646)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P13_VARIABLE_LABEL'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-label")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980334025084407647)
,p_event_id=>wwv_flow_imp.id(56980331607933407646)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P13_CURRENT_VALUE,P13_NEW_VALUE'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-value")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980334514409407648)
,p_event_id=>wwv_flow_imp.id(56980331607933407646)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P13_NEW_VALUE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56980335034145407648)
,p_name=>'Cancel Edit Variable'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56980321942960407638)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980335493830407648)
,p_event_id=>wwv_flow_imp.id(56980335034145407648)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P13_NEW_VALUE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980335950406407648)
,p_event_id=>wwv_flow_imp.id(56980335034145407648)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56980319979288407637)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56980336404711407649)
,p_name=>'Cancel Dialog'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56980326883232407642)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980336856061407649)
,p_event_id=>wwv_flow_imp.id(56980336404711407649)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56980337374002407649)
,p_name=>'Disable/Enable Update Button'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P13_NEW_VALUE'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.items.P13_NEW_VALUE.value != apex.items.P13_CURRENT_VALUE.value'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'keyup'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980337765712407650)
,p_event_id=>wwv_flow_imp.id(56980337374002407649)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(56980322357446407639)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56980338276168407650)
,p_event_id=>wwv_flow_imp.id(56980337374002407649)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(56980322357446407639)
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56980338713564407650)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update Variable'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.update_variables (',
'    p_instance_id    => :P13_WORKFLOW_ID,',
'    p_changed_params => apex_workflow.t_workflow_parameters (',
'        1 => apex_workflow.t_workflow_parameter (',
'                static_id    => :P13_VARIABLE_ID,',
'                string_value => :P13_NEW_VALUE ) ) );'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56980322357446407639)
,p_process_success_message=>'Variable updated'
,p_internal_uid=>56980338713564407650
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56980339197170407651)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'Suspend'
,p_attribute_01=>'SUSPEND'
,p_attribute_04=>'P13_WORKFLOW_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56980327241178407642)
,p_process_success_message=>'Workflow suspended'
,p_internal_uid=>56980339197170407651
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56980339572421407651)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'Resume'
,p_attribute_01=>'RESUME'
,p_attribute_04=>'P13_WORKFLOW_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56980327656418407643)
,p_process_success_message=>'Workflow resumed'
,p_internal_uid=>56980339572421407651
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56980339977232407651)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'Terminate'
,p_attribute_01=>'TERMINATE'
,p_attribute_04=>'P13_WORKFLOW_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56980328011093407643)
,p_process_success_message=>'Workflow terminated'
,p_internal_uid=>56980339977232407651
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56980340337982407651)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'Retry'
,p_attribute_01=>'RETRY'
,p_attribute_04=>'P13_WORKFLOW_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56980328404894407643)
,p_process_success_message=>'Workflow retried'
,p_internal_uid=>56980340337982407651
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56980340713666407652)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'UPDATE_VARIABLE'
,p_process_when_type=>'REQUEST_NOT_IN_CONDITION'
,p_internal_uid=>56980340713666407652
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(56980313710490407632)
,p_region_id=>wwv_flow_imp.id(56980307328791407626)
,p_position_id=>348722977165395441
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#'
,p_link_attributes=>'class="audit" data-id="&ACTIVITY_ID." aria-haspopup="dialog"'
,p_condition_type=>'ITEM_IS_NULL'
,p_condition_expr1=>'INVOKED_WORKFLOW_ID'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(56980314271731407632)
,p_region_id=>wwv_flow_imp.id(56980307328791407626)
,p_position_id=>348722977165395441
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_PAGE'
,p_link_target=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_WORKFLOW_ID:&INVOKED_WORKFLOW_ID.'
,p_condition_type=>'ITEM_IS_NOT_NULL'
,p_condition_expr1=>'INVOKED_WORKFLOW_ID'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(56980319445654407636)
,p_region_id=>wwv_flow_imp.id(56980317522139407635)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Edit'
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#'
,p_link_attributes=>'class="variable" data-id="&STATIC_ID!ATTR." data-label="&LABEL!ATTR." data-value="&DISPLAY_VALUE!ATTR." aria-haspopup="dialog"'
,p_button_display_type=>'TEXT'
,p_is_hot=>false
,p_show_as_disabled=>false
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_workflow.is_allowed (',
'    p_instance_id => :P13_WORKFLOW_ID,',
'    p_operation   => apex_workflow.c_workflow$_op_update_var )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>false
);
end;
/
prompt --application/pages/delete_00014
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>14);
end;
/
prompt --application/pages/page_00014
begin
wwv_flow_imp_page.create_page(
 p_id=>14
,p_name=>'Purchase_Request'
,p_alias=>'PURCHASE-REQUEST1'
,p_page_mode=>'MODAL'
,p_step_title=>'Purchase_Request'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(56607530477376018758)
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(112450447440926550569)
,p_plug_name=>'Purchase_Request'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'CUSTOMER_ORDERS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56983460528840486316)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P14_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56983459709744486315)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:14:&APP_SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56983460938371486316)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P14_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56983460160226486315)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
,p_button_execute_validations=>'N'
,p_confirm_message=>'&APP_TEXT$DELETE_MSG!RAW.'
,p_confirm_style=>'danger'
,p_button_condition=>'P14_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(56983472536787486327)
,p_branch_action=>'f?p=&APP_ID.:14:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56976629785095315207)
,p_name=>'P14_TASK_ID'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450450244319550575)
,p_name=>'P14_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Id'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450450661155550576)
,p_name=>'P14_ORDER_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_prompt=>'Order Date'
,p_source=>'ORDER_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450451050434550576)
,p_name=>'P14_STATUS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_source=>'STATUS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450451529783550577)
,p_name=>'P14_TOTAL_KG_ORDERED'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_prompt=>'Total Kg Ordered'
,p_source=>'TOTAL_KG_ORDERED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450451901442550577)
,p_name=>'P14_CREATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_source=>'CREATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450452297869550578)
,p_name=>'P14_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_source=>'CREATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450452697071550578)
,p_name=>'P14_UPDATED'
,p_source_data_type=>'DATE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_source=>'UPDATED'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450453119968550579)
,p_name=>'P14_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_source=>'UPDATED_BY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450453515220550579)
,p_name=>'P14_RICE_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_prompt=>'Rice Type'
,p_source=>'RICE_TYPE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select rice_type as r , rice_type as d from rice_item;'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450453878729550580)
,p_name=>'P14_SHOP_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_prompt=>'Shop Name'
,p_source=>'SHOP_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450454314849550580)
,p_name=>'P14_SHOP_LOCATION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_prompt=>'Shop Location'
,p_source=>'SHOP_LOCATION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(112450454741804550581)
,p_name=>'P14_CUSTOMER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_item_source_plug_id=>wwv_flow_imp.id(112450447440926550569)
,p_prompt=>'Customer Id'
,p_source=>'CUSTOMER_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select customer_code as d , customer_code as r from customers;'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(56976629801647315208)
,p_computation_sequence=>10
,p_computation_item=>'P14_ID'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'QUERY'
,p_computation=>'select param_value from apex_task_parameters where param_static_id = ''ID'' and TASK_ID =:P14_TASK_ID'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56983469055325486324)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(112450447440926550569)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Purchase_Request'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_required_patch=>wwv_flow_imp.id(54650442436467145814)
,p_internal_uid=>56983469055325486324
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56983469856371486325)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  customer_order_pkg.insert_order(',
'    p_customer_id       => :P14_CUSTOMER_ID,',
'    p_order_date        => :P14_ORDER_DATE,',
'    p_total_kg_ordered  => :P14_TOTAL_KG_ORDERED,',
'    p_rice_type         => :P14_RICE_TYPE,',
'    p_shop_name         => :P14_SHOP_NAME,',
'    p_shop_location     => :P14_SHOP_LOCATION',
'  );',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56983460938371486316)
,p_internal_uid=>56983469856371486325
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56983470218957486325)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'customer_order_pkg.update_order',
'(',
'    :P14_ID,',
'    :P14_CUSTOMER_ID,',
'    :P14_ORDER_DATE,',
'    :P14_TOTAL_KG_ORDERED,',
'    :P14_RICE_TYPE,',
'    :P14_SHOP_NAME,',
'    :P14_SHOP_LOCATION',
');',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56983460528840486316)
,p_internal_uid=>56983470218957486325
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56983470680784486325)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'customer_order_pkg.delete_order',
'(',
'   :P14_ID',
');',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56983460160226486315)
,p_internal_uid=>56983470680784486325
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56983471077895486325)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_WORKFLOW'
,p_process_name=>'New'
,p_attribute_01=>'START'
,p_attribute_02=>wwv_flow_imp.id(56441781020431500131)
,p_attribute_03=>'P14_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>56983471077895486325
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(56983471547569486327)
,p_page_process_id=>wwv_flow_imp.id(56983471077895486325)
,p_workflow_variable_id=>wwv_flow_imp.id(56976629225329315202)
,p_page_id=>14
,p_value_type=>'ITEM'
,p_value=>'P14_CUSTOMER_ID'
);
wwv_flow_imp_shared.create_workflow_comp_param(
 p_id=>wwv_flow_imp.id(56983472051290486327)
,p_page_process_id=>wwv_flow_imp.id(56983471077895486325)
,p_workflow_variable_id=>wwv_flow_imp.id(56976629122208315201)
,p_page_id=>14
,p_value_type=>'ITEM'
,p_value=>'P14_ID'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56976629604687315206)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Complete task'
,p_attribute_01=>'APPROVE_TASK'
,p_attribute_02=>'P14_TASK_ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>56976629604687315206
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56983468698619486323)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(112450447440926550569)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Purchase_Request'
,p_internal_uid=>56983468698619486323
);
end;
/
prompt --application/pages/delete_00024
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>24);
end;
/
prompt --application/pages/page_00024
begin
wwv_flow_imp_page.create_page(
 p_id=>24
,p_name=>'Task Details'
,p_page_mode=>'MODAL'
,p_step_title=>'Task Details'
,p_allow_duplicate_submissions=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.jQuery(() => {',
'    apex.jQuery("a.taskActionMenu").each((index, item) => {',
'        const element = apex.jQuery(item);',
'        const actionName = decodeURI(element.attr("href")).match(/\$([^?]+)/)[1];',
'        const actionLabel = element.text();',
'        apex.actions.add({',
'            name: actionName,',
'            label: actionLabel,',
'            action: (event, element, args) => {',
'                if (args.do === "submit") {',
'                    apex.page.submit(actionName.toUpperCase());',
'                }',
'                else if (args.do === "openRegion") {',
'                    apex.theme.openRegion(actionName.toUpperCase());',
'                }',
'            }',
'        });',
'    });',
'});'))
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_protection_level=>'C'
,p_page_component_map=>'27'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985306811897503452)
,p_plug_name=>'Subject'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--hideHeader js-addHiddenHeadingRoleDesc:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>30
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_id,',
'       task_type,',
'       task_def_name,',
'       details_app_name,',
'       details_link_target,',
'       subject,',
'       initiator,',
'       actual_owner,',
'       priority,',
'       due_on,',
'       due_in,',
'       due_in_hours,',
'       due_code,',
'       state_code,',
'       is_completed,',
'       outcome,',
'       created_on,',
'       created_ago,',
'       created_ago_hours,',
'       last_updated_on,',
'       badge_text,',
'       badge_state',
'  from table ( apex_human_task.get_tasks (',
'                   p_context => ''SINGLE_TASK'',',
'                   p_task_id => :P24_TASK_ID ) );'))
,p_template_component_type=>'PARTIAL'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'BADGE_COL_WIDTH', 't-ContentRow-badge--auto',
  'BADGE_LABEL', 'State',
  'BADGE_LABEL_DISPLAY', 'N',
  'BADGE_SIZE', 't-Badge--md',
  'BADGE_STATE', 'BADGE_STATE',
  'BADGE_VALUE', 'BADGE_TEXT',
  'DESCRIPTION', wwv_flow_string.join(wwv_flow_t_varchar2(
    '<strong>&TASK_DEF_NAME!HTML.</strong>',
    '{if INITIATOR/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &{APEX.TASK.INITIATED_BY_USER_SINCE 0=&INITIATOR!HTML. 1=&CREATED_AGO.}.',
    '{endif/}',
    '{if ACTUAL_OWNER/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &{APEX.TASK.ASSIGNED_TO_USER 0=&ACTUAL_OWNER!HTML.}.',
    '{endif/}',
    '{if !IS_COMPLETED/}',
    '    {case DUE_CODE/}',
    '        {when OVERDUE/}',
    '            <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            <strong class="u-danger-text">&{APEX.TASK.DUE_SINCE 0=&DUE_IN.}.</strong>',
    '        {when NEXT_HOUR/}',
    '            <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            <strong class="u-danger-text">&{APEX.TASK.DUE_SINCE 0=&DUE_IN.}.</strong>',
    '        {when NEXT_24_HOURS/}',
    '            <span role="separator" aria-label="&middot;"> &middot; </span>',
    '            <span class="u-danger-text">&{APEX.TASK.DUE_SINCE 0=&DUE_IN.}.</span>',
    '        {otherwise/}',
    '            {if DUE_IN/}',
    '                <span role="separator" aria-label="&middot;"> &middot; </span>',
    '                &{APEX.TASK.DUE_SINCE 0=&DUE_IN.}.',
    '            {endif/}',
    '    {endcase/}',
    '{endif/}',
    '{if !IS_COMPLETED/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    {case PRIORITY/}',
    '        {when 1/}',
    '            <strong class="u-danger-text">&{APEX.TASK.PRIORITY.1.DESCRIPTION}.</strong>',
    '        {when 2/}',
    '            <span class="u-danger-text">&{APEX.TASK.PRIORITY.2.DESCRIPTION}.</span>',
    '        {when 3/}',
    '            &{APEX.TASK.PRIORITY.3.DESCRIPTION}.',
    '        {when 4/}',
    '            &{APEX.TASK.PRIORITY.4.DESCRIPTION}.',
    '        {when 5/}',
    '            &{APEX.TASK.PRIORITY.5.DESCRIPTION}.',
    '    {endcase/}',
    '{endif/}',
    '{if OUTCOME/}',
    '    <span role="separator" aria-label="&middot;"> &middot; </span>',
    '    &OUTCOME.',
    '{endif/}')),
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'Y',
  'TITLE', '&SUBJECT.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985307205336503453)
,p_name=>'TASK_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TASK_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985307699842503454)
,p_name=>'TASK_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TASK_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985308123061503454)
,p_name=>'TASK_DEF_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TASK_DEF_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985308695904503454)
,p_name=>'DETAILS_APP_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETAILS_APP_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985309146590503455)
,p_name=>'DETAILS_LINK_TARGET'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETAILS_LINK_TARGET'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985309624546503455)
,p_name=>'SUBJECT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SUBJECT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>60
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985310199183503456)
,p_name=>'INITIATOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INITIATOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>70
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985310640010503456)
,p_name=>'ACTUAL_OWNER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTUAL_OWNER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>80
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985311185478503457)
,p_name=>'PRIORITY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRIORITY'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>90
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985311643381503457)
,p_name=>'DUE_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>100
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985312165994503457)
,p_name=>'DUE_IN'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_IN'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>110
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985312687275503458)
,p_name=>'DUE_IN_HOURS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_IN_HOURS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>120
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985313153500503458)
,p_name=>'DUE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DUE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>130
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985313687756503458)
,p_name=>'STATE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>140
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985314172674503459)
,p_name=>'IS_COMPLETED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_COMPLETED'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>150
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985314603008503459)
,p_name=>'OUTCOME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OUTCOME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>160
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985315130226503459)
,p_name=>'CREATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>170
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985315612573503460)
,p_name=>'CREATED_AGO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_AGO'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>180
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985316194728503460)
,p_name=>'CREATED_AGO_HOURS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_AGO_HOURS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>190
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985316620355503460)
,p_name=>'LAST_UPDATED_ON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LAST_UPDATED_ON'
,p_data_type=>'TIMESTAMP_TZ'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>200
,p_format_mask=>'SINCE'
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985317110456503461)
,p_name=>'BADGE_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_TEXT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>210
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985317645868503461)
,p_name=>'BADGE_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BADGE_STATE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>220
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985324044348503466)
,p_plug_name=>'Delegate'
,p_region_name=>'DELEGATE'
,p_parent_plug_id=>wwv_flow_imp.id(56985306811897503452)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_delegate )'))
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985325633975503468)
,p_plug_name=>'Priority'
,p_region_name=>'SET_PRIORITY'
,p_parent_plug_id=>wwv_flow_imp.id(56985306811897503452)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_set_priority )'))
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985327235215503469)
,p_plug_name=>'Due'
,p_region_name=>'SET_DUE_DATE'
,p_parent_plug_id=>wwv_flow_imp.id(56985306811897503452)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_set_due_date )'))
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985328885757503471)
,p_plug_name=>'Request Information'
,p_region_name=>'REQUEST_INFO'
,p_parent_plug_id=>wwv_flow_imp.id(56985306811897503452)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_request_info )'))
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985330443498503473)
,p_plug_name=>'Submit Information'
,p_region_name=>'SUBMIT_INFO'
,p_parent_plug_id=>wwv_flow_imp.id(56985306811897503452)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>50
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_submit_info )'))
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985332080503503474)
,p_plug_name=>'Invite Participant'
,p_region_name=>'ADD_OWNER'
,p_parent_plug_id=>wwv_flow_imp.id(56985306811897503452)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>60
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_add_owner )'))
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985333676167503475)
,p_plug_name=>'Remove Participant'
,p_region_name=>'REMOVE_OWNER'
,p_parent_plug_id=>wwv_flow_imp.id(56985306811897503452)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>70
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_remove_owner )'))
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985335270270503476)
,p_plug_name=>'Cancel Task'
,p_region_name=>'CANCEL'
,p_parent_plug_id=>wwv_flow_imp.id(56985306811897503452)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>80
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Do you really want to cancel this task?</p>',
'<p>This will mark the task as no longer needed.</p>'))
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_cancel )'))
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985336479911503477)
,p_plug_name=>'Details'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_plug_template=>4072358936313175081
,p_plug_display_sequence=>40
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select param_static_id,',
'       param_label,',
'       param_value,',
'       is_updatable,',
'       is_required',
'  from apex_task_parameters',
' where task_id = :P24_TASK_ID',
'   and is_visible = ''Y''',
' order by param_label;'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$CONTENT_ROW'
,p_ajax_items_to_submit=>'P24_TASK_ID'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null',
'  from apex_task_parameters',
' where task_id = :P24_TASK_ID'))
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'DISPLAY_AVATAR', 'N',
  'DISPLAY_BADGE', 'N',
  'HIDE_BORDERS', 'N',
  'OVERLINE', '&PARAM_LABEL.',
  'REMOVE_PADDING', 'N',
  'TITLE', '&PARAM_VALUE.')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985336887126503477)
,p_name=>'PARAM_STATIC_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARAM_STATIC_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985337367831503478)
,p_name=>'PARAM_LABEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARAM_LABEL'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985337801959503478)
,p_name=>'PARAM_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARAM_VALUE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985338362494503479)
,p_name=>'IS_UPDATABLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_UPDATABLE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985338864507503479)
,p_name=>'IS_REQUIRED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_REQUIRED'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985339898028503480)
,p_plug_name=>'Edit Parameter'
,p_parent_plug_id=>wwv_flow_imp.id(56985336479911503477)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>90
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>':P24_CAN_UPDATE_PARAMS = ''Y'''
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985343022301503482)
,p_plug_name=>'Comments'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>60
,p_plug_item_display_point=>'BELOW'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select apex_string.get_initials(created_by) as user_initials,',
'       ''u-color-''||ora_hash(created_by,45)  as user_css_class,',
'       created_by                           as user_name,',
'       text                                 as comment_text,',
'       created_on                           as comment_date',
'  from apex_task_comments',
' where nvl(:P24_ALL_COMMENTS, ''N'') = ''N''',
'       and task_id = :P24_TASK_ID',
'    or nvl(:P24_ALL_COMMENTS, ''N'') = ''Y''',
'       and task_id in ( ',
'                select task_id',
'                  from apex_tasks',
'               connect by prior previous_task_id = task_id',
'                 start with task_id = :P24_TASK_ID )',
' order by created_on desc'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$COMMENTS'
,p_ajax_items_to_submit=>'P24_TASK_ID,P24_ALL_COMMENTS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_no_data_found=>'No Comments'
,p_no_data_found_icon_classes=>'fa-comments-o fa-lg'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'AVATAR_CSS_CLASSES', '&USER_CSS_CLASS.',
  'AVATAR_DESCRIPTION', '&USER_NAME.',
  'AVATAR_INITIALS', 'USER_INITIALS',
  'AVATAR_SHAPE', 't-Avatar--circle',
  'AVATAR_TYPE', 'initials',
  'COMMENT_DATE', 'COMMENT_DATE',
  'COMMENT_TEXT', 'COMMENT_TEXT',
  'DISPLAY_AVATAR', 'Y',
  'STYLE', 't-Comments--chat',
  'USER_NAME', 'USER_NAME')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985343450374503483)
,p_name=>'USER_INITIALS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USER_INITIALS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985343920739503483)
,p_name=>'USER_CSS_CLASS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USER_CSS_CLASS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985344457126503483)
,p_name=>'USER_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USER_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985344978723503484)
,p_name=>'COMMENT_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMMENT_TEXT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985345432849503484)
,p_name=>'COMMENT_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMMENT_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_format_mask=>'SINCE'
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985347147752503485)
,p_plug_name=>'Add Comment'
,p_parent_plug_id=>wwv_flow_imp.id(56985343022301503482)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-nosize'
,p_plug_template=>1485369341786500999
,p_plug_display_sequence=>100
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_add_comment )'))
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985348736783503487)
,p_plug_name=>'History'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2664334895415463485
,p_plug_display_sequence=>70
,p_plug_item_display_point=>'BELOW'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select display_msg,',
'       event_creator,',
'       event_timestamp',
'  from table ( apex_human_task.get_task_history (',
'                   p_task_id     => :P24_TASK_ID,',
'                   p_include_all => :P24_ALL_HISTORY ) )',
' order by event_timestamp desc'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$COMMENTS'
,p_ajax_items_to_submit=>'P24_TASK_ID,P24_ALL_HISTORY'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_show_total_row_count=>false
,p_landmark_type=>'region'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'COMMENT_DATE', 'EVENT_TIMESTAMP',
  'COMMENT_TEXT', 'DISPLAY_MSG',
  'DISPLAY_AVATAR', 'N',
  'STYLE', 't-Comments--basic',
  'USER_NAME', 'EVENT_CREATOR')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985349135765503487)
,p_name=>'DISPLAY_MSG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISPLAY_MSG'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985349641038503488)
,p_name=>'EVENT_CREATOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EVENT_CREATOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(56985350135397503488)
,p_name=>'EVENT_TIMESTAMP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EVENT_TIMESTAMP'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_format_mask=>'SINCE'
,p_use_as_row_header=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56985351020867503489)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--stickToBottom:t-ButtonRegion--slimPadding:margin-bottom-none'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985324884882503467)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985324044348503466)
,p_button_name=>'CLOSE_DELEGATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985326456792503468)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985325633975503468)
,p_button_name=>'CLOSE_SET_PRIORITY'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985328068368503469)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985327235215503469)
,p_button_name=>'CLOSE_SET_DUE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985329628124503472)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985328885757503471)
,p_button_name=>'CLOSE_REQUEST_INFORMATION'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985331261665503473)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985330443498503473)
,p_button_name=>'CLOSE_SUBMIT_INFORMATION'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985332886579503474)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985332080503503474)
,p_button_name=>'CLOSE_INVITE_PARTICIPANT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985334422538503476)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985333676167503475)
,p_button_name=>'CLOSE_REMOVE_PARTICIPANT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985335688622503477)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985335270270503476)
,p_button_name=>'CLOSE_CANCEL_TASK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985342216510503482)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985339898028503480)
,p_button_name=>'CLOSE_UPDATE_PARAMETER'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985347958777503486)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985347147752503485)
,p_button_name=>'CLOSE_ADD_COMMENT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Close'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985351429520503489)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985351020867503489)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985351826368503489)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985351020867503489)
,p_button_name=>'CLAIM'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Claim Task'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_claim )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985352228652503490)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(56985351020867503489)
,p_button_name=>'REJECT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--link:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reject'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_reject )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-times-circle-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985352687421503490)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(56985351020867503489)
,p_button_name=>'APPROVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Approve'
,p_button_position=>'CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_approve )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985345995146503485)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56985343022301503482)
,p_button_name=>'OPEN_DIALOG_ADD_COMMENT'
,p_button_static_id=>'OPEN_DIALOG_ADD_COMMENT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Add Comment'
,p_button_position=>'EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'not apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_submit_info )',
'and apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_add_comment )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985325272202503467)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985324044348503466)
,p_button_name=>'DELEGATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Delegate'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985326809020503469)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985325633975503468)
,p_button_name=>'SET_PRIORITY'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Change Priority'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985328460950503470)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985327235215503469)
,p_button_name=>'SET_DUE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Change Due Date'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985330011207503472)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985328885757503471)
,p_button_name=>'REQUEST_INFORMATION'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Request Information'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985331652680503474)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985330443498503473)
,p_button_name=>'SUBMIT_INFORMATION'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit Information'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985333251348503475)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985332080503503474)
,p_button_name=>'INVITE_PARTICIPANT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Invite Participant'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985334865498503476)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985333676167503475)
,p_button_name=>'REMOVE_PARTICIPANT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Remove Participant'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985336034752503477)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985335270270503476)
,p_button_name=>'CANCEL_TASK'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel Task'
,p_button_position=>'EDIT'
,p_button_css_classes=>'u-danger'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985342663012503482)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985339898028503480)
,p_button_name=>'UPDATE_PARAMETER'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985346379695503485)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985343022301503482)
,p_button_name=>'OPEN_DIALOG_SUBMIT_INFORMATION'
,p_button_static_id=>'OPEN_DIALOG_SUBMIT_INFORMATION'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit Information'
,p_button_position=>'EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_submit_info )'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(56985348388216503487)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(56985347147752503485)
,p_button_name=>'ADD_COMMENT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Comment'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(56985381041962503507)
,p_branch_name=>'Reload Dialog'
,p_branch_action=>'f?p=&APP_ID.:&APP_PAGE_ID.:&APP_SESSION.::&DEBUG.::P24_TASK_ID:&P24_TASK_ID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985305684737503450)
,p_name=>'P24_TASK_ID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985306030377503451)
,p_name=>'P24_CAN_UPDATE_PARAMS'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985324488022503467)
,p_name=>'P24_NEW_OWNER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985324044348503466)
,p_prompt=>'New Owner'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( ',
'           apex_human_task.get_task_delegates ( ',
'               p_task_id => :P24_TASK_ID ) )'))
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'N',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985326027690503468)
,p_name=>'P24_NEW_PRIORITY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985325633975503468)
,p_prompt=>'New Priority'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select priority',
'  from apex_tasks',
' where task_id = :P24_TASK_ID'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'UNIFIED_TASK_LIST.LOV.PRIORITY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( apex_human_task.get_lov_priority )',
' order by insert_order'))
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_protection_level=>'S'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985327616028503469)
,p_name=>'P24_NEW_DUE_DATE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985327235215503469)
,p_use_cache_before_default=>'NO'
,p_prompt=>'New Due Date'
,p_format_mask=>'YYYY-MM-DD HH24:MI'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select to_char(due_on, ''YYYY-MM-DD HH24:MI'')',
'  from apex_tasks',
' where task_id = :P24_TASK_ID'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'INLINE',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'Y',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985329219063503472)
,p_name=>'P24_REQUEST_INFO_TEXT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985328885757503471)
,p_prompt=>'Message'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>7
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'Y',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985330845739503473)
,p_name=>'P24_SUBMIT_INFO_TEXT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985330443498503473)
,p_prompt=>'Message'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>7
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'Y',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985332437596503474)
,p_name=>'P24_NEW_POTENTIAL_OWNER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985332080503503474)
,p_prompt=>'New Potential Owner'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985334016296503475)
,p_name=>'P24_POTENTIAL_OWNER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985333676167503475)
,p_prompt=>'Potential Owner'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select disp,',
'       val',
'  from table ( ',
'           apex_human_task.get_task_delegates ( ',
'               p_task_id => :P24_TASK_ID ) )'))
,p_cHeight=>1
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'N',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985340293433503480)
,p_name=>'P24_PARAM_STATIC_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985339898028503480)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985340671262503480)
,p_name=>'P24_PARAM_LABEL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56985339898028503480)
,p_prompt=>'Parameter'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985341023603503481)
,p_name=>'P24_PARAM_VALUE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56985339898028503480)
,p_prompt=>'Current Value'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985341456367503481)
,p_name=>'P24_NEW_VALUE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(56985339898028503480)
,p_prompt=>'New Value'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>3
,p_field_template=>1609122147107268652
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985341855342503481)
,p_name=>'P24_IS_REQUIRED'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(56985339898028503480)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985346758861503485)
,p_name=>'P24_ALL_COMMENTS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56985343022301503482)
,p_prompt=>'Include comments from expired tasks'
,p_source=>'N'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_grid_label_column_span=>0
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_id ',
'  from apex_tasks',
' where task_id = :P24_TASK_ID',
'   and previous_task_id is not null'))
,p_display_when_type=>'EXISTS'
,p_field_template=>2318601014859922299
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'checked_value', 'Y',
  'unchecked_value', 'N',
  'use_defaults', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985347533164503486)
,p_name=>'P24_COMMENT_TEXT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985347147752503485)
,p_prompt=>'Comment'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>2000
,p_cHeight=>7
,p_field_template=>1609121967514267634
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'Y',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56985350698004503489)
,p_name=>'P24_ALL_HISTORY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56985348736783503487)
,p_prompt=>'Include history from expired tasks'
,p_source=>'N'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_grid_label_column_span=>0
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_id ',
'  from apex_tasks',
' where task_id = :P24_TASK_ID',
'   and previous_task_id is not null'))
,p_display_when_type=>'EXISTS'
,p_field_template=>2318601014859922299
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'checked_value', 'Y',
  'unchecked_value', 'N',
  'use_defaults', 'N')).to_clob
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(56985306454550503451)
,p_computation_sequence=>10
,p_computation_item=>'P24_CAN_UPDATE_PARAMS'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'EXPRESSION'
,p_computation_language=>'PLSQL'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'case ',
'    when apex_human_task.is_allowed (',
'            p_task_id   => :P24_TASK_ID,',
'            p_operation => apex_human_task.c_task_op_set_params )',
'    then ''Y''',
'    else ''N''',
'end'))
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56985371834568503501)
,p_validation_name=>'Delegate'
,p_validation_sequence=>10
,p_validation=>'P24_NEW_OWNER'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please provide a potential owner'
,p_when_button_pressed=>wwv_flow_imp.id(56985325272202503467)
,p_associated_item=>wwv_flow_imp.id(56985324488022503467)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56985372237634503501)
,p_validation_name=>'Request Information'
,p_validation_sequence=>20
,p_validation=>'P24_REQUEST_INFO_TEXT'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please provide a message'
,p_when_button_pressed=>wwv_flow_imp.id(56985330011207503472)
,p_associated_item=>wwv_flow_imp.id(56985329219063503472)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56985372659692503502)
,p_validation_name=>'Submit Information'
,p_validation_sequence=>30
,p_validation=>'P24_SUBMIT_INFO_TEXT'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please provide a message'
,p_when_button_pressed=>wwv_flow_imp.id(56985331652680503474)
,p_associated_item=>wwv_flow_imp.id(56985330845739503473)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56985373007486503502)
,p_validation_name=>'Invite Participant'
,p_validation_sequence=>40
,p_validation=>'P24_NEW_POTENTIAL_OWNER'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please provide a potential owner'
,p_when_button_pressed=>wwv_flow_imp.id(56985333251348503475)
,p_associated_item=>wwv_flow_imp.id(56985332437596503474)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56985373421898503502)
,p_validation_name=>'Remove Participant'
,p_validation_sequence=>50
,p_validation=>'P24_POTENTIAL_OWNER'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please provide a potential owner'
,p_when_button_pressed=>wwv_flow_imp.id(56985334865498503476)
,p_associated_item=>wwv_flow_imp.id(56985334016296503475)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56985373852164503502)
,p_validation_name=>'Update Parameter'
,p_validation_sequence=>60
,p_validation=>'P24_NEW_VALUE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please provide a new parameter value'
,p_validation_condition=>':REQUEST = ''UPDATE_PARAMETER'' and :P24_IS_REQUIRED = ''Y'''
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_imp.id(56985341456367503481)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(56985374256043503503)
,p_validation_name=>'Add Comment'
,p_validation_sequence=>70
,p_validation=>'P24_COMMENT_TEXT'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please provide a comment'
,p_when_button_pressed=>wwv_flow_imp.id(56985348388216503487)
,p_associated_item=>wwv_flow_imp.id(56985347533164503486)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985353080873503490)
,p_name=>'Refresh - Comments'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P24_ALL_COMMENTS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985353448202503490)
,p_event_id=>wwv_flow_imp.id(56985353080873503490)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985343022301503482)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985354877223503491)
,p_name=>'Edit Parameter'
,p_event_sequence=>10
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'a.parameter'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'body'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985355219033503491)
,p_event_id=>wwv_flow_imp.id(56985354877223503491)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985339898028503480)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985355779748503492)
,p_event_id=>wwv_flow_imp.id(56985354877223503491)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(56985342663012503482)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985356241029503492)
,p_event_id=>wwv_flow_imp.id(56985354877223503491)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P24_PARAM_STATIC_ID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-id")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985356747780503492)
,p_event_id=>wwv_flow_imp.id(56985354877223503491)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P24_PARAM_LABEL'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-label")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985357217584503493)
,p_event_id=>wwv_flow_imp.id(56985354877223503491)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P24_PARAM_VALUE,P24_NEW_VALUE'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-value")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985357785835503493)
,p_event_id=>wwv_flow_imp.id(56985354877223503491)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P24_IS_REQUIRED'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'apex.jQuery(this.triggeringElement).attr("data-required")'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985358230056503493)
,p_event_id=>wwv_flow_imp.id(56985354877223503491)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P24_NEW_VALUE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985370463933503500)
,p_name=>'Disable/Enable Update Button'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P24_NEW_VALUE'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.items.P24_NEW_VALUE.value != apex.items.P24_PARAM_VALUE.value'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'keyup'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985370852864503500)
,p_event_id=>wwv_flow_imp.id(56985370463933503500)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(56985342663012503482)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985371363104503501)
,p_event_id=>wwv_flow_imp.id(56985370463933503500)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(56985342663012503482)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985353985881503491)
,p_name=>'Refresh - History'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P24_ALL_HISTORY'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985354363565503491)
,p_event_id=>wwv_flow_imp.id(56985353985881503491)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985348736783503487)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985358799428503493)
,p_name=>'Add Comment'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985345995146503485)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985359104948503494)
,p_event_id=>wwv_flow_imp.id(56985358799428503493)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985347147752503485)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985359616949503494)
,p_name=>'Submit Information'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985346379695503485)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985360087896503494)
,p_event_id=>wwv_flow_imp.id(56985359616949503494)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985330443498503473)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985360590062503494)
,p_name=>'Cancel'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985351429520503489)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985360939701503495)
,p_event_id=>wwv_flow_imp.id(56985360590062503494)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985361469610503495)
,p_name=>'Close Delegate Dialog'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985324884882503467)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985361868953503495)
,p_event_id=>wwv_flow_imp.id(56985361469610503495)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985324044348503466)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985362306875503496)
,p_name=>'Close Change Priority Dialog'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985326456792503468)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985362754962503496)
,p_event_id=>wwv_flow_imp.id(56985362306875503496)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985325633975503468)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985363278837503496)
,p_name=>'Close Change Due Date Dialog'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985328068368503469)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985363688136503496)
,p_event_id=>wwv_flow_imp.id(56985363278837503496)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985327235215503469)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985364158978503496)
,p_name=>'Close Request Information Dialog'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985329628124503472)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985364509687503497)
,p_event_id=>wwv_flow_imp.id(56985364158978503496)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985328885757503471)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985365011692503497)
,p_name=>'Close Submit Information Dialog'
,p_event_sequence=>140
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985331261665503473)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985365402100503497)
,p_event_id=>wwv_flow_imp.id(56985365011692503497)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985330443498503473)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985365941850503497)
,p_name=>'Close Invite Participant Dialog'
,p_event_sequence=>150
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985332886579503474)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985366333864503498)
,p_event_id=>wwv_flow_imp.id(56985365941850503497)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985332080503503474)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985366808440503498)
,p_name=>'Close Remove Participant Dialog'
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985334422538503476)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985367226482503498)
,p_event_id=>wwv_flow_imp.id(56985366808440503498)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985333676167503475)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985367793433503499)
,p_name=>'Close Cancel Task Dialog'
,p_event_sequence=>170
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985335688622503477)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985368185738503499)
,p_event_id=>wwv_flow_imp.id(56985367793433503499)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985335270270503476)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985368600779503499)
,p_name=>'Close Edit Parameter Dialog'
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985342216510503482)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985369005487503499)
,p_event_id=>wwv_flow_imp.id(56985368600779503499)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985339898028503480)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(56985369581415503500)
,p_name=>'Close Add Comment Dialog'
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(56985347958777503486)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(56985369941200503500)
,p_event_id=>wwv_flow_imp.id(56985369581415503500)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(56985347147752503485)
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985374683978503503)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Renew Task'
,p_attribute_01=>'RENEW_TASK'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_09=>'P24_TASK_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'RENEW'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Task renewed'
,p_internal_uid=>56985374683978503503
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985375089289503503)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Claim'
,p_attribute_01=>'CLAIM_TASK'
,p_attribute_02=>'P24_TASK_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985351826368503489)
,p_internal_uid=>56985375089289503503
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985375477463503503)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Approve'
,p_attribute_01=>'APPROVE_TASK'
,p_attribute_02=>'P24_TASK_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985352687421503490)
,p_process_success_message=>'Task approved'
,p_internal_uid=>56985375477463503503
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985375809296503504)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Reject'
,p_attribute_01=>'REJECT_TASK'
,p_attribute_02=>'P24_TASK_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985352228652503490)
,p_process_success_message=>'Task rejected'
,p_internal_uid=>56985375809296503504
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985376254395503504)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Release'
,p_attribute_01=>'RELEASE_TASK'
,p_attribute_02=>'P24_TASK_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'RELEASE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Task released - can now be claimed by others'
,p_internal_uid=>56985376254395503504
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985376662882503504)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Delegate'
,p_attribute_01=>'DELEGATE_TASK'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_04=>'P24_NEW_OWNER'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985325272202503467)
,p_process_success_message=>'Task delegated to &P24_NEW_OWNER!HTML.'
,p_internal_uid=>56985376662882503504
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985377042673503504)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Change Priority'
,p_attribute_01=>'SET_TASK_PRIORITY'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_05=>'P24_NEW_PRIORITY'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985326809020503469)
,p_process_success_message=>'Task priority changed'
,p_internal_uid=>56985377042673503504
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985377403637503505)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Change Due Date'
,p_attribute_01=>'SET_DUE_DATE'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_06=>'P24_NEW_DUE_DATE'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985328460950503470)
,p_process_success_message=>'Task due date updated'
,p_internal_uid=>56985377403637503505
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985377815265503505)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Request Information'
,p_attribute_01=>'REQUEST_INFO'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_03=>'&P24_REQUEST_INFO_TEXT.'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985330011207503472)
,p_process_success_message=>'Information requested'
,p_internal_uid=>56985377815265503505
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985378292022503505)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Submit Information'
,p_attribute_01=>'SUBMIT_INFO'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_03=>'&P24_SUBMIT_INFO_TEXT.'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985331652680503474)
,p_process_success_message=>'Information submitted'
,p_internal_uid=>56985378292022503505
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985378681729503505)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Invite Participant'
,p_attribute_01=>'ADD_TASK_POTENTIAL_OWNER'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_04=>'P24_NEW_POTENTIAL_OWNER'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985333251348503475)
,p_process_success_message=>'Participant &P24_NEW_POTENTIAL_OWNER!HTML. added to task as potential owner'
,p_internal_uid=>56985378681729503505
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985379059463503505)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Remove Participant'
,p_attribute_01=>'REMOVE_POTENTIAL_OWNER'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_04=>'P24_POTENTIAL_OWNER'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985334865498503476)
,p_process_success_message=>'Participant &P24_POTENTIAL_OWNER!HTML. removed from task.'
,p_internal_uid=>56985379059463503505
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985379498299503506)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Cancel Task'
,p_attribute_01=>'CANCEL_TASK'
,p_attribute_02=>'P24_TASK_ID'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985336034752503477)
,p_process_success_message=>'Task canceled'
,p_internal_uid=>56985379498299503506
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985379879026503506)
,p_process_sequence=>140
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Update Parameter'
,p_attribute_01=>'SET_TASK_PARAMS'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_10=>'P24_PARAM_STATIC_ID'
,p_attribute_11=>'P24_NEW_VALUE'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985342663012503482)
,p_process_success_message=>'Parameter updated'
,p_internal_uid=>56985379879026503506
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985380273490503506)
,p_process_sequence=>150
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_MANAGE_TASK'
,p_process_name=>'Add Comment'
,p_attribute_01=>'ADD_TASK_COMMENT'
,p_attribute_02=>'P24_TASK_ID'
,p_attribute_03=>'&P24_COMMENT_TEXT.'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(56985348388216503487)
,p_process_success_message=>'Comment added'
,p_internal_uid=>56985380273490503506
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(56985380668357503506)
,p_process_sequence=>160
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_02=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CLAIM,SET_PRIORITY,SET_DUE,INVITE_PARTICIPANT,REMOVE_PARTICIPANT,RENEW,UPDATE_PARAMETER,SAVE,ADD_COMMENT'
,p_process_when_type=>'REQUEST_NOT_IN_CONDITION'
,p_internal_uid=>56985380668357503506
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(56985318185383503462)
,p_region_id=>wwv_flow_imp.id(56985306811897503452)
,p_position_id=>362316004162771045
,p_display_sequence=>20
,p_template_id=>362317865359806322
,p_label=>'Actions'
,p_button_display_type=>'ICON'
,p_icon_css_classes=>'fa-ellipsis-v'
,p_is_hot=>false
,p_show_as_disabled=>false
);
wwv_flow_imp_page.create_component_action(
 p_id=>wwv_flow_imp.id(56985339325634503479)
,p_region_id=>wwv_flow_imp.id(56985336479911503477)
,p_position_id=>362316004162771045
,p_display_sequence=>10
,p_template_id=>362316605839802174
,p_label=>'Edit'
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#'
,p_link_attributes=>'class="parameter" data-id="&PARAM_STATIC_ID!ATTR." data-label="&PARAM_LABEL!ATTR." data-value="&PARAM_VALUE!ATTR." data-required="&IS_REQUIRED!ATTR." aria-haspopup="dialog"'
,p_button_display_type=>'TEXT'
,p_is_hot=>false
,p_show_as_disabled=>false
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>':IS_UPDATABLE = ''Y'' and :P24_CAN_UPDATE_PARAMS = ''Y'''
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(56985318617849503462)
,p_component_action_id=>wwv_flow_imp.id(56985318185383503462)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Renew Task'
,p_display_sequence=>10
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$renew?do=submit'
,p_link_attributes=>'class="taskActionMenu"'
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_renew )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(56985319229350503463)
,p_component_action_id=>wwv_flow_imp.id(56985318185383503462)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Release'
,p_display_sequence=>20
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$release?do=submit'
,p_link_attributes=>'class="taskActionMenu"'
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_release )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(56985319833782503463)
,p_component_action_id=>wwv_flow_imp.id(56985318185383503462)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Delegate'
,p_display_sequence=>30
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$delegate?do=openRegion'
,p_link_attributes=>'class="taskActionMenu"'
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_delegate )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(56985320485743503463)
,p_component_action_id=>wwv_flow_imp.id(56985318185383503462)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Change Priority'
,p_display_sequence=>40
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$set_priority?do=openRegion'
,p_link_attributes=>'class="taskActionMenu"'
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_set_priority )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(56985321008412503464)
,p_component_action_id=>wwv_flow_imp.id(56985318185383503462)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Change Due Date'
,p_display_sequence=>50
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$set_due_date?do=openRegion'
,p_link_attributes=>'class="taskActionMenu"'
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_set_due_date )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(56985321603073503464)
,p_component_action_id=>wwv_flow_imp.id(56985318185383503462)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Request Information'
,p_display_sequence=>60
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$request_info?do=openRegion'
,p_link_attributes=>'class="taskActionMenu"'
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_request_info )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(56985322218210503465)
,p_component_action_id=>wwv_flow_imp.id(56985318185383503462)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Invite Participant'
,p_display_sequence=>70
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$add_owner?do=openRegion'
,p_link_attributes=>'class="taskActionMenu"'
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_add_owner )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(56985322856643503465)
,p_component_action_id=>wwv_flow_imp.id(56985318185383503462)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Remove Participant'
,p_display_sequence=>80
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$remove_owner?do=openRegion'
,p_link_attributes=>'class="taskActionMenu"'
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_remove_owner )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
wwv_flow_imp_page.create_comp_menu_entry(
 p_id=>wwv_flow_imp.id(56985323421057503466)
,p_component_action_id=>wwv_flow_imp.id(56985318185383503462)
,p_menu_entry_type=>'ENTRY'
,p_label=>'Cancel Task'
,p_display_sequence=>90
,p_link_target_type=>'REDIRECT_URL'
,p_link_target=>'#action$cancel?do=openRegion'
,p_link_attributes=>'class="taskActionMenu"'
,p_condition_type=>'EXPRESSION'
,p_condition_expr1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_human_task.is_allowed (',
'    p_task_id   => :P24_TASK_ID,',
'    p_operation => apex_human_task.c_task_op_cancel )'))
,p_condition_expr2=>'PLSQL'
,p_exec_cond_for_each_row=>true
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
--commit;
end;
/
set verify on feedback on define on
prompt  ...done
