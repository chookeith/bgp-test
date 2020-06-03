*** Settings ***
Documentation    Resource file for keywords used to test grants
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.


Resource    ${EXECDIR}/Tests/Resources/resource.robot

*** Variables ***
${GRANT NAME}                       Market Readiness Assistance
${SECTOR}                           IT
${PURPOSE}                          International Expansion

${GRANT DASHBOARD LOCATOR}          id:grants
${NEW GRANT BUTTON}                 xpath://a[contains(@href,'grants/new')]/section

${BGP SIDEBAR ELEM}                 xpath://div[@class='bgp-sidebar']
${GRANT TITLE ELEM}                 xpath://h1[contains(@class,'grant-title')]

${PROCEED BUTTON}                   id:keyPage-form-button
${SAVE BUTTON}                      id:save-btn

*** Keywords ***
Navigate to MRA Grant form
    [Documentation]  Performs steps leading up to the MRA Grant form page
    Go to Application
    Log in to Application
    Click on New Grant Button
    Fill In Grant Questionnaire             ${SECTOR}       ${PURPOSE}      ${GRANT NAME}
    Click on Proceed Button
    Wait for Grant Form to Load
    Element Should Contain                  ${GRANT TITLE ELEM}   ${GRANT NAME}

Click on New Grant Button
    Wait Until Element Is Visible           ${GRANT DASHBOARD LOCATOR}      ${WAIT}
    Click Element                           ${NEW GRANT BUTTON}

Click on Proceed Button
    Click on Button when it is visible      ${PROCEED BUTTON}

Click on Save Button
    Click on Button when it is visible      ${SAVE BUTTON}


Wait for Grant Form to Load
    ${grant_title_elem}     Set Variable    xpath://h1[contains(@class,'grant-title')]
    Wait Until Element Is Visible           ${grant_title_elem}     ${WAIT}
    Element Should Contain                  ${grant_title_elem}     ${GRANT NAME}

Fill In Grant Questionnaire
    [Arguments]  ${sector}   ${purpose}   ${grant_name}
    Wait Until Element Is Visible           id:grant-wizard   ${WAIT}
    Click Element                           //input[contains(@id,'${sector}')]/parent::label
    Click Element                           //input[contains(@id,'${purpose}')]/parent::label
    Click Element                           //input[contains(@id,'${grant_name}')]/parent::label
    Click Element                           id:go-to-grant

Applicant is on MRA Grant Form page
    Element Should Contain                  ${GRANT TITLE ELEM}   ${GRANT NAME}

Applicant is on '${section}' section
    ${is_active}        Get Element Attribute       ${BGP SIDEBAR ELEM}//span[contains(text(),'${section}')]/parent::a      class
    Run keyword if                                  '${is_active}' != 'active'      Go to '${section}'
    Wait Until Element Is Visible                   ${BGP SIDEBAR ELEM}//span[contains(text(),'${section}')]/parent::a[contains(@class,'active')]    ${WAIT}

Applicant is on section
    [Arguments]         ${section}
    ${is_active}        Get Element Attribute       ${BGP SIDEBAR ELEM}//span[contains(text(),'${section}')]/parent::a      class
    Run keyword if                                  '${is_active}' != 'active'      Go to '${section}'
    Wait Until Element Is Visible                   ${BGP SIDEBAR ELEM}//span[contains(text(),'${section}')]/parent::a[contains(@class,'active')]    ${WAIT}

Applicant should be on section '${section}'
    Element Attribute Value Should Be              ${BGP SIDEBAR ELEM}//span[contains(text(),'${section}')]/parent::a      class       active

Go to '${section}'
    Click Element       ${BGP SIDEBAR ELEM}//span[contains(text(),'${section}')]