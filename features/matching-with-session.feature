Feature: Group stubs into sessions

  Scenario: Return response matching declared in session
    Given a file to describe "/matching/example" path
    And in session "example-session"
    When this path "/matching/example" is accessed throught tshield
    Then response should be equal "matching-example-response-in-session"

  Scenario: Return response matching into global if not defined in session
    Given a file to describe "/matching/example" path only for method "POST"
    And in session "example-session"
    When this path "/matching/example" is accessed throught tshield via "post"
    Then response should be equal "matching-example-response-with-post"

  Scenario: Return different answer for same stub
    Given a file to describe "/matching/twice" path
    And in session "multiples-responses"
    When this path "/matching/twice" is accessed throught tshield 2 times
    Then call number 1 response should be equal "{\"attribute\":\"value1\"}"
    And call number 2 response should be equal "{\"attribute\":\"value2\"}"

  Scenario: Repeat responses after end of array
    Given a file to describe "/matching/twice" path
    And in session "multiples-responses"
    When this path "/matching/twice" is accessed throught tshield 3 times
    Then call number 3 response should be equal "{\"attribute\":\"value1\"}"

  Scenario: In a session with a main-session and a secondary-session return main
    Given a file to describe "/matching/two-sessions" path
    When start session "main-session"
    And append session "second-session"
    And this path "/matching/fake" is accessed throught tshield via "post"
    Then response should be equal "main-session-fake"

  Scenario: In a session with a main-session and a secondary-session return secondary
    Given a file to describe "/matching/two-sessions" path
    When start session "main-session"
    And append session "second-session"
    And this path "/matching/second-fake" is accessed throught tshield via "get"
    Then response should be equal "secondary-session-first-response-fake"

  Scenario: In a session with a main-session and a secondary-session return second call of secondary session
    Given a file to describe "/matching/two-sessions" path
    When start session "main-session"
    And append session "second-session"
    And this path "/matching/second-fake" is accessed throught tshield 2 times
    Then call number 2 response should be equal "secondary-session-second-response-fake"
