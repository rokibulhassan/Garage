class ProductionYearFromStringToInteger < ActiveRecord::Migration
  def up
    execute "ALTER TABLE versions ALTER COLUMN production_year TYPE INT USING CAST(production_year AS INT);"
  end

  def down
    change_column :versions, :production_year, :string
  end
end
