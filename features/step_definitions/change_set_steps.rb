Given /^the #{capture_model} exists with #{capture_fields}, modifications:$/ do |model, fields, table|
  change_set = create_model model, fields
  table.hashes.each do |hash|
    change_set.modifications << model!(hash["modification"])
  end
  change_set.save!
end

Then /^I should see "(.*?)" selected in chosen select "(.*?)"$/ do |selected, chosen_selector_id|
  within("#{chosen_selector_id}_chzn .chzn-choices") do
    page.all(".search-choice").map(&:text).should include(selected)
  end
end

Then /^I should not see "(.*?)" selected in chosen select "(.*?)"$/ do |selected, chosen_selector_id|
  within("#{chosen_selector_id}_chzn .chzn-choices") do
    page.all(".search-choice").map(&:text).should_not include(selected)
  end
end

#TODO: Refactor chosen steps
Then /^I should see "(.*?)" selected in change_set "(.*?)" modifications chosen select$/ do |selected, change_set|
  change_set = model! "change_set \"#{change_set}\""
  within("#change_set_#{change_set.id}_modifications_chzn .chzn-choices") do
    page.all(".search-choice").map(&:text).should include(selected)
  end
end


Then /^I should see "(.*?)" selected in single chosen select "(.*?)"$/ do |selected, chosen_selector_id|
  within("#{chosen_selector_id}_chzn .chzn-results") do
    page.all(".result-selected").map(&:text).should include(selected)
  end
end

Then /^I should not see "(.*?)" selected in single chosen select "(.*?)"$/ do |selected, chosen_selector_id|
  within("#{chosen_selector_id}_chzn .chzn-results") do
    page.all(".result-selected").map(&:text).should_not include(selected)
  end
end

Then /^I should see "(.*?)" in the "(.*?)" change set properties$/ do |value, name|
  within("table.changes") do
    step "I should see change set \"#{name}\" property with value \"#{value}\""
  end
end

Then /^I should see change set "(.*?)" property with value "(.*?)"$/ do |value, name|
  page.all('tr').map(&:text).should include "#{value} #{name}"
end

And /^the width of the (max_power|top_speed|accel_time_0_100_kph) #{capture_model} comparison attribute bar should be "(.*?)"$/ do |attribute_name, change_set, width|
  change_set = model! change_set
  bar_width = page.evaluate_script "$(\"#comparisons .#{attribute_name} .comparison_change_set_#{change_set.id}_properties .bar\").data('width')"
  width.to_i.should be_within(1).of(bar_width)
end


Given /^the #{capture_model} is current for the #{capture_model}$/ do |change_set, vehicle|
  model!(vehicle).update_attribute :current_change_set_id, model!(change_set).id
end