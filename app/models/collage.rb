class Collage < ActiveRecord::Base
  attr_accessible :active_layout, :position, :move
  attr_accessor :move
  has_many :cutouts, dependent: :destroy

  def cutouts_of_active_layout
    cutouts_of(active_layout)
  end

  # Returns cutouts (Cutout) for the specified `layout` (String)
  def cutouts_of layout
    cutouts.select do |cutout|
      cutout.layout == layout
    end
  end

  # Returns either persisted or unpersisted (placeholder) cutouts (Cutout) for this
  # collage for the specified `layout` (String) (see config/application.yml for layouts)
  def cutouts_with_placeholders_of layout
    layout_cutouts = cutouts_of(layout)
    [].tap do |cutouts|
      layout_settings = Settings.collage_layouts[layout]
      layout_settings.keys.each do |row|
        layout_settings[row].keys.each do |col|
          cutout = layout_cutouts.find { |c| c.row == row and c.col == col }
          if cutout
            cutouts << cutout
          else
            cutouts << self.cutouts.build(layout: layout, row: row, col: col)
          end
        end
      end
    end
  end

  # Returns either persisted or unpersisted (placeholder) cutouts (Cutout) for this
  # collage for all layouts (see config/application.yml for layouts)
  def cutouts_with_placeholders
    [].tap do |cutouts|
      Settings.collage_layouts.keys.each do |layout|
        cutouts.concat cutouts_with_placeholders_of(layout)
      end
    end
  end
end
