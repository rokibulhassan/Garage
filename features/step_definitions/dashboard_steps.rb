Given /^I go to the dashboard page by a direct link$/ do
  visit '/dashboard'
  wait_for_jquery
end

Given /^news per page limit is (.*?)$/ do |limit|
  NewsFeedSearch::PER_PAGE_LIMIT = limit.to_i
end

Then /^"(.*?)" menu item should be disabled$/ do |item|
  selector = "#top-bar li.disabled a.#{item}"
  steps %Q{ Then the css selector "#{selector}" should exist }
end

Then /^"(.*?)" menu item should be enabled/ do |item|
  selector = "#top-bar li:not(.disabled) a.#{item}"
  steps %Q{ Then the css selector "#{selector}" should exist }
end

When /^I go to the my (cars|bikes) page via menus$/ do |type|
  visit '/dashboard'
  page.execute_script "$('#top-bar .myy-garage-dropdown').trigger('click')"

  within '.myy-garage-dropdown' do
    click_on "My #{type}"
  end
  wait_for_jquery
end
