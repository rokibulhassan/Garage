Given /^the #{capture_model} exists with #{capture_fields}, vehicles:$/ do |model, fields, table|
  comparison_table = create_model model, fields
  table.hashes.each do |hash|
    comparison_table.vehicles << model!(hash["vehicle"])
  end
end

When /^I go to the #{capture_model} by a direct link$/ do |comparison_table|
  comparison_table = model! comparison_table
  visit "/comparison_tables/#{comparison_table.id}"
end

Then /^I should see "(.*?)" for the #{capture_model} $/ do |text, change_set|
  change_set = model! change_set
  within("#comparisons") do
    page.all(".comparison_change_set_#{change_set.id}_properties").map(&:text).should include(text)
  end
end

Then /^I should see "(.*?)" in the top bar dropdown$/ do |text|
  page.execute_script "$('#top-bar .home.myy-garage').trigger('mouseenter')"

  within selector_for('the navbar') do
    step "I should see \"#{text}\""
  end
end

Then /^I should not see "(.*?)" in the top bar dropdown$/ do |text|
  page.execute_script "$('#top-bar .home.myy-garage').trigger('mouseenter')"

  within selector_for('the navbar') do
    step "I should not see \"#{text}\""
  end
end

When /^I click on #{capture_model} remove icon$/ do |vehicle|
  vehicle = model! vehicle
  page.find(:xpath, "//a[@data-id='#{vehicle.id}']").click
end