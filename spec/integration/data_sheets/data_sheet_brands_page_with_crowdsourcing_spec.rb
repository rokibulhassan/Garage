require 'spec_helper'

describe "Data sheet brands page", js: true do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user) }
  let!(:automobile_brand) { FactoryGirl.create(:brand, :automobile) }
  let!(:other_automobile_brand) { FactoryGirl.create(:brand, :automobile) }
  let!(:motorcycle_brand) { FactoryGirl.create(:brand, :motorcycle) }

  context "the guest user with french browser clicks the automobile icon to see brands" do
    before do
      use_browser_locale 'fr-FR'
      visit '/data_sheets'
      find('a[data-type=automobile]').click
    end

    it "should display only the automobile brands" do
      visit '/data_sheets'
      find('a[data-type=automobile]').click

      page.should have_content(automobile_brand.label_fr)
      page.should have_content(other_automobile_brand.label_fr)
      page.should_not have_content(motorcycle_brand.label_fr)
    end
  end


  context "the french user displays the brands page" do
    let!(:user) { FactoryGirl.create(:user, :french) }

    it "should display french names" do
      sign_in_as(user)
      visit '/data_sheets/automobile'

      page.should have_content(automobile_brand.label_fr)
      page.should have_content(other_automobile_brand.label_fr)
    end
  end


  context "the english user displays the brands page" do
    let!(:user) { FactoryGirl.create(:user, :english) }

    it "should display english names" do
      sign_in_as(user)
      visit '/data_sheets/automobile'

      page.should have_content(automobile_brand.label_en)
      page.should have_content(other_automobile_brand.label_en)
    end
  end


  context "when there is brand waiting for votes" do
    let!(:automobile_brand) { FactoryGirl.create(:brand, :automobile, :pending) }

    context "if the user is a guest" do
      it "should see disable vote buttons" do
        visit '/data_sheets/automobile'
        page.should have_selector('.btn.approve.disabled')
      end
    end


    context "if the user is signed in" do
      before { sign_in_as(user) }

      it "should see vote buttons" do
        visit '/data_sheets/automobile'
        page.should have_selector('.btn.approve')
      end
    end
  end
end
