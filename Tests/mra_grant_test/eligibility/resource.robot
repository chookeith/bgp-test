*** Settings ***
Resource    ${EXECDIR}/Tests/mra_grant_test/grants_resource.robot
Library     DataDriver      ${EXECDIR}/Resources/Templates.xlsx      sheet_name=Eligibility
Library     ExcelLibrary


*** Variables ***
${RADIO GRP ELEM}       xpath://div[contains(@class,'bgp-radio-group')]//span[@class='mandatory-indicator']/parent::label

*** Keywords ***
Applicant clicks radio button '${radio_btn}'
    Click Element   xpath://div[contains(@class,'bgp-radio-group')][${position}]//span[@class='bgp-label'][text()='${radio_btn}']

Question and subquestions is present
    [Arguments]     ${question}     ${subquestion}
    ${position}     Get Web Element Position            ${RADIO GRP ELEM}   ${question}
    Set Test Variable                                   ${position}
    Run Keyword If  '${subquestion}' != '${EMPTY}'      Subquestions at position should be present       ${position}     ${subquestion}

Subquestions at position should be present
    [Arguments]     ${position}     ${subquestion}
    FOR     ${sub}      IN      @{subquestion.split(';')}
        ${elem}     Set Variable      xpath://div[contains(@class,'bgp-radio-group')][${position}]//ul/li
        Get Web Element Position      ${elem}        ${sub}
    END