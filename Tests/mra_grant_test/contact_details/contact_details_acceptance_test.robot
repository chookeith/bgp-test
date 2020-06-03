*** Settings ***
Documentation   User Story 2 – Contact Details Section
...             AC 1: The page contains a ‘Main Contact Person’ subsection with the following inputs:
...                 • Name
...                 • Job Title
...                 • Contact No
...                 • Email
...                 • Alternate Contact Person’s Email
...                 • Mailing Address
...             AC 2: The Mailing Address input should be able to take in a valid postal code which auto-populates the ‘Blk/Hse No.’ and ‘Street details’ from an external API (One-map)
...             AC 3: There should be a checkbox ‘Same as registered address in Company Profile’ which will auto-populate Mailing Address details from the Applicant’s Company Profile
...             AC 4: The page contains a ‘Letter of Offer Addressee’ subsection with the following inputs:
...                 • Name
...                 • Job Title
...                 • Email
...             AC 5: There should be an option 'Same as main contact person' which will populate the subsection in AC 4 with details from the 'Main Contact Person' in AC 1
...             AC 6: Clicking ‘Save’ will save the Applicant’s inputs and refreshing the page should reload the saved values.

Resource    ${EXECDIR}/Tests/mra_grant_test/grants_resource.robot

*** Variables ***

${MAIN NAME}            Tan Ah Kao
${MAIN JOB}             Tester
${MAIN CONTACT NO}      81234567
${MAIN EMAIL}           ahkao@singtel.com.sg
${MAIN ALT EMAIL}       xiaoming@singtel.com.sg
${MAIN POSTAL CODE}     117438
${EXPECTED BLOCK}       10
${EXPECTED STREET}      PASIR PANJANG ROAD

${ADDRESSEE NAME}       Tan Ah Mao
${ADDRESSEE JOB}        Developer
${ADDRESSEE EMAIL}      ahmao@gmail.com

${SLEEP}                5

${MAIN_CONTACT_DETAILS_ELEM}    xpath://div[contains(@class,'bgp-questions-grp')]/div/div[1]
${MAIN_CONTACT_MAILING_ELEM}    xpath://div[contains(@class,'bgp-questions-grp')]/div/div[2]
${LETTER_OF_OFFER_ADDR_ELEM}    xpath://div[contains(@class,'bgp-questions-grp')]/div/div[3]

#??
${INPUT ELEM}           xpath://div[contains(@class,'bgp-questions-grp')]/div/div[1]//label[text()="Email"]/ancestor::div[@class='form-group']//input


*** Test Cases ***

Main Contact Person subsection is present
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see subsection                ${MAIN_CONTACT_DETAILS_ELEM}        Main Contact Person


Main Contact Person - 'Name' is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${MAIN_CONTACT_DETAILS_ELEM}        Name

Main Contact Person - 'Name' input field is valid
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Input text into field                          ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input        ${MAIN NAME}
    Then Applicant should see input text                ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input        ${MAIN NAME}
    And Applicant should not see a warning message      ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input


Main Contact Person - 'Job Title' is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${MAIN_CONTACT_DETAILS_ELEM}    Job Title

Main Contact Person - 'Job Title' input field is valid
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Input text into field               ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Job Title"]/ancestor::div[@class='form-group']//input       ${MAIN JOB}
    Then Applicant should see input text                ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Job Title"]/ancestor::div[@class='form-group']//input       ${MAIN JOB}
    And Applicant should not see a warning message      ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Job Title"]/ancestor::div[@class='form-group']//input


Main Contact Person - 'Contact No' is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${MAIN_CONTACT_DETAILS_ELEM}        Contact No

Main Contact Person - 'Contact No' input field is valid
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Input text into field               ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Contact No"]/ancestor::div[@class='form-group']//input      ${MAIN CONTACT NO}
    Then Applicant should see input text                ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Contact No"]/ancestor::div[@class='form-group']//input      ${MAIN CONTACT NO}
    And Applicant should not see a warning message      ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Contact No"]/ancestor::div[@class='form-group']//input


Main Contact Person - 'Email' is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${MAIN_CONTACT_DETAILS_ELEM}        Email

