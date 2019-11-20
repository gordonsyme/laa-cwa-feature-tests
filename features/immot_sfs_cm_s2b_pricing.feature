@outcomes
Feature: Immigration Standard Fee Scheme Child Migrant Stage 2b(CLR) outcome pricing

    In order to price child migrant Immigration cases correctly
    As a business stakeholder
    I want claims priced with hourly rates

    Rules:

    There are 2 pricing schemes in place for Immigration/Asylum claims.
    One scheme prices claims using hourly rates(HR), the other via a Standard Fee Scheme (SFS).
    The MT1 code determines the pricing scheme in place
    (see the section on Immigration in
    https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/832905/Guidance_for_Reporting_Controlled_Work_September_2019.pdf)

    For information on pricing via the SFS please see Tables 4(a-d)
    in http://www.legislation.gov.uk/uksi/2013/422/schedule/1/made).

    Child Migrant claims must be priced via hourly rates and there there is a £500
    cap above which the case must be flagged as an Escape Fee Case.  The rules on
    pricing Child Migrant cases are as follows:-

    • If Profit Costs ex. VAT + Counsel Costs ex. VAT < £500 AND VAT_INDICATOR = 'Y'
    then Price = (Profit Costs + VAT) + (Counsel Costs + VAT) + (Disbursements + VAT)

    • If Profit Costs ex. VAT + Counsel Costs ex. VAT < £500 AND VAT_INDICATOR = 'N'
    then Price = (Profit Costs) + (Counsel Costs) + (Disbursements + VAT)

    • If Profit Costs ex. VAT + Counsel Costs ex. VAT = £500 AND VAT_INDICATOR = 'Y'
    then Price = (Profit Costs + VAT) + (Counsel Costs + VAT) + (Disbursements + VAT)

    • If Profit Costs ex. VAT + Counsel Costs ex. VAT = £500 AND VAT_INDICATOR = 'N'
    then Price = (Profit Costs) + (Counsel Costs) + (Disbursements + VAT)

    • If Profit Costs ex. VAT + Counsel Costs ex. VAT > £500 AND VAT_INDICATOR = 'Y'
    then Price = (£500 + VAT) + (Disbursements + VAT) & flag as Escape Fee case

    • If Profit Costs ex. VAT + Counsel Costs ex. VAT > £500 AND VAT_INDICATOR = 'N'
    then Price = (£500) + (Disbursements + VAT) & flag as Escape Fee case

    Background:
      Given a test firm user is logged in CWA

    @slow
    Scenario: Bulk load child migrant Immigration claims and have them priced correctly
      When a user successfully bulk loads "o_sfs_immas_stage2b_clr_cm.xml" for the test firm
      And user is on the "LEGAL HELP" pricing outcome details page
      Then user should see the following outcomes:
			| UFN        | Matter Type | Value | Escape Fee |
      | 011119/520 | IMCB:IIRC | £ 499.00 | N |
      | 011119/521 | IMCB:IOTH | £ 500.00 | N |
      | 011119/522 | IMCB:IOTH | £ 500.00 | Y |
      | 011119/523 | IMCB:IOTH | £ 499.00 | N |
      | 310313/524 | IMCB:IGOL | £ 500.00 | N |
      | 011119/525 | IMCB:IRVL | £ 500.00 | Y |
      | 011119/526 | IMCB:IOTH | £ 599.00 | N |
      | 011119/527 | IMCB:IRVL | £ 600.00 | N |
      | 310313/528 | IMCB:IGOL | £ 600.00 | Y |
      | 011119/529 | IMCB:IRVL | £ 619.00 | N |
      | 011119/530 | IMCB:IRVL | £ 620.00 | N |
      | 011119/531 | IMCB:IRVL | £ 620.00 | Y |
      | 011119/532 | IMCB:IILL | £ 598.80 | N |
      | 011119/533 | IMCB:IOTH | £ 600.00 | N |
      | 310313/534 | IMCB:IGOL | £ 500.00 | Y |
      | 011119/535 | IMCB:IOTH | £ 598.80 | N |
      | 011119/536 | IMCB:IRVL | £ 600.00 | N |
      | 011119/537 | IMCB:IIRC | £ 500.00 | Y |
      | 011119/538 | IMCB:IOTH | £ 698.80 | N |
      | 011119/539 | IMCB:IOTH | £ 700.00 | N |
      | 011119/540 | IMCB:IRVL | £ 600.00 | Y |
      | 310313/541 | IMCB:IGOL | £ 718.80 | N |
      | 011119/542 | IMCB:IIRC | £ 720.00 | N |
      | 011119/543 | IMCB:IIRC | £ 620.00 | Y |
