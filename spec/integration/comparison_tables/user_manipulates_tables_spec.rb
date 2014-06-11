require 'spec_helper'

describe "User manipulate tables", js: true do
  it "A user should see a button to compare vehicles" do
    user    = FactoryGirl.create(:user)
    vehicle = FactoryGirl.create(:vehicle)

    sign_in_as(user)
    visit "/users/#{vehicle.user.id}/vehicles/#{vehicle.id}"
    page.execute_script('$(".compare .dropdown-toggle").trigger("click")')

    page.should have_css('.compare .compare-later')
    page.should have_css('.compare .compare-now')
  end


  it "A guest user should not see the compare button vehicle" do
    user    = FactoryGirl.create(:user)
    vehicle = FactoryGirl.create(:vehicle)

    visit "/users/#{vehicle.user.id}/vehicles/#{vehicle.id}"

    page.should_not have_css('.compare')
  end


  describe "User want to compare later" do
    context "while he has no other table" do
      it "he should remain on the same page but see a table in the Myy Garage menu" do
        user    = FactoryGirl.create(:user)
        vehicle = FactoryGirl.create(:vehicle)

        sign_in_as(user)
        visit "/users/#{vehicle.user.id}/vehicles/#{vehicle.id}"

        expect { find('.compare .compare-later').click }.not_to change { current_path }
        page.execute_script('$(".navbar .myy-garage").trigger("mouseenter")')

        find('#myy-garage-dropdown .comparison-tables').should have_css('.comparison-table', count: 1)
      end
    end


    context "while he already has an untitled table" do
      it "he should remain on the same page but see a table in the Myy Garage menu" do
        user    = FactoryGirl.create(:user)
        vehicle = FactoryGirl.create(:vehicle)
        FactoryGirl.create(:comparison_table, label: nil, user: user)

        sign_in_as(user)
        visit "/users/#{vehicle.user.id}/vehicles/#{vehicle.id}"

        expect { find('.compare .compare-later').click }.not_to change { current_path }
        page.execute_script('$(".navbar .myy-garage").trigger("mouseenter")')

        find('#myy-garage-dropdown .comparison-tables').should have_css('.comparison-table', count: 1)
      end
    end


    context "while he already has table with a title" do
      it "he should remain on the same page but see a new table in the Myy Garage menu" do
        user    = FactoryGirl.create(:user)
        vehicle = FactoryGirl.create(:vehicle)
        FactoryGirl.create(:comparison_table, user: user)

        sign_in_as(user)
        visit "/users/#{vehicle.user.id}/vehicles/#{vehicle.id}"
        find('.compare .compare-later').click
        page.execute_script('$(".navbar .myy-garage").trigger("mouseenter")')

        find('#myy-garage-dropdown .comparison-tables').should have_css('.comparison-table', count: 2)
      end
    end
  end


  describe "User want to compare now" do
    context "while he has no other table" do
      it "he should be sent to the table page" do
        user    = FactoryGirl.create(:user)
        vehicle = FactoryGirl.create(:vehicle)

        sign_in_as(user)
        visit "/users/#{vehicle.user.id}/vehicles/#{vehicle.id}"
        find('.compare .compare-now').click
        page.execute_script('$(".navbar .myy-garage").trigger("mouseenter")')

        find('#myy-garage-dropdown .comparison-tables').should have_css('.comparison-table', count: 1)
        find('h2 input').value.should be_blank
        page.should have_css(".vehicles #vehicle-#{vehicle.id}")
      end
    end
  end
end
