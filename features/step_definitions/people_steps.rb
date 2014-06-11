Given /^I go to the my people page by a direct link$/ do
  visit '/my/people'
  wait_for_jquery
end
