json.array! @comparison_tables do |json, comparison_table|
  json_partial!(json, 'comparison_tables/comparison_table', comparison_table: comparison_table, user: @user)
end
