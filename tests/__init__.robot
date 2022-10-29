*** Settings ***
Library      SeleniumLibrary
Resource     ../Resources/Keywords/Generalkeywords.robot
Variables     ../Resources/customlib/variables.py
Suite Setup    Launch demoapp in Chrome
Suite Teardown  Close All Browsers