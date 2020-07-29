*** Settings ***
Documentation     A test suite with a single test for GLPI - Chamados - 75795
...               Created by hats' Robotcorder
Library           Selenium2Library    timeout=10
# biblioteca geral
Library               OperatingSystem

Suite Setup         Login Session       diego.silva   is@be11@33
Suite Teardown      Close Session
Test Teardown       Finalizando Teste

*** Variables ***
${BROWSER}      chrome
${SLEEP}        3
${BASE_URL}     https://atendimento.abaco.com.br/glpi

*** Test Cases ***
Listagem de cards 
    @{v_cards}=   Retorna arquivo em Json
    ...     cards.json
    # Log Many    @{v_json}
    FOR    ${v_card}   IN      @{v_cards}   
        Go To            ${BASE_URL}/front/ticket.form.php?id=${v_card['Chamado']} 
        Click Link       //a[@id="ui-id-13"]
        ${rows}=    get element count   //table[@class='tab_cadre_fixehov']/tbody/tr 
        # Click Link       //a[@id="task21630"]
        # Click Element    //span[@id="select2-dropdown_plugin_tasklists_taskstates_id2039183355-container"]
        # Sleep   5s
    # Click Element    //input[@name="update"]
    END
    # Go To            ${BASE_URL}/front/ticket.form.php?id=75795
    # Click Link       //a[@id="ui-id-13"]
    # Click Link       //a[@id="task21630"]
    # Click Element    //span[@id="select2-dropdown_plugin_tasklists_taskstates_id2039183355-container"]
    # Click Element    //input[@name="update"]

*** Keywords ***
Abrir navegador
    Open Browser     ${BASE_URL}    ${BROWSER}

    Set Window Size                 1440    900
    Set Browser Implicit Wait       15 seconds
    Set Selenium Implicit Wait      15 seconds
    Set Selenium Speed              0.1 seconds

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

