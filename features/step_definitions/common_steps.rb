When /^(.*) within (.*)$/ do |custom_step, scope|
  within(selector_for(scope)) { step custom_step }
end

Given /^I click on "(.*?)"$/ do |text|
  wait_for_jquery if @javascript
  click_on(text)
end

When /^I press on "(.*)"$/ do |element|
  wait_for_jquery if @javascript
  find("##{element}").click
end

When /^I check "([^"]*)"$/ do |field|
  check(field)
end

When /^I uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

Then /^the "([^"]*)" checkbox should be checked$/ do |label|
  field_checked = find_field(label)['checked']
  if field_checked.respond_to? :should
    field_checked.should be_true
  else
    assert field_checked
  end
end

Then /^the "([^"]*)" checkbox should not be checked$/ do |label|
  field_checked = find_field(label)['checked']
  if field_checked.respond_to? :should
    field_checked.should be_false
  else
    assert !field_checked
  end
end

Then /^I should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^I should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^I should see "(.*?)" in "(.*?)" field$/ do |text, field|
  if page.respond_to? :should
    find_field(field).value.should == text
  else
    assert_equal text, find_field(field).value
  end
end

Then /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  field = field.gsub(/&quot;/, "\"")
  fill_in(field, :with => value)
end

Then /^I should see the following (.*?) list:$/ do |raw_entity_name, expected_entities_table|
  wait_for_jquery

  entity_name = raw_entity_name.singularize
  expected = expected_entities_table.hashes.map do |hash|
    "#{entity_name}_#{model!(hash[entity_name]).id}"
  end
  actual = page.all("ul.#{entity_name.pluralize} > li").map { |li| li['id'] }

  assert_equal expected, actual
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^I wait for AJAX$/ do
  wait_for_jquery
end

When /^I debug$/ do
  debugger
end

Then /^the css selector "([^"]*)" should exist$/ do |selector|
  if page.respond_to? :should
    page.should have_css(selector)
  else
    assert page.has_css?(selector)
  end
end

Then /^the css selector "([^"]*)" should not exist$/ do |selector|
  if page.respond_to? :should
    page.should have_no_css(selector)
  else
    assert page.has_no_css?(selector)
  end
end

Then /^I should be on (.*?)$/ do |page_name|
  steps %Q{ Then the css selector "#{selector_for(page_name)}" should exist within the content }
end

Then /^accordion components are all visible$/ do
  page.execute_script "$('.accordion-body').css('height', 'auto')"
end

Then /^tabbable components are all visible$/ do
  page.execute_script "$('.tab-pane').css('display', 'block')"
end

When /^I trigger element change event$/ do
  find(selector_for('the content')).click
end

Then /^the "(.*)" tab should be active$/ do |tab|
  selector = "##{tab.downcase}.tab-pane.active"
  page.should have_css(selector)
end