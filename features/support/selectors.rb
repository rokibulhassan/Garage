module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  def selector_for(locator)
    case locator

    when "the navbar"
      ".navbar"

    when "the content"
      "#content"

    when "the new vehicle page"
      "#vehicles-new-page"

    when "the vehicles tab"
      "#vehicles"

    when "the vehicle's gallery tab"
      "#galleries"

    when "the vehicle gallery"
      "#gallery"

    when "the modal"
      "#modal"

    when "the inner modal"
      "#inner-modal"

    when "the bootbox modal"
      ".bootbox.modal"

    when "the vehicles search form"
      "#vehicles-search"

    when "the picture comments list"
      ".comments-list"

    when "the breadcrumb"
      "#breadcrumb"

    when "the collages list"
      ".collages"

    when "the admin sign in"
      "#login"

    when "the admin header"
      "#header"

    when "the admin new side view form"
      "#new_side_view"

    when "the vehicle side view"
      ".vehicle-side-view"

    when "the admin side views table"
      "table#side_views"

    when "the modification parts"
      "table.parts"

    when "the modification services"
      "table.services"

    when "the modification changes"
      "table.changes"

    when "the modification title"
      "h2"

    when "the modifications"
      "#all-modifications"

    when "the comparisons"
      "#comparisons"

    when "the comparison attributes group navigation"
      "#comparisons .nav"

    when "the vehicle quantities"
      ".quantities"

    when /the (max_power|top_speed|accel_time_0_100_kph|consumption_city) #{capture_model} comparison attribute/
      comparison_table = model! $2
      "#comparisons .#{$1} .comparison_change_set_#{comparison_table.id}_properties"

    when /the (max_power|top_speed|accel_time_0_100_kph|consumption_city) comparison attribute/
      "#comparisons .#{$1}"

    when "the comparison table change set checkbox"
      ".change-set-checkbox"

    when "the expenses table"
      "#expenses tbody"

    when "the identification tab"
      "#identification"

    when "the modifications dashboard"
      "#modifications-dashboard"

    when "the user information"
      "#user-information"

    when "the silhouettes bar"
      "#silhouettes-bar"

    when "the navigation bar"
      ".navigation"

    when "the ownership"
      "#ownership"

    when /the #{capture_model} model/
      model = model! $1
      "##{model.class.to_s.downcase}_#{model.id}"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #  when /^the (notice|error|info) flash$/
    #    ".flash.#{$1}"

    # You can also return an array to use a different selector
    # type, like:
    #
    #  when /the header/
    #    [:xpath, "//header"]

    # This allows you to provide a quoted selector as the scope
    # for "within" steps
    when /^"(.+)"$/
      $1

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)
