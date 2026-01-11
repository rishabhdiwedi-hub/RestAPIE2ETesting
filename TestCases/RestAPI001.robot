*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Resource    ../Resources/Resource.robot



*** Variables ***


*** Test Cases ***
RestAPI Get Request Testing
    TC_001_GET_Request
    TC_002_E2E_Testing



