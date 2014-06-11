When /^I login as #{capture_model}$/ do |user|
  user = model!(user)
  visit root_path
  within(selector_for('the navbar')) do
    fill_in('session[identifier]', :with => user.email)
    fill_in('session[password]', :with => 'password')
    click_on('Submit')
  end
end

When /^I logout$/ do
  within selector_for('the navbar') do
    find('.sign-out').click
  end
  within selector_for('the bootbox modal') do
    click_on 'OK'
  end
end

Given /^I am a guest with (.*) language preferred$/ do |lang|
  lang_value = case lang
  when 'French'
    'fr-FR'
  when 'English'
    'en-US'
  else
    raise "Can't find mapping from \"#{lang}\ to a language header value."
  end
  Capybara.current_session.driver.header 'Accept-Language', "#{lang_value},*"
end

Given /^I go to view my profile by a direct link$/ do
  visit '/my/vehicles'
  wait_for_jquery
end

When /^I go to the edit user page via menus$/ do
  visit '/dashboard'
  page.execute_script "$('#top-bar .user-dropdown').trigger('click')"

  within '.user-dropdown' do
    click_on 'Edit profile'
  end
  wait_for_jquery
end

When /^I go to the edit user page by a direct link$/ do
  visit '/my/profile/edit'
end