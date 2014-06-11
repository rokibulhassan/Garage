require 'spec_helper'

describe "A french user want to display the data sheet of an automobile", js: true do
  let!(:french_user) { FactoryGirl.create(:user, :french) }
  let!(:automobile_brand) { FactoryGirl.create(:brand, :automobile) }
  before { sign_in_as(french_user) }

  context "he goes to the data sheets page" do
    it "he should see the different types from the data sheets page" do
      visit '/data_sheets'

      page.should have_selector('a[data-type=automobile]')
      page.should have_selector('a[data-type=motorcycle]')
    end

    context "when he clicks the automobile type" do
      let!(:motorcycle_brand) { FactoryGirl.create(:brand, :motorcycle) }

      it "he should see the automobile brands in french" do
        visit '/data_sheets'
        find('a[data-type=automobile]').click

        page.should have_content(automobile_brand.label_fr)
        page.should_not have_content(motorcycle_brand.label_fr)
      end
    end


    context "when he clicks an automobile brand" do
      let!(:other_automobile_brand) { FactoryGirl.create(:brand, :automobile) }
      let!(:model) { FactoryGirl.create(:model, brand: automobile_brand) }
      let!(:other_model) { FactoryGirl.create(:model, brand: other_automobile_brand) }

      it "he should see only models of the selected brand" do
        visit '/data_sheets'
        find('a[data-type=automobile]').click
        find("tr #brand_#{automobile_brand.id}").click

        page.should have_content(model.label_fr)
        page.should_not have_content(other_model.label_fr)
      end
    end


    context "when he clicks a model while the brand doesn't use production codes" do
      let!(:automobile_brand) { FactoryGirl.create(:brand, :automobile) }
      let!(:model) { FactoryGirl.create(:model, brand: automobile_brand ) }
      let!(:other_model) { FactoryGirl.create(:model, brand: automobile_brand ) }
      let!(:version) { FactoryGirl.create(:version, model: model) }
      let!(:other_version) { FactoryGirl.create(:version, model: other_model) }

      it "he should see the versions for this model" do
          visit '/data_sheets'
          find('a[data-type=automobile]').click
          find("#brand_#{automobile_brand.id}").click
          find("#model_#{model.id}").click

          page.should have_content(version.label_fr)
          page.should_not have_content(other_version.label_fr)
      end
    end


    context "when he clicks a version" do
      let!(:automobile_brand) { FactoryGirl.create(:brand, :automobile) }
      let!(:model) { FactoryGirl.create(:model, brand: automobile_brand ) }
      let!(:version) { FactoryGirl.create(:version, model: model) }

      it "should see the data sheet" do
        visit '/data_sheets'
        find('a[data-type=automobile]').click
        find("#brand_#{automobile_brand.id}").click
        find("#model_#{model.id}").click
        find("#version_#{version.id}").click

        screenshot('data-sheet')
        page.should have_selector('.groups')
      end
    end
  end
end
