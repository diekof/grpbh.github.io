*** Settings ***
Documentation     A test suite with a single test for GLPI - Chamados

Library           SeleniumLibrary   
# biblioteca geral
Library               OperatingSystem

Library             ../lib/converter.py

Suite Setup         Login Session       diego.silva   jo@qu1m33
Suite Teardown      Close Session
Test Teardown       Finalizando Teste

*** Variables ***
${BROWSER}          chrome
${SLEEP}            3
${BASE_URL}         https://atendimento.abaco.com.br/glpi
${TABELA_LINHAS}    //table[@class='tab_cadre_fixehov']/tbody/tr
${TABELA}           //table[@class='tab_cadre_fixehov']
${CAMPO_SELECT}     class:md-select

*** Test Cases ***
Listagem de cards 
    # Impressao de arquivos   fin.json
    # Impressao de arquivos   ctt.json
    Impressao de arquivos   ctb.json
    # Impressao de arquivos   cmp.json
    # Impressao de arquivos   cdu.json
    # Impressao de arquivos   sup.json
    # Impressao de arquivos   pln.json
    # Impressao de arquivos   pat.json

*** Keywords ***
Impressao de arquivos
    [Arguments]     ${modulo}

    @{v_cards}=   Retorna arquivo em Json
    ...     ${modulo}
    Log Many    @{v_cards}
    FOR    ${v_card}   IN      @{v_cards}  

        # ${nome_pdf}
        Go To            ${BASE_URL}/front/ticket.form.php?id=${v_card['Chamado']} 
        Sleep   2s
        Execute Javascript      window.print();
        Sleep   5s
        # ${myHtml} =    Get Source
        # conv to pdf     ${myHtml}       ${v_card['Chamado']}.pdf
        # conv to pdf     ${BASE_URL}/front/ticket.form.php?id=${v_card['Chamado']}       ${v_card['Chamado']}.pdf
        
    END

Abrir navegador


    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method  ${options}  add_argument  --kiosk-printing
    ${options.prefs}=  Create Dictionary  printing.print_preview_sticky_settings.appState  {"recentDestinations": [{"id": "Save as PDF","origin": "local","account": ""}],"selectedDestinationId": "Save as PDF","version": 2}
    Call Method  ${options}  add_experimental_option  prefs   ${options.prefs}

    Open Browser     ${BASE_URL}    ${BROWSER}      options=${options}

    Maximize Browser Window
    # Set Window Size                 1440    900
    Set Browser Implicit Wait       15 seconds
    Set Selenium Implicit Wait      15 seconds
    Set Selenium Speed              0.1 seconds
    Set Selenium Timeout            60 seconds
    
    # ${options} =	Get Options
Close Session   
    Close Browser

Finalizando Teste
    Capture Page Screenshot

Login Session
    [Arguments]     ${usuer}       ${pass}

    Abrir navegador

    Input Text    id:login_name           ${usuer} 
    Input Text    id:login_password       ${pass}

    Click Element    //input[@name="submit"]

Retorna arquivo em Json
    [Documentation]     Função responsável por transformar uma string json em um objeto.

    [Arguments]     ${json_file}

    ${string_file}=        Get File    ${EXECDIR}/fixtures/${json_file}
    ${jsob_object}=       Evaluate    json.loads($string_file)     json

    [Return]    ${jsob_object}

