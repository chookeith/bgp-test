*** Settings ***
Documentation    User Story 1 - Eligibility Section - Tests Acceptance Criteria 1 & 2
...
...               AC 1: The section should contain questions from excel sheet
...               AC 2: Each question can be answered Yes or No through radio buttons.

Resource    ${EXECDIR}/Tests/mra_grant_test/eligibility/resource.robot

Test Template   Valid Eligibility Question


*** Test Cases ***
Valid Eligibility Question - '${question}'
    [Tags]  smoke

*** Keywords ***
Valid Eligibility Question
    [Arguments]     ${question}     ${subquestion}
    When Applicant is on 'Eligibility' section
    Then Question and subquestions should be present    ${question}     ${subquestion}
    And Question should have visible Yes / No Radio Buttons

Question and subquestions should be present
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

Question should have visible Yes / No Radio Buttons
    ${elem_yes}     Set Variable    xpath://div[contains(@class,'bgp-radio-group')][${position}]//label[@class="bgp-radio"][1]//span[@class='bgp-label']
    ${elem_no}      Set Variable    xpath://div[contains(@class,'bgp-radio-group')][${position}]//label[@class="bgp-radio"][2]//span[@class='bgp-label']
    Element Should Contain      ${elem_yes}     Yes
    Element Should Contain      ${elem_no}      No
    Element Should Be Visible   ${elem_yes}
    Element Should Be Visible   ${elem_no}
