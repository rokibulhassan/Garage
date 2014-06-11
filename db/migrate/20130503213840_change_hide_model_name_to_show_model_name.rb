class ChangeHideModelNameToShowModelName < ActiveRecord::Migration
  def up
    rename_column :versions, :hide_model_name, :show_model_name
  end

  def down
    rename_column :versions, :show_model_name, :hide_model_name
  end
end
