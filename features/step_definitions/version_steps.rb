When /^I add "(.*?)" option to chosen select "(.*?)"$/ do |option, chosen_select_name|
  add_value_to_chosen option, from: chosen_select_name
end

Then /^"(.*?)" select should contain "(.*?)"$/ do |field, option|
  wait_for_jquery
  find_field(field).all("option").map(&:text).should include(option)
end

Then /^"(.*?)" select should not contain "(.*?)"$/ do |field, option|
  wait_for_jquery
  find_field(field).all("option").map(&:text).should_not include(option)
end