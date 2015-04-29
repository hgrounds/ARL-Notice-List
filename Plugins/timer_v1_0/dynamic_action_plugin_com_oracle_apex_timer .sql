set define off
set verify off
set serveroutput on size 1000000
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end; 
/
 
--       AAAA       PPPPP   EEEEEE  XX      XX
--      AA  AA      PP  PP  EE       XX    XX
--     AA    AA     PP  PP  EE        XX  XX
--    AAAAAAAAAA    PPPPP   EEEE       XXXX
--   AA        AA   PP      EE        XX  XX
--  AA          AA  PP      EE       XX    XX
--  AA          AA  PP      EEEEEE  XX      XX
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Oracle user APEX_040000 or as the owner (parsing schema) of the application.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,697160412873685139));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin 

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'en'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2010.05.13');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_flow_id := nvl(wwv_flow_application_install.get_application_id,654321);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
null;
 
end;
/

prompt  ...plugins
--
--application/shared_components/plugins/dynamic_action/com_oracle_apex_timer
 
begin
 
wwv_flow_api.create_plugin (
  p_id => 4011653921273626225 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_type => 'DYNAMIC ACTION'
 ,p_name => 'COM.ORACLE.APEX.TIMER'
 ,p_display_name => 'Timer'
 ,p_category => 'INIT'
 ,p_image_prefix => '#PLUGIN_PREFIX#'
 ,p_plsql_code => 
'function render_timer ('||chr(10)||
'    p_dynamic_action  in apex_plugin.t_dynamic_action,'||chr(10)||
'    p_plugin          in apex_plugin.t_plugin )'||chr(10)||
'    return apex_plugin.t_dynamic_action_render_result'||chr(10)||
'is'||chr(10)||
'    l_action     varchar2(10) := nvl(p_dynamic_action.attribute_01, ''add'');'||chr(10)||
'    l_timer_name varchar2(20) := substr(nvl(case l_action'||chr(10)||
'                                              when ''add''    then p_dynamic_action.'||
'attribute_02'||chr(10)||
'                                              when ''remove'' then p_dynamic_action.attribute_03'||chr(10)||
'                                            end, p_dynamic_action.id), 1, 20);'||chr(10)||
'    l_expire_in  number       := nvl(p_dynamic_action.attribute_04, 1000);'||chr(10)||
'    l_occurrence varchar2(10) := nvl(p_dynamic_action.attribute_05, ''infinite'');'||chr(10)||
''||chr(10)||
'    l_result apex_plugin.t_dynamic_action_render_result;'||
''||chr(10)||
'begin'||chr(10)||
'    apex_javascript.add_library ('||chr(10)||
'        p_name      => ''com_oracle_apex_timer.min'','||chr(10)||
'        p_directory => p_plugin.file_prefix,'||chr(10)||
'        p_version   => null );'||chr(10)||
''||chr(10)||
'    l_result.javascript_function := ''com_oracle_apex_timer.init'';'||chr(10)||
'    l_result.attribute_01        := l_action;'||chr(10)||
'    l_result.attribute_02        := l_timer_name;'||chr(10)||
'    l_result.attribute_03        := l_expire_in;'||chr(10)||
'    l_result.attrib'||
'ute_04        := l_occurrence;'||chr(10)||
'    return l_result;'||chr(10)||
'end render_timer;'
 ,p_render_function => 'render_timer'
 ,p_standard_attributes => 'ITEM:REGION:DOM_OBJECT:JQUERY_SELECTOR:TRIGGERING_ELEMENT:EVENT_SOURCE:REQUIRED'
 ,p_help_text => '<p>'||chr(10)||
'	&nbsp;</p>'||chr(10)||
'<div id="cke_pastebin">'||chr(10)||
'	This plug-in is a dynamic action which allows to periodically fire other dynamic actions in the browser.&nbsp;For example to refresh a region. But you can perform any action you want, because the plug-in just provides&nbsp;the infrastructure so that you can hook up your own actions which you want to execute periodically.</div>'||chr(10)||
'<div>'||chr(10)||
'	&nbsp;</div>'||chr(10)||
'<ol>'||chr(10)||
'	<li>'||chr(10)||
'		Create a dynamic action with the &quot;Timer&quot; plug-in which sets up the periodic timer</li>'||chr(10)||
'	<li>'||chr(10)||
'		Create a dynamic action for the event &quot;Timer Expired [Plug-in]&quot; where you execute your periodic actions.</li>'||chr(10)||
'</ol>'||chr(10)||
''
 ,p_version_identifier => '1.0'
 ,p_about_url => 'http://www.oracleapex.info/'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 4011654424520636602 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 4011653921273626225 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 1
 ,p_display_sequence => 10
 ,p_prompt => 'Action'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => true
 ,p_default_value => 'add'
 ,p_is_translatable => false
 ,p_help_text => 'Specify if you want to <strong>add</strong> or <strong>remove</strong> a timer. If you add a timer with the same name again, the existing one will be removed and created again. If you remove an existing timer, you have to specify a name when you add the timer so that you are able to identify it when you remove it.'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 4011655032486638881 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 4011654424520636602 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Add Timer'
 ,p_return_value => 'add'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 4011655419111644555 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 4011654424520636602 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Remove Timer'
 ,p_return_value => 'remove'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 4011655732364705140 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 4011653921273626225 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 2
 ,p_display_sequence => 20
 ,p_prompt => 'Timer Name'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => false
 ,p_display_length => 20
 ,p_max_length => 20
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 4011654424520636602 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'add'
 ,p_help_text => 'If you want to remove a timer with the "Remove Timer" action you have to specify a name for the timer when you create it. If you just want to create a timer you don''t have to specify a timer name.'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 4011656220374711130 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 4011653921273626225 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 3
 ,p_display_sequence => 30
 ,p_prompt => 'Timer Name'
 ,p_attribute_type => 'TEXT'
 ,p_is_required => true
 ,p_display_length => 20
 ,p_max_length => 20
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 4011654424520636602 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'remove'
 ,p_help_text => 'Name of the timer you want to remove. Use the same name you used when you created the timer.'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 4011656716480728867 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 4011653921273626225 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 4
 ,p_display_sequence => 40
 ,p_prompt => 'Expire in x Milliseconds'
 ,p_attribute_type => 'INTEGER'
 ,p_is_required => true
 ,p_display_length => 10
 ,p_max_length => 10
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 4011654424520636602 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'add'
 ,p_help_text => 'Specify the number of milliseconds after which the timer should expire. There are 1000 milliseconds in one second.'
  );
