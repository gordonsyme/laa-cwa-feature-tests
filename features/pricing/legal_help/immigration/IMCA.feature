Feature: Pricing: IMCA: Immigration - Stage 2a (CLR)

  Background: 
    Given a test firm user is logged in CWA
    And user prepares to submit outcomes for test provider "LEGAL HELP.IMMOT#13"
    Given the following Matter Types are chosen:
      | IMCA:IOUT |

  Scenario: Claims priced with: Standard Fee Scheme
    When the following outcomes are bulkloaded:
      | # | UFN        | CLAIM_TYPE | CASE_START_DATE | WORK_CONCLUDED_DATE | PROFIT_COST | COUNSEL_COST | VAT_INDICATOR | TRAVEL_COSTS |
      | 1 | 010413/001 | CM         |      01/04/2013 |          31/03/2023 |         200 |           28 | N             |        10000 |
    When user confirms the submission
    And user is on the pricing outcome details page
    Then user should see the following outcomes:
      | # | UFN        | Value    | Comment                                                                            |
      | 1 | 010413/001 | £ 227.00 | Standard fee for MT1 IMCA £227 , priced at fixed fee even though PC+CC > Fixed fee |

  Scenario: Claims priced with: Additional Payments
    When the following outcomes are bulkloaded:
      | # | UFN        | CLAIM_TYPE | CASE_START_DATE | WORK_CONCLUDED_DATE | PROFIT_COST | VAT_INDICATOR | CMRH_ORAL | CMRH_TELEPHONE |
      | 1 | 010413/001 | CM         |      01/04/2013 |          31/03/2023 |         228 | N             |         1 |              1 |
    When user confirms the submission
    And user is on the pricing outcome details page
    Then user should see the following outcomes:
      | # | UFN        | Value    | Comment                                                    |
      | 1 | 010413/001 | £ 483.00 | Standard fee(£227) + CMRH_ORAL(£166) + CMRH_TELEPHONE(£90) |

  Scenario: Claims priced with: Disbursements
    When the following outcomes are bulkloaded:
      | # | UFN        | CLAIM_TYPE | CASE_START_DATE | WORK_CONCLUDED_DATE | PROFIT_COST | VAT_INDICATOR | DISBURSEMENTS_AMOUNT | DISBURSEMENTS_VAT | TRAVEL_COSTS |
      | 1 | 010413/001 | CM         |      01/04/2013 |          31/03/2023 |         228 | N             |                100.0 |                20 |        10000 |
    When user confirms the submission
    And user is on the pricing outcome details page
    Then user should see the following outcomes:
      | # | UFN        | Value    | Comment                                                                              |
      | 1 | 010413/001 | £ 347.00 | Standard fee for MT1 IMCA £227  + DibursementAmount= £100 + DisbursementVat = £20.00 |

  Scenario: Claims priced with: VAT Indicator enabled
    When the following outcomes are bulkloaded:
      | # | UFN        | CLAIM_TYPE | CASE_START_DATE | WORK_CONCLUDED_DATE | PROFIT_COST | VAT_INDICATOR |
      | 1 | 010413/001 | CM         |      01/04/2013 |          31/03/2023 |         228 | Y             |
    When user confirms the submission
    And user is on the pricing outcome details page
    Then user should see the following outcomes:
      | # | UFN        | Value    | Comment                                                            |
      | 1 | 010413/001 | £ 272.40 | Standard fee for MT1 IMCA £227  + 20% vat on standard fee = £45.40 |

  @escape_fee_flag
  Scenario: Claims priced with: Escape Fee Flag (profit cost + counsel cost => the escape threshold)
    When the following outcomes are bulkloaded:
      | # | UFN        | CLAIM_TYPE | CASE_START_DATE | WORK_CONCLUDED_DATE | PROFIT_COST | COUNSEL_COST | VAT_INDICATOR |
      | 1 | 010413/001 | CM         |      01/04/2013 |          31/03/2023 |         228 |          453 | N             |
    When user confirms the submission
    And user is on the pricing outcome details page
    Then user should see the following outcomes:
      | # | UFN        | Value    | Comment                                     |
      | 1 | 010413/001 | £ 227.00 | Standard fee for MT1 IMCA £227 is the total |
    Then the outcomes are flagged as escape fee cases
      | Comment                                                                                                                |
      | escape threhold 3 * standard fee (£227) = £681, Profit_Cost(£228) + Counsel_Cost(£453) - Additioanal_payments(0)= £681 |

  @escape_fee_flag
  Scenario: Claims priced with: NO Escape Fee Flag (profit cost + counsel cost < the escape threshold)
    When the following outcomes are bulkloaded:
      | # | UFN        | CLAIM_TYPE | CASE_START_DATE | WORK_CONCLUDED_DATE | PROFIT_COST | COUNSEL_COST | VAT_INDICATOR |
      | 1 | 010413/001 | CM         |      01/04/2013 |          31/03/2023 |         228 |          452 | N             |
    When user confirms the submission
    And user is on the pricing outcome details page
    Then user should see the following outcomes:
      | # | UFN        | Value    | Comment                                     |
      | 1 | 010413/001 | £ 227.00 | Standard fee for MT1 IMCA £227 is the total |
    Then the outcomes are NOT flagged as escape fee cases
      | Comment                                                                                                                |
      | escape threhold 3 * standard fee (£227) = £681, Profit_Cost(£228) + Counsel_Cost(£452) - Additioanal_payments(0)= £680 |

  @escape_fee_flag
  Scenario: Claims priced with: Escape Fee Flag (additional payments)
    When the following outcomes are bulkloaded:
      | # | UFN        | CLAIM_TYPE | CASE_START_DATE | WORK_CONCLUDED_DATE | PROFIT_COST | COUNSEL_COST | VAT_INDICATOR | CMRH_ORAL | CMRH_TELEPHONE |
      | 1 | 010413/001 | CM         |      01/04/2013 |          31/03/2023 |         712 |          225 | N             |         1 |              1 |
    When user confirms the submission
    And user is on the pricing outcome details page
    Then user should see the following outcomes:
      | # | UFN        | Value    | Comment                                                    |
      | 1 | 010413/001 | £ 483.00 | Standard fee(£227) + CMRH_ORAL(£166) + CMRH_TELEPHONE(£90) |
    Then the outcomes are flagged as escape fee cases
      | Comment                                                                                                                                                   |
      | escape threhold 3 * standard fee (£227) = £681, Profit_Cost(£712) + Counsel_Cost(£225) - Additioanal_payments(CMRH_ORAL(£166) + CMRH_TELEPHONE(£90)= £681 |

  @escape_fee_flag
  Scenario: Claims priced with: NO Escape Fee Flag (additional payments)
    When the following outcomes are bulkloaded:
      | # | UFN        | CLAIM_TYPE | CASE_START_DATE | WORK_CONCLUDED_DATE | PROFIT_COST | COUNSEL_COST | VAT_INDICATOR | CMRH_ORAL | CMRH_TELEPHONE |
      | 1 | 010413/001 | CM         |      01/04/2013 |          31/03/2023 |         711 |          225 | N             |         1 |              1 |
    When user confirms the submission
    And user is on the pricing outcome details page
    Then user should see the following outcomes:
      | # | UFN        | Value    | Comment                                                    |
      | 1 | 010413/001 | £ 483.00 | Standard fee(£227) + CMRH_ORAL(£166) + CMRH_TELEPHONE(£90) |
    Then the outcomes are NOT flagged as escape fee cases
      | Comment                                                                                                                                                   |
      | escape threhold 3 * standard fee (£227) = £681, Profit_Cost(£711) + Counsel_Cost(£225) - Additioanal_payments(CMRH_ORAL(£166) + CMRH_TELEPHONE(£90)= £680 |
