require 'spec_helper'

describe "Modifications dashboard of a vehicle", js: true do
  describe "Visibility of owner controls" do
    it "should not display owner's controls when the user is a guest" do
      owner   = FactoryGirl.create(:user)
      vehicle = FactoryGirl.create(:vehicle, user: owner)

      visit "/users/#{owner.id}/vehicles/#{vehicle.id}"
      find('.show-modifications').click

      page.should_not have_css('.add-modification')
    end


    it "should not display owner controls when the signed in user is not the owner" do
      user    = FactoryGirl.create(:user)
      owner   = FactoryGirl.create(:user)
      vehicle = FactoryGirl.create(:vehicle, user: owner)

      sign_in_as(user)
      visit "/users/#{owner.id}/vehicles/#{vehicle.id}"
      find('.show-modifications').click

      page.should_not have_css('.add-modification')
    end


    it "should display owner controls if the signed in user is the owner" do
      owner    = FactoryGirl.create(:user)
      vehicle = FactoryGirl.create(:vehicle, user: owner)

      sign_in_as(owner)
      visit "/users/#{owner.id}/vehicles/#{vehicle.id}"
      find('.show-modifications').click

      page.should have_css('.add-modification')
    end
  end


  describe "Listing of created modifications" do
    it "should display no item when the vehicle has no modification" do
      owner   = FactoryGirl.create(:user)
      vehicle = FactoryGirl.create(:vehicle, user: owner)

      visit "/users/#{owner.id}/vehicles/#{vehicle.id}"
      find('.show-modifications').click

      page.should_not have_css('.modification-item')
    end


    it "should list the modification with the default revision" do
      owner        = FactoryGirl.create(:user)
      vehicle      = FactoryGirl.create(:vehicle, user: owner)
      revision     = FactoryGirl.create(:default_revision)
      modification = FactoryGirl.create(:modification, vehicle: vehicle, revision: revision)

      visit "/users/#{owner.id}/vehicles/#{vehicle.id}"
      find('.show-modifications').click

      page.should have_css('.modification-item .change-revision')
    end


    it "should display the modification with a regular revision" do
      owner        = FactoryGirl.create(:user)
      vehicle      = FactoryGirl.create(:vehicle, user: owner)
      revision     = FactoryGirl.create(:revision, label: 'My revision', vehicle: vehicle)
      modification = FactoryGirl.create(:modification, vehicle: vehicle, revision: revision)

      visit "/users/#{owner.id}/vehicles/#{vehicle.id}"
      find('.show-modifications').click

      find('.modification-item .change-revision').has_content?(revision.label)
    end
  end


  describe "Adding a modification from the dashboard" do
    it "should use the default revision" do
      owner        = FactoryGirl.create(:user)
      vehicle      = FactoryGirl.create(:vehicle, user: owner)

      sign_in_as(owner)
      visit "/users/#{owner.id}/vehicles/#{vehicle.id}"
      find('.show-modifications').click
      find('.add-modification').click

      vehicle.default_revision.should have(1).modification
    end
  end
end
