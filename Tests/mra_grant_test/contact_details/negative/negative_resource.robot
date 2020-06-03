*** Settings ***

Resource    ${EXECDIR}/Tests/mra_grant_test/grants_resource.robot

*** Variables ***
${WARNING ELEM}     ${EMAIL ELEM}/parent::div/following-sibling::*[contains(@class,'field-error-message')]
${WAIT}             5

*** Keywords ***

Applicant inputs invalid email
    [Arguments]     ${invalid_email}
    Input Text      ${EMAIL ELEM}       ${invalid_email}
    Press Keys      ${EMAIL ELEM}       TAB

Applicant should see a warning message
    Wait Until Element Is Visible       ${WARNING ELEM}     ${WAIT}
    Page Should Contain Element         ${WARNING ELEM}
