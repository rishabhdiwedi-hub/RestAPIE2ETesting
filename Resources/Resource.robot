*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${URL}      https://api.restful-api.dev
${URI}      /objects
${price}    18500
${CPU model}    A7
${Hard disk size}       2 TB
${old_name}     HP Compq Pluse
${New_Name}     Accer Pro

*** Keywords ***
TC_001_GET_Request
    create session    Student_Details      ${URL}
    ${response}=    get on session    Student_Details       ${URI}
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

TC_002_E2E_Testing
#Create POST API with Payload variables
    #Create a session for the POST API    and also add verify=True ensures SSL certificates are validated (removes HTTPS warnings).
    create session    E2E_API_Testing       ${URL}      verify=True
    #Create headers dictionary
    ${headers}      create dictionary    Content-Type=application/json
    #Create the inner JSON object
    ${Data}     create dictionary    year=2025      price=${price}      CPU model=${CPU model}      Hard disk size=${Hard disk size}
    #Create the main POST body
    ${POST_Body}    create dictionary    name=${old_name}      data=${Data}
    #Send the POST request
    ${post_response}=       POST On Session    E2E_API_Testing     ${URI}      headers=${headers}       json=${POST_Body}
    #Print the HTTP status code
    log to console    ${post_response.status_code}
    #Print the JSON response
    log to console    ${post_response.json()}
    #Convert status code to string
    ${status_code}=     convert to string    ${post_response.status_code}
    #Validate the status code
    should be equal    ${status_code}     200
    #Store the JSON response in ${Json_Response}
    ${Json_Response}=   set variable    ${post_response.json()}
    #Extract the id field from the JSON
    ${id_list}=      get value from json    ${Json_Response}     id
    #Print the extracted list
    log to console    ${id_list}
    #Get the first element from the list
    ${ids}=   get from list    ${id_list}     0
    #Print the extracted ID
    log to console    ${ids}

#Verify the Post payload using fatched ID
    #Create the PUT request body
    ${Put_Body}    create dictionary    id=${ids}       name=${New_Name}      data=${Data}
    #Send the PUT request
    ${put_response}=       PUT On Session    E2E_API_Testing     ${URI}/${ids}      headers=${headers}       json=${Put_Body}
    #Print the status code
    log to console    ${put_response.status_code}
    #Print the raw response content
    log to console    ${put_response.content}

#Now you verify the update using GET
    #Send a GET request to fetch the updated object
    ${Get_Response}=    GET On Session    E2E_API_Testing       ${URI}/${ids}
    #Convert GET response to JSON
    ${Get_Json_Response}=   set variable    ${Get_Response.json()}
    #Extract the name field using JSONPath
    ${First_Name}=      get value from json    ${Get_Json_Response}     $.name
    #Extract the first element from the list
    ${Name}=        get from list    ${First_Name}      0
    #Validate that the name was updated
    should be equal    ${Name}      ${New_Name}