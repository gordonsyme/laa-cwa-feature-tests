class SubmissionListSection < SitePrism::Section
  element :schedule_submission_reference, :xpath, './/td[6]'
  element :update_button, :xpath, './/td[8]/a'
end

class SubmissionListPage < SitePrism::Page
  set_url '/OA_HTML/RF.jsp?function_id=25788&*'

  element :firm_name, :xpath, '//*[@id="SearchFirmName"]'
  element :search_button, :xpath, '/html/body/form/span[2]/div[1]/div[3]/span/div/table[2]/tbody/tr[2]/td[2]/table/tbody/tr[2]/td[3]/button[1]'

  sections :submissions, SubmissionListSection, :xpath, '/html/body/form/span[2]/div[1]/div[3]/span/div/span[1]/table[2]/tbody/tr/following-sibling::tr[position() > 0]'
end
