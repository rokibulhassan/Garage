Then /^I should see #{capture_model} thumbnail$/ do |gallery|
  gallery = model!(gallery)
  within("#thumbnail_#{gallery.id}") do
    page.should have_content(gallery.title)
  end
end

Then /^I should not see #{capture_model} thumbnail$/ do |gallery|
  gallery = model!(gallery)
  page.should_not have_css("#thumbnail_#{gallery.id}")
end

When /^I go to the (.*?)'s pictures list$/ do |gallery|
  gallery = model!(gallery)

  within(selector_for('the content')) do
    wait_for_jquery
    click_on gallery.title
  end
  wait_for_jquery
end

When /^I upload a file using "(.*?)" input$/ do |selector|
  page.attach_file(selector, File.join(Rails.root, 'spec', 'fixtures', 'files', 'test1.jpg'))
end

When /^I navigate to the (.*?) picture in the modal$/ do |direction|
  case direction

  when 'previous'
    page.execute_script("MyApp.modal.currentView.trigger('nav:prev');")

  when 'next'
    page.execute_script("MyApp.modal.currentView.trigger('nav:next');")

  else
    raise "Can't navigate to \"#{direction}\" image."
  end
end

Then /^I should see an updated "(.*?)" image after click on "(.*?)"$/ do |alt_text, action_link|
  wait_for_jquery

  within(selector_for('the modal')) do
    steps %Q{ Then I should see "#{alt_text}" image }
    old_src = page.find("img[alt='#{alt_text}']")[:src]

    click_on(action_link)
    wait_for_jquery

    if 'Blur area' == action_link
      #FIXME: something is really wrong with rendering of the view if we need this workaround
      page.execute_script <<-EOS
        if (MyApp.modal.currentView.api == null) {
          MyApp.modal.currentView.onRender();
        }
      EOS

      page.execute_script("MyApp.modal.currentView.api.setSelect([0, 0, 10, 10]);")
      click_on 'Blur area'
      wait_for_jquery
    end

    steps %Q{ Then I should see "#{alt_text}" image }
    new_src = page.find("img[alt='#{alt_text}']")[:src]
    refute_equal old_src, new_src, "A link to the image isn't updated"
  end
end

When /^I submit a new picture comment$/ do
  page.execute_script("MyApp.modal.currentView.comments.currentView.postComment()")
end

Then /^I should be able to update the first picture comment with "(.*?)"$/ do |comment|
  click_button 'edit-comment'
  fill_in('comment-inplace', with: comment)
  page.execute_script("e = $.Event('keydown'); e.which = 13; MyApp.modal.currentView.comments.currentView.$('.comment-input').trigger(e);")
end

Then /^I should not be able to update the first picture comment with "(.*?)"$/ do |arg1|
  assert page.has_no_selector?("button[value='edit-comment']")
end

Then /^I should be able to delete the first picture comment$/ do
  click_button 'delete-comment'
  wait_for_jquery
end

Then /^I should not be able to delete the first picture comment$/ do
  assert page.has_no_selector?("button[value='delete-comment']")
end

When /^I update picture description in\-place with "(.*?)"$/ do |title|
  within('.picture-info') do
    fill_in('title-inplace', with: 'new and edited in-place')
    page.execute_script("MyApp.modal.currentView.comments.currentView.updatePictureTitle()")
  end
end

When /^I submit a new gallery title$/ do
  page.execute_script("MyApp.content.currentView.content.currentView.updateTitle()")
end

When /^I move (higher|lower) the collage: (.*?)$/ do |direction, collage|
  collage = model!(collage)
  selector = "ul.collages > li[id='collage_#{collage.id}']"

  wait_for_jquery
  within selector do
    find(".move-#{direction}").click
  end
end

When /^I drag (.*?)'s thumbnail to (.*?)'s thumbnail$/ do |drag_source, drag_target|
  wait_for_jquery
  drag_source = model!(drag_source)
  drag_target = model!(drag_target)
  source = page.find "ul.thumbnails > li[id='thumbnail_#{drag_source.id}']"
  target = page.find "ul.thumbnails > li[id='thumbnail_#{drag_target.id}']"
  source.drag_to target
end

And /^I should not see comments counter$/ do
  selector = ".show-picture.thumbnail .comments-size"

  steps %Q{ Then the css selector "#{selector}" should not exist }
end

And /^I should see comments size of "(.*?)"$/ do |amount|
  selector = ".thumbnails .comments-size"

  within selector do
    steps %Q{And I should see "#{amount}"}
  end
end
