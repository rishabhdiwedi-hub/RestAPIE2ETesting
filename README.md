Project Structure:

<img width="707" height="236" alt="image" src="https://github.com/user-attachments/assets/1f2f9774-8159-4d1d-a3aa-bf2387273689" />

<img width="473" height="259" alt="image" src="https://github.com/user-attachments/assets/4165c5e6-8eba-4012-8e98-0baf635f7fc8" />


📦 Installation & Setup:
	1. Install Robot Framework
		pip install robotframework
	2. Install Required Libraries
		pip install robotframework-requests
		pip install robotframework-jsonlibrary
		pip install robotframework-seleniumlibrary
	3. Run the Test Suite
		robot TestCases/RestAPI001.robot

✔ Keywords Overview
1. TC_001_GET_Request
Creates a session

Sends a GET request

Validates status code = 200

2. TC_002_E2E_Testing
  A complete end‑to‑end API workflow:

🔹 Step 1: POST Request
Create session with SSL verification
  Build JSON headers
  Build nested JSON payload
  Send POST request
  Validate status code
  Extract id from response

🔹 Step 2: PUT Request
Build updated payload using extracted ID
  Send PUT request to update object
  Validate response

🔹 Step 3: GET Request (Verification)
  Fetch updated object using ID
  Extract updated name using JSONPath
  Validate updated name matches ${New_Name}

🧪 Test Suite (TestCases/RestAPI001.robot)
Code
*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Resource    ../Resources/Resource.robot

*** Test Cases ***
RestAPI Get Request Testing
    TC_001_GET_Request
    TC_002_E2E_Testing
This suite simply calls the reusable keywords defined in Resource.robot.

📝 Test Flow Summary
✔ GET → Validate API is reachable
✔ POST → Create new object
✔ Extract ID from POST response
✔ PUT → Update object using extracted ID
✔ GET → Validate updated object
✔ Assertions for status codes & JSON values
This demonstrates a complete E2E API Testing Lifecycle.

📊 Reports
After execution, Robot Framework generates:
log.html → Detailed execution log
report.html → Summary report
output.xml → Machine‑readable output

All reports are stored in the project root or /Result/ folder depending on your configuration.
