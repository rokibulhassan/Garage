Then /^I should see "(.*?)" image$/ do |alt_text|
  selector = "img[alt='#{alt_text}']"
  steps %Q{ Then the css selector "#{selector}" should exist }
end

Then /^I should not see "(.*?)" image$/ do |alt_text|
  selector = "img[alt='#{alt_text}']"
  steps %Q{ Then the css selector "#{selector}" should not exist }
end

Then /^I should see (\d+) picture thumbnails?$/ do |n|
  wait_for_jquery
  assert_equal n.to_i, page.all('.thumbnails img').size
end

Then /^I should see (\d+) real pictures?$/ do |n|
  wait_for_jquery
  assert_equal n.to_i, page.all('img.has-url').size
end

When /^I click on "(.*?)" image$/ do |alt_text|
  selector = "img[alt='#{alt_text}']"
  page.find(selector).click
end

Then /^I should( not)? see the following cutout images:$/ do |negate, expected_images_table|
  expected_images_table.hashes.each do |hash|
    steps %Q{ Then I should#{negate} see "#{hash['picture_title']} cutout" image within #{hash['scope']} }
  end
end

When /^I click on (.*?)'s image$/ do |model|
  model = model!(model)
  selector = "##{model.class.to_s.underscore}_#{model.id} img"
  page.find(selector).click
end
