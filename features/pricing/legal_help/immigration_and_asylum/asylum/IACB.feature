Feature: IACB: Asylum - Stage 2b (CLR) pricing

  Background:
    Given a test firm user is logged in CWA
    And the user prepares to add outcomes in the "Asylum" category of law
    And the user wants to add outcomes with any Matter Type 1 from:
      """
      Asylum - Stage 2b (CLR)
      """

  Scenario: Claims priced with: Standard Fee Scheme
    When the user adds outcomes with:
      """
      total profit costs just above or below the standard fee
      """
    Then the outcomes are priced at:
      """
      standard fee
      """

  Scenario: Claims priced with: Additional Payments
    When the user adds outcomes with:
      """
      additional payments
      """
    Then the outcomes are priced at:
      """
      standard fee + additional payments
      """

  Scenario: Claims priced with: Disbursements
    When the user adds outcomes with:
      """
      disbursements and disbursements VAT
      """
    Then the outcomes are priced at:
      """
      standard fee + disbursements + disbursements VAT
      """

  Scenario: Claims priced with: VAT Indicator enabled
    When the user adds outcomes with:
    """
    VAT indicator enabled for profit and counsel costs
    """
    Then the outcomes are priced at:
      """
      standard fee + VAT
      """

  Scenario: Claims priced with: Hourly Rates (Separated Migrant Child)
    When the user adds outcomes with:
      """
      exemption criteria separated migrant child
      """
    Then the outcomes are priced at:
      """
      hourly rates
      """

  Scenario: Claims priced with: Escape Fee Flag
    When the user adds outcomes with:
      """
      total profit costs (minus additional payments) exceeding three times the standard fee(s)
      """
    Then the outcomes are flagged as escape fee cases

  Scenario: Claims priced with: No Escape Fee Flag
    When the user adds outcomes with:
      """
      total profit costs (minus additional payments) NOT exceeding three times the standard fee(s)
      """
    Then the outcomes are NOT flagged as escape fee cases
