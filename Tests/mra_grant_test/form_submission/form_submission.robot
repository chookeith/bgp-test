*** Settings ***
Documentation    User Story 3 - Form Submission

Library     ExcelLibrary
Resource    ${EXECDIR}/Tests/mra_grant_test/grants_resource.robot


*** Test Cases ***
Clicking 'Review' on form with missing mandatory fields triggers validation error
    [Documentation]     Acceptance criteria
    ...                 AC2 : If there are any mandatory inputs missing, a validation error should trigger and the form should redirect to the section with the missing details
    ...                 AC2 : An error number should also be shown in the sidebar next to the offending section
    [Tags]  ac
    Given Applicant has missing mandatory inputs
    When Applicant clicks on 'Review'
    Then An error number '1' should be shown in sidebar next to the offending section 'Cost'
    And An error number '2' should be shown in sidebar next to the offending section 'Declare & Review'
    And Applicant should be on section 'Cost'
    [Teardown]  Close All Excel Documents


Clicking 'Review' on a complete form returns valid summary page
    [Documentation]     Acceptance criteria
    ...                 AC1 : Summary page is read-only (no input html elements)
    ...                 AC3 : The read-only summary page should correctly contain all the details previously filled in each form section.
    ...                 AC4 : At the bottom of the read-only summary page is a final ‘Consent and Acknowledgement’ checkbox.
    [Tags]  ac  smoke
    Given Applicant has completed mandatory inputs
    When Applicant clicks on 'Review'
    Then Applicant should be taken to a read-only summary page
    And Read-only summary page should correctly contain details
    And Summary page should contain 'Consent & Acknowledgement' checkbox
    [Teardown]  Close All Excel Documents


Success message box
    [Documentation]     Acceptance criteria
    ...                 AC5 : A Success message box should be shown
    ...                 AC5 : The Success message box should contain Application Ref ID
    ...                 AC5 : The Success message box should contain Agency details
    ...                 AC5 : Agency details should display the receiving Agency as ‘Enterprise Singapore’
    [Tags]  ac
    Given Applicant is on summary page
    When Applicant submits form
    Then Applicant should see a 'Success message box'
    And 'Success message box' should contain an Application Ref ID
    And 'Success message box' should contain Agency Details
    And Agency Details should display the receiving agency as 'Enterprise Singapore'


Upon submission, the main ‘My Grants’ dashboard should show the Application under the ‘Processing’ tab
    [Documentation]     Acceptance criteria
    ...                 AC6 : Upon submission, the main 'My Grants' dashboard should show the Application under the 'Processing' tab
    [Tags]  ac
    Given Applicant has submitted form successfully
    When Applicant navigates to 'My Grants' dashboard - 'Processing' tab
    Then Applicant should see project application Ref Id
    And Applicant should see Project Title 'Kenny & Johnny's Garden Emporium'


*** Keywords ***
Applicant has missing mandatory inputs
    Populate Inputs     Incomplete_Form_Input

Applicant has completed mandatory inputs
    Populate Inputs     Completed_Form_Input

Applicant clicks on 'Review'
    Click Element       id:review-btn

An error number '${number}' should be shown in sidebar next to the offending section '${section}'
    Element Should Contain      ${BGP SIDEBAR ELEM}//span[contains(text(),"${section}")]/following-sibling::div/span[contains(@class,"label-error")]        ${number}

Applicant should be on section '${section}'
     Element Attribute Value Should Be              ${BGP SIDEBAR ELEM}//span[contains(text(),'${section}')]/parent::a      class       active

Applicant should be taken to a read-only summary page
    Applicant is on summary page
    Summary page should not contain input elements

Applicant scrolls to bottom of page
    Scroll Element Into View        xpath://div[contains(@class,"bgp-btn-group")]

'Consent & Acknowledgement' checkbox should be visible
    Element Should be Visible       xpath://div[@class="main summary-page"]//input[@id="react-declaration-info_truthfulness_check"]

Applicant is on summary page
    Wait Until Element Is Visible   xpath://div[@class="main summary-page"]/*         ${WAIT}

Summary page should not contain input elements
    Page Should Contain Element     xpath://div[@class="main summary-page"]//input[not(@id="react-declaration-info_truthfulness_check")]    limit=0

Summary page should contain 'Consent & Acknowledgement' checkbox
    Page Should Contain Element     xpath://div[@class="main summary-page"]//input[@id="react-declaration-info_truthfulness_check"]    limit=1

Applicant submits form
    Click Element                   id:react-declaration-info_truthfulness_check
    Click Element                   id:submit-btn

Applicant should see a 'Success message box'
    Wait Until Element Is Visible   xpath://section//h3[contains(text(),"submitted")]       ${WAIT}
    Page Should Contain Element     xpath://section//h3[contains(text(),"submitted")]

