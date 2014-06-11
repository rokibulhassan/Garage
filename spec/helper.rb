module Helper
  def sign_in_as(user)
    visit '/'
    within '.navbar-form' do
      fill_in 'session[identifier]', with: user.email
      fill_in 'session[password]',   with: 'password'
      click_button 'Submit'
    end
  end


  def use_browser_locale(locale)
    Capybara.current_session.driver.header 'Accept-Language', "#{locale},*"
  end


  def screenshot(filename)
    page.driver.render(Rails.root.join('tmp', 'screenshots', "#{filename}.png"))
  end
end
