***Settings***
Documentation     Testing Signant Health Demo App by using RF scripts and API
Library            BuiltIn
Library            SeleniumLibrary  
Variables          ../Resources/customlib/variables.py
Resource           ../Resources/Keywords/Generalkeywords.robot
Library            ../Resources/customlib/customlibrary.py


***Test Cases***
Register through web portal 
    [Documentation]  UI automation with RF Scripts
     Generalkeywords.Click on Register
     Generalkeywords.Enter user details
     Generalkeywords.Submit the form

Validate user information from the main view
    [Documentation]  UI automation with RF Scripts
    Generalkeywords.Login with registered user
    SeleniumLibrary.Wait Until Page Contains    User Information
    ${user_name} =      Get Text    //td[@id="username"]
    BuiltIn.Should Be Equal    ${user_name}   ${USER_NAME}

Register new user through API
     [Documentation]  API Testing with Python    
    ${status} =  customlibrary.Register User    ${PYTHON_API_USER}    ${USER_PASSWORD}   ${FIRST_NAME}   ${LAST_NAME}   ${PHONE}
    Log To Console    ${status}

Review users registered in system
    [Documentation]  API Testing with Python 
    Generalkeywords.Set Access Token
    ${user_name} =  customlibrary.Review Registered Users    ${token}
    Log To Console   ${user_name}

Verify I can get personal information of users if authenticated 
    [Documentation]  API Testing with Python   
    Generalkeywords.Set Access Token
    ${user_list} =   customlibrary.Get User Information    ${token}
    Log To Console    ${user_list}
       
Verify I can update personal information of users if authenticated
    [Documentation]  API Testing with Python  
    Generalkeywords.Set Access Token
    ${status} =  customlibrary.Update User      ${token}
    Log To Console    ${status}
