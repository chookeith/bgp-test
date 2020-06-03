*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.

#Library     SeleniumLibrary
Library     ../src/WebConnector.py

*** Variables ***
${SERVER}           https://public:Let$BeC001@bgp-qa.gds-gov.tech
${BROWSER}          headlessfirefox
${DELAY}            0
${WAIT}             60

${VALID USER}       Tan Ah Kow
${VALID NRIC}       S1234567A
${VALID UEN}        BGPQEDEMO
${VALID ROLE}       Acceptor

${LOGIN BUTTON}     xpath://form/h6/following-sibling::button[text()='Login']


*** Keywords ***
Go to Application
    [Documentation]  Opens browser to the Application under test
    Open Browser                    ${SERVER}    ${BROWSER}
    Set Browser Implicit Wait       5
    Title Should Be                 Business Grants Portal

Log in to Application
    [Documentation]  Log in to Application under test
    Go To Login Page
    Input NRIC              ${VALID NRIC}
    Input Username          ${VALID USER}
    Input UEN               ${VALID UEN}
    Input Role              ${VALID ROLE}
    Click Element           ${LOGIN BUTTON}

Go To Login Page
    [Documentation]  Clicks on log in button on dashboard
    Click Element   id:login-button
    Element Should Contain  xpath://form/h6  Login with your own user

Input Username
    [Arguments]    ${name}
    Input Text    name:CPUID_FullName    ${name}

Input NRIC
    [Arguments]    ${nric}
    Input Text    name:CPUID    ${nric}

Input UEN
    [Arguments]    ${uen}
    Input Text    name:CPEntID    ${uen}

Input Role
    [Arguments]    ${role}
    Select From List By Value   name:CPRole    ${role}

Click on Button when it is visible
    [Arguments]  ${elem}
    Wait Until Element Is Visible   ${elem}
    Click Element   ${elem}
