*** Settings ***
Documentation   User Story 1 – Eligibility Section
...             As an Applicant, I should be able to answer a set of Yes/No Eligibility questions in the Eligibility page.
...             AC 1: The section should contain 4 questions:
...                 1) Is the applicant registered in Singapore?
...                 2) Is the applicant's group sales turnover less than or equal to S$100m or is the 
...                    applicant's group employment size less than or equal to 200?
...                 3) Does the applicant have at least 30% local equity?
...                 4) Are all the following statements true for this project? *
...                     • The applicant has not started work on this project
...                     • The applicant has not made any payment to any supplier, vendor, 
...                       or third party prior to applying for this grant
...                     • The applicant has not signed any contractual agreement with any supplier,
...                       vendor, or third party prior to applying for this grant
...             AC 2: Each question can be answered Yes or No through radio buttons.
...             AC 3: Answering No for any of the questions should display a warning message
...                   'Visit Smart Advisor on the SME Portal for more information on other government assistance.'
...             AC 4: Clicking the link in the warning message in AC 3 will launch a website in another window tab
...                   to the url: https://www.smeportal.sg/content/smeportal/en/moneymatters.html#saText

Resource    ${EXECDIR}/Tests/mra_grant_test/grants_resource.robot

*** Variables ***
${BGP SIDEBAR ELEM}     xpath://div[@class='bgp-sidebar']
${GRANT TITLE ELEM}     xpath://h1[contains(@class,'grant-title')]

${QUESTION LOCATOR}   //span[@class='mandatory-indicator']/parent::label
${SUBQUESTION LOCATOR}   //span[@class='mandatory-indicator']/parent::label/ul/li



*** Test Cases ***

Eligibility section should contain 4 questions
    [Tags]  ac
    Given Applicant is on 'Eligibility' section
    Then Page should contain element     locator=${QUESTION LOCATOR}  limit=4

Save button
    [Tags]  ac
    Given Applicant is on 'Eligibility' section
    When Applicant selects 'Yes' for question '2'
    And Applicant clicks on 'Save' button
    Then Applicant should see 'Yes' selected for question '2' when page is refeshed

*** Keywords ***

Applicant should see '${question}'
    Get Web Element Position   ${QUESTION LOCATOR}     ${question}

Applicant should see bullet point '${question}'
    Get Web Element Position   ${SUBQUESTION LOCATOR}     ${question}

Applicant selects '${radio_btn}' for question '${position}'
    Click Element   xpath://div[contains(@class,'bgp-radio-group')][${position}]//span[@class='bgp-label'][text()='${radio_btn}']

Applicant should see '${radio_btn}' selected for question '${position}' when page is refeshed
    Reload Page
    Wait Until Element Is Enabled   xpath://div[contains(@class,'bgp-radio-group')][${position}]//span[@class='bgp-label'][text()='${radio_btn}']/preceding-sibling::input      ${WAIT}
    ${elem}=    Get Webelement      xpath://div[contains(@class,'bgp-radio-group')][${position}]//span[@class='bgp-label'][text()='${radio_btn}']/preceding-sibling::input
    Should Be Equal     '${elem.is_selected()}'   'True'

Applicant clicks on 'Save' button
    Click on Save Button

