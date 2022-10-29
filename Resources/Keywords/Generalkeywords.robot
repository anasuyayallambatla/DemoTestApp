*** Settings ***
Library         SeleniumLibrary
Variables       ../../Resources/customlib/variables.py
Library         ../Resources/customlib/customlibrary.py

*** Keywords ***
Launch demoapp in Chrome
    Set Selenium speed    0.1
    Open Browser    ${SITE_URL}    Chrome
    Wait Until Page Contains Element    //a[@href="/register"]

Click on Register
    Click Element                       //a[@href="/register"]
    Wait Until Page Contains Element    //form

Enter user details
    Wait Until Page Contains Element            //input[@id="username"]
    Input Text        //input[@id="username"]       ${USER_NAME}
    Input Password    //input[@id="password"]       ${USER_PASSWORD}
    Input Text        //input[@id="firstname"]      ${FIRST_NAME}
    Input Text        //input[@id="lastname"]       ${LAST_NAME}
    Input Text       //input[@id="phone"]           ${PHONE}
 
Submit the form
    Wait Until Page Contains Element     //input[@type="submit"]
    Click Element                        //input[@type="submit"]

Login with registered user
    Click Element    //a[@href="/login"]
    Wait Until Page Contains Element           //input[@type="submit"]
    Input Text        //input[@id="username"]    ${USER_NAME}
    Input Password    //input[@id="password"]    ${USER_PASSWORD}
    Click Element    //input[@type="submit"]

Set Access Token
    ${token} =  Access Token    ${USER_NAME}    ${USER_PASSWORD}
    Set Test Variable    ${token}