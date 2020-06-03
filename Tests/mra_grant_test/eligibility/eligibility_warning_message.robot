*** Settings ***
Documentation   User Story 1 - Eligibility Section
...             AC 2: Each question can be answered Yes or No through radio buttons.
...             AC 3: Answering No for any of the questions should display a warning message
...                   'Visit Smart Advisor on the SME Portal for more information on other government assistance.'
...             AC 4: Clicking the link in the warning message in AC 3 will launch a website in another window tab
...                   to the url: https://www.smeportal.sg/content/smeportal/en/moneymatters.html#saText
Resource    ${EXECDIR}/Tests/mra_grant_test/eligibility/resource.robot

Test Template   Valid warning message on 'No' input

*** Variables ***
##This is what is in QA env
#${MESSAGE}              The applicant may not meet the eligibility criteria for this grant. Visit FAQ page for more information on other government grants.
#${WARNING LINK}         https://www.ifaq.gov.sg/BGP/apps/fcd_faqmain.aspx#FAQ_1111145

${MESSAGE}              Visit Smart Advisor on the SME Portal for more information on other government assistance.
${WARNING LINK}         https://www.smeportal.sg/content/smeportal/en/moneymatters.html#saText
*** Test Cases ***
Test warning message on 'No' for question - '${question}'
    [Tags]  ac


*** Keywords ***
Valid warning message on 'No' input
    [Arguments]     ${question}     ${subquestion}
    Given Applicant is on 'Eligibility' section
    And Question and subquestions is present            ${question}     ${subquestion}
    When Applicant clicks radio button 'No'
    Then Question should have valid warning message
    And Question should have valid link in warning message

Question should have valid warning message
    ${elem}         Set Variable                xpath://div[contains(@class,'bgp-radio-group')][${position}]/following-sibling::span/div[@class='eligibility-advice']/span
    Wait Until Element Is Visible               ${elem}         ${WAIT}
    Element Should Contain                      ${elem}         ${MESSAGE}

Question should have valid link in warning message
    ${elem}         Set Variable                xpath://div[contains(@class,'bgp-radio-group')][${position}]/following-sibling::span/div[@class='eligibility-advice']/span/a
    Wait Until Element Is Visible               ${elem}         ${WAIT}
    Element Attribute Value Should Be           ${elem}         href        ${WARNING LINK}