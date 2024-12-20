Feature: YOUK code Manual and Bulk load validations

  @bullkload_submission
  Scenario: Bulkoad Crime Lower stage reached code YOUK with case outcome code CP19
  is invalid for YOUK

    Given a test firm user is logged in CWA
    And user prepares to submit outcomes for test provider "CRIME LOWER#8"
    Given the following Matter Types are chosen:
      | YOUK |
    And the following outcomes are bulkloaded:
      | # | UFN        | OUTCOME_CODE | WORK_CONCLUDED_DATE | YOUTH_COURT | POLICE_STATION |NUMBER_OF_POLICE_STATION|
      | 1 | 010924/001 | CP19         |           01/9/2024 | Y           | C1013          |1                       |
    Then the following results are expected:
      | # | ERROR_CODE_OR_MESSAGE            |
      | 1 | CP19 is not a valid OUTCOME_CODE |

  @manual_submission
  Scenario: Manually enter YOUK outcomes using the mag court fee scheme 01-JAN-1995 to 02-OCT-2011
    Given user is on their "CRIME LOWER" submission details page
    When user adds outcomes for "Crime Lower" "criminal proceedings" with fields like this:
      | matter_type | rep_order_date | standard_fee_cat | profit_cost | ufn        | work_concluded_date | police_station | outcome_code | maat_id |
      | YOUK        | 28-OCT-2024    | 1C               |           0 | 010924/001 |         01-SEP-2024 | C1013          | CP19         | 1234567 |
    Then the outcome does not save and gives an error containing:
      """
      Outcome Code - ID CP19 for the flexfield segment Outcome Code does not exist in the value set XXLSC_CASE_OUTCOME_CODE_CL.
      """

  #YOU<a> court codes have a new screen to capture fields.  It is pretty much a close copy of the PRO<a> 
  #screen with some fields now being mandatory.  The following tests check that these fields are now being 
  #implemented as mandatory fields on the new screen.  They are as follows:-
  # Representation Order Date
  # MAAT ID
  # Standard Fee Category
  # On the manual screen a popup will warn the user if the fields are not completed.
  @manual_submission
  Scenario: Manually enter YOUK outcomes without certain mandatory fields completed
    Given user is on their "CRIME LOWER" submission details page
    When user adds outcomes for "Crime Lower" "criminal proceedings" with fields like this:
      | matter_type | rep_order_date | standard_fee_cat | profit_cost | ufn        | work_concluded_date | police_station | outcome_code | maat_id |
      | YOUK        |                |                  |         100 | 010924/001 |         01-SEP-2024 | C1013          | CP18         |         |
    Then the outcome does not save and this popup error appears:
      """
      A value must be entered for "Representation Order Date".
      A value must be entered for "Standard Fee Category".
      A value must be entered for "MAAT ID".
      """


  @manual_submission
  Scenario: Manually enter YOUE outcomes and test some drop down lists are correct
    Given user is on their "CRIME LOWER" submission details page
    When user enters an outcome for "Crime Lower" "criminal proceedings" with fields like this:
      | matter_type |
      | YOUL        |
    Then the drop down list "standard_fee_cat" contains the following values:
      | Category 1A |
      | Category 1B |
      | Category 2A |
      | Category 2B |
    And the drop down list "crime_matter_type" contains the following values:
      | 1-Offences against the person                                                      |
      | 2-Homicide and related grave offences                                              |
      | 3-Sexual offences and associated offences against children                         |
      | 4-Robbery                                                                          |
      | 5-Burglary                                                                         |
      | 6-Criminal damage                                                                  |
      | 7-Theft (including taking vehicle without consent)                                 |
      | 8-Fraud and forgery and other offences of dishonesty not otherwise categorised     |
      | 9-Public order offences                                                            |
      | 10-Drug offences                                                                   |
      | 11-Driving and motor vehicle offences (other than those covered by codes 1, 6 & 7) |
      | 12-Other offences                                                                  |
      | 13-Terrorism                                                                       |
      | 14-Anti-social behaviour orders                                                    |
      | 15-Sexual offender orders                                                          |
      | 16-Other prescribed proceedings                                                    |
      | 36-Breach of part 1 Injunctions under the ASBCP Act 2014                           |