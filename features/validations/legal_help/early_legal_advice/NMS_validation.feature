# Commenting out these tests until we have clarity on TA-2643 ticket. 

# Feature: validate NMS with PA ,case start date and schedule start/end dates

#   @delete_outcome_after @manual_submission
#   Scenario Outline: Manual entry for EARLY LEGAL ADVICE , NMS validation
#     Given user is on their "LEGAL HELP" submission details page
#     When user adds outcomes for "Legal Help" "early_legal_advice" with fields like this:
#       | case_id | matter_type | procurement_area | access_point | stage_reached | outcome_code | case_start_date |
#       |     201 | LHPC:LHAC   | HP00001          | AP00000      | LA            | LB           |      31/03/2024 |
#     Then the outcome does not save and gives an error containing:
#       """
#       There is no active HLPAS schedule authorisation for this claim.
#       """

#   Scenario: Bulkload HLPAS outcomes with valid procurement area codes but NMS start date is 01/04/2024
#     Given a test firm user is logged in CWA
#     And user prepares to submit outcomes for test provider "LEGAL HELP.ELA#16"
#     Given the following Matter Types are chosen:
#       | LWOT:LCRE |
#     And the following outcomes are bulkloaded:
#       | # | CASE_START_DATE | OUTCOME_CODE | STAGE_REACHED | PROCUREMENT_AREA |
#       | 1 |      31/03/2024 | LA           | LA            | HP00001          |
#     Then the following results are expected:
#       | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE                                           |
#       | 1 | LWOT:LCRE   | There is no active HLPAS schedule authorisation for this claim. |

#   Scenario: Bulkload HLPAS outcomes with PA code valid in the NMS start date 01/03/24 and end date 31/03/24 but ELA matter start valid from 13/03/24
#     Given a test firm user is logged in CWA
#     And user prepares to submit outcomes for test provider "LEGAL HELP.ELA#17"
#     Given the following Matter Types are chosen:
#       | LWOT:LCRE |
#     And the following outcomes are bulkloaded:
#       | # | CASE_START_DATE | OUTCOME_CODE | STAGE_REACHED | PROCUREMENT_AREA |
#       | 1 |      01/03/2024 | LA           | LA            | HP00001          |
#     Then the following results are expected:
#       | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE                                                                     |
#       | 1 | LWOT:LCRE   | The reporting code combination that has been used is not valid. Please amend accordingly. |

#   Scenario: Bulkload HLPAS outcomes with PA code valid in the NMS start date 01/03/24 and end date 31/03/24 ELA matter start date is set at 15/03/24
#   Case start date greater than NMS end date so expecting an error, NMS withdrawn case.

#     Given a test firm user is logged in CWA
#     And user prepares to submit outcomes for test provider "LEGAL HELP.ELA#17"
#     Given the following Matter Types are chosen:
#       | LWOT:LCRE |
#     And the following outcomes are bulkloaded:
#       | # | CASE_START_DATE | OUTCOME_CODE | STAGE_REACHED | PROCUREMENT_AREA |
#       | 1 |      01/04/2024 | LA           | LA            | HP00001          |
#     Then the following results are expected:
#       | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE                                           |
#       | 1 | LWOT:LCRE   | There is no active HLPAS schedule authorisation for this claim. |

#   Scenario: Bulkload HLPAS outcomes with PA code valid with the NMS start date 01/08/24 and no end date ELA matter start date is set at 13/03/24
#   Case start date before NMS start date, so NMS validation for PA code

#     Given a test firm user is logged in CWA
#     And user prepares to submit outcomes for test provider "LEGAL HELP.ELA#17"
#     Given the following Matter Types are chosen:
#       | LWOT:LCRE |
#     And the following outcomes are bulkloaded:
#       | # | CASE_START_DATE | OUTCOME_CODE | STAGE_REACHED | PROCUREMENT_AREA |
#       | 1 |      01/04/2024 | LA           | LA            | HP00080          |
#     Then the following results are expected:
#       | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE                                           |
#       | 1 | LWOT:LCRE   | There is no active HLPAS schedule authorisation for this claim. |

#   Scenario: Bulkload HLPAS outcomes with PA code valid in the NMS start date 01/03/24 and end date 31/03/24 ELA matter start date is set at 13/03/24, schedule ref valid from 01-SEP-23 to 20-JUN-24
#   Case start date greater than NMS end date and schedule end date so expecting an error

#     Given a test firm user is logged in CWA
#     And user prepares to submit outcomes for test provider "LEGAL HELP.ELA#17"
#     Given the following Matter Types are chosen:
#       | LWOT:LCRE |
#     And the following outcomes are bulkloaded:
#       | # | CASE_START_DATE | OUTCOME_CODE | STAGE_REACHED | PROCUREMENT_AREA |
#       | 1 |      21/06/2024 | LA           | LA            | HP00016          |
#     Then the following results are expected:
#       | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE                                           |
#       | 1 | LWOT:LCRE   | There is no active HLPAS schedule authorisation for this claim. |

#   Scenario: Bulkload HLPAS outcomes with PA code valid in the NMS start date 14/03/24 and no end date ELA matter start date is set at 13/03/24, schedule ref valid from 01-SEP-23 to 20-JUN-24
#   Case start date earlier than NMS start date

#     Given a test firm user is logged in CWA
#     And user prepares to submit outcomes for test provider "LEGAL HELP.ELA#17"
#     Given the following Matter Types are chosen:
#       | LWOT:LCRE |
#     And the following outcomes are bulkloaded:
#       | # | CASE_START_DATE | OUTCOME_CODE | STAGE_REACHED | PROCUREMENT_AREA |
#       | 1 |      13/03/2024 | LA           | LA            | HP00016          |
#     Then the following results are expected:
#       | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE                                           |
#       | 1 | LWOT:LCRE   | There is no active HLPAS schedule authorisation for this claim. |

#   Scenario: Bulkload HLPAS outcomes NMS start date 01/03/24 and end date 31/03/24 ELA matter start date is set at 13/03/24
#   Its an ECF matter so NMS validation does not happen. schedule ref valid from 01-SEP-23 to 20-JUN-24, case start date is outside of schedule validity

#     Given a test firm user is logged in CWA
#     And user prepares to submit outcomes for test provider "LEGAL HELP.ELA#17"
#     Given the following Matter Types are chosen:
#       | LWOT:LCRE |
#     And the following outcomes are bulkloaded:
#       | # | CASE_START_DATE | OUTCOME_CODE | STAGE_REACHED | PROCUREMENT_AREA | ACCESS_POINT | EXCL_CASE_FUNDING_REF |
#       | 1 |      21/06/2024 | LA           | LA            | PA20000          | AP20000      |             1234567AB |
#     Then the following results are expected:
#       | # | MATTER_TYPE | ERROR_CODE_OR_MESSAGE |
#       | 1 | LWOT:LCRE   | <none>                |