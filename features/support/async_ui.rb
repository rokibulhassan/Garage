module AsyncUI
  def wait_for_jquery(timeout = Capybara.default_wait_time)
    page.wait_until(timeout) do
      page.evaluate_script 'jQuery.active == 0'
    end
  end
end

World(AsyncUI)

Before '@javascript' do
  @javascript = true
end
