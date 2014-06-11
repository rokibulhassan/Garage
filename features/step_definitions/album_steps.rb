Given /^I go to the albums page by a direct link$/ do
  visit '/albums'
  wait_for_jquery
end

Given /^albums per page limit is (.*?)$/ do |limit|
  ProfilePictureSearch::PER_PAGE_LIMIT = limit.to_i
end
