When /^I select "(.*?)" (.*?) from chosen$/ do |resource_name, resource|
  select_from_chosen resource_name, from: "#{resource.gsub ' ', '_'}_id"
end