Main Contact Person - 'Email' input field is valid
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Input text into field               ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Email"]/ancestor::div[@class='form-group']//input           ${MAIN EMAIL}
    Then Applicant should see input text                ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Email"]/ancestor::div[@class='form-group']//input           ${MAIN EMAIL}
    And Applicant should not see a warning message      ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Email"]/ancestor::div[@class='form-group']//input


Main Contact Person - 'Alternate Contact Person's Email' is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${MAIN_CONTACT_DETAILS_ELEM}        Alternate Contact Person's Email

Main Contact Person - 'Alternate Contact Person's Email' input field is valid
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Input text into field               ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Alternate Contact Person's Email"]/ancestor::div[@class='form-group']//input        ${MAIN ALT EMAIL}
    Then Applicant should see input text                ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Alternate Contact Person's Email"]/ancestor::div[@class='form-group']//input        ${MAIN ALT EMAIL}
    And Applicant should not see a warning message      ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Alternate Contact Person's Email"]/ancestor::div[@class='form-group']//input


Main Contact Person - 'Mailing Address' is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${MAIN_CONTACT_MAILING_ELEM}        Mailing Address

Main Contact Person - 'Mailing Address' postal code api auto-populates fields
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Applicant enters valid postal code             ${MAIN POSTAL CODE}
    Then 'Blk/Hse No' should be populated               ${EXPECTED BLOCK}
    And 'Street details' should be populated            ${EXPECTED STREET}


Main Contact Person - 'Same as registered address in Company Profile' checkbox is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${MAIN_CONTACT_MAILING_ELEM}        Same as registered address in Company Profile

Main Contact Person - 'Same as registered address in Company Profile' checkbox auto-populates fields
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Applicant clicks on checkbox field             id:react-contact_info-correspondence_address-copied
    Then Mailing address should be populated from applicant's company profile


Letter Of Offer Addressee subsection is present
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see subsection                ${LETTER_OF_OFFER_ADDR_ELEM}        Letter Of Offer Addressee


Letter Of Offer Addressee - 'Name' is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${LETTER_OF_OFFER_ADDR_ELEM}        Name

Letter Of Offer Addressee - 'Name' input field is valid
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Input text into field               ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input        ${ADDRESSEE NAME}
    Then Applicant should see input text                ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input        ${ADDRESSEE NAME}
    And Applicant should not see a warning message      ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input


Letter Of Offer Addressee - 'Job Title' is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${LETTER_OF_OFFER_ADDR_ELEM}    Job Title

Letter Of Offer Addressee - 'Job Title' input field is valid
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Input text into field               ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Job Title"]/ancestor::div[@class='form-group']//input       ${ADDRESSEE JOB}
    Then Applicant should see input text                ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Job Title"]/ancestor::div[@class='form-group']//input       ${ADDRESSEE JOB}
    And Applicant should not see a warning message      ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Job Title"]/ancestor::div[@class='form-group']//input


Letter Of Offer Addressee - 'Email' is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${LETTER_OF_OFFER_ADDR_ELEM}        Email

Letter Of Offer Addressee - 'Email' input field is valid
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    When Input text into field               ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Email"]/ancestor::div[@class='form-group']//input       ${ADDRESSEE EMAIL}
    Then Applicant should see input text                ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Email"]/ancestor::div[@class='form-group']//input       ${ADDRESSEE EMAIL}
    And Applicant should not see a warning message      ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Email"]/ancestor::div[@class='form-group']//input


Letter Of Offer Addressee - 'Same as main contact person' checkbox is visible
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    Then Applicant should see field label               ${LETTER_OF_OFFER_ADDR_ELEM}        Same as main contact person

Letter Of Offer Addressee - 'Same as main contact person' checkbox auto-populates fields
    [Tags]  smoke   ac
    Given Applicant is on 'Contact Details' section
    And Applicant has filled Main Contact Person details
    When Applicant clicks on checkbox field                 id:react-contact_info-copied
    Then Applicant should see input text                    ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input            ${MAIN NAME}
    And Applicant should see input text                     ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Job Title"]/ancestor::div[@class='form-group']//input       ${MAIN JOB}
    And Applicant should see input text                     ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Email"]/ancestor::div[@class='form-group']//input           ${MAIN EMAIL}

