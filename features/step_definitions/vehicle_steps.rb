When /^I go to the my profile vehicles via menus$/ do
  visit '/dashboard'
  page.execute_script "$('#top-bar .myy-garage').trigger('click')"

  within selector_for('the navbar') do
    click_on 'My Vehicles'
  end

  within selector_for('the content') do
    click_on 'Vehicles'
  end
end

When /^I go to the (.*?)'s my profile$/ do |vehicle|
  vehicle = model!(vehicle)

  vehicle_title = "#{vehicle.brand.name} #{vehicle.model.name}"

  page.execute_script "$('#top-bar .myy-garage').trigger('click')"

  within(selector_for('the navbar')) do
    click_on('My Vehicles')
  end

  within(selector_for('the content')) do
    click_on('Vehicles')
    wait_for_jquery
    within(".tab-content") do
      click_on(vehicle_title)
    end
  end
end

When /^I go to a bookmarked vehicles page$/ do
  visit '/dashboard'
  page.execute_script "$('#top-bar .vehicles').trigger('click')"

  within(selector_for('the navbar')) do
    click_on('Bookmarked Vehicles')
  end
end

When /^I go to the (.*?)'s profile by a direct link$/ do |resource|
  resource = model!(resource)

  case resource
  when Vehicle
    visit "/users/#{resource.user_id}/vehicles/#{resource.id}"
  when User
    visit "/users/#{resource.id}"
  end

  wait_for_jquery
end

When /^I go to the (.*?)'s (specifications|performances|modifications) by a direct link$/ do |vehicle, tab|
  vehicle = model!(vehicle)

  visit "/vehicles/#{vehicle.id}/#{tab}"

  wait_for_jquery
end

Then /^I should see (.*?)'s image$/ do |side_view|
  wait_for_jquery if @javascript

  side_view = model!(side_view)
  selector = "#side_view_#{side_view.id} img"

  steps %Q{ Then the css selector "#{selector}" should exist }
end

Then /^I should not see (.*?)'s image$/ do |side_view|
  wait_for_jquery if @javascript

  side_view = model!(side_view)
  selector = "#side_view_#{side_view.id}"

  steps %Q{ Then the css selector "#{selector}" should not exist }
end

Given /^I go to the new vehicle page by a direct link$/ do
  visit '/vehicles/new'
  wait_for_jquery
end

When /^I select "(.*?)" vehicle type$/ do |vehicle_type|
  find('form .vehicle-type[data-type="' + vehicle_type + '"]').click
end

#TODO: DRY steps using select_from_chosen
When /^I select "(.*?)" property name$/ do |property_name|
  select_from_chosen property_name, :from => 'property_name'
  wait_for_jquery
end

Then /^the "(.*?)" tab should be available$/ do |tab_name|
  selector = "li:not(.disabled) a.show-#{tab_name.downcase}"
  steps %Q{ Then the css selector "#{selector}" should exist }
end

Then /^the "(.*?)" tab should not be available$/ do |tab_name|
  selector = "li.disabled a.show-#{tab_name.downcase}"
  steps %Q{ Then the css selector "#{selector}" should exist }
end
