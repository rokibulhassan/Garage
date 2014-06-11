class RenameTitleIntoLabelInFieldsets < ActiveRecord::Migration
  def change
    rename_column :fieldsets, :title_fr, :label_fr
    rename_column :fieldsets, :title_en, :label_en
  end
end