Save button
    [Tags]  ac
    Given Applicant is on 'Contact Details' section
    When Applicant enters 'Tan Ah Soo' into Main Contact Person name
    And Applicant clicks on 'Save' button
    Then Applicant should see Main Contact Person name as 'Tan Ah Soo' when page is refeshed




*** Keywords ***
Main Contact Person subsection is present
    Set Test Variable                   ${elem_group}       xpath://div[contains(@class,'bgp-questions-grp')]/div/div[1]
    Applicant should see subsection     ${elem_group}       Main Contact Person

Applicant enters '${name}' into Main Contact Person name
    Clear all element text
    Input text into field               ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input  ${name}

Applicant should see Main Contact Person name as '${name}' when page is refeshed
    Reload Page
    Wait Until Element Is Enabled       ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input    ${WAIT}
    Applicant should see input text     ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input    ${name}


Applicant should see subsection
    [Arguments]     ${elem_group}   ${field}
    Element Should Be Visible       ${elem_group}/div[contains(@class,'subsection-title')]/h3
    Element Should Contain          ${elem_group}/div[contains(@class,'subsection-title')]/h3       ${field}

Applicant should see field label
    [Arguments]     ${elem_group}   ${field}
    Element Should Be Visible        ${elem_group}//*[contains(text(),"${field}")]

Applicant clicks on checkbox field
    [Arguments]     ${elem}
    Click Element   ${elem}

Input text into field
    [Arguments]     ${field_elem}       ${input}
    Input Text      ${field_elem}       ${input}        clear=True
    Press Keys      ${field_elem}       TAB

Applicant should see input text
    [Arguments]     ${field_elem}       ${expected}
    Element Attribute Value Should Be       ${field_elem}       value       ${expected}

Applicant should not see a warning message
    [Arguments]     ${field_elem}
    Wait Until Element Is Not Visible      ${field_elem}/parent::div/following-sibling::*[contains(@class,'field-error-message')]   5
    Page Should Not Contain Element        ${field_elem}/parent::div/following-sibling::*[contains(@class,'field-error-message')]

Applicant enters valid postal code
    [Arguments]     ${postal_code}
    Input Text      xpath://input[@id='react-contact_info-correspondence_address-postal']       ${postal_code}      clear=True
    Sleep           ${SLEEP}

'Blk/Hse No' should be populated
    [Arguments]     ${expected}
    Element Attribute Value Should Be     id:react-contact_info-correspondence_address-block    value   ${expected}

'Street details' should be populated
    [Arguments]     ${expected}
    Element Attribute Value Should Be     id:react-contact_info-correspondence_address-street   value   ${expected}

Mailing address should be populated from applicant's company profile
    Element Attribute Value Should Be   id:react-contact_info-correspondence_address-postal     value   453123
    Element Attribute Value Should Be   id:react-contact_info-correspondence_address-block      value   45
    Element Attribute Value Should Be   id:react-contact_info-correspondence_address-street     value   CHOA CHU KANG CENTRAL
    Element Attribute Value Should Be   id:react-contact_info-correspondence_address-level      value   03
    Element Attribute Value Should Be   id:react-contact_info-correspondence_address-unit       value   19

Applicant has filled Main Contact Person details
    Input text into field    ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input        ${MAIN NAME}
    Input text into field    ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Job Title"]/ancestor::div[@class='form-group']//input   ${MAIN JOB}
    Input text into field    ${MAIN_CONTACT_DETAILS_ELEM}//label[text()="Email"]/ancestor::div[@class='form-group']//input       ${MAIN EMAIL}


Details should be populated with input from the Main Contact Person section
    Applicant should see input text     ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Name"]/ancestor::div[@class='form-group']//input        ${VALID NAME}
    Applicant should see input text     ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Job Title"]/ancestor::div[@class='form-group']//input   ${VALID JOB}
    Applicant should see input text     ${LETTER_OF_OFFER_ADDR_ELEM}//label[text()="Email"]/ancestor::div[@class='form-group']//input       ${VALID EMAIL}

Applicant clicks on 'Save' button
    Click on Save Button


Clear all element text
    @{elem_list}=    Get Webelements    xpath://div[@class="main"]//input
    FOR     ${elem}     IN      @{elem_list}
        Run Keyword And Ignore Error    Clear Element Text  ${elem}
        Run Keyword And Ignore Error    Unselect Checkbox   ${elem}
    END
