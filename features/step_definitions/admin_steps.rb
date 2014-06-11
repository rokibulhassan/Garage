When /^I login as #{capture_model} to admin$/ do |user|
  user = model!(user)
  visit new_admin_user_session_path
  within selector_for('the admin sign in') do
    fill_in 'admin_user_email', with: user.email
    fill_in 'admin_user_password', with: 'password'
    click_on 'Login'
  end
end

When /^I logout from admin$/ do
  within selector_for('the admin header') do
    click_on 'Logout'
  end
  assert page.has_content?('Forgotten password')
end