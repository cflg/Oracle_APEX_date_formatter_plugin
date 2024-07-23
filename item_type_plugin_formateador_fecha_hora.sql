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
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.0'
,p_default_workspace_id=>2000497131370443
,p_default_application_id=>139
,p_default_id_offset=>61707333900934268
,p_default_owner=>'HMS_DESA'
);
end;
/
 
prompt APPLICATION 139 - EVENTOS MÉDICOS
--
-- Application Export:
--   Application:     139
--   Name:            EVENTOS MÉDICOS
--   Date and Time:   15:32 Tuesday July 23, 2024
--   Exported By:     HM34653965
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 87096023398183199
--   Manifest End
--   Version:         23.2.0
--   Instance ID:     708617302808332
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/formateador_fecha_hora
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(87096023398183199)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'FORMATEADOR_FECHA_HORA'
,p_display_name=>'ITEM FORMATEADOR DE FECHAS'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PROCEDURE format_date_item_rendering (',
'    p_item     IN            apex_plugin.t_page_item,-- Item Name'',',
'    p_plugin   IN            apex_plugin.t_plugin, -- Plugin name''',
'    --p_value    IN            NUMBER,-- Value of the item'',',
'    p_param    IN            apex_plugin.t_item_render_param,',
'    p_result   IN OUT NOCOPY apex_plugin.t_item_render_result',
')',
'IS',
'    l_input_code VARCHAR2(4000);',
'    -- CONFIGURACION',
'    l_id_item apex_application_page_items.attribute_01%TYPE:= Nvl(p_item.attribute_01, ''SIN ID'');',
'    l_mostrar_hora apex_application_page_items.attribute_04%TYPE:= nvl(p_item.attribute_04, '''');',
'    l_label apex_application_page_items.attribute_05%TYPE:= nvl(p_item.attribute_05, '''');',
'    --l_hora apex_application_page_items.attribute_13%TYPE:= nvl(p_item.attribute_13, ''00:00'');',
'    -- ESTILOS',
'    l_container apex_application_page_items.attribute_06%TYPE:= Nvl(p_item.attribute_06, '''');',
'    l_div_label apex_application_page_items.attribute_07%TYPE:= nvl(p_item.attribute_07, '''');',
'    l_label_class apex_application_page_items.attribute_08%TYPE:= nvl(p_item.attribute_08, '''');',
'    l_input_container apex_application_page_items.attribute_09%TYPE:= nvl(p_item.attribute_09, '''');',
'    l_item_wrapper apex_application_page_items.attribute_10%TYPE:= nvl(p_item.attribute_10, '''');',
'    l_input apex_application_page_items.attribute_11%TYPE:= nvl(p_item.attribute_11, '''');',
'    l_error apex_application_page_items.attribute_12%TYPE:= nvl(p_item.attribute_12, '''');',
'BEGIN',
'    ',
'    apex_javascript.add_inline_code (',
'        p_code   =>',
'            ''',
'            $(document).ready(function() {',
'                $("#''||l_id_item||''").on("blur", function() {',
'                ',
'                let idColumna = "''||l_id_item||''";',
'                let mostrarHora = "''||l_mostrar_hora||''";',
'                let fechaFormateada;',
'',
'                //console.log("Parametros => ","ID / Nombre Item: ", idColumna,", Muestra Hora? ", mostrarHora);',
'',
'                let dateInputValue;',
'                ',
'                dateInputValue = document.getElementById(`${idColumna}`);',
'',
'                //console.log("Input:", dateInputValue.value);',
'                ',
'                function formatDate(input) {',
'                    let dateTimeParts, datePart, timePart, day, month, year;',
'                    ',
'                    // FORMATO #1',
'                    // Si la entrada es del formato "ddmmyyyy hh:mm"',
'                    if (/^\d{6,8} \d{2}:\d{2}$/.test(input)) {',
'                        //console.log("Detectado FORMATO #1");',
'                        dateTimeParts = input.split(" ");',
'                        datePart = dateTimeParts[0];',
'                        timePart = dateTimeParts[1];',
'                        day = datePart.slice(0, 2);',
'                        month = datePart.slice(2, 4);',
'                        year = datePart.slice(4, 8);',
'                        ',
'                        if (mostrarHora === "SI") {',
'                            fechaFormateada = day + "/" + month + "/" + year + " " + timePart;',
'                            return fechaFormateada;',
'                        } else {',
'                            fechaFormateada = day + "/" + month + "/" + year;',
'                            return fechaFormateada;',
'                        }',
'                    }',
'',
'                    // FORMATO #2',
'                    // Si la entrada es del formato "d/m/yy"',
'                    if (/^\d{1,2}\/\d{1,2}\/\d{2}$/.test(input)) {',
'                        //console.log("Detectado FORMATO #2");',
'                        dateTimeParts = input.split(" ");',
'                        let dateParts = dateTimeParts[0].split("/");',
'                        timePart = dateTimeParts[1];',
'                        day = dateParts[0].length === 1 ? "0" + dateParts[0] : dateParts[0];',
'                        month = dateParts[1].length === 1 ? "0" + dateParts[1] : dateParts[1];',
'                        year = "20" + dateParts[2];',
'                        ',
'                        if (mostrarHora === "SI") {',
'                            fechaFormateada = day + "/" + month + "/" + year + " " + "00:00";',
'                            return fechaFormateada;',
'                        } else {',
'                            fechaFormateada = day + "/" + month + "/" + year;',
'                            return fechaFormateada;',
'                        }',
'                    }',
'',
'                    // FORMATO #2.5',
'                    // Si la entrada es del formato "d/m/yy hh:mm"',
'                    if (/^\d{1,2}\/\d{1,2}\/\d{2} \d{2}:\d{2}$/.test(input)) {',
'                        //console.log("Detectado FORMATO #2.5");',
'                        dateTimeParts = input.split(" ");',
'                        let dateParts = dateTimeParts[0].split("/");',
'                        timePart = dateTimeParts[1];',
'                        day = dateParts[0].length === 1 ? "0" + dateParts[0] : dateParts[0];',
'                        month = dateParts[1].length === 1 ? "0" + dateParts[1] : dateParts[1];',
'                        year = "20" + dateParts[2];',
'                        ',
'                        if (mostrarHora === "SI") {',
'                            fechaFormateada = day + "/" + month + "/" + year + " " + timePart;',
'                            return fechaFormateada;',
'                        } else {',
'                            fechaFormateada = day + "/" + month + "/" + year;',
'                            return fechaFormateada;',
'                        }',
'                    }',
'',
'                    // FORMATO #3',
'                    // Si la entrada es del formato "ddmmyyyy hhmm" o "ddmmyy hhmm"',
'                    if (/^\d{6,8} \d{4}$/.test(input)) {',
'                        //console.log("Detectado FORMATO #3");',
'                        dateTimeParts = input.split(" ");',
'                        datePart = dateTimeParts[0];',
'                        timePart = dateTimeParts[1];',
'                        day = datePart.slice(0, 2);',
'                        month = datePart.slice(2, 4);',
'                        year = datePart.slice(4);',
'                        ',
'                        if (year.length === 2) {',
'                            year = "20" + year;',
'                        }',
'',
'                        let hour = timePart.slice(0, 2);',
'                        let minute = timePart.slice(2, 4);',
'                        ',
'                        if (mostrarHora === "SI") {',
'                            fechaFormateada = day + "/" + month + "/" + year + " " + hour + ":" + minute;',
'                            return fechaFormateada;                           ',
'                        } else {',
'                            fechaFormateada = day + "/" + month + "/" + year;',
'                            return fechaFormateada;',
'                        }',
'                    }',
'',
'                    // FORMATO #4',
'                    // Si la entrada es del formato "d/m/yy hhmm"',
'                    if (/^\d{1,2}\/\d{1,2}\/\d{2} \d{4}$/.test(input)) {',
'                        //console.log("Detectado FORMATO #4");',
'                        dateTimeParts = input.split(" ");',
'                        let dateParts = dateTimeParts[0].split("/");',
'                        timePart = dateTimeParts[1];',
'                        day = dateParts[0].length === 1 ? "0" + dateParts[0] : dateParts[0];',
'                        month = dateParts[1].length === 1 ? "0" + dateParts[1] : dateParts[1];',
'                        year = "20" + dateParts[2]; ',
'                        let hour = timePart.slice(0, 2);',
'                        let minute = timePart.slice(2, 4);',
'                        ',
'                        if (mostrarHora === "SI") {',
'                            fechaFormateada = day + "/" + month + "/" + year + " " + hour + ":" + minute;',
'                            return fechaFormateada;                          ',
'                        } else {',
'                            fechaFormateada = day + "/" + month + "/" + year;',
'                            return fechaFormateada;',
'                        }',
'                    }',
'',
'                    // FORMATO #5',
'                    // Si la entrada es del formato "dmyy" y mostrarHora es false',
'                    if (/^\d{4}$/.test(input) && mostrarHora == "NO") {',
'                        //console.log("Detectado FORMATO #5");',
'                        datePart = input;',
'                        day = "0" + datePart.slice(0, 1);',
'                        month = "0" + datePart.slice(1, 2);',
'                        year = "20" + datePart.slice(2, 4);',
'                        fechaFormateada = day + "/" + month + "/" + year;',
'                        return fechaFormateada;',
'                    }',
'',
'                    // FORMATO #5.5',
'                    // Si la entrada es del formato "dmyy" y mostrarHora es true',
'                    if (/^\d{4}$/.test(input) && mostrarHora == "SI") {',
'                        //console.log("Detectado FORMATO #5.5");',
'                        datePart = input;',
'                        ',
'                        let day = "0" + datePart.slice(0, 1);',
'                        let month = "0" + datePart.slice(1, 2);',
'                        let year = "20" + datePart.slice(2, 4);',
'                        ',
'                        return day + "/" + month + "/" + year + " " + "00:00";',
'                    }',
'',
'                    // FORMATO #6',
'                    // Si la entrada es del formato "ddmmyy" y mostrarHora es false',
'                    if (/^\d{6}$/.test(input) && mostrarHora === "NO") {',
'                        //console.log("Detectado FORMATO #6");',
'                        datePart = input;',
'                        day = datePart.slice(0, 2);',
'                        month = datePart.slice(2, 4);',
'                        year = "20" + datePart.slice(4);',
'                        fechaFormateada = day + "/" + month + "/" + year;',
'                        return fechaFormateada;',
'                    }',
'',
'                    // FORMATO #6.5',
'                    // Si la entrada es del formato "ddmmyy" y mostrarHora SI',
'                    if (/^\d{6}$/.test(input) && mostrarHora == "SI") {',
'                        //console.log("Detectado FORMATO #6.5");',
'                        datePart = input;',
'                        ',
'                        let day = datePart.slice(0, 2);',
'                        let month = datePart.slice(2, 4);',
'                        let year = "20" + datePart.slice(4);',
'                        ',
'                        return day + "/" + month + "/" + year + " " + "00:00";',
'                    }',
'',
'                    // FORMATO #7',
'                    // Si la entrada es del formato "ddmmyyyy" y mostrarHora NO',
'                    if (/^\d{8}$/.test(input) && mostrarHora == "NO") {',
'                        //console.log("Detectado FORMATO #7");',
'                        datePart = input;',
'                        day = datePart.slice(0, 2);',
'                        month = datePart.slice(2, 4);',
'                        year = datePart.slice(4);',
'                        fechaFormateada = day + "/" + month + "/" + year;',
'                        return fechaFormateada;',
'                    }',
'',
'                    // FORMATO #7.5',
'                    // Si la entrada es del formato "ddmmyyyy" y mostrarHora SI',
'                    if (/^\d{8}$/.test(input) && mostrarHora == "SI") {',
'                        //console.log("Detectado FORMATO #7.5");',
'                        datePart = input;',
'                        day = datePart.slice(0, 2);',
'                        month = datePart.slice(2, 4);',
'                        year = datePart.slice(4);',
'                        fechaFormateada = day + "/" + month + "/" + year + " 00:00";',
'                        return fechaFormateada;',
'                    }',
'',
'',
'                    return null;',
'                }',
'                ',
'                fechaFormateada = formatDate(dateInputValue.value);',
'                //console.log("Output: ", fechaFormateada);',
'                ',
'                if (fechaFormateada) {',
'                    apex.item(idColumna).setValue(fechaFormateada);',
'                } else {',
'                    //console.log("Formato de fecha no reconocido.");',
'                }',
'                ',
'            });',
'        });',
'',
'            '');',
'    ',
'    l_input_code := ''<div class="'' || l_container || ''t-Form-fieldContainer t-Form-fieldContainer--floatingLabel apex-item-wrapper apex-item-wrapper--text-field" id="'' || l_id_item || ''_CONTAINER">',
'                         <div class="'' || l_div_label || ''t-Form-labelContainer" style="display: flex; justify-content: center; width: 100%;">',
'                             <label for="'' || l_id_item || ''" id="''  || l_id_item ||  ''_LABEL" class="'' || l_label_class || ''t-Form-label" style="text-align: center; width: 100%;">',
'                                '' || l_label || ''',
'                             </label>',
'                         </div>',
'                         <div class="'' || l_input_container || ''t-Form-inputContainer centered-item">',
'                            <div class="'' || l_item_wrapper || ''t-Form-itemWrapper">',
'                                <input type="text" id="''  || l_id_item ||  ''" name="''  || l_id_item ||  ''" class="'' || l_input || ''text_field apex-item-text" value="" size="30" style="text-align: center;">',
'                            </div>',
'                            <span id="''  || l_id_item ||  ''_error_placeholder" class="'' || l_error || ''a-Form-error">',
'                            </span>',
'                         </div>',
'                     </div>'';',
'    ',
'    HTP.p(l_input_code);',
'END format_date_item_rendering;'))
,p_default_escape_mode=>'HTML'
,p_api_version=>2
,p_render_function=>'format_date_item_rendering'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:READONLY:QUICKPICK:SOURCE:ELEMENT:WIDTH:HEIGHT:ELEMENT_OPTION:PLACEHOLDER:ICON:INIT_JAVASCRIPT_CODE'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Este plugin formatea automaticamente tanto fecha como fecha y hora. Admite los siguiente formatos:',
'',
'- "ddmmyyyy hh:mm"',
'- "d/m/yy"',
'- "d/m/yy hh:mm"',
'- "ddmmyyyy hhmm"',
'- "ddmmyy hhmm"',
'- "d/m/yy hhmm"',
'- "dmyy"',
'- "ddmmyy"',
'- "ddmmyyyy"',
'',
'',
'Dando como salida:',
'',
'Muestra Hora? SI',
'''dd/mm/yyyy hh:mm''',
'',
'Muestra Hora? NO',
'''dd/mm/yyyy'''))
,p_version_identifier=>'1.0.0'
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(87626884534709351)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_title=>'Estilos (se inyectan directamente en el at. class)'
,p_display_sequence=>20
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(87107105943381680)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_title=>unistr('Par\00E1metros de Configuraci\00F3n')
,p_display_sequence=>10
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87102525065338018)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'*ID del Item'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(87107105943381680)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87619683380633370)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Muestra Hora'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'SI'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(87107105943381680)
,p_help_text=>'Elegi si queres mostrar la hora o no.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(87620540813635924)
,p_plugin_attribute_id=>wwv_flow_imp.id(87619683380633370)
,p_display_sequence=>10
,p_display_value=>'SI'
,p_return_value=>'SI'
,p_is_quick_pick=>true
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(87621496841638455)
,p_plugin_attribute_id=>wwv_flow_imp.id(87619683380633370)
,p_display_sequence=>20
,p_display_value=>'NO'
,p_return_value=>'NO'
,p_is_quick_pick=>true
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87750018741619652)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Label'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(87107105943381680)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87630470745820355)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Contenedor'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(87626884534709351)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87780114150831045)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Label Container'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(87626884534709351)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87781094373833321)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Label'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(87626884534709351)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87781915965835679)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Input Container'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(87626884534709351)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87631585913832508)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Input SubContainer'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(87626884534709351)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87632427830834705)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Input'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(87626884534709351)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(87633314918853682)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Error'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(87626884534709351)
);
wwv_flow_imp_shared.create_plugin_std_attribute(
 p_id=>wwv_flow_imp.id(87101082035328081)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_name=>'INIT_JAVASCRIPT_CODE'
,p_is_required=>false
);
wwv_flow_imp_shared.create_plugin_event(
 p_id=>wwv_flow_imp.id(87112031835417660)
,p_plugin_id=>wwv_flow_imp.id(87096023398183199)
,p_name=>'evento_prueba'
,p_display_name=>'Evento'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
