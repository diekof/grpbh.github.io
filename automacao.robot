*** Settings ***
Documentation     A test suite with a single test for GLPI - Chamados - 75795
...               Created by hats' Robotcorder
Library           Selenium2Library    timeout=10

*** Variables ***
${BROWSER}      chrome
${SLEEP}        3
${BASE_URL}     https://atendimento.abaco.com.br/glpi

*** Test Cases ***
GLPI - Chamados - 75795 test
    Open Browser     ${BASE_URL}/front/ticket.form.php?id=75795    ${BROWSER}
    Click Link       //a[@id="ui-id-13"]
    Click Link       //a[@id="task21630"]
    Click Element    //span[@id="select2-dropdown_plugin_tasklists_taskstates_id2039183355-container"]
    Click Element    //input[@name="update"]

    Close Browser

*** Keywords ***
