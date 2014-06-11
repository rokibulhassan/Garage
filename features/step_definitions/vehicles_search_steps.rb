When /^I go to a users' vehicles search page$/ do
  visit '/vehicles/search'
  #page.execute_script "$('.home.vehicles').trigger('mouseenter')"

  #within(selector_for('the navbar')) do
    #click_on('Users\' Vehicles')
  #end
end

When /^I exclude select "(.*?)" brand$/ do |brand_name|
  select_from_chosen brand_name, :from => 'excl_brand_ids'
end

#TODO: DRY steps using select_from_chosen
When /^I select "(.*?)" country$/ do |country|
  select_from_chosen country, :from => 'country_code'
end

When /^I exclude select "(.*?)" country$/ do |country|
  select_from_chosen country, :from => 'excl_country_codes'
end
