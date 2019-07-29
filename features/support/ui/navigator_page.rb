class RolesSection < SitePrism::Section
  element :cwa_activity_report_manager_internal_role, :xpath, '//a[text()="CWA Activity Reporter Manager (Internal) role"]'
end

class NavigatorContent < SitePrism::Section
  element :bulk_load, :xpath, '//*[@id="N55"]'
  element :submission_list, :xpath, '//*[@id="N61"]'
end

class NavigatorPage < SitePrism::Page
  set_url "#{CWAProvider.url}/OA_HTML/OA.jsp?OAFunc=OAHOMEPAGE"

  section :roles, RolesSection, :xpath, '//*[@id="responsibilityRN"]/table/tbody/tr/td[1]/table/tbody'
  section :content, NavigatorContent, :xpath, '//*[@id="responsibilityRN"]/table/tbody/tr/td[2]/table/tbody'
end