wwv_flow_api.create_plugin_attribute (
  p_id => 4011657205183735076 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 4011653921273626225 + wwv_flow_api.g_id_offset
 ,p_attribute_scope => 'COMPONENT'
 ,p_attribute_sequence => 5
 ,p_display_sequence => 50
 ,p_prompt => 'Occurrence'
 ,p_attribute_type => 'SELECT LIST'
 ,p_is_required => true
 ,p_default_value => 'infinite'
 ,p_is_translatable => false
 ,p_depending_on_attribute_id => 4011654424520636602 + wwv_flow_api.g_id_offset
 ,p_depending_on_condition_type => 'EQUALS'
 ,p_depending_on_expression => 'add'
 ,p_help_text => 'Specify how often the timer should fire. The timer can be fired just <strong>once</strong> or <strong>infinite</strong> until you remove it with the "Remove Timer" action.'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 4011657813495737503 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 4011657205183735076 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 10
 ,p_display_value => 'Once'
 ,p_return_value => 'once'
  );
wwv_flow_api.create_plugin_attr_value (
  p_id => 4011658218689739000 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_attribute_id => 4011657205183735076 + wwv_flow_api.g_id_offset
 ,p_display_sequence => 20
 ,p_display_value => 'Infinite'
 ,p_return_value => 'infinite'
  );
wwv_flow_api.create_plugin_event (
  p_id => 4011654205820631246 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 4011653921273626225 + wwv_flow_api.g_id_offset
 ,p_name => 'timer_expired'
 ,p_display_name => 'Timer Expired'
  );
null;
 
end;
/

 
begin
 
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '636F6D5F6F7261636C655F617065785F74696D65723D7B6372656174656454696D6572733A7B7D2C696E69743A66756E6374696F6E28297B76617220613D746869732E616374696F6E2E61747472696275746530312C663D746869732E616374696F6E2E';
wwv_flow_api.g_varchar2_table(2) := '61747472696275746530322C653D7061727365496E7428746869732E616374696F6E2E61747472696275746530332C3130292C633D746869732E616374696F6E2E61747472696275746530342C643D746869732E6166666563746564456C656D656E7473';
wwv_flow_api.g_varchar2_table(3) := '3B66756E6374696F6E206228297B696628633D3D3D22696E66696E69746522297B636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D3D73657454696D656F757428622C65297D656C73657B64656C65746520';
wwv_flow_api.g_varchar2_table(4) := '636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D7D642E74726967676572282274696D65725F657870697265642E434F4D5F4F5241434C455F415045585F54494D4552222C66297D696628613D3D3D226164';
wwv_flow_api.g_varchar2_table(5) := '6422297B696628636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D297B636C65617254696D656F757428636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D297D';
wwv_flow_api.g_varchar2_table(6) := '636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D3D73657454696D656F757428622C65297D656C73657B696628613D3D3D2272656D6F766522297B696628636F6D5F6F7261636C655F617065785F74696D65';
wwv_flow_api.g_varchar2_table(7) := '722E6372656174656454696D6572735B665D297B636C65617254696D656F757428636F6D5F6F7261636C655F617065785F74696D65722E6372656174656454696D6572735B665D293B64656C65746520636F6D5F6F7261636C655F617065785F74696D65';
wwv_flow_api.g_varchar2_table(8) := '722E6372656174656454696D6572735B665D7D7D7D7D7D3B';
null;
 
end;
/

 
begin
 
wwv_flow_api.create_plugin_file (
  p_id => 4011667609568958021 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_id => 4011653921273626225 + wwv_flow_api.g_id_offset
 ,p_file_name => 'com_oracle_apex_timer.min.js'
 ,p_mime_type => 'text/javascript'
 ,p_file_content => wwv_flow_api.g_varchar2_table
  );
null;
 
end;
/

commit;
begin 
execute immediate 'begin dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/
set verify on
set feedback on
prompt  ...done
