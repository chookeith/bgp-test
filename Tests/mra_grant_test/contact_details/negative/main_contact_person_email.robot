*** Settings ***

Resource    ${EXECDIR}/Tests/mra_grant_test/contact_details/negative/negative_resource.robot
Library     DataDriver      ${EXECDIR}/Resources/Templates.xlsx      sheet_name=Invalid_Email

Test Template  Invalid email


*** Variables ***
${EMAIL ELEM}       xpath://div[contains(@class,'bgp-questions-grp')]/div/div[1]//label[text()="Email"]/ancestor::div[@class='form-group']//input

*** Test Cases ***
Main Contact Person - Email should show warning for emails with ${invalid_scenario}
    [Tags]  negative

*** Keywords ***
Invalid email
    [Arguments]  ${invalid_email}
    Given Applicant is on 'Contact Details' section
    When Applicant inputs invalid email             ${invalid_email}
    Then Applicant should see a warning message