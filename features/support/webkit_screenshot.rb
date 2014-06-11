module Screenshot
  def screen_shot_and_save_page
    require 'capybara/util/save_and_open_page'
    path = "/#{Time.now.to_s(:file_name)}"
    Capybara.save_page body, "#{path}.html"
    if page.driver.respond_to? :render
      page.driver.render Rails.root.join("#{Capybara.save_and_open_page_path}" "#{path}.png"), width: 1024, height: 768
    end
  end
end

World(Screenshot)

begin
  Before do
    page.driver.resize_window(1024, 768)
  end

  After do |scenario|
    screen_shot_and_save_page if scenario.failed?
  end
rescue Exception => e
  puts "Snapshots not available for this environment.\n
    Have you got gem 'capybara-webkit' in your Gemfile and have you enabled the javascript driver?"
end
