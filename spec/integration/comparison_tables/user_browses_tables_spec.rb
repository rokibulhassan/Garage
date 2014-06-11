require 'spec_helper'

describe "Comparison tables pages", js: true do
  describe "A guest visiting a table" do
    it "should see the default label as title when the table is untitled" do
      table = FactoryGirl.create(:comparison_table, label: nil, user: FactoryGirl.create(:user))

      use_browser_locale 'fr-FR'
      visit "/comparison_tables/#{table.id}"

      find('h2').should have_content('Comparaison sans titre')
    end


    it "should see the label as title when the table has a title and the list of vehicles" do
      vehicle = FactoryGirl.create(:vehicle)
      table   = FactoryGirl.create(:comparison_table, label: 'Some label', user: FactoryGirl.create(:user))
      table.vehicles << vehicle

      use_browser_locale 'fr-FR'
      visit "/comparison_tables/#{table.id}"

      find('h2').should have_content(table.label)
    end
  end


  describe "A user visiting his own table" do
    it "should see an editable title" do
      user  = FactoryGirl.create(:user, :french)
      table = FactoryGirl.create(:comparison_table, user: user)

      sign_in_as(user)
      visit "/comparison_tables/#{table.id}"

      page.should have_css('h2 input')
    end
  end


  describe "A user browsing the tables via the menu" do
    it "3 recent tables should appear in the Myy Garage menu" do
      user              = FactoryGirl.create(:user, :french)
      very_old_table    = FactoryGirl.create(:comparison_table, user: user, created_at: 40.minutes.ago)
      old_table         = FactoryGirl.create(:comparison_table, user: user, created_at: 30.minutes.ago)
      recent_table      = FactoryGirl.create(:comparison_table, user: user, created_at: 20.minutes.ago)
      very_recent_table = FactoryGirl.create(:comparison_table, user: user, created_at: 10.minutes.ago)

      sign_in_as(user)
      visit '/'
      page.execute_script('$(".navbar .myy-garage").trigger("mouseenter")')

      list = find('#myy-garage-dropdown .comparison-tables')
      list.should_not have_content(very_old_table.label)
      list.should have_content(old_table.label)
      list.should have_content(recent_table.label)
      list.should have_content(very_recent_table.label)
    end


    it "should send the user on the table page when he click the title in the Myy Garage menu" do
      user    = FactoryGirl.create(:user, :french)
      vehicle = FactoryGirl.create(:vehicle)
      table   = FactoryGirl.create(:comparison_table, user: user)
      table.vehicles << vehicle

      sign_in_as(user)
      visit '/'
      page.execute_script('$(".navbar .myy-garage").trigger("mouseenter")')
      find('#myy-garage-dropdown .comparison-tables').click_link(table.label)

      find('h2 input').value.should == table.label
    end
  end


  describe "Table tabs" do
    it "should display the performances tab by default" do
      user  = FactoryGirl.create(:user)
      table = FactoryGirl.create(:comparison_table, user: user)

      visit "/comparison_tables/#{table.id}"

      page.should have_css('#tab_label_performance.active'), "Performance tab should be active"
    end


    it "by default the metrics for performances are used and a control allow to change it" do
      user  = FactoryGirl.create(:user)
      table = FactoryGirl.create(:comparison_table, user: user)

      visit "/comparison_tables/#{table.id}/fuel_consumption"

      page.should have_css('#tab_label_fuel_consumption.active'), "Consumption tab should be active"
    end


    it "should fall back to the default tab when " do
      user  = FactoryGirl.create(:user)
      table = FactoryGirl.create(:comparison_table, user: user)

      visit "/comparison_tables/#{table.id}/unknown_metrics_type"

      page.should have_css('#tab_label_performance.active'), "Performance tab should be active"
    end
  end
end