'Success message box' should contain an Application Ref ID
    Page Should Contain Element     xpath://section//td[contains(text(),"Ref ID")]

'Success message box' should contain Agency Details
    Page Should Contain Element     xpath://section//td[contains(text(),"Agency Details")]

Agency Details should display the receiving agency as 'Enterprise Singapore'
    Element Should Contain          xpath://section//td[contains(text(),"Agency Details")]/following-sibling::td      Enterprise Singapore

Applicant has submitted form successfully
    Applicant should see a 'Success message box'
    ${ref_id}=              Get Text        xpath://section//td[contains(text(),"Ref ID")]/following-sibling::td
    Set Test Variable       ${ref_id}       ${ref_id}

Applicant navigates to 'My Grants' dashboard - 'Processing' tab
    Click Element                   xpath://a[@id="sgds-nav-start"][contains(text(),"My Grants")]
    Wait Until Element Is Visible   xpath://section[@class="dashboard-tab-container"]//a[contains(text(),"Applications")]                   ${WAIT}
    Click Element                   xpath://section[@class="dashboard-tab-container"]//a[contains(text(),"Applications")]
    Wait Until Element Is Visible   xpath://div[@id="grants"]//section[@class="dashboard-tab-container"]//a[contains(text(),"Processing")]  ${WAIT}
    Click Element           xpath://div[@id="grants"]//section[@class="dashboard-tab-container"]//a[contains(text(),"Processing")]


Applicant should see project application Ref Id
    ${position}     Get Web Element Position    xpath://table[@id="db-apps-processing"]//tbody/tr/td[1]     ${ref_id}
    Set Test Variable           ${position}

Applicant should see Project Title '${project_title}'
    Element Should Contain      xpath://table[@id="db-apps-processing"]//tbody/tr[${position}]/td[4]        ${project_title}

Read-only summary page should correctly contain details
    Check Inputs

Check Inputs
    Open Excel Document     ${EXECDIR}/Resources/Templates.xlsx     expected_doc
    ${sheet}=               Get Sheet               sheet_name=Completed_Form_Expected
    ${row_count}            Set Variable            ${sheet.max_row}
    @{form_entry_list}      Create List     ${sheet.rows}
    FOR     ${form_entry}    IN RANGE    2   ${row_count+1}
        Set Test Variable   ${section}          ${sheet.cell(row=${form_entry},column=1).value}
        Set Test Variable   ${xpath}            ${sheet.cell(row=${form_entry},column=4).value}
        Set Test Variable   ${user_input}       ${sheet.cell(row=${form_entry},column=3).value}
        Go to '${section}'
        Run Keyword and continue on failure     Element Should Contain              ${xpath}        ${user_input}
    END

Populate Inputs
    [Arguments]     ${sheet_name}
    Open Excel Document     ${EXECDIR}/Resources/Templates.xlsx     ${sheet_name}
    ${sheet}=               Get Sheet       sheet_name=${sheet_name}
    ${row_count}            Set Variable    ${sheet.max_row}
    FOR     ${row_index}    IN RANGE        2       ${row_count+1}
        Set Test Variable   ${section}      ${sheet.cell(row=${row_index},column=1).value}
        Set Test Variable   ${field_name}   ${sheet.cell(row=${row_index},column=2).value}
        Set Test Variable   ${field_type}   ${sheet.cell(row=${row_index},column=3).value}
        Set Test Variable   ${user_input}   ${sheet.cell(row=${row_index},column=4).value}
        Set Test Variable   ${xpath}        ${sheet.cell(row=${row_index},column=5).value}
        Set Test Variable   ${sleep}        ${sheet.cell(row=${row_index},column=6).value}
        Run Keyword and continue on failure     Fill in form        ${section}      ${field_name}       ${field_type}       ${user_input}
    END

Fill in form
    [Arguments]     ${section}      ${field_name}       ${field_type}       ${user_input}
    Applicant is on section     ${section}
    Run Keyword If      '${field_type}'=='Radio'        Applicant clicks field
    Run Keyword If      '${field_type}'=='Text'         Applicant enters text into field
    Run Keyword If      '${field_type}'=='Date'         Applicant enters text into field
    Run Keyword If      '${field_type}'=='Click'        Applicant clicks field
    Run Keyword If      '${field_type}'=='Checkbox'     Applicant clicks checkbox
    Run Keyword If      '${field_type}'=='Dropdown'     Applicant clicks field


Applicant clicks radio button
    Click Element   ${xpath}

Applicant enters text into field
    Input Text      ${xpath}        ${user_input}
    Sleep           ${sleep}
    Press Keys      ${xpath}        TAB
    Sleep           ${sleep}

Applicant clicks field
    Click Element   ${xpath}
    Sleep           ${sleep}

Applicant clicks checkbox
    Select Checkbox     ${xpath}
    Sleep               ${sleep}
